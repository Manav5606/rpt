// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:customer_app/app/controller/account_controller.dart';
// // import 'package:customer_app/app/ui/common/loader.dart';
// // import 'package:customer_app/constants/colors.dart';
// // import 'package:customer_app/constants/string_constants.dart';
// // import 'package:customer_app/data/profile_screen_data.dart';
// // import 'package:customer_app/routes/app_list.dart';
// // import 'package:customer_app/theme/styles.dart';
// // import 'package:get/get.dart';
// // import 'package:get/route_manager.dart';
// //
// // class MyAccountPage extends GetView<MyAccountController> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return AnnotatedRegion<SystemUiOverlayStyle>(
// //       value: SystemUiOverlayStyle(
// //         statusBarColor: Colors.transparent,
// //         statusBarIconBrightness: Brightness.dark,
// //         statusBarBrightness: Brightness.dark,
// //       ),
// //       child: Scaffold(
// //         body: SafeArea(
// //           child: SingleChildScrollView(
// //             physics: ClampingScrollPhysics(),
// //             child: GetX<MyAccountController>(
// //               initState: (state) {
// //                 Get.find<MyAccountController>().getUserData();
// //               },
// //               builder: (_) {
// //                 return _.user.id == null
// //                     ? LoadingWidget()
// //                     : Column(
// //                         children: [
// //                           Padding(
// //                             padding: const EdgeInsets.only(
// //                                 top: 18.0, left: 10, right: 10),
// //                             child: Row(
// //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                               children: [
// //                                 Text(
// //                                   "Hi, ${_.user.firstName}",
// //                                   style: TextStyle(
// //                                     color: AppConst.black,
// //                                     fontSize: 30,
// //                                   ),
// //                                 ),
// //                                 CircleAvatar(
// //                                   radius: 30,
// //                                   backgroundColor: Colors.grey[800],
// //                                   child: Text(
// //                                     StringContants.userName[0],
// //                                     style: TextStyle(
// //                                       color: AppConst.white,
// //                                       fontSize: 30,
// //                                     ),
// //                                   ),
// //                                 )
// //                               ],
// //                             ),
// //                           ),
// //                           Divider(
// //                             height: 50,
// //                             color: AppConst.black38,
// //                           ),
// //                           Padding(
// //                             padding:
// //                                 const EdgeInsets.symmetric(horizontal: 8.0),
// //                             child: Row(
// //                               children: [
// //                                 Expanded(
// //                                   child: SizedBox(
// //                                     height: 50,
// //                                     child: ElevatedButton(
// //                                       onPressed: () {},
// //                                       style: ElevatedButton.styleFrom(
// //                                         textStyle: TextStyle(
// //                                           fontSize: 17,
// //                                           fontWeight: FontWeight.bold,
// //                                         ),
// //                                         elevation: 0,
// //                                         primary: kSecondaryColor,
// //                                         padding: EdgeInsets.all(13),
// //                                       ),
// //                                       child: Row(
// //                                         mainAxisAlignment:
// //                                             MainAxisAlignment.spaceBetween,
// //                                         children: [
// //                                           Text("Withdraw Cash"),
// //                                           Text("\$${_.user.balance} available"),
// //                                         ],
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                           ListView.builder(
// //                             itemCount: profileScreenData.length,
// //                             shrinkWrap: true,
// //                             physics: NeverScrollableScrollPhysics(),
// //                             itemBuilder: (context, index) {
// //                               return ListTile(
// //                                 contentPadding:
// //                                     EdgeInsets.symmetric(horizontal: 12),
// //                                 dense: true,
// //                                 leading: profileScreenData[index].icon,
// //                                 horizontalTitleGap: 0,
// //                                 title: Text(
// //                                   profileScreenData[index].name,
// //                                   style: TextStyle(
// //                                     fontSize: 18,
// //                                   ),
// //                                 ),
// //                                 trailing: Icon(
// //                                   Icons.arrow_forward_ios_rounded,
// //                                   color: kIconColor,
// //                                   size: 20,
// //                                 ),
// //                                 onTap: () {
// //                                   if (index == 0) {
// //                                     Get.toNamed(AppRoutes.Orders);
// //                                   } else if (index == 1) {
// //                                     Get.toNamed(AppRoutes.EditProfile);
// //                                   } else if (index == 2) {
// //                                     Get.toNamed(AppRoutes.History);
// //                                   } else if (index == 3) {
// //                                     Get.toNamed(AppRoutes.MyAddresses);
// //                                   } else if (index == 4) {
// //                                     Get.toNamed(AppRoutes.ReferAndEarn);
// //                                   } else if (index == 5) {
// //                                     Get.toNamed(AppRoutes.Wallet);
// //                                   }
// //                                 },
// //                               );
// //                             },
// //                           ),
// //                           SizedBox(
// //                             height: 10,
// //                           ),
// //                           Padding(
// //                             padding: AppStyles.BODY_PADDING,
// //                             child: GestureDetector(
// //                               onTap: () => Get.toNamed(AppRoutes.ReferAndEarn),
// //                               child: Container(
// //                                 height: 110,
// //                                 width: double.infinity,
// //                                 decoration: BoxDecoration(
// //                                   borderRadius: BorderRadius.circular(5),
// //                                   border: Border.all(
// //                                     color: Colors.grey,
// //                                   ),
// //                                   image: DecorationImage(
// //                                     fit: BoxFit.fill,
// //                                     image: AssetImage(
// //                                       'assets/images/account_banner.png',
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ),
// //                             ),
// //                           ),
// //                         ],
// //                       );
// //               },
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'dart:math';
// import 'dart:ui';
// import 'package:customer_app/app/data/provider/hive/hive.dart';
// import 'package:customer_app/app/ui/pages/chat/freshchat_controller.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:customer_app/app/constants/responsive.dart';
// import 'package:customer_app/app/controller/account_controller.dart';
// import 'package:customer_app/app/ui/common/loader.dart';
// import 'package:customer_app/app/ui/pages/refer_and_earn/refer_and_earn_screen.dart';
// import 'package:customer_app/constants/app_const.dart';

// import 'package:customer_app/widgets/custom_alert_dialog.dart';
// import 'package:customer_app/data/profile_screen_data.dart';
// import 'package:customer_app/routes/app_list.dart';
// import 'package:get/get.dart';
// import 'package:get/route_manager.dart';
// import 'package:hive/hive.dart';
// import 'package:sizer/sizer.dart';

// import '../../../data/model/user_model.dart';
// import '../../../data/provider/hive/hive_constants.dart';

// class MyAccountPage extends GetView<MyAccountController> {
//   final freshChatController _freshChat = Get.find();
//   @override
//   Widget build(BuildContext context) {
//     return AnnotatedRegion<SystemUiOverlayStyle>(
//       value: SystemUiOverlayStyle(
//         statusBarColor: AppConst.transparent,
//         statusBarIconBrightness: Brightness.dark,
//         statusBarBrightness: Brightness.dark,
//       ),
//       child: Scaffold(
//         key: _freshChat.scaffoldKey,
//         body: SafeArea(
//           child: SingleChildScrollView(
//             physics: ClampingScrollPhysics(),
//             child: GetX<MyAccountController>(
//               initState: (state) {
//                 Get.find<MyAccountController>().getUserData();
//               },
//               builder: (_) {
//                 return _.user.id == null
//                     ? LoadingWidget() // throw an 404 error msg
//                     : Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(
//                             height: 4.h,
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(
//                                 top: 2.h, left: 5.w, right: 5.w),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 RichText(
//                                   text: TextSpan(
//                                     text: "Hi, ${_.user.firstName ?? ""}",
//                                     style: TextStyle(
//                                         color: AppConst.black,
//                                         fontSize:
//                                             SizeUtils.horizontalBlockSize * 6,
//                                         fontWeight: FontWeight.bold),
//                                     children: <TextSpan>[
//                                       TextSpan(
//                                           text: "\n${_.user.tablet ?? ""}",
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.normal,
//                                               fontSize: SizeUtils
//                                                       .horizontalBlockSize *
//                                                   4.5)),
//                                       TextSpan(
//                                           text: "\n${_.user.email ?? ""}",
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.normal,
//                                               fontSize: SizeUtils
//                                                       .horizontalBlockSize *
//                                                   4.5)),
//                                     ],
//                                   ),
//                                 ),
//                                 // Expanded(
//                                 //   child: Text(
//                                 //     "Hi, ${_.user.firstName?.substring(0, 20) ?? _.user.tablet}",
//                                 //     style: TextStyle(
//                                 //       color: AppConst.black,
//                                 //       fontSize: 20.sp,
//                                 //     ),
//                                 //   ),
//                                 // ),
//                                 Container(
//                                   height: 6.h,
//                                   width: 15.w,
//                                   decoration: BoxDecoration(
//                                     color: (_.user.firstName! == null ||
//                                             _.user.firstName == "")
//                                         ? AppConst.darkGrey
//                                         : Colors.primaries[Random()
//                                             .nextInt(Colors.primaries.length)],
//                                     shape: BoxShape.circle,
//                                     border: Border.all(width: 0.1),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: AppConst.black.withOpacity(0.1),
//                                         offset: Offset(
//                                           0,
//                                           1.h,
//                                         ),
//                                         blurRadius: 1.h,
//                                         spreadRadius: 1.0,
//                                       ),
//                                     ],
//                                   ),
//                                   child: Center(
//                                     child: (_.user.firstName! == null ||
//                                             _.user.firstName == "")
//                                         ? Icon(
//                                             CupertinoIcons.person_alt,
//                                             size: 4.h,
//                                             color: AppConst.white,
//                                           )
//                                         : Text(
//                                             "${_.user.firstName![0].toUpperCase()}",
//                                             style: TextStyle(
//                                               color: AppConst.white,
//                                               fontSize: SizeUtils
//                                                       .horizontalBlockSize *
//                                                   6,
//                                             ),
//                                           ),
//                                     // child: Icon(
//                                     //   CupertinoIcons.person_alt,
//                                     //   size: 4.h,
//                                     //   color: AppConst.white,
//                                     // ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             height: 3.h,
//                           ),
//                           myWalletControl(context, _),
//                           SizedBox(
//                             height: 1.h,
//                           ),
//                           ListView.builder(
//                             itemCount: profileScreenData.length,
//                             shrinkWrap: true,
//                             physics: NeverScrollableScrollPhysics(),
//                             itemBuilder: (context, index) {
//                               return ListTile(
//                                 contentPadding:
//                                     EdgeInsets.symmetric(horizontal: 4.w),
//                                 dense: true,
//                                 leading: profileScreenData[index].icon,
//                                 horizontalTitleGap: 0,
//                                 title: Text(
//                                   profileScreenData[index].name,
//                                   style: TextStyle(
//                                       fontSize:
//                                           SizeUtils.horizontalBlockSize * 4.5,
//                                       fontWeight: FontWeight.w500),
//                                 ),
//                                 onTap: () async {
//                                   if (index == 0) {
//                                     // Get.toNamed(AppRoutes.Orders);
//                                     Get.toNamed(AppRoutes.EditProfile);
//                                   } else if (index == 1) {
//                                     Get.toNamed(AppRoutes.History);
//                                   } else if (index == 2) {
//                                     Get.toNamed(AppRoutes.MyAddresses);
//                                   } else if (index == 3) {
//                                     _freshChat.initState();
//                                     await _freshChat.showChatConversation(
//                                         "opening chat support \n");
//                                     // \n${_.user.firstName ?? ''} ${_.user.lastName ?? ""}\n ${_.user.tablet ?? ''}
//                                   }
//                                   // else if (index == 4) {
//                                   //   Get.toNamed(AppRoutes.ActiveOrders);
//                                   // }
//                                 },
//                               );
//                             },
//                           ),
//                           // myAccount_item_maker(
//                           //     Icons.help_rounded, "Chat Support", () {}),
//                           lineSeparator(),
//                           Row(
//                             children: [
//                               SizedBox(
//                                 width: 5.w,
//                               ),
//                               Text(
//                                 "Credits Proms & giftcards ",
//                                 style: TextStyle(
//                                     fontSize: SizeUtils.horizontalBlockSize * 4,
//                                     color: AppConst.black),
//                               ),
//                             ],
//                           ),
//                           // SizedBox(
//                           //   height: 1.h,
//                           // ),
//                           myAccount_item_maker(
//                               Icons.currency_rupee, "Invite friends, get  10 ",
//                               () {
//                             Get.to(ReferAndEarnScreen());
//                           }),

//                           // lineSeparator(),
//                           myAccount_item_maker(Icons.logout_rounded, "Logout",
//                               () {
//                             _showLogOutDialog();
//                           }),
//                           // lineSeparator(),
//                         ],
//                       );
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   InkWell myWalletControl(BuildContext context, MyAccountController _) {
//     return InkWell(
//       highlightColor: AppConst.lightGrey,
//       onTap: () {
//         Get.toNamed(AppRoutes.Wallet);
//       },
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 2.w),
//         child: Container(
//           height: 13.h,
//           margin: EdgeInsets.only(bottom: 1.h),
//           width: MediaQuery.of(context).size.width,
//           decoration: BoxDecoration(
//             color: AppConst.lightYellow,
//             border: Border.all(width: 0.1),

//             // image: DecorationImage(
//             //     image: NetworkImage(
//             //         'https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg'),
//             //     fit: BoxFit.cover,
//             //     opacity: 0.1),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Padding(
//             padding: EdgeInsets.only(left: 2.w, top: 0.5.h, bottom: 1.h),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Text(
//                   "Your total wallet amount is \u{20B9} ${_.user.balance?.toStringAsFixed(2)} ",
//                   style: TextStyle(
//                       fontSize: SizeUtils.horizontalBlockSize * 5,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   "Unlock unlimited free delivery and more ! ",
//                   style: TextStyle(
//                       fontSize: SizeUtils.horizontalBlockSize * 3.5,
//                       fontWeight: FontWeight.w300),
//                 ),
//                 SizedBox(
//                   height: 0.5.h,
//                 ),
//                 FittedBox(
//                   child: SizedBox(
//                     height: 3.5.h,
//                     child: ElevatedButton(
//                       child: Text(
//                         'So many wallets!',
//                         style: TextStyle(
//                             fontSize: SizeUtils.horizontalBlockSize * 3.2,
//                             color: AppConst.black),
//                       ),
//                       onPressed: () {
//                         Get.toNamed(AppRoutes.Wallet);
//                       },
//                       style: ElevatedButton.styleFrom(
//                           primary: AppConst.orange,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15))),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   InkWell myAccount_item_maker(IconData icon, String text, onTap) {
//     return InkWell(
//       highlightColor: AppConst.lightGrey,
//       onTap: onTap,
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 1.5.h),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             SizedBox(
//               width: 5.w,
//             ),
//             Icon(icon),
//             SizedBox(
//               width: 2.w,
//             ),
//             Text(
//               text,
//               style: TextStyle(
//                   fontSize: SizeUtils.horizontalBlockSize * 4.5,
//                   fontWeight: FontWeight.w500),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget lineSeparator() {
//     return Padding(
//       padding: EdgeInsets.only(left: 3.w, right: 3.w, bottom: 1.5.h, top: 1.h),
//       child: Divider(
//         height: 1,
//         color: AppConst.black,
//       ),
//     );
//   }
// }

// void _showLogOutDialog() {
//   showDialog(
//     barrierDismissible: true,
//     context: Get.context!,
//     builder: (BuildContext context) {
//       return CustomDialog(
//         title: 'Log out',
//         content: "Are you sure you want to logout?",
//         buttontext: 'Log out',
//         onTap: () async {
//           await Hive.box<UserModel>('user').delete(HiveConstants.USER_KEY);
//           await Hive.box<String>('common').delete(HiveConstants.USER_TOKEN);
//           Get.offAllNamed(AppRoutes.Authentication);
//         },
//       );
//     },
//   );
// }

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
import 'package:customer_app/app/constants/colors.dart';
import 'package:customer_app/app/controller/add_location_controller.dart';
import 'package:customer_app/app/ui/pages/chat/freshchat_controller.dart';
import 'package:customer_app/app/ui/pages/location_picker/address_model.dart';
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
import 'package:hive/hive.dart';
import 'package:sizer/sizer.dart';

import '../../../data/model/user_model.dart';
import '../../../data/provider/hive/hive_constants.dart';

class MyAccountPage extends GetView<MyAccountController> {
  final freshChatController _freshChat = Get.find();
  final AddLocationController _addLocationController = Get.find();
  Future<bool> handleBackPressed() async {
    Get.offAllNamed(AppRoutes.BaseScreen);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: handleBackPressed,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: AppConst.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
        child: Scaffold(
          backgroundColor: AppConst.green,
          key: RIKeys.riKey2,
          body: SafeArea(
            child: GetX<MyAccountController>(
              initState: (state) {
                Get.find<MyAccountController>().getUserData();
              },
              builder: (_) {
                _.getGenerateReferCode();
                return _.user.id == null
                    ? LoadingWidget() // throw an 404 error msg
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 80,
                                  color: AppConst.green,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 0.h, left: 5.w, right: 3.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            text:
                                                "Hi, ${_.user.firstName ?? ""}",
                                            style: TextStyle(
                                              color: AppConst.white,
                                              fontSize: SizerUtil.deviceType ==
                                                      DeviceType.tablet
                                                  ? 9.sp
                                                  : 13.sp,
                                              fontFamily: 'MuseoSans',
                                              fontWeight: FontWeight.w700,
                                              fontStyle: FontStyle.normal,
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text:
                                                    "\n${_.user.mobile ?? ""}",
                                                style: TextStyle(
                                                    fontFamily: 'MuseoSans',
                                                    color: AppConst.white,
                                                    fontWeight: FontWeight.w300,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: SizerUtil
                                                                .deviceType ==
                                                            DeviceType.tablet
                                                        ? 8.sp
                                                        : 11.sp),
                                              ),
                                            ],
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () => Get.toNamed(
                                              AppRoutes.EditProfile),
                                          child: Text(
                                            'Edit',
                                            style: TextStyle(
                                                fontFamily: 'MuseoSans',
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                                fontSize:
                                                    SizerUtil.deviceType ==
                                                            DeviceType.tablet
                                                        ? 9.sp
                                                        : 12.sp,
                                                color: AppConst.white
                                                // Color(0xff079b2e),
                                                ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 30,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: AppConst.lightGrey,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10))),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 18.0, top: 5),
                                    child: Text(
                                      'Settings',
                                      style: TextStyle(
                                        fontSize: SizerUtil.deviceType ==
                                                DeviceType.tablet
                                            ? 9.sp
                                            : 12.sp,
                                        fontFamily: 'MuseoSans',
                                        color: AppConst.black,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Container(
                              height: 78.h,
                              color: AppConst.white,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Padding(
                                    //   padding: EdgeInsets.symmetric(
                                    //       horizontal: 4.w, vertical: 1.h),
                                    //   child: Text(
                                    //     'Settings',
                                    //     style: TextStyle(
                                    //       fontSize:
                                    //           SizeUtils.horizontalBlockSize *
                                    //               4.5,
                                    //       fontFamily: 'MuseoSans',
                                    //       color: AppConst.black,
                                    //       fontWeight: FontWeight.w400,
                                    //       fontStyle: FontStyle.normal,
                                    //     ),
                                    //   ),
                                    // ),
                                    ListView.builder(
                                      itemCount: profileScreenDataNew.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        if (index == 3) {
                                          return GestureDetector(
                                            onTap: () =>
                                                Get.to(ReferAndEarnScreen()),
                                            child: Container(
                                              color: AppConst.referBg,
                                              height: 28.h,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 16.0,
                                                            top: 10),
                                                    child: Text(
                                                      "Invite friends and family",
                                                      style: TextStyle(
                                                        fontSize: SizerUtil
                                                                    .deviceType ==
                                                                DeviceType
                                                                    .tablet
                                                            ? 11.sp
                                                            : 14.sp,
                                                        fontFamily: 'MuseoSans',
                                                        color: AppConst.black,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 16.0,
                                                                top: 0),
                                                        child: Text(
                                                          "Referral Code",
                                                          style: TextStyle(
                                                            fontSize: SizerUtil
                                                                        .deviceType ==
                                                                    DeviceType
                                                                        .tablet
                                                                ? 8.sp
                                                                : 11.sp,
                                                            fontFamily:
                                                                'MuseoSans',
                                                            color:
                                                                AppConst.black,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontStyle: FontStyle
                                                                .normal,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 12.0,
                                                                top: 5),
                                                        child: Text(
                                                          _.referCode
                                                              .toString(),
                                                          style: TextStyle(
                                                            color:
                                                                AppConst.green,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: SizerUtil
                                                                        .deviceType ==
                                                                    DeviceType
                                                                        .tablet
                                                                ? 8.sp
                                                                : 11.sp,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              SizedBox(
                                                                width: 5.w,
                                                              ),
                                                              Column(
                                                                children: [
                                                                  Container(
                                                                    height: 6.h,
                                                                    width: 12.w,
                                                                    decoration: BoxDecoration(
                                                                        color: ColorConstants
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(40)),
                                                                    child: Icon(
                                                                      Icons
                                                                          .list_alt_outlined,
                                                                      color: AppConst
                                                                          .green,
                                                                      size: 4.h,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 2.h,
                                                                  ),
                                                                  Text(
                                                                    "Make a list",
                                                                    style: TextStyle(
                                                                        fontSize: SizerUtil.deviceType == DeviceType.tablet
                                                                            ? 8
                                                                                .sp
                                                                            : 9
                                                                                .sp,
                                                                        fontWeight:
                                                                            FontWeight.w700),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                width: 3.w,
                                                              ),
                                                              Column(
                                                                children: [
                                                                  SizedBox(
                                                                    height: 2.h,
                                                                  ),
                                                                  Container(
                                                                    height: 6.h,
                                                                    width: 12.w,
                                                                    decoration: BoxDecoration(
                                                                        color: ColorConstants
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(40)),
                                                                    child: Icon(
                                                                      Icons
                                                                          .storefront_sharp,
                                                                      color: AppConst
                                                                          .green,
                                                                      size: 4.h,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 2.h,
                                                                  ),
                                                                  Text(
                                                                    "Name a store\n     or don't",
                                                                    style: TextStyle(
                                                                        fontSize: SizerUtil.deviceType == DeviceType.tablet
                                                                            ? 8
                                                                                .sp
                                                                            : 9
                                                                                .sp,
                                                                        fontWeight:
                                                                            FontWeight.w700),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                width: 3.w,
                                                              ),
                                                              Column(
                                                                children: [
                                                                  Container(
                                                                    height: 6.h,
                                                                    width: 12.w,
                                                                    decoration: BoxDecoration(
                                                                        color: ColorConstants
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(40)),
                                                                    child: Icon(
                                                                      Icons
                                                                          .directions_bike,
                                                                      color: AppConst
                                                                          .green,
                                                                      size: 4.h,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 2.h,
                                                                  ),
                                                                  Text(
                                                                    "Get it DUN",
                                                                    style: TextStyle(
                                                                        fontSize: SizerUtil.deviceType == DeviceType.tablet
                                                                            ? 8
                                                                                .sp
                                                                            : 9
                                                                                .sp,
                                                                        fontWeight:
                                                                            FontWeight.w700),
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 1.h,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              _.shareToSystem();
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          12.0),
                                                              child: Container(
                                                                height: 5.h,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    3,
                                                                decoration: BoxDecoration(
                                                                    color: AppConst
                                                                        .green,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            25)),
                                                                child: Center(
                                                                  child: Text(
                                                                    "Share the app",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize: SizerUtil.deviceType ==
                                                                              DeviceType.tablet
                                                                          ? 8.sp
                                                                          : 11.sp,
                                                                      fontFamily:
                                                                          'MuseoSans',
                                                                      color: AppConst
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontStyle:
                                                                          FontStyle
                                                                              .normal,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 0,
                                                                vertical: 10),
                                                        child: Image.asset(
                                                          'assets/images/refer_and_earn.png',
                                                          height: 18.h,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        }
                                        return ListTile(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 4.w, vertical: .4.h),
                                          dense: true,
                                          // trailing: Icon(
                                          //   Icons.arrow_forward_ios_rounded,
                                          //   color: AppConst.grey,
                                          //   size: 2.7.h,
                                          // ),
                                          leading: Container(
                                            width: 10.w,
                                            height: 5.h,
                                            decoration: BoxDecoration(
                                                color: AppConst.veryLightGrey,
                                                shape: BoxShape.circle),
                                            child: Center(
                                                child:
                                                    profileScreenDataNew[index]
                                                        .icon),
                                          ),
                                          // trailing: Icon(
                                          //   Icons.arrow_forward_ios,
                                          //   size: 3.h,
                                          // ),
                                          horizontalTitleGap: 3.w,
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                profileScreenDataNew[index]
                                                    .name,
                                                style: TextStyle(
                                                  fontSize:
                                                      SizerUtil.deviceType ==
                                                              DeviceType.tablet
                                                          ? 8.sp
                                                          : 11.sp,
                                                  fontFamily: 'MuseoSans',
                                                  color: AppConst.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.normal,
                                                  letterSpacing: -0.48,
                                                ),
                                              ),
                                              if (index == 0)
                                                Text(
                                                  "Rs ${_addLocationController.convertor(_.user.balance ?? 0)}",
                                                  // 'Rs ${_.user.balance}',
                                                  style: TextStyle(
                                                    fontSize: SizeUtils
                                                            .horizontalBlockSize *
                                                        4,
                                                    fontFamily: 'MuseoSans',
                                                    color: AppConst.black,
                                                    fontWeight: FontWeight.w400,
                                                    fontStyle: FontStyle.normal,
                                                    letterSpacing: -0.48,
                                                  ),
                                                ),
                                            ],
                                          ),
                                          onTap: () async {
                                            if (index == 0) {
                                              Get.toNamed(AppRoutes.Wallet);
                                              // Get.toNamed(AppRoutes.EditProfile);
                                            } else if (index == 1) {
                                              Get.toNamed(AppRoutes.History);
                                            } else if (index == 2) {
                                              Get.to(AddressModel(
                                                isHomeScreen: true,
                                                // isSavedAddress: true,
                                                editOrDelete: true,
                                                page: "home",
                                              ));

                                              // Get.toNamed(AppRoutes.MyAddresses);
                                            } else if (index == 4) {
                                              Get.to(ReferAndEarnScreen());
                                            } else if (index == 5) {
                                              _freshChat.initState();
                                              await _freshChat
                                                  .showChatConversation(
                                                      "opening chat support \n");
                                              // \n${_.user.firstName ?? ''} ${_.user.lastName ?? ""}\n ${_.user.tablet ?? ''}
                                            } else if (index == 6) {
                                              Get.toNamed(AppRoutes.About);
                                            } else if (index == 7) {
                                              _showLogOutDialog();
                                            }
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
              },
            ),
          ),
        ),
      ),
    );
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
          onTap: () async {
            await Hive.box<UserModel>('user').delete(HiveConstants.USER_KEY);
            await Hive.box<String>('common').delete(HiveConstants.USER_TOKEN);
            Get.offAllNamed(AppRoutes.Authentication);
          },
        );
      },
    );
  }
}
