import 'package:flutter/material.dart';
import 'package:customer_app/constants/app_const.dart';

final ThemeData appThemeData = ThemeData(
  primarySwatch: Colors.blue,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  scaffoldBackgroundColor: AppConst.white,
  fontFamily: 'Metropolis',
  appBarTheme: AppBarTheme(
    backgroundColor: AppConst.white,
    iconTheme: IconThemeData(
      color: AppConst.black,
    ),
  ),
  bottomSheetTheme: BottomSheetThemeData(backgroundColor: AppConst.transparent),
);
