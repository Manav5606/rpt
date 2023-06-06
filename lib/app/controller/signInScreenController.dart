import 'dart:async';
import 'dart:developer';

import 'package:customer_app/app/controller/add_location_controller.dart';
import 'package:customer_app/app/controller/my_wallet_controller.dart';
import 'package:customer_app/app/ui/pages/signIn/signup_screen.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/utils/firebas_crashlyatics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/app_constants.dart';
import 'package:customer_app/app/data/model/address_model.dart';
import 'package:customer_app/app/data/model/user_model.dart';
import 'package:customer_app/app/data/model/wallet_model.dart';
import 'package:customer_app/app/data/provider/hive/hive.dart';
import 'package:customer_app/app/data/provider/hive/hive_constants.dart';
import 'package:customer_app/app/data/repository/hive_repository.dart';
import 'package:customer_app/app/data/repository/sigin_in_repository.dart';

import 'package:customer_app/controllers/userViewModel.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/utils/utils.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../data/provider/firebase/firebase_notification.dart';
import '../ui/pages/signIn/otp_verification_screen.dart';

class SignInScreenController extends GetxController {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController referralController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  late AuthCredential phoneAuthCredential;
  RxString verification = ''.obs;
  RxString phoneNumber = ''.obs;
  RxBool isLoading = false.obs;
  RxString referral = ''.obs;
  RxBool isFromOTP = false.obs;
  RxBool isResendEnable = false.obs;
  RxBool checkBox = false.obs;
  User? user;
  late Timer _timer;
  UserModel? userModel;
  final HiveRepository hiveRepository = HiveRepository();
  final SignInRepository signInRepository = SignInRepository();
  final AddLocationController _addLocationController = Get.find();
  final MyWalletController _myWalletController = Get.put(MyWalletController());

  RxString phoneNumbers = ''.obs;

  // @override
  // void onClose() {
  //   // TODO: implement onClose
  //   _timer.cancel();
  //   super.onClose();
  // }

  @override
  void initState() {
    _timer = Timer(Duration(seconds: 0), () => print('Timer initialized'));
    // super.initState();
  }

  void startTimer() {
    isFromOTP.value = true;
    isResendEnable.value = false;
    Constants.start.value = 60;
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (Constants.start.value == 0) {
          isResendEnable.value = true;
          timer.cancel();
        } else {
          Constants.start--;
        }
      },
    );
  }

  // Future<void> submitPhoneNumber() async {
  //   isLoading.value = true;
  //   phoneNumbers.value = "+91" + phoneNumberController.text.toString().trim();
  //   log("phoneNumbers.value====${phoneNumbers.value}");
  //   try {
  //     void verificationCompleted(AuthCredential _phoneAuthCredential) {
  //       log('verificationCompleted');
  //       phoneAuthCredential = _phoneAuthCredential;
  //       print(phoneAuthCredential);
  //       log("phoneAuthCredential.value====${phoneAuthCredential}");
  //     }
  //
  //     void verificationFailed(FirebaseAuthException error) {
  //       log('error verificationFailed:-->> $error');
  //       isLoading.value = false;
  //     }
  //
  //     void codeSent(String? verificationId, [int? forceResendingToken]) {
  //       log('codeSent');
  //       verification.value = verificationId ?? '';
  //       log("verification.value====${verification.value}");
  //       isLoading.value = false;
  //       if (!isFromOTP.value) {
  //         Get.to(() => OtpScreen());
  //       }
  //     }
  //
  //     void codeAutoRetrievalTimeout(String verificationId) {
  //       isLoading.value = false;
  //       log('codeAutoRetrievalTimeout');
  //     }
  //
  //     await FirebaseAuth.instance.verifyPhoneNumber(
  //       phoneNumber: phoneNumbers.value,
  //       timeout: Duration(seconds: 60),
  //       verificationCompleted: verificationCompleted,
  //       verificationFailed: verificationFailed,
  //       codeSent: codeSent,
  //       codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
  //     );
  //   } on PlatformException catch (error) {
  //     log('PlatformException Error is:--->>>$error');
  //   } catch (e) {
  //     log('Error is:--->>>$e');
  //     isLoading.value = false;
  //   }
  // }
  int? _resendToken;
  Future submitPhoneNumber() async {
    try {
      log("inside submitPhoneNumber ");
      isLoading.value = true;

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+91${phoneNumberController.text}",
        timeout: Duration(seconds: 5),
        verificationCompleted: (PhoneAuthCredential credential) {
          // log("aavoooo :4");
          // FirebaseAuth.instance
          //     .signInWithCredential(credential)
          //     .then((value) async {
          //   if (value.user != null) {
          //     log("Verification Complete successful With Mobile number");
          //   }
          // });
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          isLoading.value = false;
          verification.value = verificationId;
          _resendToken = forceResendingToken;
          if (!isFromOTP.value) {
            Get.to(() => OtpScreen());
          }
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // isLoading.value = false;
          // verification.value = verificationId;
        },
        forceResendingToken: _resendToken,
        verificationFailed: (FirebaseAuthException e) {
          isLoading.value = false;
          if (e.code == 'invalid-phone-number') {
            Get.showSnackbar(GetSnackBar(
              backgroundColor: AppConst.black,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              snackStyle: SnackStyle.FLOATING,
              borderRadius: 12,
              duration: Duration(seconds: 2),
              message: "The provided phone number is not valid.",
              // title: "Amount must be at least \u{20b9}1"
            ));
            log('The provided phone number is not valid.');
          }
        },
      );
    } catch (e) {
      ReportCrashes().reportRecorderror(e);
      ReportCrashes().reportErrorCustomKey("submitPhoneNumber", "$e");
      log("error submitPhoneNumber :$e");
    }
  }

  void submitOTP() {
    isLoading.value = true;
    String smsCode = otpController.text.toString().trim();
    log('smsCode :$smsCode');
    log('smsCode :${verification.value}');
    phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verification.value, smsCode: smsCode);
    _login();
  }

  Future<void> _login() async {
    try {
      await FirebaseAuth.instance
          .signInWithCredential(phoneAuthCredential)
          .then((UserCredential authRes) async {
        user = authRes.user;
        _timer.cancel();
        if (user != null) {
          userModel = await signInRepository.customerLoginOrSignUp(
              phoneNumber: phoneNumberController.text,
              referID: referralController.text);

          if (userModel != null) {
            UserViewModel.setUser(userModel!);
            List<Wallet>? wallet = await signInRepository.getAllWallet();
            userModel?.wallet = wallet;

            final box = Boxes.getCommonBoolBox();
            final flag = box.get(HiveConstants.SIGNUP_FLAG);
            log("flag :$flag");
            if (referralController.text.isNotEmpty) {
              UserViewModel.setReferFlag(true);
            }
            await checkSession(flag ?? false);
          } else {
            isLoading.value = false;
            Get.showSnackbar(GetSnackBar(
              backgroundColor: AppConst.black,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              snackStyle: SnackStyle.FLOATING,
              borderRadius: 12,
              duration: Duration(seconds: 2),
              message: "User Not Created Please Try Again!",
              // title: "Amount must be at least \u{20b9}1"
            ));
          }

          // isLoading.value = false;
        } else {
          isLoading.value = false;
          Get.showSnackbar(GetSnackBar(
            backgroundColor: AppConst.black,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            snackStyle: SnackStyle.FLOATING,
            borderRadius: 12,
            duration: Duration(seconds: 2),
            message: "Please Enter the vaild OTP!",
            // title: "Amount must be at least \u{20b9}1"
          ));
        }
      });
    } catch (e, st) {
      ReportCrashes().reportRecorderror(e);
      ReportCrashes().reportErrorCustomKey("customerLoginOrSignUp", "$st");
      otpController.clear();

      isLoading.value = false;
      Get.showSnackbar(GetSnackBar(
        backgroundColor: AppConst.black,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        snackStyle: SnackStyle.FLOATING,
        borderRadius: 12,
        duration: Duration(seconds: 2),
        message: "OTP Invaild : Please Enter Vaild OTP!",
        // title: "Amount must be at least \u{20b9}1"
      ));
      log('eeee :$e $st');
    }
  }

  Future<void> signUpButton(
      String firstName, String lastName, String email) async {
    var flag = await SignInRepository.updateCustomerInformation(
        firstName, lastName, email);

    if (flag) {
      // await checkSession(false);
      if (_myWalletController.isNonVegSelected.value == true) {
        for (int i = 0; i < (_myWalletController.NonVegStores.length); i++) {
          _addLocationController.allWalletStores
              .add(_myWalletController.NonVegStores[i]);
        }
      }
      if (_myWalletController.isPetfoodSelected.value == true) {
        for (int i = 0; i < (_myWalletController.PetfoodStores.length); i++) {
          _addLocationController.allWalletStores
              .add(_myWalletController.PetfoodStores[i]);
        }
      }
      await _addLocationController.addMultipleStoreToWalletToClaimMore();
      await _myWalletController.getAllWalletByCustomer();
      _myWalletController.walletbalanceOfBusinessType.value =
          _myWalletController.StoreTotalWelcomeAmount();
      Get.offNamed(AppRoutes.NewBaseScreen);
    }
  }

  Future<void> UpdateInfo(
      String firstName, String lastName, String email) async {
    var flag = await SignInRepository.updateCustomerInformation(
        firstName, lastName, email);
    if (flag) {
      await checkUpdateInfo();
    }
  }

  Future<void> checkUpdateInfo() async {
    if (hiveRepository.hasUser()) {
      try {
        final UserModel userModel = hiveRepository.getCurrentUser();
        log("userModeluserModel :${userModel.toJson()}");

        Get.back();
        Get.back();
        // Get.offAllNamed(AppRoutes.MyAccount);
      } catch (e) {
        ReportCrashes().reportRecorderror(e);
        ReportCrashes().reportErrorCustomKey("getCurrentUser", "$e");
      }
    }
  }

  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      user = null;
    } catch (e) {
      ReportCrashes().reportRecorderror(e);
      ReportCrashes().reportErrorCustomKey("_logout", "$e");
      print(e.toString());
    }
  }

  Future<void> checkSession(bool SignUp) async {
    try {
      // if (SignUp) {
      //   //check for siginupflag
      //   // final box = Boxes.getCommonBoolBox();
      //   // final flag = box.get(HiveConstants.SIGNUP_FLAG);
      //   // log("SiginUp :$flag");
      //   // if (flag!) {
      //   return Get.to(
      //       SignUpScreen()); // brfore going to signup open wallet address details page which already have location
      //   // }
      // }

      //location permission check

      _addLocationController.getCurrentLocation1().then((value) {
        if (value.latitude != 0.0 && value.longitude != 0.0) {
          // WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
          FireBaseNotification().firebaseCloudMessagingLSetup();
          Future.delayed(Duration(seconds: 2), () async {
            if (SignUp && (userModel?.firstName != null)) {
              UserViewModel.setLocation(LatLng(
                  _addLocationController.currentPosition.latitude,
                  _addLocationController.currentPosition.longitude));
              await _myWalletController.getAllWalletByCustomerByBusinessType();
              int? value =
                  await _myWalletController.updateBusinesstypeWallets();

              if (value != null) {
                _addLocationController.isRecentAddress.value = false;
                Get.toNamed(AppRoutes.SelectBusinessType,
                    arguments: {"signup": true});
              }
            } else {
              await Get.offAllNamed(AppRoutes.NewBaseScreen);
              isLoading.value = false;
            }
          });
          // });
        } else {
          if ((userModel?.addresses?.length ?? 0) > 0) {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              FireBaseNotification().firebaseCloudMessagingLSetup();
              await Get.offAllNamed(AppRoutes.SelectLocationAddress,
                  arguments: {"locationListAvilable": true});
              isLoading.value = false;
              // _addLocationController.getCurrentLocation();
            });
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              FireBaseNotification().firebaseCloudMessagingLSetup();
              await Get.offAllNamed(AppRoutes.SelectLocationAddress,
                  arguments: {"locationListAvilable": false});
              isLoading.value = false;
              // _addLocationController.getCurrentLocation();
            });
          }
        }
      });
      connectUserStream(
          userId: userModel!.id!,
          name: "${userModel?.firstName} ${userModel?.lastName}");
    } catch (e) {
      ReportCrashes().reportRecorderror(e);
      ReportCrashes().reportErrorCustomKey("checksessionSignin", "$e");
      Future.delayed(Duration(seconds: 2), () async {
        await Get.offAllNamed(AppRoutes.Authentication);
        isLoading.value = false;
      });
    }
    // if (hiveRepository.hasUser()) {
    //   try {
    //     final UserModel userModel = hiveRepository.getCurrentUser();
    //     log("userModeluserModel :${userModel.toJson()}");
    //     // final MoreStoreController _moreStoreController = Get.put(MoreStoreController());
    //     if ((userModel.addresses?.length ?? 0) > 0) {
    //       for (final AddressModel? addressModal
    //           in (userModel.addresses ?? [])) {
    //         if (addressModal?.status ?? false) {
    //           log("checkSession : 0000}");
    //           Get.offAllNamed(
    //             AppRoutes.NewLocationScreen,
    //           );
    //           break;
    //         }
    //       }
    //       Get.offAllNamed(AppRoutes.BaseScreen);
    //       // Get.offAll(() => ManageAddressScreen());
    //     } else {
    //       log("checkSession : 879879897}");
    //       Get.offAllNamed(AppRoutes.NewLocationScreen,
    //           arguments: {"isFalse": false});
    //     }
    //   } catch (e) {
    //     log("e:$e");
    //     Future.delayed(Duration(seconds: 2),
    //         () => Get.offAllNamed(AppRoutes.Authentication));
    //   }
    // } else {
    //   log("eggjmghhj");
    //   Future.delayed(Duration(seconds: 2),
    //       () => Get.offAllNamed(AppRoutes.Authentication));
    // }
  }
}
