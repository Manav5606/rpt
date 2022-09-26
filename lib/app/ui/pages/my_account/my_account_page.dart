// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:customer_app/app/controller/account_controller.dart';
// import 'package:customer_app/app/ui/common/loader.dart';
// import 'package:customer_app/constants/colors.dart';
// import 'package:customer_app/constants/string_constants.dart';
// import 'package:customer_app/data/profile_screen_data.dart';
// import 'package:customer_app/routes/app_list.dart';
// import 'package:customer_app/theme/styles.dart';
// import 'package:get/get.dart';
// import 'package:get/route_manager.dart';
//
// class MyAccountPage extends GetView<MyAccountController> {
//   @override
//   Widget build(BuildContext context) {
//     return AnnotatedRegion<SystemUiOverlayStyle>(
//       value: SystemUiOverlayStyle(
//         statusBarColor: Colors.transparent,
//         statusBarIconBrightness: Brightness.dark,
//         statusBarBrightness: Brightness.dark,
//       ),
//       child: Scaffold(
//         body: SafeArea(
//           child: SingleChildScrollView(
//             physics: ClampingScrollPhysics(),
//             child: GetX<MyAccountController>(
//               initState: (state) {
//                 Get.find<MyAccountController>().getUserData();
//               },
//               builder: (_) {
//                 return _.user.id == null
//                     ? LoadingWidget()
//                     : Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(
//                                 top: 18.0, left: 10, right: 10),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   "Hi, ${_.user.firstName}",
//                                   style: TextStyle(
//                                     color: AppConst.black,
//                                     fontSize: 30,
//                                   ),
//                                 ),
//                                 CircleAvatar(
//                                   radius: 30,
//                                   backgroundColor: Colors.grey[800],
//                                   child: Text(
//                                     StringContants.userName[0],
//                                     style: TextStyle(
//                                       color: AppConst.white,
//                                       fontSize: 30,
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                           Divider(
//                             height: 50,
//                             color: AppConst.black38,
//                           ),
//                           Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 8.0),
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: SizedBox(
//                                     height: 50,
//                                     child: ElevatedButton(
//                                       onPressed: () {},
//                                       style: ElevatedButton.styleFrom(
//                                         textStyle: TextStyle(
//                                           fontSize: 17,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                         elevation: 0,
//                                         primary: kSecondaryColor,
//                                         padding: EdgeInsets.all(13),
//                                       ),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text("Withdraw Cash"),
//                                           Text("\$${_.user.balance} available"),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           ListView.builder(
//                             itemCount: profileScreenData.length,
//                             shrinkWrap: true,
//                             physics: NeverScrollableScrollPhysics(),
//                             itemBuilder: (context, index) {
//                               return ListTile(
//                                 contentPadding:
//                                     EdgeInsets.symmetric(horizontal: 12),
//                                 dense: true,
//                                 leading: profileScreenData[index].icon,
//                                 horizontalTitleGap: 0,
//                                 title: Text(
//                                   profileScreenData[index].name,
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                   ),
//                                 ),
//                                 trailing: Icon(
//                                   Icons.arrow_forward_ios_rounded,
//                                   color: kIconColor,
//                                   size: 20,
//                                 ),
//                                 onTap: () {
//                                   if (index == 0) {
//                                     Get.toNamed(AppRoutes.Orders);
//                                   } else if (index == 1) {
//                                     Get.toNamed(AppRoutes.EditProfile);
//                                   } else if (index == 2) {
//                                     Get.toNamed(AppRoutes.History);
//                                   } else if (index == 3) {
//                                     Get.toNamed(AppRoutes.MyAddresses);
//                                   } else if (index == 4) {
//                                     Get.toNamed(AppRoutes.ReferAndEarn);
//                                   } else if (index == 5) {
//                                     Get.toNamed(AppRoutes.Wallet);
//                                   }
//                                 },
//                               );
//                             },
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Padding(
//                             padding: AppStyles.BODY_PADDING,
//                             child: GestureDetector(
//                               onTap: () => Get.toNamed(AppRoutes.ReferAndEarn),
//                               child: Container(
//                                 height: 110,
//                                 width: double.infinity,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(5),
//                                   border: Border.all(
//                                     color: Colors.grey,
//                                   ),
//                                   image: DecorationImage(
//                                     fit: BoxFit.fill,
//                                     image: AssetImage(
//                                       'assets/images/account_banner.png',
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       );
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/controller/account_controller.dart';
import 'package:customer_app/app/ui/common/loader.dart';
import 'package:customer_app/app/ui/pages/refer_and_earn/refer_and_earn_screen.dart';
import 'package:customer_app/constants/app_const.dart';

import 'package:customer_app/widgets/custom_alert_dialog.dart';
import 'package:customer_app/data/profile_screen_data.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:sizer/sizer.dart';

class MyAccountPage extends GetView<MyAccountController> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppConst.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: GetX<MyAccountController>(
              initState: (state) {
                Get.find<MyAccountController>().getUserData();
              },
              builder: (_) {
                return _.user.id == null
                    ? LoadingWidget() // throw an 404 error msg
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 4.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 2.h, left: 5.w, right: 5.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: "Hi, ${_.user.firstName ?? ""}",
                                    style: TextStyle(
                                        color: AppConst.black,
                                        fontSize:
                                            SizeUtils.horizontalBlockSize * 6,
                                        fontWeight: FontWeight.bold),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: "\n${_.user.mobile ?? ""}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: SizeUtils
                                                      .horizontalBlockSize *
                                                  4.5)),
                                      TextSpan(
                                          text: "\n${_.user.email ?? ""}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: SizeUtils
                                                      .horizontalBlockSize *
                                                  4.5)),
                                    ],
                                  ),
                                ),
                                // Expanded(
                                //   child: Text(
                                //     "Hi, ${_.user.firstName?.substring(0, 20) ?? _.user.mobile}",
                                //     style: TextStyle(
                                //       color: AppConst.black,
                                //       fontSize: 20.sp,
                                //     ),
                                //   ),
                                // ),
                                Container(
                                  height: 6.h,
                                  width: 15.w,
                                  decoration: BoxDecoration(
                                    color: (_.user.firstName! == null ||
                                            _.user.firstName == "")
                                        ? AppConst.darkGrey
                                        : Colors.primaries[Random()
                                            .nextInt(Colors.primaries.length)],
                                    shape: BoxShape.circle,
                                    border: Border.all(width: 0.1),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppConst.black.withOpacity(0.1),
                                        offset: Offset(
                                          0,
                                          1.h,
                                        ),
                                        blurRadius: 1.h,
                                        spreadRadius: 1.0,
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: (_.user.firstName! == null ||
                                            _.user.firstName == "")
                                        ? Icon(
                                            CupertinoIcons.person_alt,
                                            size: 4.h,
                                            color: AppConst.white,
                                          )
                                        : Text(
                                            "${_.user.firstName![0].toUpperCase()}",
                                            style: TextStyle(
                                              color: AppConst.white,
                                              fontSize: SizeUtils
                                                      .horizontalBlockSize *
                                                  6,
                                            ),
                                          ),
                                    // child: Icon(
                                    //   CupertinoIcons.person_alt,
                                    //   size: 4.h,
                                    //   color: AppConst.white,
                                    // ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          myWalletControl(context, _),
                          SizedBox(
                            height: 3.h,
                          ),
                          ListView.builder(
                            itemCount: profileScreenData.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return ListTile(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 4.w),
                                dense: true,
                                leading: profileScreenData[index].icon,
                                horizontalTitleGap: 0,
                                title: Text(
                                  profileScreenData[index].name,
                                  style: TextStyle(
                                      fontSize:
                                          SizeUtils.horizontalBlockSize * 4.5,
                                      fontWeight: FontWeight.w500),
                                ),
                                onTap: () {
                                  if (index == 0) {
                                    // Get.toNamed(AppRoutes.Orders);
                                    Get.toNamed(AppRoutes.EditProfile);
                                  } else if (index == 1) {
                                    Get.toNamed(AppRoutes.History);
                                  } else if (index == 2) {
                                    Get.toNamed(AppRoutes.MyAddresses);
                                  }
                                  // else if (index == 3) {

                                  // }
                                  // else if (index == 4) {
                                  //   Get.toNamed(AppRoutes.ActiveOrders);
                                  // }
                                },
                              );
                            },
                          ),
                          lineSeparator(),
                          Row(
                            children: [
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                "Credits Proms & giftcards ",
                                style: TextStyle(
                                    fontSize:
                                        SizeUtils.horizontalBlockSize * 4.5,
                                    color: AppConst.black),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          myAccount_item_maker(
                              Icons.currency_rupee, "Invite friends, get  10 ",
                              () {
                            Get.to(ReferAndEarnScreen());
                          }),
                          lineSeparator(),
                          myAccount_item_maker(Icons.logout_rounded, "Logout",
                              () {
                            _showLogOutDialog();
                          }),
                          lineSeparator(),
                        ],
                      );
              },
            ),
          ),
        ),
      ),
    );
  }

  Padding myWalletControl(BuildContext context, MyAccountController _) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: Container(
        height: 13.h,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: AppConst.lightYellow,
          border: Border.all(width: 0.1),

          // image: DecorationImage(
          //     image: NetworkImage(
          //         'https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg'),
          //     fit: BoxFit.cover,
          //     opacity: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 2.w, top: 1.h, bottom: 1.5.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Your total wallet amount is \u{20B9} ${_.user.balance?.toStringAsFixed(2)} ",
                style: TextStyle(
                    fontSize: SizeUtils.horizontalBlockSize * 5,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Unlock unlimited free delivery and more ! ",
                style: TextStyle(
                    fontSize: SizeUtils.horizontalBlockSize * 3.5,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: 1.h,
              ),
              FittedBox(
                child: SizedBox(
                  height: 3.5.h,
                  child: ElevatedButton(
                    child: Text(
                      'So many wallets!',
                      style: TextStyle(
                          fontSize: SizeUtils.horizontalBlockSize * 3.2,
                          color: AppConst.black),
                    ),
                    onPressed: () {
                      Get.toNamed(AppRoutes.Wallet);
                    },
                    style: ElevatedButton.styleFrom(
                        primary: AppConst.orange,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector myAccount_item_maker(IconData icon, String text, onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 5.w,
          ),
          Icon(icon),
          SizedBox(
            width: 2.w,
          ),
          Text(
            text,
            style: TextStyle(
                fontSize: SizeUtils.horizontalBlockSize * 4.5,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }

  Widget lineSeparator() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
      child: Divider(
        height: 1,
        color: AppConst.black,
      ),
    );
  }
}

void _showLogOutDialog() {
  showDialog(
    barrierDismissible: true,
    context: Get.context!,
    builder: (BuildContext context) {
      return CustomDialog(
        title: 'Log out',
        content: "Are you sure you want to logout?",
        buttontext: 'Log out',
        onTap: () {
          Get.offAllNamed(AppRoutes.Authentication);
        },
      );
    },
  );
}
