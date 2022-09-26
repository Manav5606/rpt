import 'dart:developer';

import 'package:customer_app/app/controller/account_controller.dart';
import 'package:customer_app/app/data/provider/graphql/queries.dart';
import 'package:customer_app/app/data/provider/graphql/request.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class FCMHandler {
  final MyAccountController _myAccountController = Get.find();
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static String? fcmToken;
  static init() async {
    print('FCM INITIALIZED');

    // NotificationSettings settings = await _firebaseMessaging.requestPermission(
    //   alert: true,
    //   announcement: false,
    //   badge: true,
    //   carPlay: false,
    //   criticalAlert: false,
    //   provisional: false,
    //   sound: true,
    // );

    // if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    //   print('User granted permission');
    // } else if (settings.authorizationStatus ==
    //     AuthorizationStatus.provisional) {
    //   print('User granted provisional permission');
    // } else {
    //   print('User declined or has not accepted permission');
    // }
    FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
    _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    Future<bool> registerFirebase(String? firebaseToken) async {
      log("inside the box");

      final result = await GraphQLRequest.query(
          query: GraphQLQueries.addFirebaseToken,
          variables: {
            'firebase_token': firebaseToken,
          });
      log("resultfcm:$result");

      if (result['error'] == false) {
        log('fcm token updated successfully');
        return true;
      } else {
        return false;
      }
    }

    fcmToken = await _firebaseMessaging.getToken(
        vapidKey:
            "BMr3aQ3mUPUCE_ENhCSCLg3YBVUoFUIJRpCce310Xiw5eHZuFh2jwDoV1FPBO3BjTldrvA8QHtBM7eFO6GnHR10");
    // if (fcmToken != null) {
    registerFirebase(fcmToken);
    // }
    // check fcmtoken is in the userdata if it present

    //mutation add firebase token to backend

    // store firebase token

    print("fcmToken");
    print(fcmToken);

    /// while app is on
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('onMessage');
      print(message.data);
    });

    /// on close notification tap
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('onMessageOpenedApp');
      print(message.data);
    });
  }

  static Future<void> _backgroundMessageHandler(RemoteMessage message) async {
    print('_backgroundMessageHandler');
    print(message.data);
  }
}
