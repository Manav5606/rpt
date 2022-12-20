import 'dart:async';
import 'dart:developer';

import 'package:customer_app/app/data/serivce/dynamic_link_service.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/controllers/userViewModel.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/data/model/address_model.dart';
import 'package:customer_app/app/data/model/user_model.dart';
import 'package:customer_app/app/data/provider/firebase/firebase_notification.dart';
import 'package:customer_app/app/data/repository/hive_repository.dart';
import 'package:customer_app/routes/app_list.dart';

import 'package:customer_app/utils/utils.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> with TickerProviderStateMixin {
  late bool error;
  final HiveRepository hiveRepository = HiveRepository();

  @override
  void initState() {
    checkNetwork();
    checkPermission();
    FireBaseNotification().firebaseCloudMessagingLSetup();
    if (!mounted) {
      return;
    } else {
      super.initState();
      checkSession();
    }
  }

  void checkPermission() async {
    await Geolocator.requestPermission();
    await Permission.location.request();
  }

  void checkNetwork() async {
    await InternetConnectionChecker().hasConnection;
    InternetConnectionChecker().onStatusChange.listen(
      (InternetConnectionStatus status) async {
        switch (status) {
          case InternetConnectionStatus.connected:
            print('Data connection is available.');
            // ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
            //   content: Text('Data connection is available.'),
            // ));
            break;
          case InternetConnectionStatus.disconnected:
            ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
              content: Text('You are disconnected from the internet.'),
            ));
            print('You are disconnected from the internet.');
            break;
        }
      },
    );
  }

  Future<void> checkSession() async {
    UserViewModel.setRefferralCode('');
    await DynamicLinkService().retrieveDynamicLink();
    if (hiveRepository.hasUser()) {
      try {
        final UserModel userModel = hiveRepository.getCurrentUser();
        connectUserStream(
            userId: userModel.id!,
            name: "${userModel.firstName} ${userModel.lastName}");
        if ((userModel.addresses?.length ?? 0) > 0) {
          for (final AddressModel? addressModal
              in (userModel.addresses ?? [])) {
            if (addressModal?.status ?? false) {
              WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                Get.offAllNamed(AppRoutes.BaseScreen);
                // Get.offAllNamed(AppRoutes.NewLocationScreen);
              });
              break;
            }
          }
          // WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
          //   Get.offAllNamed(AppRoutes.BaseScreen);
          // });
        } else {
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            log("checkSession : 12121}");
            Get.offAllNamed(AppRoutes.NewLocationScreen,
                arguments: {"isFalse": false});
          });
        }
      } catch (e) {
        Future.delayed(Duration(seconds: 2),
            () => Get.offAllNamed(AppRoutes.Authentication));
      }
    } else {
      Future.delayed(Duration(seconds: 2),
          () => Get.offAllNamed(AppRoutes.Authentication));
    }
  }

  // checkSession() async {
  //   if (GetStorage().hasData('userInfo')) {
  //     try {
  //       var data = GetStorage().read('userInfo');
  //       print(data['mobile']);
  //       //error = await AuthRepo.requestLogin(data['mobile']);
  //       error = await AuthRepo.requestLogin("9000084844");
  //       if (error) {
  //
  //         Get.toNamed(AppRoutes.Authentication);
  //       } else {
  //         print(UserViewModel.token.value);
  //
  //         if (UserViewModel.user.value.addresses!.length == 0) {
  //           Get.offAll(() => LocationPickerScreen());
  //         } else {
  //           Get.offAll(() => BaseScreen());
  //         }
  //         // if (UserViewModel.user.value.addresses.length > 0) {
  //         //   bool hasActiveAddress = false;
  //         //   int index = 0;
  //         //   LatLng latLng;
  //         //   UserViewModel.user.value.addresses.forEach((element) {
  //         //     if (!hasActiveAddress) {
  //         //       index = UserViewModel.user.value.addresses.indexOf(element);
  //         //       latLng = LatLng(element.location.lat, element.location.lng);
  //         //       hasActiveAddress = element.status;
  //         //     }
  //         //   });
  //         //   if (hasActiveAddress) {
  //         //     UserViewModel.setLocationIndex(index);
  //         //     UserViewModel.setLocation(latLng, UserViewModel.user.value.addresses[index].id);
  //         //     Get.offAll(() => Home());
  //         //   } else {
  //         //     Get.offAll(() => ManageAddressScreen());
  //         //   }
  //         // } else {
  //         //   Get.offAll(() => LocationPickerScreen());
  //         // }
  //
  //       }
  //     } catch (e) {
  //       print(e.toString());
  //       error = true;
  //       Future.delayed(
  //           Duration(seconds: 2), () => Get.toNamed(AppRoutes.Authentication));
  //     }
  //   } else {
  //     error = true;
  //     print('Session Unavailable');
  //     Future.delayed(Duration(seconds: 2), () => Get.toNamed(AppRoutes.Authentication));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
    // sizeConfig.setSize((Get.height - (Get.mediaQuery.padding.top + Get.mediaQuery.padding.bottom)) / 1000,
    //     (Get.width - (Get.mediaQuery.padding.left + Get.mediaQuery.padding.right)) / 1000);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: AppConst.white,
          image: DecorationImage(
              image: AssetImage("assets/images/splashbg.png"),
              fit: BoxFit.fill),
        ),
        height: double.infinity,
        width: double.infinity,
        child: FittedBox(
          child: Center(
              child: Image.asset(
            "assets/images/splash.gif",
          )),
        ),
      ),

      //     Center(
      //         child: Lottie.asset(
      //   'assets/lottie/splashscreen.json',
      // )),
      // )
    );
  }
}
