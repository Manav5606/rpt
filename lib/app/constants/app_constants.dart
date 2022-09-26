import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class Constants {
  static RxInt start = 60.obs;
  static bool isAbleToCallApi = false;

  static final client =
      StreamChatClient('8gm7wmg4ep65', logLevel: Level.WARNING);
  static final Dio dio = new Dio()
    ..options = BaseOptions(headers: {
      'Accept-Version': 'v1',
      'Authorization': 'Client-ID hmHD_3JNv8PJxroAG0D2PgGE7lxY3_qpKwckT3Z5x_Q'
    });

  static const String fresh = '5fdf434058a42e05d4bc2044';
  static const String grocery = '5fde415692cc6c13f9e879fd';
  static const String APP_ID = "942ba118-79b9-4be7-bdfa-00b4b49522e8";
  static const String APP_KEY = "6b9a4433-5a91-4105-a4d6-e48eedee2ef9";
  static const String DOMAIN = "msdk.in.freshchat.com";
}
