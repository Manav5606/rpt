import 'dart:math';

import 'package:flutter/material.dart';

class ColorConstants {
  static Color lightScaffoldBackgroundColor = hexToColor('#F9F9F9');
  static Color darkScaffoldBackgroundColor = hexToColor('#2F2E2E');
  static Color secondaryAppColor = hexToColor('#22DDA6');
  static Color secondaryDarkAppColor = Colors.white;
  static Color tipColor = hexToColor('#B6B6B6');
  static Color lightGray = Color(0xFFF6F6F6);
  static Color darkGray = Color(0xFF9F9F9F);
  static Color black = Color(0xFF000000);
  static Color white = Color(0xFFFFFFFF);
  static Color kPrimaryColor = Color(0xffDD2863);
  static Color kSecondaryColor = Color(0xff0A7986);
  static Color kGreyColor = Color(0xffF6F7FA);
  static Color kIconColor = Color(0xff616161);
  static Color kSecondaryTextColor = Color(0xfffc647b);
}

final List<Color> circleColors = [
  Color(0xff003f6d),
  Color(0xff3d006d),
  Color(0xff006d60),
  Color(0xff6d5500),
  Color(0xff6d0000),
  Color(0xff4A6D00),
  Color(0xff6D0055)
];
Color randomGenerator() {
  return circleColors[new Random().nextInt(7)];
}

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
      'hex color must be #rrggbb or #rrggbbaa');

  return Color(
    int.parse(hex.substring(1), radix: 16) +
        (hex.length == 7 ? 0xff000000 : 0x00000000),
  );
}
