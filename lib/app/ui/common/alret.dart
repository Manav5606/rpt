import 'package:flutter/material.dart';
import 'package:customer_app/app/utils/app_constants.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:get/get.dart';

class Alert {
  static void error(String msg, {bool? top}) {
    if (top == true) {
      Get.snackbar(
        "Error",
        msg,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.only(bottom: 20, left: 10, right: 10),
        backgroundColor: AppConstants.warning.withOpacity(0.60),
        colorText: AppConst.white,
      );
    } else {
      Get.snackbar(
        "Error",
        msg,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.only(bottom: 20, left: 10, right: 10),
        backgroundColor: AppConstants.warning.withOpacity(0.20),
      );
    }
  }
}
