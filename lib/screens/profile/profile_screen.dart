// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:customer_app/constants/app_const.dart';

// import 'package:customer_app/constants/string_constants.dart';
// import 'package:customer_app/data/profile_screen_data.dart';
// import 'package:customer_app/routes/app_list.dart';
// import 'package:customer_app/theme/styles.dart';
// import 'package:get/route_manager.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AnnotatedRegion<SystemUiOverlayStyle>(
//       value: SystemUiOverlayStyle(
//         statusBarColor: AppConst.transparent,
//         statusBarIconBrightness: Brightness.dark,
//         statusBarBrightness: Brightness.dark,
//       ),
//       child: Scaffold(
//         body: SafeArea(
//           child: SingleChildScrollView(
//             physics: ClampingScrollPhysics(),
//             child: Column(
//               children: [
//                 Padding(
//                   padding:
//                       const EdgeInsets.only(top: 18.0, left: 10, right: 10),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "Hi, ${StringContants.userName}",
//                         style: TextStyle(
//                           color: AppConst.black,
//                           fontSize: 30,
//                         ),
//                       ),
//                       CircleAvatar(
//                         radius: 30,
//                         backgroundColor: AppConst.darkGrey,
//                         child: Text(
//                           StringContants.userName[0],
//                           style: TextStyle(
//                             color: AppConst.white,
//                             fontSize: 30,
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 Divider(
//                   height: 50,
//                   color: AppConst.grey,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: SizedBox(
//                           height: 50,
//                           child: ElevatedButton(
//                             onPressed: () {},
//                             style: ElevatedButton.styleFrom(
//                               textStyle: TextStyle(
//                                 fontSize: 17,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                               elevation: 0,
//                               primary: AppConst.kSecondaryColor,
//                               padding: EdgeInsets.all(13),
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text("Withdraw Cash"),
//                                 Text("\$11.50 available"),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 ListView.builder(
//                   itemCount: profileScreenData.length,
//                   shrinkWrap: true,
//                   physics: NeverScrollableScrollPhysics(),
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       contentPadding: EdgeInsets.symmetric(horizontal: 12),
//                       dense: true,
//                       leading: profileScreenData[index].icon,
//                       horizontalTitleGap: 0,
//                       title: Text(
//                         profileScreenData[index].name,
//                         style: TextStyle(
//                           fontSize: 18,
//                         ),
//                       ),
//                       trailing: Icon(
//                         Icons.arrow_forward_ios_rounded,
//                         color: AppConst.kIconColor,
//                         size: 20,
//                       ),
//                       onTap: () {
//                         if (index == 0) {
//                           Get.toNamed(AppRoutes.Orders);
//                         } else if (index == 1) {
//                           Get.toNamed(AppRoutes.EditProfile);
//                         } else if (index == 2) {
//                           Get.toNamed(AppRoutes.History);
//                         } else if (index == 3) {
//                           Get.toNamed(AppRoutes.MyAddresses);
//                         } else if (index == 4) {
//                           Get.toNamed(AppRoutes.ReferAndEarn);
//                         } else if (index == 5) {
//                           Get.toNamed(AppRoutes.Wallet);
//                         }
//                       },
//                     );
//                   },
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Padding(
//                   padding: AppStyles.BODY_PADDING,
//                   child: Container(
//                     height: 110,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5),
//                       border: Border.all(
//                         color: AppConst.grey,
//                       ),
//                       image: DecorationImage(
//                         fit: BoxFit.fill,
//                         image: AssetImage(
//                           'assets/images/account_banner.png',
//                         ),
//                       ),
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
// }
