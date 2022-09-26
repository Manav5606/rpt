// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:customer_app/controllers/userViewModel.dart';
// import 'package:customer_app/screens/base_screen.dart';
// import 'package:customer_app/utils/size_config.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:lottie/lottie.dart';
//
// //import 'package:hive_flutter/hive_flutter.dart';
// import 'authentication/repository/authRepo.dart';
// import 'authentication/view/location_picker_screen.dart';
// import 'authentication/view/phone_authentication_screen.dart';
//
// class Root extends StatefulWidget {
//   @override
//   _RootState createState() => _RootState();
// }
//
// class _RootState extends State<Root> with TickerProviderStateMixin {
//   late bool error;
//   // final HiveStorage = Hive.box('');
//   final UserViewModel rootController = Get.find();
//
//   @override
//   void initState() {
//     if (!mounted) {
//       return;
//     } else {
//       super.initState();
//       checkSession();
//     }
//   }
//
// //fetches the token data , data-> homescreen ,NoData-> signupscreen
//   /* checkSession() async {
//     if (HiveStorage.containsKey('token')) {
//       print('Session Available');
//       try {
//         var data = HiveStorage.get('token');
//
//         error = await AuthRepo.requestLogin(data['token']);
//         if (error) {
//           Get.to(() => SignInScreen());
//         } else {
//           print(UserViewModel.token.value);
//           if (UserViewModel.user.value.addresses!.length == 0) {
//             Get.offAll(() => LocationPickerScreen());
//           } else {
//             Get.offAll(() => BaseScreen());
//           }
//         }
//       } catch (e) {
//         print(e.toString());
//         error = true;
//         Future.delayed(
//             Duration(seconds: 2), () => Get.to(() => SignInScreen()));
//       }
//     } else {
//       error = true;
//       print('Session Unavailable');
//       Future.delayed(Duration(seconds: 2), () => Get.to(() => SignInScreen()));
//     }
//   }
//   */
//
//   checkSession() async {
//     if (GetStorage().hasData('userInfo')) {
//       try {
//         var data = GetStorage().read('userInfo');
//         print("user mobile number: ${data['mobile']}");
//         error = await AuthRepo.requestLogin("09000084844");
//         if (error) {
//           Get.to(() => SignInScreen());
//         } else {
//           print("User token: ${UserViewModel.token.value}");
//           if (UserViewModel.user.value.addresses!.length == 0) {
//             Get.offAll(() => LocationPickerScreen());
//           } else {
//             Get.offAll(() => BaseScreen());
//           }
//           // if (UserViewModel.user.value.addresses.length > 0) {
//           //   bool hasActiveAddress = false;
//           //   int index = 0;
//           //   LatLng latLng;
//           //   UserViewModel.user.value.addresses.forEach((element) {
//           //     if (!hasActiveAddress) {
//           //       index = UserViewModel.user.value.addresses.indexOf(element);
//           //       latLng = LatLng(element.location.lat, element.location.lng);
//           //       hasActiveAddress = element.status;
//           //     }
//           //   });
//           //   if (hasActiveAddress) {
//           //     UserViewModel.setLocationIndex(index);
//           //     UserViewModel.setLocation(latLng, UserViewModel.user.value.addresses[index].id);
//           //     Get.offAll(() => Home());
//           //   } else {
//           //     Get.offAll(() => ManageAddressScreen());
//           //   }
//           // } else {
//           //   Get.offAll(() => LocationPickerScreen());
//           // }
//
//         }
//       } catch (e) {
//         print(e.toString());
//         //  await FirebaseCrashlytics.instance.recordError(e, stackTrace,);
//         error = true;
//         Future.delayed(Duration(seconds: 2), () => Get.to(() => SignInScreen()));
//       }
//     } else {
//       error = true;
//       print('Session Unavailable');
//       Future.delayed(Duration(seconds: 2), () => Get.to(() => SignInScreen()));
//     }
//   }
//
//   final GetSizeConfig sizeConfig = Get.find();
//
//   @override
//   Widget build(BuildContext context) {
//     sizeConfig.setSize((Get.height - (Get.mediaQuery.padding.top + Get.mediaQuery.padding.bottom)) / 1000,
//         (Get.width - (Get.mediaQuery.padding.left + Get.mediaQuery.padding.right)) / 1000);
//     return Scaffold(
//       body: Center(
//           child: Lottie.asset(
//         'assets/lottie/splash.json',
//       )),
//     );
//   }
// }
