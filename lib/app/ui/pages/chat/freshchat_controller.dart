import 'dart:developer';
import 'dart:io';

import 'package:customer_app/app/data/provider/graphql/queries.dart';
import 'package:customer_app/app/data/provider/graphql/request.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:customer_app/app/constants/app_constants.dart';
import 'package:customer_app/app/controller/account_controller.dart';
import 'package:customer_app/app/ui/pages/chat/freshchat_sdk.dart';
import 'package:customer_app/app/ui/pages/chat/freshchat_user.dart';
import 'package:get/get.dart';

class freshChatController extends GetxController {
  void handleFreshchatNotification(Map<String, dynamic> message) async {
    if (await Freshchat.isFreshchatNotification(message)) {
      print("is Freshchat notification");
      Freshchat.handlePushNotification(message);
    }
  }

  Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
    print("Inside background handler");
    await Firebase.initializeApp();
    handleFreshchatNotification(message.data);
  }

  int counter = 0;
  static const String APP_ID =
          Constants.APP_ID, //"942ba118-79b9-4be7-bdfa-00b4b49522e8",
      APP_KEY = Constants.APP_KEY, //"6b9a4433-5a91-4105-a4d6-e48eedee2ef9",
      DOMAIN = Constants.DOMAIN; //"msdk.in.freshchat.com";
  final GlobalKey<ScaffoldState>? scaffoldKey = new GlobalKey<ScaffoldState>();
  final MyAccountController _myAccountController = Get.find();

  void registerFcmToken() async {
    if (Platform.isAndroid) {
      String? token = await FirebaseMessaging.instance.getToken();
      print("FCM Token is generated $token");
      Freshchat.setPushRegistrationToken(token!);
    }
  }

  void notifyRestoreId(var event) async {
    FreshchatUser user = await Freshchat.getUser;
    String? restoreId = user.getRestoreId();
    if (restoreId != null) {
      Clipboard.setData(new ClipboardData(text: restoreId));
    }
    scaffoldKey!.currentState!.showSnackBar(
        new SnackBar(content: new Text("Restore ID copied: $restoreId")));
  }

  void initState() {
    // super.initState();
    Freshchat.init(APP_ID, APP_KEY, DOMAIN);

    /**
     * This is the Firebase push notification server key for this sample app.
     * Please save this in your Freshchat account to test push notifications in Sample app.
     *
     * Server key: Please refer support documentation for the server key of this sample app.
     *
     * Note: This is the push notification server key for sample app. You need to use your own server key for testing in your application
     */
    var restoreStream = Freshchat.onRestoreIdGenerated;
    var restoreStreamSubsctiption = restoreStream.listen((event) {
      print("Restore ID Generated: $event");
      notifyRestoreId(event);
    });

    // FreshchatUser user = new FreshchatUser(
    //     "6263f7e2f91bba7f87fcadba", "724f87b8-bac3-498c-b511-6661ad7b8f1a");

    // FreshchatUser freshchatUser = new FreshchatUser(
    //     "6263f7e2f91bba7f87fcadba", "724f87b8-bac3-498c-b511-6661ad7b8f1a");
    // freshchatUser.setFirstName("test1");
    // Freshchat.setUser(freshchatUser);

    var unreadCountStream = Freshchat.onMessageCountUpdate;
    unreadCountStream.listen((event) {
      print("Have unread messages: $event");
    });

    var userInteractionStream = Freshchat.onUserInteraction;
    userInteractionStream.listen((event) {
      print("User interaction for Freshchat SDK");
    });

    if (Platform.isAndroid) {
      registerFcmToken();
      FirebaseMessaging.instance.onTokenRefresh
          .listen(Freshchat.setPushRegistrationToken);

      Freshchat.setNotificationConfig(notificationInterceptionEnabled: true);
      var notificationInterceptStream = Freshchat.onNotificationIntercept;
      notificationInterceptStream.listen((event) {
        print("Freshchat Notification Intercept detected");
        Freshchat.openFreshchatDeeplink(event["url"]);
      });

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        var data = message.data;
        handleFreshchatNotification(data);
        print("Notification Content: $data");
      });
      FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
    }
  }

  Future<bool> addrestoreIDtoCustomer(String? restoreID) async {
    log(restoreID!);
    final result = await GraphQLRequest.query(
        query: GraphQLQueries.addrestoreIDtoCustomer,
        variables: {
          'restoreID': restoreID,
        });

    log("resultRestoreId:$result");
    if (result['error'] == false) {
      log('restoreID added successfully');
      return true;
    } else {
      log('restoreID  not upload to db');
      return false;
    }
  }

  Future<void> showChatConversation() async {
    FreshchatUser user = await Freshchat.getUser;

    var restoreId = user.getRestoreId();
    addrestoreIDtoCustomer(restoreId);
    log("restoreIdddddd:$restoreId");

    FreshchatUser freshchatUser =
        new FreshchatUser("${_myAccountController.user.id}", restoreId);
    //customerId  == externalId  hint   6263f7e2f91bba7f87fcadba
    freshchatUser
        .setFirstName("${_myAccountController.user.firstName ?? "customer"}");
    freshchatUser.setLastName("${_myAccountController.user.lastName ?? ""}");
    Freshchat.setUser(freshchatUser);

    Freshchat.identifyUser(
        externalId: "${_myAccountController.user.id}", restoreId: restoreId);

    Freshchat.showConversations();
    // Freshchat.showFAQ();
  }
}
