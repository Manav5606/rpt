import 'dart:developer';

import 'package:customer_app/app/constants/app_constants.dart';
import 'package:customer_app/app/data/provider/graphql/queries.dart';
import 'package:customer_app/app/data/provider/graphql/request.dart';
import 'package:customer_app/app/data/provider/hive/hive.dart';
import 'package:customer_app/app/data/provider/hive/hive_constants.dart';
import 'package:customer_app/app/data/repository/hive_repository.dart';
import 'package:customer_app/app/ui/pages/chat/ChatView.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/data/models/user_model.dart';
import 'package:customer_app/widgets/snack.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:customer_app/models/received_notification.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:get/get.dart';
import 'package:rxdart/subjects.dart';
import 'package:sizer/sizer.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class FireBaseNotification {
  static final FireBaseNotification _fireBaseNotification =
      FireBaseNotification.init();
  static String? fcmToken;
  factory FireBaseNotification() {
    return _fireBaseNotification;
  }

  FireBaseNotification.init();

  late FirebaseMessaging firebaseMessaging;
  late AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    // 'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  final _selectNotificationSubject = PublishSubject<String?>();
  final HiveRepository hiveRepository = HiveRepository();

  Stream<String?> get selectNotificationStream =>
      _selectNotificationSubject.stream;

  final _didReceiveLocalNotificationSubject =
      PublishSubject<ReceivedNotification>();

  Stream<ReceivedNotification> get didReceiveLocalNotificationStream =>
      _didReceiveLocalNotificationSubject.stream;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static bool isNotification = false;

  void firebaseCloudMessagingLSetup() async {
    firebaseMessaging = FirebaseMessaging.instance;
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    iOSPermission(firebaseMessaging);

    Future<bool> addFirebaseToken(String? firebase_token) async {
      log("inside the box");
      final result = await GraphQLRequest.query(
          query: GraphQLQueries.addFirebaseToken,
          variables: {
            'firebase_token': firebase_token,
          });
      log("resultfcm:$result");
      if (result['error'] == false) {
        log('fcm token updated successfully');
        return true;
      } else {
        log('fcm token not upload to db');
        return false;
      }
    }

    fcmToken = await firebaseMessaging
        .getToken(); // handle token value when token is null
    String fcmTok = fcmToken.toString();

    firebaseMessaging.onTokenRefresh.listen((event) {
      Constants.client.addDevice(event, PushProvider.firebase);
    }).onError((err) {
      log(err);
      // Error getting token.
    });
    ;
    Constants.client.addDevice(fcmTok, PushProvider.firebase);

    if (fcmToken != null && fcmToken!.isNotEmpty) {
      final box = Boxes.getCommonBoolBox();
      final isLogin = box.get(HiveConstants.USER_TOKEN);
      if (isLogin != null) {
        addFirebaseToken(fcmToken);
      }
    }
    log('TOKEN to be Registered: $fcmToken');

    // await firebaseMessaging.getToken().then((token) {
    //   log('TOKEN to be Registered: $token');
    // }
    // );

    // Fired when app is coming from a terminated state
    var initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) _showLocalNotification(initialMessage);

    // Fired when app is in foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      _showLocalNotification(message);
      // notificationToNavigat(); local
      debugPrint(
          'Got a message, app is in the foreground! ${message.notification}');
    });

    // Fired when app is in foreground
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      notificationToNavigat();
      _showLocalNotification(message);
      selectNotification('playLoad -->');
      debugPrint('Got a message, app is in the foreground! onMessage');
    });

    // background message
    FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
  }

  Future<void> _backgroundMessageHandler(RemoteMessage message) async {
    final chatClient = StreamChatClient('8gm7wmg4ep65');
    log("inside the background messge");
    final box = Boxes.getCommonBox();
    final token = box.get(HiveConstants.STREAM_TOKEN);
    final HiveRepository hiveRepository = HiveRepository();
    UserModel? userModel;

    chatClient.connectUser(
      User(id: userModel?.id ?? ''),
      token!,
      connectWebSocket: false,
    );

    handleNotification(message, chatClient);
    debugPrint(
        'Got a message, app is in the background! ${message.notification}');
    print('_backgroundMessageHandler');
    print(message.data);
  }

  void handleNotification(
    RemoteMessage message,
    StreamChatClient chatClient,
  ) async {
    final data = message.data;

    if (data['type'] == 'message.new') {
      // final flutterLocalNotificationsPlugin = await setupLocalNotifications();
      final messageId = data['id'];
      final response = await chatClient.getMessage(messageId);
      log("response: ${response.message.text}");
      // flutterLocalNotificationsPlugin.show(
      //   1,
      //   'New message from ${response.message.user?.name} in ${response.channel?.name}',
      //   response.message.text,
      //   NotificationDetails(
      //       android: AndroidNotificationDetails(
      //     'new_message',
      //     'New message notifications channel',
      //   )),
      // );
    }
  }

  Future<void> setUpLocalNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            requestAlertPermission: false,
            requestBadgePermission: false,
            requestSoundPermission: false,
            onDidReceiveLocalNotification: (
              int id,
              String? title,
              String? body,
              String? payload,
            ) async {
              _didReceiveLocalNotificationSubject.add(
                ReceivedNotification(
                  id: id,
                  title: title,
                  body: body,
                  payload: payload,
                ),
              );
            });

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) => selectNotification(payload));
    log("flutterLocalNotificationsPlugin Complete");
  }

  Future selectNotification(String? payload) async {
    if (payload != null && payload.isNotEmpty) {
      log('selectNotificationSubject: $payload');
      _selectNotificationSubject.add(payload);
    }
  }

  void iOSPermission(firebaseMessaging) {
    firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void _showLocalNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');

    /// Local Notification
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, notification!.title, notification.body, platformChannelSpecifics,
        payload: notification.title);
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        backgroundColor: AppConst.transparent,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        // margin: EdgeInsets.only(bottom: 75.h, right: 2.w, left: 2.w),
        content: Snack.bottom('', 'Order Placed Successfully')

        // Container(
        //     height: 12.h,
        //     decoration: BoxDecoration(
        //         color: AppConst.lightYellow,
        //         borderRadius: BorderRadius.circular(8)),
        //     child: Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text(
        //             notification.title ?? '',
        //             style: TextStyle(color: AppConst.black),
        //           ),
        //           Text(
        //             notification.body ?? '',
        //             style: TextStyle(color: AppConst.black),
        //           ),
        //         ],
        //       ),
        //     )),
        ));
  }

  void localNotificationRequestPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  void configureDidReceiveLocalNotificationSubject() {
    log('configureDidReceiveLocalNotificationSubject stream listen"');
    didReceiveLocalNotificationStream
        .listen((ReceivedNotification receivedNotification) async {
      log("payloadNotification: $receivedNotification");
      notificationToNavigat();
    });
  }

  void configureSelectNotificationSubject() {
    log("configureSelectNotificationSubject stream listen");
    selectNotificationStream.listen((String? payload) {
      log("payloadNotification: $payload");

      notificationToNavigat();
    });
  }

  void notificationToNavigat() {
    log('notificationToNavigat : ');
    Get.toNamed(AppRoutes.ChatView);
  }

  void localNotificationDispose() {
    _didReceiveLocalNotificationSubject.close();
    _selectNotificationSubject.close();
  }
}
