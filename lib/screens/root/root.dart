import 'dart:async';
import 'dart:developer';
import 'dart:ffi';
import 'package:customer_app/app/controller/add_location_controller.dart';
import 'package:customer_app/app/data/provider/hive/hive.dart';
import 'package:customer_app/app/data/provider/hive/hive_constants.dart';
import 'package:customer_app/app/data/repository/my_account_repository.dart';
import 'package:customer_app/app/data/serivce/dynamic_link_service.dart';
import 'package:customer_app/app/ui/pages/signIn/signup_screen.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/controllers/userViewModel.dart';
import 'package:customer_app/data/repositories/mainRepoWithAllApi.dart';
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
// import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart' as temp;
import 'package:sizer/sizer.dart';

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> with TickerProviderStateMixin {
  late bool error;
  final HiveRepository hiveRepository = HiveRepository();
  final AddLocationController _addLocationController = Get.find();
  temp.Location location = new temp.Location();
  @override
  void initState() {
    // checkNetwork();
    // checkPermission();
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
    await DynamicLinkService().retrieveDynamicLink();
    final box = Boxes.getCommonBox();
    final token = box.get(HiveConstants.USER_TOKEN);
    if (token != null && token != "") {
      try {
        // get customer info based upon token
        MyAccountRepository().getCurrentUser();
        final UserModel userModel = hiveRepository.getCurrentUser();

        //check for siginupflag
        // final box = Boxes.getCommonBoolBox();
        // final flag = box.get(HiveConstants.SIGNUP_FLAG);
        // log("SiginUp :$flag");
        // if (flag!) {
        //   return Get.to(SignUpScreen());
        // }
        //check user exit
        if (!((userModel.email != null && userModel.email != "") &&
            (userModel.firstName != null && userModel.firstName != ""))) {
          return Get.to(SignUpScreen());
        }

        // bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
        // final checkPermission =
        //     serviceEnabled && await Permission.location.isGranted;

        // var lat;
        // var lng;
        // try {
        //   Position position = await Geolocator.getCurrentPosition();
        //   lat = position.latitude;
        //   lng = position.longitude;
        // } catch (e) {
        //   lng = 0.0;
        // }
        // value = _addLocationController.getCurrentLocation1() ;
        // _addLocationController.checkLocationPermission();

//         bool IsGpsOn = true;
//         double value;
//         checkGps() async {
//           try {
//  Position position = await Geolocator.getCurrentPosition();

//             // value =  _addLocationController.getCurrentLocation1();

//             IsGpsOn = true;
//           } catch (e) {
//             IsGpsOn = false;
//           }
//         }

//         checkGps();

//  Position position =
//             await Geolocator.getCurrentPosition().then((position) {
//           return position;
//         });
        // Future<Position> value = _addLocationController.getCurrentLocation1();

        // bool isBothEnable = checkPermission;

        _addLocationController.getCurrentLocation1().then((value) {
          if (value.latitude != 0.0 && value.longitude != 0.0) {
            // WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
            FireBaseNotification().firebaseCloudMessagingLSetup();
            Future.delayed(Duration(seconds: 2), () {
              Get.offAllNamed(AppRoutes.BaseScreen);
            });
            // });
          } else {
            if ((userModel.addresses?.length ?? 0) > 0) {
              WidgetsBinding.instance!.addPostFrameCallback((_) {
                FireBaseNotification().firebaseCloudMessagingLSetup();
                Get.offAllNamed(AppRoutes.SelectLocationAddress,
                    arguments: {"locationListAvilable": true});
                // _addLocationController.getCurrentLocation();
              });
            } else {
              WidgetsBinding.instance!.addPostFrameCallback((_) {
                FireBaseNotification().firebaseCloudMessagingLSetup();
                Get.offAllNamed(AppRoutes.SelectLocationAddress,
                    arguments: {"locationListAvilable": false});
                // _addLocationController.getCurrentLocation();
              });
            }
          }
        });
        connectUserStream(
            userId: userModel.id!,
            name: "${userModel.firstName} ${userModel.lastName}");
      } catch (e) {
        Future.delayed(Duration(seconds: 2),
            () => Get.offAllNamed(AppRoutes.Authentication));
      }
    } else {
      Future.delayed(Duration(seconds: 2),
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
                image: AssetImage("assets/images/rootsplash.png"),
                fit: BoxFit.fill),
          ),
          height: double.infinity,
          width: double.infinity,
          // child: FittedBox(
          //   child: Center(child: Bloyallogo()),
          // ),
        ),
      ),
    );
  }
}
