import 'package:flutter/material.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:sizer/sizer.dart';

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
}
