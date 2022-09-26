import 'package:flutter/material.dart';
import 'package:customer_app/constants/app_const.dart';

final ThemeData appThemeData = ThemeData(
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: AppConst.white,
  fontFamily: 'MuseoSans',
  appBarTheme: AppBarTheme(
    backgroundColor: AppConst.white,
    iconTheme: IconThemeData(
      color: AppConst.black,
    ),
  ),
);
