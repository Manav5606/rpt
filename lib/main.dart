import 'package:camera/camera.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:customer_app/app/constants/app_constants.dart';
import 'package:customer_app/app/controller/add_location_controller.dart';
import 'package:customer_app/app/data/provider/firebase/firebase_notification.dart';
import 'package:customer_app/app/ui/theme/app_theme.dart';
import 'package:customer_app/app/utils/hive_helper.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/routes/app_pages.dart';
import 'package:customer_app/utils/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:upgrader/upgrader.dart';
import 'app/constants/colors.dart';

List<CameraDescription> cameras = [];
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FireBaseNotification().setUpLocalNotification();
  await GetStorage.init();
  await FirebaseRemoteConfigUtils().initMethod();

  await HiveHelper.init();
  // DynamicLinkHelper.init();
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  // Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //     statusBarColor: AppConst.white,
  //     statusBarIconBrightness: Brightness.dark));
  Get.put(AddLocationController());

  // Only call clearSavedSettings() during testing to reset internal values.
  // await Upgrader.clearSavedSettings(); // REMOVE this for release builds
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
    configLoading();
  });
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.threeBounce
    ..loadingStyle = EasyLoadingStyle.custom
    // ..indicatorSize = 45.0
    ..radius = 10.0
    // ..progressColor = Colors.yellow
    ..backgroundColor = AppConst.lightGrey
    ..indicatorColor = hexToColor('#64DEE0')
    ..textColor = hexToColor('#64DEE0')
    ..maskColor = AppConst.kPrimaryColor
    ..userInteractions = false
    ..dismissOnTap = false
    ..animationStyle = EasyLoadingAnimationStyle.scale;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: AppConst.white,
        statusBarIconBrightness: Brightness.dark));
    return Sizer(builder: (context, orientation, deviceType) {
      return GetBuilder<AddLocationController>(builder: (_) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Recipto',
          theme: appThemeData,
          getPages: AppPages.list,
          initialRoute: AppRoutes.SplashScreen,
          // builder: EasyLoading.init(),
          initialBinding: AppBinding(),
          builder: (context, child) {
            EasyLoading.init();
            return StreamChat(
              client: Constants.client,
              child: child,
            );
          },
        );
      });
    });
  }
}

class AppBinding extends Bindings {
  @override
  void dependencies() async {
    // TODO: implement dependencies
    cameras = await availableCameras();
    // Get.put(HomeController());
    // Get.put(AddLocationController());
    // Get.lazyPut(() => AddLocationController());
  }
}
