import 'dart:async';
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
    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (CurrentIndex < 3) {
        CurrentIndex++;
        _controller.animateToPage(
          CurrentIndex,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeIn,
        );
      } else {
        CurrentIndex = 3;
      }
      super.initState();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
    var currentTabs = [
      DisplayAppInfo(
          context,
          "assets/images/order1.png",
          "Order",
          " from your Nearby Stores",
          "Order from your Nearby Stores Order from your Nearby Stores  "),
      DisplayAppInfo(
          context,
          "assets/images/scan2.png",
          "Scan",
          " the Receipts",
          "Scan the receipts after purchasing the products to get more "),
      DisplayAppInfo(
          context,
          "assets/images/cashback3.png",
          "Earn",
          " Cashbacks from the Store",
          "Get Cashback instantly to your E-Wallet "),
      DisplayAppInfo(
          context,
          "assets/images/redeem4.png",
          "Redeem",
          " in your next purchase",
          " Use your E-Wallet in your next purchase get more Rewards")
    ];
    SizeUtils().init(context);
    final box = Boxes.getCommonBox();
    final flag = box.get(HiveConstants.REFERID);
    if (flag?.isNotEmpty ?? false) {
      _signInController.referralController.text = flag ?? '';
      _signInController.referral.value = flag ?? '';
    }
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: AppConst.transparent,
          statusBarIconBrightness: Brightness.dark),
      child: Scaffold(
          // resizeToAvoidBottomInset: false,

          bottomSheet: Container(
            height: 24.h,
            color: AppConst.white,
            child: Padding(
              padding: EdgeInsets.only(
                left: 4.w,
                right: 4.w,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sign in",
                    style: TextStyle(
                      color: AppConst.black,
                      fontFamily: "MuseoSans",
                      fontStyle: FontStyle.normal,
                      fontSize: SizeUtils.horizontalBlockSize * 4.2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    "Enter your Mobile Number",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppConst.darkGrey,
                      fontFamily: "MuseoSans",
                      fontStyle: FontStyle.normal,
                      fontSize: SizeUtils.horizontalBlockSize * 3.5,
                    ),
                  ),
                  Container(
                    // height: 6.h,
                    child: KeyboardActions(
                      config: _buildConfig(context),
                      autoScroll: false,
                      disableScroll: true,
                      child: Container(
                        // height: 50,
                        child: SignUpFeilds(
                          prefixIcon:
                              AddPlus91(signInController: _signInController),
                          focusNode: _nodeText1,
                          hinttext: "",
                          keyboardtype: TextInputType.number,
                          maxlength: 10,
                          controller: _signInController.phoneNumberController,
                          onChange: (value) {
                            _signInController.phoneNumber.value = value;
                          },
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => GestureDetector(
                        onTap:
                            (_signInController.phoneNumber.value.length == 10)
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
                          color:
                              _signInController.phoneNumber.value.length == 10
                                  ? AppConst.darkGreen
                                  : AppConst.grey,
                          borderColor:
                              _signInController.phoneNumber.value.length == 10
                                  ? AppConst.darkGreen
                                  : AppConst.grey,
                        )),
                  ),
                ],
              ),
            ),
          ),
          body: Obx(
            () => _signInController.isLoading.value
                ? SignInScreenShimmer()
                : SingleChildScrollView(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                            height: 75.h,
                            child: PageView(
                              controller: _controller,
                              children: currentTabs,
                              onPageChanged: (int index) {
                                setState(() {
                                  CurrentIndex = index;
                                });
                              },
                            )),
                        SizedBox(
                          height: 3.h,
                        )
                      ],
                    ),
                  ),
          )),
    );
  }

  Container DisplayAppInfo(BuildContext context, String image, String text1,
      String text2, String subtitle) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppConst.white,
        image: DecorationImage(
            image: AssetImage("assets/images/BG.png"), fit: BoxFit.fill),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: 4.h,
          ),
          Bloyallogo(),
          SizedBox(
            height: 4.h,
          ),

          Container(
            height: 40.h,
            width: double.infinity,
            child: FittedBox(
              child: Center(
                  child: Image.asset(
                image,
                // "assets/images/order1.png",
              )),
            ),
          ),

          // SizedBox(),
          Container(
            height: 15.h,
            width: double.infinity,
            color: AppConst.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              child: Column(
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      style: TextStyle(
                          color: AppConst.green,
                          fontWeight: FontWeight.w700,
                          fontFamily: "MuseoSans",
                          fontStyle: FontStyle.normal,
                          fontSize: 20),
                      text: text1,
                      // "Order "
                    ),
                    TextSpan(
                        style: TextStyle(
                            color: AppConst.black,
                            fontWeight: FontWeight.w700,
                            fontFamily: "MuseoSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 20.0),
                        text: text2
                        // " from your Nearby Stores"
                        )
                  ])),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(subtitle,
                      // "Order from your Nearby Stores Order from your Nearby Stores  ",
                      style: TextStyle(
                          color: AppConst.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: "MuseoSans",
                          fontStyle: FontStyle.normal,
                          fontSize: SizeUtils.horizontalBlockSize * 3.8),
                      textAlign: TextAlign.center),
                ],
              ),
            ),
          ),

          Container(
            color: AppConst.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                        List.generate(4, (index) => buildDot(index, context)),
                  ),
                ),
                // CurrentIndex > 0
                //     ? GestureDetector(
                //         onTap: () {
                //           if (CurrentIndex == 4) {}
                //           _controller.previousPage(
                //               duration: Duration(
                //                   milliseconds:
                //                       100),
                //               curve:
                //                   Curves.bounceIn);
                //         },
                //         child: Icon(
                //           Icons.arrow_back,
                //           size: 3.2.h,
                //         ),
                //       )
                //     : Container(
                //         child: SizedBox(
                //         width: 5.w,
                //       )),
                // Container(
                //   child: Row(
                //     mainAxisAlignment:
                //         MainAxisAlignment.center,
                //     children: List.generate(
                //         4,
                //         (index) => buildDot(
                //             index, context)),
                //   ),
                // ),
                // CurrentIndex < 3
                //     ? GestureDetector(
                //         onTap: () {
                //           if (CurrentIndex == 4) {}
                //           _controller.nextPage(
                //               duration: Duration(
                //                   milliseconds:
                //                       100),
                //               curve:
                //                   Curves.bounceIn);
                //         },
                //         child: Icon(
                //           Icons.arrow_forward,
                //           size: 3.2.h,
                //         ),
                //       )
                //     : Container(
                //         child: SizedBox(
                //         width: 5.w,
                //       )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: 10,
      // CurrentIndex == index ? 25 : 10,
      margin: EdgeInsets.only(right: 2.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: CurrentIndex == index ? AppConst.darkGreen : AppConst.lightGrey
          // Colors.green
          // kSecondaryColor
          ),
    );
  }
}

class BottomWideButton extends StatelessWidget {
  final Color color;
  final Color Textcolor;
  final Color borderColor;
  BottomWideButton(
      {Key? key,
      this.text,
      this.borderColor = AppConst.darkGreen,
      this.color = AppConst.darkGreen,
      this.Textcolor = AppConst.white})
      : super(key: key);
  String? text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 1.h),
      height: 6.h,
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
              border: Border.all(width: 1.5, color: borderColor
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
                fontSize: SizeUtils.horizontalBlockSize * 4,
                color: Textcolor,
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
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: AppConst.transparent,
          statusBarIconBrightness: Brightness.dark),
      child: Scaffold(
        // appBar: AppBar(
        //   elevation: 0,
        //   automaticallyImplyLeading: false,
        //   title: Bloyallogo(),
        //   centerTitle: true,
        //   // actions: [
        // Bloyallogo(),
        //   // ],
        // ),

        body: Obx(
          () => _signInController.isLoading.value
              ? SignInShimmerEffect()
              : SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            height: 70.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppConst.white,
                              image: DecorationImage(
                                  image: AssetImage("assets/images/BG.png"),
                                  fit: BoxFit.fill),
                            ),
                            child: FittedBox(
                              child: Center(
                                  child: Image.asset(
                                "assets/images/order1.png",
                                fit: BoxFit.contain,
                              )),
                            )),
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
                        // SizedBox(
                        //   height: 5.h,
                        // ),

                        Padding(
                          padding:
                              EdgeInsets.only(left: 4.w, right: 4.w, top: 6.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Sign in",
                                style: TextStyle(
                                  color: AppConst.black,
                                  fontFamily: "MuseoSans",
                                  fontStyle: FontStyle.normal,
                                  fontSize: SizeUtils.horizontalBlockSize * 4.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Text(
                                "Enter your Mobile Number",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: AppConst.grey,
                                  fontFamily: "MuseoSans",
                                  fontStyle: FontStyle.normal,
                                  fontSize: SizeUtils.horizontalBlockSize * 3.5,
                                ),
                              ),
                              Container(
                                // height: 6.h,
                                child: KeyboardActions(
                                  config: _buildConfig(context),
                                  autoScroll: false,
                                  disableScroll: true,
                                  child: Container(
                                    // height: 50,
                                    child: SignUpFeilds(
                                      prefixIcon: AddPlus91(
                                          signInController: _signInController),
                                      focusNode: _nodeText1,
                                      hinttext: "",
                                      keyboardtype: TextInputType.number,
                                      maxlength: 10,
                                      controller: _signInController
                                          .phoneNumberController,
                                      onChange: (value) {
                                        _signInController.phoneNumber.value =
                                            value;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Obx(
                                () => GestureDetector(
                                    onTap: (_signInController
                                                .phoneNumber.value.length ==
                                            10)
                                        ? () {
                                            log("aavoooo :0");
                                            try {
                                              _signInController
                                                  .submitPhoneNumber();
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
                                          ? AppConst.darkGreen
                                          : AppConst.grey,
                                      borderColor: _signInController
                                                  .phoneNumber.value.length ==
                                              10
                                          ? AppConst.darkGreen
                                          : AppConst.grey,
                                    )),
                              ),
                            ],
                          ),
                        ),
                        // SizedBox(
                        //   height: 27.h,
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
                      ]),
                ),
        ),
      ),
    );
  }
}

class AddPlus91 extends StatelessWidget {
  const AddPlus91({
    Key? key,
    required SignInScreenController signInController,
  })  : _signInController = signInController,
        super(key: key);

  final SignInScreenController _signInController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20.w,
      child: Row(
        children: [
          SizedBox(
            width: 2.w,
          ),
          Padding(
            padding: EdgeInsets.only(top: 0.5.h),
            child: Icon(
              Icons.call,
              size: 3.h,
              color: _signInController.phoneNumber.value.length == 10
                  ? AppConst.darkGreen
                  : AppConst.grey,
            ),
          ),
          SizedBox(
            width: 3.w,
          ),
          Padding(
            padding: EdgeInsets.only(top: 0.5.h),
            child: Text(
              "+91",
              style: TextStyle(
                  fontFamily: 'MuseoSans',
                  color: AppConst.black,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  fontSize: SizeUtils.horizontalBlockSize * 4),
            ),
          )
        ],
      ),
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
