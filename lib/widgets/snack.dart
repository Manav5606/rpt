import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Snack {
  static bottom(String title, String message) {
    Get.rawSnackbar(
      title: title,
      message: message,
      margin: EdgeInsets.all(10),
      borderRadius: 10,
    );
  }

  static top(String title, String message) {
    Get.snackbar(title, message);
  }
}
