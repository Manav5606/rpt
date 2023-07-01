import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app/constants/responsive.dart';

class AppConst {
  // Colors used
  static const Color transparent = Color(0x00000000);
  static const Color themePurple = Color(0xff9D239A);
  static const Color darkBlue = Color(0xff384093);
  static const Color DarkColor = Color(0xff413E3E);
  static const Color themeBlue = Color(0xff0067BD);
  static const Color blue = Color(0xff136EB4);
  static const Color black = Color(0xff131313);
  static const Color white = Color(0xffffffff);
  static const Color acentGreen = Color(0xff22ffb1);
  static const Color green = Color(0xff028353);
  static const Color greenText = Color(0xff359C76);
  static const Color limegreen = Color(0xff0aad0a);
  static const Color radiumGreen = Color(0xFF22FFB1);
  static const Color Lightgrey = Color(0xFFF2F3F7);
  static const Color darkyellow = Color(0xffe7a408); //Color(0xFFFFC700);
  static const Color lightGreen = Color(0xffA2D889);
  static const Color highLightColor = Color(0xffF5F6F7);
  static const Color ContainerColor = Color(0xff1D3E4A);
  static const Color lightSkyBlue = Color(0xffE6FAF1);
  static const Color lightPichYellow = Color(0xfffef0d3);

  static const Color kPrimaryColor = Color(0xffDD2863);
  static const Color kSecondaryColor = Color(0xff0A7986); //button color
  static const Color kGreyColor = Color(0xffF6F7FA);
  static const Color kIconColor = Color(0xff616161);
  static const Color kSettingsIconColor = Color(0xff888888);
  static const Color kSecondaryTextColor = Color(0xfffc647b);
  static const Color lightYellow = Color(0xffFFECA7);
  static const Color yellow = Color(0xffFFFC38);
  static const Color yellowText = Color(0xffB87A00);
  static const Color pastalGreen = Color(0xFF005B41);
  static const Color containerGreenBackground = Color(0xffE6FAF1);
  static const Color darkGreen = Color(0xff003d29);
  static const Color orange = Color(0xffEF6400);
  static const Color red = Color(0xffEEE0000);
  static const Color voilet = Color(0xffa12aff);

//grey variant
  static const Color grey200 = Color(0xffF5F5F5);
  static const Color grey100 = Color(0xffCACACA);
  static const Color grey = Color(0xff9E9E9E);
  static const Color greySecondaryText = Color(0xffA5A9B5);
  static const Color lightBlack = Color(0xff000000);

  static const Color darkGrey = Color(0xff707070);
  static const Color lightGrey = Color(0xffE7E7F1);
  static const Color shimmerbgColor = Color(0xffF3F3F5);
  static const Color veryLightGrey = Color(0xffF4F4F4);

  static final Duration duration = Duration(milliseconds: 300);
  static final double splashRadius = 20;

  //Linear Gradient
  static LinearGradient gradient1 = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [Color(0xff4A3980), Color(0xff9D239A)]);

  //box shadow
  static BoxShadow shadowBasic = BoxShadow(
      color: AppConst.lightGrey,
      spreadRadius: 1,
      blurRadius: 1,
      offset: Offset(0.5, 0.5));
  static BoxShadow shadowBasic2 = BoxShadow(
      color: AppConst.lightGrey,
      spreadRadius: 1,
      blurRadius: 1,
      offset: Offset(-0.5, -0.5));
  static BoxShadow shadowBottomNavBar = BoxShadow(
      color: AppConst.lightGrey,
      spreadRadius: 0.6,
      blurRadius: 0.6,
      offset: Offset(0, -1));

  //Font Styles
  static TextStyle appbarTextStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      fontFamily: 'MuseoSans-500.otf',
      letterSpacing: 0.3);

  static TextStyle titleText = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      fontFamily: 'Stag',
      letterSpacing: .5);

  static TextStyle titleText1 =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'Stag');
  static TextStyle titleText1_2 =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w400, fontFamily: 'Stag');
  static TextStyle titleText1Purple = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontFamily: 'Stag',
      color: themePurple);
  static TextStyle titleText1White = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      fontFamily: 'Stag',
      color: AppConst.white,
      letterSpacing: .5);

  static TextStyle titleText2 =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w500, fontFamily: 'Stag');
  static TextStyle titleText3 =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'Stag');
  static TextStyle title =
      TextStyle(fontSize: 22, fontWeight: FontWeight.w500, fontFamily: 'Stag');
  static TextStyle titleText2Purple = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      fontFamily: 'Stag',
      color: AppConst.themePurple);

  static TextStyle header = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    fontFamily: 'Stag',
    letterSpacing: 0.3,
  );
  static TextStyle header2 = TextStyle(
      fontSize: SizeUtils.horizontalBlockSize * 4,
      fontWeight: FontWeight.w500,
      fontFamily: 'Stag',
      letterSpacing: 0.3);
  static TextStyle header2Purple = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppConst.themePurple,
      fontFamily: 'Stag',
      letterSpacing: 0.3);
  static TextStyle purpleTextBold = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: themePurple,
      fontFamily: 'Stag',
      letterSpacing: 0.3);

  static TextStyle descriptionText2 = TextStyle(
      fontSize: 14,
      color: black,
      fontWeight: FontWeight.w400,
      fontFamily: 'Stag',
      letterSpacing: 0.3);

  static TextStyle body = TextStyle(
      fontSize: 14,
      color: black,
      fontWeight: FontWeight.w500,
      fontFamily: 'Stag',
      letterSpacing: 0.3);
  static TextStyle bodyBold = TextStyle(
      fontSize: 14,
      color: black,
      fontWeight: FontWeight.w600,
      fontFamily: 'Stag',
      letterSpacing: 0.3);

  static TextStyle descriptionTextWhite2 = TextStyle(
      fontSize: 14,
      color: AppConst.white,
      fontFamily: 'Stag',
      letterSpacing: 0.3);
  static TextStyle descriptionTextPurple2 = TextStyle(
      fontSize: 14, color: themePurple, fontFamily: 'Stag', letterSpacing: 0.3);

  static TextStyle descriptionText = TextStyle(
      fontSize: SizeUtils.horizontalBlockSize * 3,
      color: black,
      fontFamily: 'Stag',
      letterSpacing: 0.3);
  static TextStyle smallBoxTextSan = TextStyle(
      fontSize: SizeUtils.horizontalBlockSize * 3,
      color: black,
      fontFamily: 'open',
      fontWeight: FontWeight.w600,
      letterSpacing: 0.3);
  static TextStyle descriptionTextPurple = TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w600,
      color: themePurple,
      fontFamily: 'open',
      letterSpacing: 0.3);
  static TextStyle descriptionTextRed = TextStyle(
      fontSize: 10,
      color: Color(0xffEE175B),
      fontFamily: 'Stag',
      letterSpacing: 0.3,
      fontWeight: FontWeight.w600);
  static TextStyle descriptionTextWhite = TextStyle(
      fontSize: SizeUtils.horizontalBlockSize * 3,
      color: AppConst.white,
      fontFamily: 'open',
      letterSpacing: 0.3); //10

  static TextStyle headerOpenSan = TextStyle(
      fontSize: SizeUtils.horizontalBlockSize * 4,
      fontFamily: 'open',
      letterSpacing: 0.3); //14

  static TextStyle descriptionTextOpen = TextStyle(
      fontSize: 12, color: black, fontFamily: 'open', letterSpacing: 0.3);

  //image paths
  static String referAndEarnImage =
      'assets/images/Refer and earn illustration.png';

/*  static final Widget couponIcon = SvgPicture.asset(
    'assets/images/svg/coupon.svg',
    color: pink
  );*/
}
