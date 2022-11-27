import 'package:customer_app/theme/app_dimens.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/constants/app_const.dart';

import '../app/constants/responsive.dart';

class AppStyles {
  static const BODY_PADDING = EdgeInsets.symmetric(horizontal: 10);

  static final ADDRESS_STYLE = TextStyle(
      fontSize: SizeUtils.horizontalBlockSize * 4,
      fontWeight: FontWeight.w500,
      fontFamily: 'MuseoSans-500.otf',
      color: AppConst.black,
      letterSpacing: 0.5);

  static final STORE_NAME_STYLE = TextStyle(
    fontSize: SizeUtils.horizontalBlockSize * 4.5,
    fontWeight: FontWeight.w600,
    color: AppConst.black,
    fontFamily: 'MuseoSans-700.otf',
  );
  static final STORES_SUBTITLE_STYLE = TextStyle(
    fontSize: SizeUtils.horizontalBlockSize * 4,
    fontWeight: FontWeight.w500,
    color: AppConst.grey,
  );
  static final BOLD_STYLE = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: SizeUtils.horizontalBlockSize * 4,
    fontFamily: 'MuseoSans-700.otf',
  );
  static final BOLD_STYLE_GREEN = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: SizeUtils.horizontalBlockSize * 4,
    color: AppConst.green,
  );

  static final NEW_STORE_NAME_STYLE = TextStyle(
    fontSize: SizeUtils.horizontalBlockSize * 3.5,
    fontWeight: FontWeight.w600,
    color: AppConst.black,
    fontFamily: 'MuseoSans-700.otf',
  );
  static final NEW_STORE_TEXT_BOLD = TextStyle(
    fontSize: SizeUtils.horizontalBlockSize * 3,
    fontWeight: FontWeight.w500,
    color: AppConst.black,
    fontFamily: 'MuseoSans-600.otf',
  );
  static final NEW_STORES_SUBTITLE_STYLE = TextStyle(
    fontSize: SizeUtils.horizontalBlockSize * 3,
    fontWeight: FontWeight.w400,
    color: AppConst.grey,
  );
}

mixin AppTextStyle {
//bold
  static TextStyle h1Bold(
          {Color? color, FontStyle fontStyle = FontStyle.normal}) =>
      TextStyle(
          fontSize: Dimens.h1,
          fontWeight: FontWeight.bold,
          color: color,
          fontStyle: fontStyle);

  static TextStyle h2Bold(
          {Color? color, FontStyle fontStyle = FontStyle.normal}) =>
      TextStyle(
          fontSize: Dimens.h2,
          fontWeight: FontWeight.bold,
          color: color,
          fontStyle: fontStyle);

  static TextStyle h3Bold(
          {Color? color, FontStyle fontStyle = FontStyle.normal}) =>
      TextStyle(
          fontSize: Dimens.h3,
          fontWeight: FontWeight.bold,
          color: color,
          fontStyle: fontStyle);

  static TextStyle h35Bold(
          {Color? color, FontStyle fontStyle = FontStyle.normal}) =>
      TextStyle(
          fontSize: Dimens.h3,
          fontWeight: FontWeight.w600,
          color: color,
          fontStyle: fontStyle);

  static TextStyle h4Bold(
          {Color? color, FontStyle fontStyle = FontStyle.normal}) =>
      TextStyle(
          fontSize: Dimens.h4,
          fontWeight: FontWeight.w600,
          color: color,
          fontStyle: fontStyle);

  static TextStyle h5Bold(
          {Color? color, FontStyle fontStyle = FontStyle.normal}) =>
      TextStyle(
          fontSize: Dimens.h5,
          fontWeight: FontWeight.bold,
          color: color,
          fontStyle: fontStyle);

  static TextStyle h6Bold(
          {Color? color, FontStyle fontStyle = FontStyle.normal}) =>
      TextStyle(
          fontSize: Dimens.h6,
          fontWeight: FontWeight.bold,
          color: color,
          fontStyle: fontStyle);

  static TextStyle h7Bold(
          {Color? color, FontStyle fontStyle = FontStyle.normal}) =>
      TextStyle(
          fontSize: Dimens.h7,
          fontWeight: FontWeight.bold,
          color: color,
          fontStyle: fontStyle);

  static TextStyle h8Bold(
          {Color? color, FontStyle fontStyle = FontStyle.normal}) =>
      TextStyle(
          fontSize: Dimens.h8,
          fontWeight: FontWeight.bold,
          color: color,
          fontStyle: fontStyle);

//medium
  static TextStyle h1Medium(
          {Color? color, FontStyle fontStyle = FontStyle.normal}) =>
      TextStyle(
          fontSize: Dimens.h1,
          fontWeight: FontWeight.w500,
          color: color,
          fontStyle: fontStyle);

  static TextStyle h2Medium(
          {Color? color, FontStyle fontStyle = FontStyle.normal}) =>
      TextStyle(
          fontSize: Dimens.h2,
          fontWeight: FontWeight.w500,
          color: color,
          fontStyle: fontStyle);

  static TextStyle h3Medium(
          {Color? color, FontStyle fontStyle = FontStyle.normal}) =>
      TextStyle(
          fontSize: Dimens.h3,
          fontWeight: FontWeight.w500,
          color: color,
          fontStyle: fontStyle);

  static TextStyle h4Medium(
          {Color? color, FontStyle fontStyle = FontStyle.normal}) =>
      TextStyle(
          fontSize: Dimens.h4,
          fontWeight: FontWeight.w500,
          color: color,
          fontStyle: fontStyle);

  static TextStyle h5Medium(
          {Color? color, FontStyle fontStyle = FontStyle.normal}) =>
      TextStyle(
          fontSize: Dimens.h5,
          fontWeight: FontWeight.w500,
          color: color,
          fontStyle: fontStyle);

  static TextStyle h6Medium(
          {Color? color, FontStyle fontStyle = FontStyle.normal}) =>
      TextStyle(
          fontSize: Dimens.h6,
          fontWeight: FontWeight.w500,
          color: color,
          fontStyle: fontStyle);

  static TextStyle h7Medium(
          {Color? color, FontStyle fontStyle = FontStyle.normal}) =>
      TextStyle(
          fontSize: Dimens.h7,
          fontWeight: FontWeight.w500,
          color: color,
          fontStyle: fontStyle);

  static TextStyle h8Medium(
          {Color? color, FontStyle fontStyle = FontStyle.normal}) =>
      TextStyle(
          fontSize: Dimens.h8,
          fontWeight: FontWeight.w500,
          color: color,
          fontStyle: fontStyle);
  static TextStyle h6SemiBold(
          {Color? color, FontStyle fontStyle = FontStyle.normal}) =>
      TextStyle(
          fontSize: Dimens.h6,
          fontWeight: FontWeight.w600,
          color: color,
          fontStyle: fontStyle);

  static TextStyle h7SemiBold(
          {Color? color, FontStyle fontStyle = FontStyle.normal}) =>
      TextStyle(
          fontSize: Dimens.h7,
          fontWeight: FontWeight.w600,
          color: color,
          fontStyle: fontStyle);
  //regular
  static TextStyle h1Regular(
          {Color? color, FontStyle fontStyle = FontStyle.normal}) =>
      TextStyle(
          fontSize: Dimens.h1,
          fontWeight: FontWeight.w400,
          color: color,
          fontStyle: fontStyle);

  static TextStyle h2Regular(
          {Color? color, FontStyle fontStyle = FontStyle.normal}) =>
      TextStyle(
          fontSize: Dimens.h2,
          fontWeight: FontWeight.w400,
          color: color,
          fontStyle: fontStyle);

  static TextStyle h3Regular(
          {Color? color, FontStyle fontStyle = FontStyle.normal}) =>
      TextStyle(
          fontSize: Dimens.h3,
          fontWeight: FontWeight.w400,
          color: color,
          fontStyle: fontStyle);

  static TextStyle h4Regular(
          {Color? color, FontStyle fontStyle = FontStyle.normal}) =>
      TextStyle(
          fontSize: Dimens.h4,
          fontWeight: FontWeight.w400,
          color: color,
          fontStyle: fontStyle);

  static TextStyle h5Regular(
          {Color? color, FontStyle fontStyle = FontStyle.normal}) =>
      TextStyle(
          fontSize: Dimens.h5,
          fontWeight: FontWeight.w400,
          color: color,
          fontStyle: fontStyle);

  static TextStyle h6Regular(
          {Color? color, FontStyle fontStyle = FontStyle.normal}) =>
      TextStyle(
          fontSize: Dimens.h6,
          fontWeight: FontWeight.w300,
          color: color,
          fontStyle: fontStyle);

  static TextStyle h7Regular(
          {Color? color, FontStyle fontStyle = FontStyle.normal}) =>
      TextStyle(
          fontSize: Dimens.h7,
          fontWeight: FontWeight.w400,
          color: color,
          fontStyle: fontStyle);

  static TextStyle h8Regular(
          {Color? color, FontStyle fontStyle = FontStyle.normal}) =>
      TextStyle(
          fontSize: Dimens.h8,
          fontWeight: FontWeight.w400,
          color: color,
          fontStyle: fontStyle);
}
