import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/constants/app_const.dart';

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
      ),
      name: "Your account settings"),
  ProfileScreen(
      icon: Icon(
        Icons.star_outline,
        color: AppConst.kIconColor,
      ),
      name: "Order History"),
  ProfileScreen(
      icon: Icon(
        Icons.location_city_rounded,
        color: AppConst.kIconColor,
      ),
      name: "My Addresses"),
  // ProfileScreen(
  //     icon: Icon(
  //       Icons.receipt_outlined,
  //       color: kIconColor,
  //     ),
  //     name: "My Wallet"),
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
