import 'dart:developer';

import 'package:customer_app/app/ui/common/shimmer_widget.dart';
import 'package:customer_app/app/ui/pages/signIn/signup_screen.dart';
import 'package:customer_app/widgets/signup_feilds.dart';
import 'package:customer_app/widgets/textfield_clear_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/data/provider/hive/hive.dart';
import 'package:customer_app/app/data/provider/hive/hive_constants.dart';
import 'package:customer_app/app/ui/pages/signIn/phone_authentication_screen_shimmer.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/signInScreenController.dart';

class SignInScreen extends StatefulWidget {
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final SignInScreenController _signInController = Get.find();

  int CurrentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
    return Stack(
      children: [
        Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(top: 2.h, left: 1.h, right: 1.h),
                child: Obx(
                  () => _signInController.isLoading.value
                      ? SignInScreenShimmer()
                      : Column(
                          children: [
                            // Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                            // InkWell(
                            //   onTap: () {},
                            //   child: Container(
                            //     padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.h),
                            //     decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(2.h),
                            //       color: kGreyColor,
                            //     ),
                            //     child: Center(
                            //         child: Text(
                            //       'Skip',
                            //           style: TextStyle(fontSize: 14.sp),
                            //     )),
                            //   ),
                            // )
                            // ]),
                            // SizedBox(
                            //   height: 2.h,
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Bloyallogo(),
                                // Container(
                                //     height: 7.h,
                                //     width: 50.w,
                                //     child: FittedBox(
                                //       child: SvgPicture.asset(
                                //         "assets/icons/bloyal_logo.svg",
                                //         fit: BoxFit.fill,
                                //       ),
                                //     )),
                              ],
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            // Container(
                            //   height: 15.h,
                            //   width: 45.w,
                            //   child: Lottie.asset(
                            //       'assets/lottie/loginscreen1.json'),
                            // ),
                            // Container(
                            //   height: 15.h,
                            //   width: 45.w,
                            //   child: Lottie.asset(
                            //       'assets/lottie/loginscreen2.json'),
                            // ),
                            // Container(
                            //   height: 4.h,
                            //   child: FittedBox(
                            //     fit: BoxFit.scaleDown,
                            //     child: Text(
                            //       'Welcome to Recipto',
                            //       style: TextStyle(
                            //           fontSize: 18.sp,
                            //           color: kSecondaryTextColor),
                            //     ),
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 3.h,
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Flexible(
                            //       child: Divider(
                            //         thickness: 2,
                            //       ),
                            //     ),
                            //     Padding(
                            //       padding: EdgeInsets.all(2.h),
                            //       child: FittedBox(
                            //         fit: BoxFit.scaleDown,
                            //         child: Text(
                            //           'Login or Signup',
                            //           style: TextStyle(
                            //               fontWeight: FontWeight.bold,
                            //               fontSize: 12.sp),
                            //         ),
                            //       ),
                            //     ),
                            //     Flexible(
                            //       child: Divider(
                            //         thickness: 2,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // SizedBox(
                            //   height: 3.h,
                            // ),
                            Container(
                              height: 50.h,
                              width: MediaQuery.of(context).size.width,
                              color: AppConst.white,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: PageView.builder(
                                        controller: _controller,
                                        itemCount: 4,
                                        onPageChanged: (int index) {
                                          setState(() {
                                            CurrentIndex = index;
                                          });
                                        },
                                        itemBuilder: (_, index) {
                                          return Column(
                                            children: [
                                              Container(
                                                height: 15.h,
                                                width: 45.w,
                                                child: Lottie.asset(
                                                    'assets/lottie/loginscreen1.json'),
                                              ),
                                              Container(
                                                height: 15.h,
                                                width: 45.w,
                                                child: Lottie.asset(
                                                    'assets/lottie/loginscreen2.json'),
                                              ),
                                              Text(
                                                "Scan recipts \n and earn money",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        "MuseoSans_700.otf"),
                                              ),
                                              SizedBox(
                                                height: 1.5.h,
                                              ),
                                              Text(
                                                "Scan recipts  and earn money Scan recipts  and earn money Scan recipts  and earn money",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          );
                                        }),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      CurrentIndex > 0
                                          ? GestureDetector(
                                              onTap: () {
                                                if (CurrentIndex == 4) {}
                                                _controller.previousPage(
                                                    duration: Duration(
                                                        milliseconds: 100),
                                                    curve: Curves.bounceIn);
                                              },
                                              child: Icon(
                                                Icons.arrow_back,
                                                size: 3.2.h,
                                              ),
                                            )
                                          : Container(
                                              child: SizedBox(
                                              width: 5.w,
                                            )),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: List.generate(
                                              4,
                                              (index) =>
                                                  buildDot(index, context)),
                                        ),
                                      ),
                                      CurrentIndex < 3
                                          ? GestureDetector(
                                              onTap: () {
                                                if (CurrentIndex == 4) {}
                                                _controller.nextPage(
                                                    duration: Duration(
                                                        milliseconds: 100),
                                                    curve: Curves.bounceIn);
                                              },
                                              child: Icon(
                                                Icons.arrow_forward,
                                                size: 3.2.h,
                                              ),
                                            )
                                          : Container(
                                              child: SizedBox(
                                              width: 5.w,
                                            )),
                                    ],
                                  ),
                                ],
                              ),

                              // child:,
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     Container(
                            //       width: 12.w,
                            //       decoration: BoxDecoration(
                            //           border: Border.all(color: AppConst.black)),
                            //       child: TextField(
                            //         style: TextStyle(fontSize: 14.sp),
                            //         textAlign: TextAlign.center,
                            //         enabled: false,
                            //         decoration: InputDecoration(
                            //           border: InputBorder.none,
                            //           hintText: '+91',
                            //           hintStyle: TextStyle(
                            //               fontSize: 14.sp, color: AppConst.black),
                            //           hintTextDirection: TextDirection.ltr,
                            //           counterText: "",
                            //         ),
                            //       ),
                            //     ),
                            //     SizedBox(
                            //       width: 1.w,
                            //     ),
                            //     Container(
                            //       width: 65.w,
                            //       decoration: BoxDecoration(
                            //           border: Border.all(color: AppConst.black)),
                            //       child: TextField(
                            //         style: TextStyle(fontSize: 14.sp),
                            //         textAlign: TextAlign.center,
                            //         cursorColor: kPrimaryColor,
                            //         maxLength: 10,
                            //         keyboardType: TextInputType.number,
                            //         controller:
                            // _signInController.phoneNumberController,
                            //         decoration: InputDecoration(
                            //           border: InputBorder.none,
                            //           hintText: 'Enter Phone Number',
                            //           hintTextDirection: TextDirection.ltr,
                            //           counterText: "",
                            //         ),
                            //       ),
                            //     )
                            //   ],
                            // ),
                            // SizedBox(
                            //   height: 3.h,
                            // ),
                            /* SizedBox(
                        height: 50,
                        width: 280,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            'Continue',
                            style: AppStyles.BOLD_STYLE,
                          ),
                          style: ElevatedButton.styleFrom(
                              shadowColor: kPrimaryColor, primary: kPrimaryColor),
                        ),
                      ),*/
                            // ElevatedButton(
                            //     style: ElevatedButton.styleFrom(
                            //       elevation: 0,
                            //       primary: kSecondaryTextColor,
                            //       padding: EdgeInsets.symmetric(
                            //           vertical: 1.5.h, horizontal: 10.h),
                            //       shape: RoundedRectangleBorder(
                            //         borderRadius: BorderRadius.circular(1.h),
                            //       ),
                            //     ),
                            // onPressed: (_signInController
                            //             .phoneNumberController
                            //             .value
                            //             .text
                            //             .length ==
                            //         10)
                            //     ? () {
                            //         _signInController.submitPhoneNumber();
                            //       }
                            //     : null,
                            //     child: Text(
                            //       "Continue",
                            //       style: TextStyle(
                            //         fontSize: 15.sp,
                            //         fontWeight: FontWeight.w500,
                            //       ),
                            //     )),
                            SizedBox(
                              height: 3.h,
                            ),
                            Spacer(),
                            GestureDetector(
                                onTap: (() {
                                  Get.to(EnterNumberScreen());
                                }),
                                child: BottomWideButton()),
                            // Divider(
                            //   thickness: 1,
                            // ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account ? | ",
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(SignUpScreen());
                                  },
                                  child: Text(
                                    "Sign up ",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppConst.blue),
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              thickness: 1,
                            ),
                          ],
                        ),
                ),
              ),
            )),
      ],
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: CurrentIndex == index ? 25 : 10,
      margin: EdgeInsets.only(right: 2.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Color(0xFFDF2A63)
          // Colors.green
          // kSecondaryColor
          ),
    );
  }
}

class BottomWideButton extends StatelessWidget {
  final Color color;

  BottomWideButton({Key? key, this.text, this.color = AppConst.darkGreen})
      : super(key: key);
  String? text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 1.h, bottom: 1.h),
      height: 6.6.h,
      child: Container(
        decoration: new BoxDecoration(
            // color: Colors.,
            ),
        child: Container(
          decoration: BoxDecoration(
              color:
                  // Colors.green.shade700,
                  color,
              // Color(0xFFDF2A63),
              // kSecondaryTextColor,
              border: Border.all(width: 0.3, color: AppConst.darkGreen
                  // kPrimaryColor
                  ),
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Text(
              text ?? "LOGIN",
              // "LOGIN",
              style: TextStyle(
                fontFamily: 'MuseoSans',
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
                fontSize: SizeUtils.horizontalBlockSize * 5,
                color: AppConst.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EnterNumberScreen extends StatelessWidget {
  final SignInScreenController _signInController = Get.find();

  EnterNumberScreen({Key? key}) : super(key: key);

  final FocusNode _nodeText1 = FocusNode();

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
        keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
        keyboardBarColor: Colors.grey[200],
        nextFocus: false,
        actions: [
          KeyboardActionsItem(
            focusNode: _nodeText1,
            toolbarButtons: [
              (node) {
                return GestureDetector(
                  onTap: () => node.unfocus(),
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: AppConst.grey,
                    ),
                    margin: const EdgeInsets.only(right: 4),
                    child: Text(
                      "DONE",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }
            ],
          ),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    final box = Boxes.getCommonBox();
    final flag = box.get(HiveConstants.REFERID);
    if (flag?.isNotEmpty ?? false) {
      _signInController.referralController.text = flag ?? '';
      _signInController.referral.value = flag ?? '';
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Bloyallogo(),
        centerTitle: true,
        // actions: [
        //   Bloyallogo(),
        // ],
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
        child: Obx(
          () => _signInController.isLoading.value
              ? SignInShimmerEffect()
              : SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     // BackButton(
                        //     //   color: AppConst.black,
                        //     //   onPressed: () {
                        //     //     Get.back();
                        //     //   },
                        //     // ),
                        //     Bloyallogo(),
                        //     // SizedBox(
                        //     //   width: 10.w,
                        //     // )
                        //   ],
                        // ),
                        SizedBox(
                          height: 35.h,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              " Sign in ",
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "MuseoSans_700.otf"),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Container(
                              height: 50,
                              child: KeyboardActions(
                                config: _buildConfig(context),
                                autoScroll: false,
                                disableScroll: true,
                                child: Container(
                                  height: 50,
                                  child: SignUpFeilds(
                                    focusNode: _nodeText1,
                                    hinttext: "Enter mobile number",
                                    keyboardtype: TextInputType.number,
                                    maxlength: 10,
                                    controller:
                                        _signInController.phoneNumberController,
                                    onChange: (value) {
                                      _signInController.phoneNumber.value =
                                          value;
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 27.h,
                        ),
                        // Container(
                        //   width: MediaQuery.of(context).size.width,
                        //   // height: 9.h,
                        //   decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(10),
                        //       border: Border.all(color: AppConst.black, width: 1.5)),
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Padding(
                        //         padding: EdgeInsets.only(
                        //             left: 2.w, top: 0.5.h, bottom: 0.5.h),
                        //         child: Text(
                        //           "Mobile",
                        //           style: TextStyle(
                        //               fontSize: 9.sp, fontWeight: FontWeight.w500),
                        //         ),
                        //       ),
                        //       TextField(
                        //         style: TextStyle(fontSize: 14.sp),
                        //         textAlign: TextAlign.start,
                        //         cursorColor: AppConst.kPrimaryColor,
                        //         maxLength: 10,
                        //         keyboardType: TextInputType.number,
                        //         controller: _signInController.phoneNumberController,
                        //         decoration: InputDecoration(
                        //           isDense: true,
                        //           border: InputBorder.none,
                        //           hintText: 'Enter Phone Number',
                        //           contentPadding:
                        //               EdgeInsets.only(left: 2.w, bottom: 1.h),
                        //           hintTextDirection: TextDirection.ltr,
                        //           counterText: "",
                        //         ),
                        // onChanged: (value) {
                        //   _signInController.phoneNumber.value = value;
                        // },
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 2.h,
                        // ),
                        // Container(
                        //   width: MediaQuery.of(context).size.width,
                        //   // height: 9.h,
                        //   decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(10),
                        //       border: Border.all(color: AppConst.black, width: 1.5)),
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Padding(
                        //         padding: EdgeInsets.only(
                        //             left: 2.w, top: 0.5.h, bottom: 0.5.h),
                        //         child: Text(
                        //           "Referral code",
                        //           style: TextStyle(
                        //               fontSize: 9.sp, fontWeight: FontWeight.w500),
                        //         ),
                        //       ),
                        //       TextField(
                        //         style: TextStyle(fontSize: 14.sp),
                        //         textAlign: TextAlign.start,
                        //         cursorColor: AppConst.kPrimaryColor,
                        //         maxLength: 10,
                        //         controller: _signInController.referralController,
                        //         decoration: InputDecoration(
                        //           isDense: true,
                        //           border: InputBorder.none,
                        //           hintText: 'Enter Referral code',
                        //           contentPadding:
                        //               EdgeInsets.only(left: 2.w, bottom: 1.h),
                        //           hintTextDirection: TextDirection.ltr,
                        //           counterText: "",
                        //         ),
                        // onChanged: (value) {
                        //   _signInController.referral.value = value;
                        // },
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 2.h,
                        // ),
                        Obx(
                          () => GestureDetector(
                              onTap: (_signInController
                                          .phoneNumber.value.length ==
                                      10)
                                  ? () {
                                      log("aavoooo :0");
                                      try {
                                        _signInController.submitPhoneNumber();
                                      } catch (e) {
                                        print(e);
                                      }
                                      log("aavoooo :1");
                                    }
                                  : null,
                              child: BottomWideButton(
                                text: "Sign in",
                                color: _signInController
                                            .phoneNumber.value.length ==
                                        10
                                    ? AppConst.kSecondaryColor
                                    : AppConst.grey,
                              )),
                        ),
                      ]),
                ),
        ),
      )),
    );
  }
}

class SignInShimmerEffect extends StatelessWidget {
  final SignInScreenController _signInController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 35.h,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerEffect(
              child: Text(
                " Sign in ",
                style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: "MuseoSans_700.otf"),
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            ShimmerEffect(
              child: SignUpFeilds(
                hinttext: "Enter mobile number",
                keyboardtype: TextInputType.number,
                maxlength: 10,
                controller: _signInController.phoneNumberController,
                onChange: (value) {
                  _signInController.phoneNumber.value = value;
                },
              ),
            ),
          ],
        ),
        SizedBox(
          height: 27.h,
        ),
        ShimmerEffect(
          child: BottomWideButton(
            text: "Sign in",
            color: _signInController.phoneNumber.value.length == 10
                ? AppConst.kSecondaryColor
                : AppConst.grey,
          ),
        ),
      ]),
    );
  }
}
