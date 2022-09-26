import 'package:flutter/material.dart';
import 'package:customer_app/app/ui/pages/stores/StoreView.dart';
import 'package:customer_app/app/ui/pages/stores/chatOrder/chatOrder.dart';
import 'package:customer_app/app/ui/pages/stores/freshStore.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({Key? key}) : super(key: key);

  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  late PersistentTabController _controller;
  bool isGrocery = false;

  @override
  void initState() {
    super.initState();
    Map arg = Get.arguments ?? {};
    isGrocery = arg['isGrocery'] ?? false;
    _controller = PersistentTabController(initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: AppConst.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      navBarStyle: NavBarStyle.style14,
    );
  }

  List<Widget> _buildScreens() {
    return [
      StoreView(),
      isGrocery ? ChatOrderScreen() : FreshStoreScreen(),
      // Text("Buy it again"),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          icon: Icon(Icons.shopping_bag_outlined),
          title: "Shop",
          activeColorPrimary: AppConst.kSecondaryColor,
          activeColorSecondary: AppConst.green,
          inactiveColorPrimary: AppConst.grey),
      PersistentBottomNavBarItem(
          icon: isGrocery ? Icon(Icons.chat_bubble_outlined) : Icon(Icons.shopping_cart),
          title: isGrocery ? "Chat Order" : "Fresh Store",
          activeColorPrimary: AppConst.kSecondaryColor,
          activeColorSecondary: AppConst.green,
          inactiveColorPrimary: AppConst.grey),
      // PersistentBottomNavBarItem(
      //     icon: Icon(Icons.fastfood),
      //     title: "Buy it again",
      //     activeColorPrimary: AppConst.kSecondaryColor,
      //     activeColorSecondary: AppConst.green,
      //     inactiveColorPrimary: AppConst.grey),
    ];
  }
}
