import 'dart:async';

import 'package:customer_app/app/constants/app_constants.dart';
import 'package:customer_app/app/ui/pages/chat/chatViewScreen.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

void showLocalNotification(
  Event event,
  String currentUserId,
  BuildContext context,
) async {
  if (![
        EventType.messageNew,
        EventType.notificationMessageNew,
      ].contains(event.type) ||
      event.user!.id == currentUserId) {
    return;
  }
  if (event.message == null) return;
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final initializationSettingsAndroid =
      AndroidInitializationSettings('launch_background');
  final initializationSettingsIOS = IOSInitializationSettings();
  final initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onSelectNotification: (channelCid) async {
      if (channelCid != null) {
        final client = Constants.client;
        var channel = client.state.channels[channelCid];

        if (channel == null) {
          final splits = channelCid.split(':');
          final type = splits[0];
          final id = splits[1];
          channel = client.channel(
            type,
            id: id,
          );
          await channel.watch();
        }

        Get.to(ChattingScreen(channel: channel));
      }
    },
  );
  await flutterLocalNotificationsPlugin.show(
    event.message!.id.hashCode,
    event.message!.user!.name,
    event.message!.text,
    NotificationDetails(
      android: AndroidNotificationDetails(
        'message channel',
        event.channel!.name,
        //  AppLocalizations.of(context).messageChannelName,
        // channelDescription: '',
        // AppLocalizations.of(context).messageChannelDescription,
        priority: Priority.high,
        importance: Importance.high,
      ),
      iOS: IOSNotificationDetails(),
    ),
    payload: '${event.channelType}:${event.channelId}',
  );
}
