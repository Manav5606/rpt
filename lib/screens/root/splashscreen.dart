import 'dart:async';
import 'package:customer_app/constants/app_const.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Future.delayed(Duration(seconds: 3), () {
        Get.toNamed(
          AppRoutes.Root,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: AppConst.transparent,
          statusBarIconBrightness: Brightness.dark),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Color(0xff0a3453),
            image: DecorationImage(
                image: AssetImage("assets/images/bgsplash.png"),
                fit: BoxFit.fill),
          ),
          height: double.infinity,
          width: double.infinity,
          child: FittedBox(
            child: Center(
              child: Lottie.asset('assets/lottie/splash2.json'),
            ),
            //      Image.asset(
            //   "assets/images/splash11.gif",
            // )
          ),
        ),
      ),
    );
  }
}








  

  // Future<void> checkSession1() async {
  //   UserViewModel.setRefferralCode('');
  //   await DynamicLinkService().retrieveDynamicLink();
  //   if (hiveRepository.hasUser()) {
  //     try {
  //       final UserModel userModel = hiveRepository.getCurrentUser();
  //       connectUserStream(
  //           userId: userModel.id!,
  //           name: "${userModel.firstName} ${userModel.lastName}");
  //       if ((userModel.addresses?.length ?? 0) > 0) {
  //         for (final AddressModel? addressModal
  //             in (userModel.addresses ?? [])) {
  //           if (addressModal?.status ?? false) {
  //             WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
  //               Future.delayed(Duration(seconds: 2),
  //                   () => Get.offAllNamed(AppRoutes.BaseScreen));
  //               // Get.offAllNamed(AppRoutes.BaseScreen);
  //               // Get.offAllNamed(AppRoutes.NewLocationScreen);
  //             });
  //             break;
  //           }
  //         }
  //         // WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
  //         //   Get.offAllNamed(AppRoutes.BaseScreen);
  //         // });
  //       } else {
  //         WidgetsBinding.instance!.addPostFrameCallback((_) {
  //           log("checkSession : 12121}");
  //           Get.offAllNamed(AppRoutes.NewLocationScreen,
  //               arguments: {"isFalse": false});
  //         });
  //       }
  //     } catch (e) {
  //       Future.delayed(Duration(seconds: 2),
  //           () => Get.offAllNamed(AppRoutes.Authentication));
  //     }
  //   } else {
  //     Future.delayed(Duration(seconds: 2),
  //         () => Get.offAllNamed(AppRoutes.Authentication));
  //   }
  // }

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
 