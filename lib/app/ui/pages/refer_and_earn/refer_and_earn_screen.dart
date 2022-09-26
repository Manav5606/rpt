import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:customer_app/app/controller/account_controller.dart';

import 'package:customer_app/constants/app_const.dart';

import 'package:customer_app/widgets/snack.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:sizer/sizer.dart';

import 'widgets/rewards_card.dart';
import 'widgets/start_referring_widget.dart';

class ReferAndEarnScreen extends GetView<MyAccountController> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppConst.kSecondaryColor,
        statusBarIconBrightness: Brightness.light,
      ),
      child: GetX<MyAccountController>(
        builder: (_) {
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: AppConst.kSecondaryColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                          )),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.arrow_back),
                                splashRadius: AppConst.splashRadius,
                                color: AppConst.white,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  "T&C",
                                  style: TextStyle(
                                    color: AppConst.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            child: Text(
                              "Refer your friends to do 90% off + FREE food delivery at top brands like McDonalds, Wow!Momos and many more",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppConst.yellow,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: LinearGradient(
                                    colors: [
                                      AppConst.kSecondaryColor,
                                      AppConst.kSecondaryColor,
                                      //add more colors for gradient
                                    ],
                                    begin: Alignment.topLeft, //begin of the gradient color
                                    end: Alignment.bottomRight, //end of the gradient color
                                    stops: [0, 0.8] //stops for individual color
                                    ),
                                border: Border.all(
                                  width: 3,
                                  color: AppConst.kSecondaryColor,
                                ),
                              ),
                              child: Column(
                                children: [
                                  RewardsCard(
                                    offerName: "Your friend has earned 200 magicPoints on regestration.",
                                    imageUrl: 'assets/icons/download.png',
                                  ),
                                  RewardsCard(
                                    offerName: "You earn 150 magicPoints",
                                    imageUrl: 'assets/icons/discount.png',
                                  ),
                                  RewardsCard(
                                    offerName: "& Rs. 100 OFF on Amazon and Flipkart gift cards when your friend does a free food delivery",
                                    imageUrl: 'assets/icons/off.png',
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    height: 100,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: AppConst.kSecondaryColor,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(5),
                                          bottomRight: Radius.circular(5),
                                        )),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Your refferal code",
                                          style: TextStyle(
                                            color: AppConst.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${_.referCode.value}",
                                              style: TextStyle(
                                                color: AppConst.white,
                                                fontSize: 30,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: AppConst.blue,
                                                shape: BoxShape.circle,
                                              ),
                                              child: IconButton(
                                                visualDensity: VisualDensity(horizontal: -4),
                                                constraints: BoxConstraints.tightFor(),
                                                onPressed: () {
                                                  Clipboard.setData(ClipboardData(text: "${_.user.mobile}")).then((value) {
                                                    Snack.bottom("${_.user.mobile}", "Referral Code Copied");
                                                  });
                                                },
                                                icon: Icon(Icons.copy),
                                                color: AppConst.white,
                                                iconSize: 20,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppConst.kSecondaryColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: StartReferring(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text("Share your Referral Code"),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton.icon(
                                icon: Icon(FontAwesomeIcons.whatsapp),
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  primary: AppConst.green,
                                  padding: EdgeInsets.all(13),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                onPressed: () {
                                  print("share to whatsapp");
                                  _.shareToWhatsApp();
                                },
                                label: Text(
                                  "Whatsapp",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              ElevatedButton.icon(
                                icon: Icon(Icons.share_outlined),
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  primary: AppConst.orange,
                                  padding: EdgeInsets.all(13),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                onPressed: () {
                                  print("share to system");
                                  _.shareToSystem();
                                },
                                label: Text(
                                  "Other",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          )
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
