import 'dart:async';
import 'package:customer_app/app/controller/add_location_controller.dart';
import 'package:customer_app/app/data/provider/hive/hive.dart';
import 'package:customer_app/app/data/provider/hive/hive_constants.dart';
import 'package:customer_app/app/data/repository/my_account_repository.dart';
import 'package:customer_app/app/data/serivce/dynamic_link_service.dart';
import 'package:customer_app/app/ui/pages/signIn/signup_screen.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/controllers/userViewModel.dart';
import 'package:customer_app/utils/firebas_crashlyatics.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/data/model/address_model.dart';
import 'package:customer_app/app/data/model/user_model.dart';
import 'package:customer_app/app/data/provider/firebase/firebase_notification.dart';
import 'package:customer_app/app/data/repository/hive_repository.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/utils/utils.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as temp;

import '../../app/controller/my_wallet_controller.dart';

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> with TickerProviderStateMixin {
  late bool error;
  final HiveRepository hiveRepository = HiveRepository();
  final AddLocationController _addLocationController = Get.find();
  final MyWalletController _myWalletController = Get.put(MyWalletController());
  temp.Location location = new temp.Location();
  @override
  void initState() {
    // checkNetwork();
    // checkPermission();
    // initUniLinks();
    if (!mounted) {
      return;
    } else {
      super.initState();
      checkSession();
    }
  }

  void checkPermission() async {
    await Geolocator.requestPermission();
    // await Permission.location.request();
  }

  // void checkNetwork() async {
  //   await InternetConnectionChecker().hasConnection;
  //   InternetConnectionChecker().onStatusChange.listen(
  //     (InternetConnectionStatus status) async {
  //       switch (status) {
  //         case InternetConnectionStatus.connected:
  //           print('Data connection is available.');
  //           // ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
  //           //   content: Text('Data connection is available.'),
  //           // ));
  //           break;
  //         case InternetConnectionStatus.disconnected:
  //           ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
  //             content: Text('You are disconnected from the internet.'),
  //           ));
  //           print('You are disconnected from the internet.');
  //           break;
  //       }
  //     },
  //   );
  // }

  Future<void> checkSession() async {
    // final value;
    // value = _addLocationController.getCurrentLocation1() as double;
    UserViewModel.setRefferralCode('');
    // await DynamicLinkService().retrieveDynamicLink();
    final box = Boxes.getCommonBox();
    final token = box.get(HiveConstants.USER_TOKEN);
    if (token != null && token != "") {
      try {
        // get customer info based upon token
        MyAccountRepository().getCurrentUser();
        final UserModel userModel = hiveRepository.getCurrentUser();

        //check user exit
        // if (!((userModel.email != null && userModel.email != "") &&
        //     (userModel.firstName != null && userModel.firstName != ""))) {
        //   return Get.to(SignUpScreen());
        // }

        _addLocationController.getCurrentLocation1().then((value) {
          if (value.latitude != 0.0 && value.longitude != 0.0) {
            // WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
            FireBaseNotification().firebaseCloudMessagingLSetup();
            Future.delayed(Duration(seconds: 4), () async {
              if (!((userModel.email != null && userModel.email != "") &&
                  (userModel.firstName != null && userModel.firstName != ""))) {
                UserViewModel.setLocation(LatLng(
                    _addLocationController.currentPosition.latitude,
                    _addLocationController.currentPosition.longitude));
                await _myWalletController
                    .getAllWalletByCustomerByBusinessType();
                int? value =
                    await _myWalletController.updateBusinesstypeWallets();
                _addLocationController.isRecentAddress.value = false;
                if (value != null) {
                  Get.toNamed(AppRoutes.SelectBusinessType,
                      arguments: {"signup": true});
                }
              } else {
                await Get.offNamed(AppRoutes.BaseScreen,
                    arguments: {"index": 0});
              }
              // Get.offAllNamed(AppRoutes.BaseScreen);
            });
            // });
          } else {
            if ((userModel.addresses?.length ?? 0) > 0) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                FireBaseNotification().firebaseCloudMessagingLSetup();
                Get.offAllNamed(AppRoutes.SelectLocationAddress,
                    arguments: {"locationListAvilable": true});
              });
            } else {
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                if (!((userModel.email != null && userModel.email != "") &&
                    (userModel.firstName != null &&
                        userModel.firstName != ""))) {
                  FireBaseNotification().firebaseCloudMessagingLSetup();
                  await Get.offAllNamed(AppRoutes.SelectLocationAddress,
                      arguments: {
                        "locationListAvilable": false,
                        "issignup": true
                      });
                } else {
                  FireBaseNotification().firebaseCloudMessagingLSetup();
                  Get.offAllNamed(AppRoutes.SelectLocationAddress,
                      arguments: {"locationListAvilable": false});
                  // _addLocationController.getCurrentLocation();
                }
              });
            }
          }
        });
        connectUserStream(
            userId: userModel.id!,
            name: "${userModel.firstName} ${userModel.lastName}");
      } catch (e) {
        ReportCrashes().reportRecorderror(e);
        ReportCrashes().reportErrorCustomKey("checksessionRoot", "");
        Future.delayed(Duration(seconds: 4),
            () => Get.offAllNamed(AppRoutes.Authentication));
      }
    } else {
      Future.delayed(Duration(seconds: 4),
          () => Get.offAllNamed(AppRoutes.Authentication));
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
    // sizeConfig.setSize((Get.height - (Get.mediaQuery.padding.top + Get.mediaQuery.padding.bottom)) / 1000,
    //     (Get.width - (Get.mediaQuery.padding.left + Get.mediaQuery.padding.right)) / 1000);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: AppConst.transparent,
          statusBarIconBrightness: Brightness.dark),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Color(0xff0a3453), // AppConst.white,
            image: DecorationImage(
                image: AssetImage("assets/images/bgsplash.png"),
                fit: BoxFit.fill),
          ),
          height: double.infinity,
          width: double.infinity,
          child: FittedBox(
            child: Center(
                child: Image.asset(
              "assets/images/splashscreen1.gif",
            )),
          ),
        ),
      ),
    );
  }
}
