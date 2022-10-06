import 'package:badges/badges.dart';
import 'package:customer_app/app/controller/signInScreenController.dart';
import 'package:customer_app/app/data/provider/hive/hive.dart';
import 'package:customer_app/controllers/userViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/constants/string_constants.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BottomNavigation extends StatelessWidget {
  static ValueNotifier<int> pageIndex = ValueNotifier(0);

  final SignInScreenController _signinContoller =
      Get.put(SignInScreenController());

  final BuildContext context;

  BottomNavigation({Key? key, required this.context}) : super(key: key);

  void _onItemTapped(int index) {
    pageIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: pageIndex,
        builder: (context, int value, child) {
          return Container(
            decoration: BoxDecoration(
                border:
                    Border.all(width: 0.5.w, color: AppConst.veryLightGrey)),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: AppConst.white,
              currentIndex: value,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              onTap: _onItemTapped,
              unselectedItemColor: AppConst.grey,
              iconSize: 22,
              selectedItemColor: AppConst.kSecondaryColor,
              elevation: 0,
              items: [
                BottomNavigationBarItem(
                  label: StringContants.orders,
                  icon: Icon(
                    Icons.home,
                    size: 3.5.h,
                  ),
                ),
                BottomNavigationBarItem(
                    label: StringContants.chats,
                    icon: ((UserViewModel.unreadCount.value != 0 &&
                            value != 1 &&
                            value != 2 &&
                            value != 3)
                        ? Badge(
                            badgeContent:
                                Text("${UserViewModel.unreadCount.value}"),
                            child: Icon(
                              CupertinoIcons.chat_bubble_fill,
                              size: 3.5.h,
                            ),
                          )
                        : Badge(
                            badgeContent: Text(""),
                            child: Icon(
                              CupertinoIcons.chat_bubble_fill,
                              size: 3.5.h,
                            ),
                          ))),
                BottomNavigationBarItem(
                  label: StringContants.explore,
                  icon: Icon(
                    Icons.search,
                    size: 3.5.h,
                  ),
                ),
                BottomNavigationBarItem(
                  label: StringContants.myAccount,
                  icon: Icon(
                    CupertinoIcons.person_fill,
                    size: 3.5.h,
                  ),
                ),
              ],
            ),
          );
        });
  }
}
