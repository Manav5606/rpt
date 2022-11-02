import 'dart:developer';

import 'package:customer_app/app/constants/app_constants.dart';
import 'package:customer_app/app/controller/signInScreenController.dart';
import 'package:customer_app/app/data/provider/hive/hive.dart';
import 'package:customer_app/controllers/userViewModel.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../app/data/provider/hive/hive_constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Iterable<E> mapIndexed<E, T>(
    Iterable<T> items, E Function(int index, T item) f) sync* {
  var index = 0;

  for (final item in items) {
    yield f(index, item);
    index = index + 1;
  }
}

connectUserStream({required String userId, String? name}) async {
  final box = Boxes.getCommonBox();
  final token = box.get(HiveConstants.STREAM_TOKEN);
  var infoUser = await Constants.client.connectUser(
    User(id: userId, extraData: {'name': name, 'userType': 'customer'}),
    token!,
  );
  UserViewModel.setUnreadCount(infoUser.totalUnreadCount);

//   void handleNotification(
//     RemoteMessage message,
//     StreamChatClient chatClient,
//   ) async {
//     final data = message.data;

//     if (data['type'] == 'message.new') {
//       // final flutterLocalNotificationsPlugin = await setupLocalNotifications();
//       final messageId = data['id'];
//       final response = await chatClient.getMessage(messageId);

//       // flutterLocalNotificationsPlugin.show(
//       //   1,
//       //   'New message from ${response.message.user?.name} in ${response.channel?.name}',
//       //   response.message.text,
//       //   NotificationDetails(
//       //       android: AndroidNotificationDetails(
//       //     'new_message',
//       //     'New message notifications channel',
//       //   )),
//       // );
//     }
//   }

//   Future<void> onBackgroundMessage(RemoteMessage message) async {
//     final chatClient = StreamChatClient('8gm7wmg4ep65');

//     chatClient.connectUser(
//       User(id: userId),
//       token,
//       connectWebSocket: false,
//     );

//     handleNotification(message, chatClient);
//   }

//   FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
}
