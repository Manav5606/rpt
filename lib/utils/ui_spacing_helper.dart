import 'package:flutter/material.dart';

/// Contains useful consts to reduce boilerplate and duplicate code
class UISpacingHelper {
  // Vertical spacing core.constants. Adjust to your liking.
  static const double _VerticalSpaceSmall = 4.0;
  static const double _VerticalSpace12 = 12.0;
  static const double _VerticalSpaceMedium = 20.0;
  static const double _VerticalSpace32 = 32.0;
  static const double _VerticalSpace50 = 50.0;
  static const double _VerticalSpaceLarge = 60.0;
  static const double _VerticalSpaceXLarge = 80.0;
  static const double _VerticalSpaceXXLarge = 100.0;
  static const double _VerticalSpaceXXXLarge = 120.0;

  // Horizontal spacing core.constants. Adjust to your liking.
  static const double _HorizontalSpaceSmall = 4.0;
  static const double _HorizontalSpace12 = 12.0;
  static const double _HorizontalSpaceMedium = 20.0;
  static const double _HorizontalSpace32 = 32.0;
  static const double _HorizontalSpaceLarge = 60.0;

  static const Widget verticalSpaceSmall = SizedBox(height: _VerticalSpaceSmall);
  static const Widget verticalSpaceMedium = SizedBox(height: _VerticalSpaceMedium);
  static const Widget verticalSpace12 = SizedBox(height: _VerticalSpace12);
  static const Widget verticalSpace32 = SizedBox(height: _VerticalSpace32);
  static const Widget verticalSpace50 = SizedBox(height: _VerticalSpace50);
  static const Widget verticalSpaceLarge = SizedBox(height: _VerticalSpaceLarge);
  static const Widget verticalSpaceXLarge = SizedBox(height: _VerticalSpaceXLarge);
  static const Widget verticalSpaceXXLarge = SizedBox(height: _VerticalSpaceXXLarge);
  static const Widget verticalSpaceXXXLarge = SizedBox(height: _VerticalSpaceXXXLarge);

  static const Widget horizontalSpaceSmall = SizedBox(width: _HorizontalSpaceSmall);
  static const Widget horizontalSpaceMedium = SizedBox(width: _HorizontalSpaceMedium);
  static const Widget horizontalSpace12 = SizedBox(width: _HorizontalSpace12);
  static const Widget horizontalSpace32 = SizedBox(width: _HorizontalSpace32);
  static const Widget horizontalSpaceLarge = SizedBox(width: _HorizontalSpaceLarge);
}
