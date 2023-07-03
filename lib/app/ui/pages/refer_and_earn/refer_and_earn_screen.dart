// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:customer_app/app/controller/account_controller.dart';

// import 'package:customer_app/constants/app_const.dart';

// import 'package:customer_app/widgets/snack.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';

// import 'package:sizer/sizer.dart';

// import 'widgets/rewards_card.dart';
// import 'widgets/start_referring_widget.dart';

// class ReferAndEarnScreen extends GetView<MyAccountController> {
//   @override
//   Widget build(BuildContext context) {
//     return AnnotatedRegion<SystemUiOverlayStyle>(
//       value: SystemUiOverlayStyle(
//         statusBarColor: AppConst.kSecondaryColor,
//         statusBarIconBrightness: Brightness.light,
//       ),
//       child: GetX<MyAccountController>(
//         builder: (_) {
//           return Scaffold(
//             body: SafeArea(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Container(
//                       decoration: BoxDecoration(
//                           color: AppConst.kSecondaryColor,
//                           borderRadius: BorderRadius.only(
//                             bottomLeft: Radius.circular(5),
//                             bottomRight: Radius.circular(5),
//                           )),
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               IconButton(
//                                 onPressed: () {
//                                   Navigator.pop(context);
//                                 },
//                                 icon: Icon(Icons.arrow_back),
//                                 splashRadius: AppConst.splashRadius,
//                                 color: AppConst.white,
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(15.0),
//                                 child: Text(
//                                   "T&C",
//                                   style: TextStyle(
//                                     color: AppConst.white,
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 15, vertical: 10),
//                             child: Text(
//                               "Refer your friends to do 90% off + FREE food delivery at top brands like McDonalds, Wow!Momos and many more",
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 color: AppConst.yellow,
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 15, vertical: 10),
//                             child: Container(
//                               width: double.infinity,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15),
//                                 gradient: LinearGradient(
//                                     colors: [
//                                       AppConst.kSecondaryColor,
//                                       AppConst.kSecondaryColor,
//                                       //add more colors for gradient
//                                     ],
//                                     begin: Alignment
//                                         .topLeft, //begin of the gradient color
//                                     end: Alignment
//                                         .bottomRight, //end of the gradient color
//                                     stops: [0, 0.8] //stops for individual color
//                                     ),
//                                 border: Border.all(
//                                   width: 3,
//                                   color: AppConst.kSecondaryColor,
//                                 ),
//                               ),
//                               child: Column(
//                                 children: [
//                                   RewardsCard(
//                                     offerName:
//                                         "Your friend has earned 200 magicPoints on regestration.",
//                                     imageUrl: 'assets/icons/download.png',
//                                   ),
//                                   RewardsCard(
//                                     offerName: "You earn 150 magicPoints",
//                                     imageUrl: 'assets/icons/discount.png',
//                                   ),
//                                   RewardsCard(
//                                     offerName:
//                                         "& Rs. 100 OFF on Amazon and Flipkart gift cards when your friend does a free food delivery",
//                                     imageUrl: 'assets/icons/off.png',
//                                   ),
//                                   SizedBox(
//                                     height: 5,
//                                   ),
//                                   Container(
//                                     height: 100,
//                                     width: double.infinity,
//                                     decoration: BoxDecoration(
//                                         color: AppConst.kSecondaryColor,
//                                         borderRadius: BorderRadius.only(
//                                           bottomLeft: Radius.circular(5),
//                                           bottomRight: Radius.circular(5),
//                                         )),
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Text(
//                                           "Your refferal code",
//                                           style: TextStyle(
//                                             color: AppConst.white,
//                                             fontSize: 12,
//                                           ),
//                                         ),
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             Text(
//                                               "${_.referCode.value}",
//                                               style: TextStyle(
//                                                 color: AppConst.white,
//                                                 fontSize: 30,
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               width: 5,
//                                             ),
//                                             Container(
//                                               decoration: BoxDecoration(
//                                                 color: AppConst.blue,
//                                                 shape: BoxShape.circle,
//                                               ),
//                                               child: IconButton(
//                                                 visualDensity: VisualDensity(
//                                                     horizontal: -4),
//                                                 constraints:
//                                                     BoxConstraints.tightFor(),
//                                                 onPressed: () {
//                                                   Clipboard.setData(ClipboardData(
//                                                           text:
//                                                               "${_.referCode.value}"))
//                                                       .then((value) {
//                                                     Snack.bottom(
//                                                         "${_.referCode.value}",
//                                                         "Referral Code Copied");
//                                                   });
//                                                 },
//                                                 icon: Icon(Icons.copy),
//                                                 color: AppConst.white,
//                                                 iconSize: 20,
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(
//                                 left: 15, top: 10, right: 15, bottom: 20),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: AppConst.kSecondaryColor,
//                                 borderRadius: BorderRadius.circular(15),
//                               ),
//                               child: StartReferring(),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         children: [
//                           Text("Share your Referral Code"),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               ElevatedButton.icon(
//                                 icon: Icon(FontAwesomeIcons.whatsapp),
//                                 style: ElevatedButton.styleFrom(
//                                   elevation: 0,
//                                   primary: AppConst.green,
//                                   padding: EdgeInsets.all(13),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10.0),
//                                   ),
//                                 ),
//                                 onPressed: () {
//                                   print("share to whatsapp");
//                                   _.shareToWhatsApp();
//                                 },
//                                 label: Text(
//                                   "Whatsapp",
//                                   style: TextStyle(
//                                     fontSize: 13.sp,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               ElevatedButton.icon(
//                                 icon: Icon(Icons.share_outlined),
//                                 style: ElevatedButton.styleFrom(
//                                   elevation: 0,
//                                   primary: AppConst.orange,
//                                   padding: EdgeInsets.all(13),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10.0),
//                                   ),
//                                 ),
//                                 onPressed: () {
//                                   print("share to system");
//                                   _.shareToSystem();
//                                 },
//                                 label: Text(
//                                   "Other",
//                                   style: TextStyle(
//                                     fontSize: 13.sp,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           )
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:customer_app/app/ui/pages/refer_and_earn/refer_and_earn_shimmer.dart';
import 'package:customer_app/app/ui/pages/signIn/phone_authentication_screen_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:customer_app/app/controller/account_controller.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/widgets/snack.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';

// ignore: must_be_immutable
class ReferAndEarnScreen extends StatefulWidget {
  @override
  State<ReferAndEarnScreen> createState() => _ReferAndEarnScreenState();
}

class _ReferAndEarnScreenState extends State<ReferAndEarnScreen> {
  bool isLoading = true;

  // void _startLoadingTimer() {
  //   Future.delayed(Duration(seconds: 2), () {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppConst.kSecondaryColor,
        statusBarIconBrightness: Brightness.light,
      ),
      child: GetX<MyAccountController>(
        builder: (_) {
          _.getGenerateReferCode();
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              title: Text(
                'Invite Friends & Family',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Image.asset(
                            'assets/images/refer_and_earn.png',
                            height: 30.h,
                          ),
                        ),
                        Text('Here\'s your Referral Code'),
                        GestureDetector(
                          onTap: () {
                            Clipboard.setData(
                                    ClipboardData(text: "${_.referCode.value}"))
                                .then((value) {
                              Snack.bottom("${_.referCode.value}",
                                  "Referral Code Copied");
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: DottedBorder(
                              dashPattern: [6, 3],
                              strokeCap: StrokeCap.round,
                              color: AppConst.kSecondaryColor,
                              strokeWidth: 1,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                alignment: Alignment.center,
                                width: double.infinity,
                                child: Text(
                                  _.referCode.value,
                                  style: TextStyle(
                                    color: AppConst.kSecondaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          padding: const EdgeInsets.all(20),
                          width: double.infinity,
                          color: Colors.grey.shade200,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              OfferColumn(
                                count: '1',
                                subtitle: 'Invite friends &\nfamily',
                              ),
                              OfferColumn(
                                count: '2',
                                subtitle: 'Get Rs 20 after\nthey join',
                              ),
                              OfferColumn(
                                count: '3',
                                subtitle: 'Get Rs 20 on first\ntransaction',
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          // OutlinedButton.icon(
                          //   icon: Icon(
                          //     FontAwesomeIcons.whatsapp,
                          //     color: Colors.green,
                          //   ),
                          //   style: ButtonStyle(
                          //     minimumSize: MaterialStateProperty.all(
                          //       Size(double.infinity, 45),
                          //     ),
                          //     shape: MaterialStateProperty.all(
                          //         RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(10.0),
                          //     )),
                          //     side: MaterialStateProperty.all(
                          //       BorderSide(
                          //         color: AppConst.kSecondaryColor,
                          //         width: 2,
                          //       ),
                          //     ),
                          //   ),
                          //   onPressed: () {
                          //     print("share to whatsapp");
                          //     _.shareToWhatsApp();
                          //   },
                          //   label: Text(
                          //     "Share on Whatsapp",
                          //     style: TextStyle(
                          //       fontSize: 13.sp,
                          //       fontWeight: FontWeight.bold,
                          //       color: Colors.black,
                          //     ),
                          //   ),
                          // ),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              primary: AppConst.darkGreen,
                              minimumSize: Size(double.infinity, 45),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onPressed: () {
                              print("share to system");
                              _.shareToSystem();
                            },
                            child: Text(
                              "Share",
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class OfferColumn extends StatelessWidget {
  final String count;
  final String subtitle;
  const OfferColumn({Key? key, required this.count, required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 4.h,
          child: Text(
            count,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
            ),
          ),
        ),
        SizedBox(
          height: 1.h,
        ),
        Text(
          subtitle,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
