import 'dart:developer';

import 'package:customer_app/app/constants/app_constants.dart';
import 'package:customer_app/app/controller/signInScreenController.dart';
import 'package:customer_app/app/data/provider/hive/hive.dart';
import 'package:customer_app/controllers/userViewModel.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../app/data/provider/hive/hive_constants.dart';

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
}
