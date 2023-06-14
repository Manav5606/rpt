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
import 'package:get/get.dart';

class BaseScreen extends StatefulWidget {
    final int? index;


  
  const BaseScreen({Key? key, this.index}) : super(key: key);

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  // late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    Map arg = Get.arguments ?? {};
     int? index = arg['index'] ?? 0;
    BottomNavigation.pageIndex.value = index ?? 0;
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

}
