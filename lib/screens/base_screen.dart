import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:customer_app/screens/root/network_check.dart';
import 'package:customer_app/widgets/all_chatview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/ui/pages/chat/ChatView.dart';
import 'package:customer_app/app/ui/pages/my_account/my_account_page.dart';
import 'package:customer_app/app/ui/pages/search/explorescreen.dart';
import 'package:customer_app/screens/home/home_screen.dart';
import 'package:customer_app/widgets/bottom_navigation.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  // late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    BottomNavigation.pageIndex.value = 0;
    // _controller = PersistentTabController(initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    Connectivity connectivity = Connectivity();
    return Scaffold(
        body: StreamBuilder<ConnectivityResult>(
          stream: connectivity.onConnectivityChanged,
          builder: (_, snapshot) {
            return CheckInternetConnectionWidget(
              snapshot: snapshot,
              showsnankbar: false,
              widget: _body(),
            );
          },
        ),
        bottomNavigationBar: BottomNavigation(context: context));
  }

  Widget _body() {
    return ValueListenableBuilder(
      valueListenable: BottomNavigation.pageIndex,
      builder: (context, int value, child) {
        return getWidget(value);
      },
    );
  }

  Widget getWidget(int index) {
    switch (index) {
      case 0:
        return HomeScreen();
      case 1:
        return AllChats();
      case 2:
        return ExploreScreen();
      case 3:
        return MyAccountPage();
      default:
        return HomeScreen();
    }
  }
  // @override
  // Widget build(BuildContext context) {
  //   return PersistentTabView(
  //     context,
  //     controller: _controller,
  //     screens: _buildScreens(),
  //     items: _navBarsItems(),
  //     confineInSafeArea: true,
  //     backgroundColor: AppConst.white,
  //     handleAndroidBackButtonPress: true,
  //     resizeToAvoidBottomInset: true,
  //     stateManagement: false,
  //     hideNavigationBarWhenKeyboardShows: true,
  //     popAllScreensOnTapOfSelectedTab: true,
  //     popActionScreens: PopActionScreensType.all,
  //     navBarStyle: NavBarStyle.style3,
  //     decoration: NavBarDecoration(
  //       boxShadow: [
  //         BoxShadow(
  //           color: AppConst.grey.withOpacity(0.7),
  //           blurRadius: 1,
  //           offset: Offset(2, 1),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // List<Widget> _buildScreens() {
  //   return [new HomeScreen(), new ChatView(), new ExploreScreen(), new MyAccountPage()];
  // }
  //
  // List<PersistentBottomNavBarItem> _navBarsItems() {
  //   return [
  //     PersistentBottomNavBarItem(
  //         icon: Icon(
  //           Icons.home,
  //           size: 3.5.h,
  //         ),
  //         title: StringContants.orders,
  //         activeColorPrimary: AppConst.transparent,
  //         activeColorSecondary: AppConst.kSecondaryColor,
  //         inactiveColorPrimary: AppConst.grey),
  //     PersistentBottomNavBarItem(
  //         icon: Badge(
  //           badgeColor: AppConst.kPrimaryColor,
  //           badgeContent: Text(
  //             '1',
  //             style: TextStyle(color: AppConst.white),
  //           ),
  //           child: Icon(
  //             CupertinoIcons.chat_bubble_fill,
  //             size: 3.5.h,
  //           ),
  //         ),
  //         title: "Chats",
  //         activeColorPrimary: AppConst.transparent,
  //         activeColorSecondary: AppConst.kSecondaryColor,
  //         inactiveColorPrimary: AppConst.grey),
  //     PersistentBottomNavBarItem(
  //         icon: Icon(
  //           Icons.search,
  //           size: 3.5.h,
  //         ),
  //         title: "Explore",
  //         activeColorPrimary: AppConst.transparent,
  //         activeColorSecondary: AppConst.kSecondaryColor,
  //         inactiveColorPrimary: AppConst.grey),
  //     PersistentBottomNavBarItem(
  //         icon: Icon(
  //           CupertinoIcons.person_fill,
  //           size: 3.5.h,
  //         ),
  //         title: StringContants.myAccount,
  //         activeColorPrimary: AppConst.transparent,
  //         activeColorSecondary: AppConst.kSecondaryColor,
  //         inactiveColorPrimary: AppConst.grey),
  //   ];
  // }
}
