import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/constants/app_const.dart';

class FavoriteAndNearbyTab extends StatelessWidget {
  final TabController? controller;

  FavoriteAndNearbyTab({this.controller, key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
        controller: controller,
        labelColor: AppConst.black,
        labelStyle: AppConst.titleText,
        unselectedLabelStyle: AppConst.titleText,
        indicatorColor: AppConst.themePurple,
        tabs: [
          Tab(
            text: 'My favourite',
          ),
          Tab(
            text: 'Near me',
          ),
        ]);
  }
}

class BusinessButtonTab extends StatelessWidget {
  const BusinessButtonTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonsTabBar(
      physics: AlwaysScrollableScrollPhysics(),
      backgroundColor: AppConst.black,
      unselectedBackgroundColor: AppConst.white,
      unselectedLabelStyle: TextStyle(color: AppConst.black),
      radius: 20,
      borderColor: AppConst.grey,
      unselectedBorderColor: AppConst.grey,
      contentPadding: EdgeInsets.symmetric(horizontal: 10),
      borderWidth: 1,
      labelStyle: TextStyle(color: AppConst.white, fontWeight: FontWeight.bold),
      tabs: [
        Tab(
          text: "Recent",
        ),
        Tab(
          text: "Grocery",
        ),
        Tab(
          text: "Fresh",
        ),
        Tab(
          text: "Restaurant",
        ),
        Tab(
          text: "Pharmacy",
        ),
      ],
    );
  }
}
