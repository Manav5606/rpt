import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:flutter/material.dart';

class SearchFieldStyle {
  final double height;
  final Color backgroundColor;
  final Color cursorColor;
  final double backgroundCornerRadius;
  final double contentHorizontalPadding;
  final double contentVerticalPadding;
  final double childPadding;
  final double floatingHintSpacing;
  final TextStyle style;
  final TextStyle hintStyle;
  final TextStyle floatingHintStyle;
  final Color focusedBorderColor;
  final Duration animationsDuration;

  SearchFieldStyle.fromTheme(
      {this.height = 36,
      this.backgroundCornerRadius = 8,
      this.contentHorizontalPadding = 8,
      this.contentVerticalPadding = 8,
      this.floatingHintSpacing = 8,
      this.childPadding = 8,
      this.animationsDuration = const Duration(milliseconds: 200)})
      : backgroundColor = AppConst.grey200,
        focusedBorderColor = AppConst.grey,
        cursorColor = AppConst.darkGrey,
        style = AppTextStyle.h5Medium(color: AppConst.black),
        hintStyle = AppTextStyle.h5Medium(color: AppConst.grey),
        floatingHintStyle = AppTextStyle.h5Medium(color: AppConst.black);

}
