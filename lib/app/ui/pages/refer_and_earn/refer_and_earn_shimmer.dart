import 'package:customer_app/app/ui/common/shimmer_widget.dart';
import 'package:customer_app/app/ui/pages/refer_and_earn/refer_and_earn_screen.dart';
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
class ReferAndEarnShimmer extends StatefulWidget {
  @override
  State<ReferAndEarnShimmer> createState() => _ReferAndEarnShimmerState();
}

class _ReferAndEarnShimmerState extends State<ReferAndEarnShimmer> {



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
                      child: ShimmerEffect(
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
                                    Clipboard.setData(ClipboardData(
                                            text: "${_.referCode.value}"))
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
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
                                        subtitle:
                                            'Get Rs 20 on first\ntransaction',
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
                  ),
                );
              },
            ),
    );
  }
}