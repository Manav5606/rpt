import 'package:badges/badges.dart' as badge;
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
              selectedItemColor: Color(0xff005b41),
              elevation: 0,
              items: [
                BottomNavigationBarItem(
                  label: "Home",
                  // StringContants.orders,
                  icon: (value == 0)
                      ? Icon(
                          Icons.home_outlined,
                          // Icons.home,
                          size: 3.5.h,
                        )
                      : Icon(
                          Icons.home_outlined,
                          size: 3.5.h,
                        ),
                ),
                BottomNavigationBarItem(
                  label: StringContants.chats,
                  icon:
                      // ((UserViewModel.unreadCount.value != 0 &&
                      //         value != 1 &&
                      //         value != 2 &&
                      //         value != 3)
                      //     ? Badge(
                      //         badgeColor: AppConst.blue,
                      //         badgeContent:
                      //             Text("${UserViewModel.unreadCount.value}"),
                      //         child: (value == 1)
                      //             ? Icon(
                      //                 CupertinoIcons.chat_bubble_2_fill,
                      //                 size: 3.5.h,
                      //               )
                      //             : Icon(
                      //                 CupertinoIcons.chat_bubble_2,
                      //                 size: 3.5.h,
                      //               ),
                      //       )
                      //     :
                      badge.Badge(
                    position: badge.BadgePosition.topEnd(top: -10, end: -8),
                    badgeColor: AppConst.red,
                    //  Color(0xff5764da),
                    badgeContent: Text(""),
                    child: (value == 1)
                        ? Icon(
                            CupertinoIcons.chat_bubble,
                            // CupertinoIcons.chat_bubble_fill,
                            size: 3.5.h,
                          )
                        : Icon(
                            CupertinoIcons.chat_bubble,
                            size: 3.5.h,
                          ),
                    // )
                  ),
                ),
                BottomNavigationBarItem(
                    label: StringContants.explore,
                    icon: (value == 2)
                        ? Icon(
                            Icons.search,
                            size: 3.5.h,
                          )
                        : Icon(
                            Icons.search,
                            size: 3.5.h,
                          )),
                BottomNavigationBarItem(
                    label: StringContants.myAccount,
                    icon: (value == 3)
                        ? Icon(
                            CupertinoIcons.person,
                            // CupertinoIcons.person_fill,
                            size: 3.5.h,
                          )
                        : Icon(
                            CupertinoIcons.person,
                            size: 3.5.h,
                          )),
              ],
            ),
          );
        });
  }
}
