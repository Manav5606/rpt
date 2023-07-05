import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen {
  String name;
  Icon icon;

  ProfileScreen({
    required this.icon,
    required this.name,
  });
}

List<ProfileScreen> profileScreenData = [
  // ProfileScreen(
  //     icon: Icon(
  //       Icons.shopping_cart_outlined,
  //       color: AppConst.kIconColor,
  //     ),
  //     name: "Your Orders"),
  ProfileScreen(
      icon: Icon(
        Icons.settings_outlined,
        color: AppConst.kIconColor,
        size: 1.7.h,
      ),
      name: "Your account settings"),
  ProfileScreen(
      icon: Icon(
        Icons.star_outline,
        color: AppConst.kIconColor,
        size: 1.7.h,
      ),
      name: "Order History"),
  ProfileScreen(
      icon: Icon(
        Icons.location_city_rounded,
        color: AppConst.kIconColor,
        size: 1.7.h,
      ),
      name: "My Addresses"),
  ProfileScreen(
      icon: Icon(
        Icons.help,
        color: AppConst.kIconColor,
        size: 1.7.h,
      ),
      name: "Chat Support"),
  // ProfileScreen(
  //     icon: Icon(
  //       Icons.calendar_today_outlined,
  //       color: AppConst.kIconColor,
  //     ),
  //     name: "Active Orders"),
  // ProfileScreen(
  //     icon: Icon(
  //       Icons.help_outline,
  //       color: kIconColor,
  //     ),
  //     name: "Help"),
  // ProfileScreen(
  //     icon: Icon(
  //       Icons.info_outline,
  //       color: kIconColor,
  //     ),
  //     name: "About this app"),
  // ProfileScreen(
  //     icon: Icon(
  //       Icons.shopping_bag_outlined,
  //       color: kIconColor,
  //     ),
  //     name: "Become a Shopper"),
];

List<ProfileScreen> profileScreenDataNew = [
  ProfileScreen(
    icon: Icon(
      Icons.account_balance_wallet_outlined,
      color: AppConst.grey,
      size: 1.7.h,
    ),
    name: "Manage Wallet",
  ),
  ProfileScreen(
    icon: Icon(
      Icons.shopping_cart_outlined,
      color: AppConst.grey,
      size: 1.7.h,
    ),
    name: "Orders & Receipts & Redeems ",
  ),
  ProfileScreen(
    icon: Icon(
      Icons.location_on_outlined,
      color: AppConst.grey,
      size: 1.7.h,
    ),
    name: "My Addresses",
  ),
  ProfileScreen(
    icon: Icon(
      Icons.receipt_outlined,
      color: AppConst.grey,
      size: 1.7.h,
    ),
    name: "Get instant",
  ),
  // ProfileScreen(
  //   icon: Icon(
  //     Icons.person_add_alt_outlined,
  //     color: AppConst.grey,
  //     size: 2.7.h,
  //   ),
  //   name: "Invite Friends & Family, Get ₹10",
  // ),
  ProfileScreen(
    icon: Icon(
      CupertinoIcons.chat_bubble,
      color: AppConst.grey,
      size: 1.7.h,
    ),
    name: "Customer Service",
  ),
  ProfileScreen(
    icon: Icon(
      CupertinoIcons.info,
      color: AppConst.grey,
      size: 1.7.h,
    ),
    name: "About Us",
  ),
  ProfileScreen(
    icon: Icon(
      Icons.power_settings_new_rounded,
      color: AppConst.grey,
      size: 1.7.h,
    ),
    name: "Logout",
  ),
];
