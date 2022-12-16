import 'dart:developer';

import 'package:customer_app/app/ui/pages/signIn/phone_authentication_screen.dart';
import 'package:customer_app/widgets/signup_feilds.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/app_constants.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/ui/common/shimmer_widget.dart';
import 'package:customer_app/constants/app_const.dart';

import 'package:customer_app/theme/styles.dart';
import 'package:get/get.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/signInScreenController.dart';

class OtpScreen extends StatefulWidget {
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final SignInScreenController _signInScreenController = Get.find()
    ..startTimer();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _signInScreenController.isFromOTP.value = false;
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          // title: Text(
          //   'OTP Verification',
          //   style: TextStyle(
          //       fontSize: 13.sp,
          //       fontWeight: FontWeight.w700,
          //       color: AppConst.black),
          // ),
          leading: GestureDetector(
            onTap: () {
              _signInScreenController.isFromOTP.value = false;
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
              size: 6.w,
            ),
          ),
        ),
        bottomSheet: Container(
          height: 8.h,
          child: InkWell(
            onTap: () async {
              _signInScreenController.otpController.text.length == 6
                  ? _signInScreenController.submitOTP()
                  : null;
              // _signInScreenController.otpController.clear();

              // _signInScreenController.startTimer();
            },
            child: Padding(
              padding: EdgeInsets.only(left: 2.w, right: 2.w),
              child: BottomWideButton(
                text: "Verify & Continue",
                color: AppConst.darkGreen,

                // _signInScreenController.otpController.text.length > 5
                //     ? AppConst.darkGreen //Colors.green //kSecondaryTextColor
                //     : AppConst.grey,
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 2.w, right: 2.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'OTP Verification',
                  style: TextStyle(
                      color: AppConst.black,
                      fontFamily: "MuseoSans",
                      fontStyle: FontStyle.normal,
                      fontSize: SizeUtils.horizontalBlockSize * 4.5,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  'Enter the OTP code sent to +91 ${_signInScreenController.phoneNumberController.text}',
                  style: TextStyle(
                      color: AppConst.grey,
                      fontFamily: "MuseoSans",
                      fontStyle: FontStyle.normal,
                      fontSize: SizeUtils.horizontalBlockSize * 3.5,
                      fontWeight: FontWeight.bold),
                ),
                Obx(
                  () => _signInScreenController.isLoading.value
                      ? ShimmerEffect(
                          child: SignUpFeilds(
                            hinttext: "Enter OTP",
                            keyboardtype: TextInputType.number,
                            controller: _signInScreenController.otpController,
                            onChange: (pin) async {
                              // _signInScreenController.submitOTP();
                              // _signInScreenController.otpController.clear();
                            },
                          ),
                        )
                      : SignUpFeilds(
                          hinttext: "Enter OTP",
                          keyboardtype: TextInputType.number,
                          maxlength: 6,
                          controller: _signInScreenController.otpController,
                          // onChange: (pin) async {
                          //   _signInScreenController.submitOTP();
                          //   // _signInScreenController.otpController.clear();
                          // },
                        ),
                ),

                SizedBox(
                  height: 2.h,
                ),
                SizedBox(
                  height: 4.h,
                ),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          text: "Didn't get the code?   ",
                          style: TextStyle(
                              color: AppConst.black,
                              fontFamily: "MuseoSans",
                              fontStyle: FontStyle.normal,
                              fontSize: SizeUtils.horizontalBlockSize * 3.5,
                              fontWeight: FontWeight.w500),
                        ),
                        TextSpan(
                          text: "RESEND IN 00:${Constants.start.value}",
                          style: TextStyle(
                              color: AppConst.green,
                              fontFamily: "MuseoSans",
                              fontStyle: FontStyle.normal,
                              fontSize: SizeUtils.horizontalBlockSize * 3.8,
                              fontWeight: FontWeight.bold),
                        )
                      ])),
                    ],
                  ),
                ),

                // Obx(
                //   () => _signInScreenController.isLoading.value
                //       ? ShimmerEffect(
                //           child: Column(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               Text(
                //                 '+91 ${_signInScreenController.phoneNumberController.text}',
                //                 style: TextStyle(
                //                     fontSize: 14.sp,
                //                     fontWeight: FontWeight.bold,
                //                     color: AppConst.grey),
                //               ),
                //               SizedBox(
                //                 height: 4.h,
                //               ),
                //               Text(
                //                 'OTP Authentication',
                //                 style: TextStyle(
                //                     fontSize: 16.sp,
                //                     fontWeight: FontWeight.bold),
                //               ),
                //               SizedBox(
                //                 height: 3.h,
                //               ),
                //               Text(
                //                 'A verification code has been to your mobile',
                //                 style: TextStyle(
                //                     fontSize: 12.5.sp,
                //                     fontWeight: FontWeight.w500),
                //               ),
                //               SizedBox(
                //                 height: 1.h,
                //               ),
                //             ],
                //           ),
                //         )
                //       : Column(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Text(
                //               '+91 ${_signInScreenController.phoneNumberController.text}',
                //               style: TextStyle(
                //                   fontSize: SizeUtils.horizontalBlockSize * 5,
                //                   fontWeight: FontWeight.w600,
                //                   fontFamily: 'MuseoSans-700.otf',
                //                   color: AppConst.darkGrey),
                //             ),

                //             SizedBox(
                //               height: 3.h,
                //             ),
                //             Text(
                //               'OTP Authentication',
                //               style: TextStyle(
                //                 fontSize: SizeUtils.horizontalBlockSize * 6,
                //                 fontWeight: FontWeight.bold,
                //                 fontFamily: 'MuseoSans-700.otf',
                //               ),
                //             ),
                //             // SizedBox(
                //             //   height: 0.5.h,
                //             // ),
                //             // Text(
                //             //   'Moblie number',
                //             //   style: TextStyle(
                //             //     fontSize: SizeUtils.horizontalBlockSize * 6,
                //             //     fontWeight: FontWeight.bold,
                //             //     fontFamily: 'MuseoSans-700.otf',
                //             //   ),
                //             // ),
                //             SizedBox(
                //               height: 2.h,
                //             ),

                //             Text(
                //               'A verification code has been to your mobile',
                //               style: TextStyle(
                //                 fontSize: 12.5.sp,
                //                 fontFamily: 'MuseoSans-700.otf',
                //                 fontWeight: FontWeight.w500,
                //                 letterSpacing: 0.5,
                //               ),
                //             ),
                //             SizedBox(
                //               height: 1.h,
                //             ),
                //             // Text(
                //             //   '+91 ${_signInScreenController.phoneNumberController.text}',
                //             //   style: AppStyles.STORE_NAME_STYLE,
                //             // )
                //           ],
                //         ),
                // ),

                // Obx(
                //   () => _signInScreenController.isLoading.value
                //       ? ShimmerEffect(
                //           child: PinPut(
                //             fieldsCount: 6,
                //             controller: _signInScreenController.otpController,
                //             eachFieldHeight: 4.h,
                //             eachFieldWidth: 6.w,
                //             selectedFieldDecoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(1.h),
                //               border: Border.all(color: AppConst.black),
                //             ),
                //             followingFieldDecoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(1.h),
                //                 border: Border.all(color: AppConst.black)),
                //             submittedFieldDecoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(1.h),
                //                 border: Border.all(color: AppConst.black)),
                //             onSubmit: (pin) async {},
                //           ),
                //         )
                //       : Container(
                //           width: 80.w,
                //           child: PinPut(
                //             fieldsCount: 6,
                //             controller: _signInScreenController.otpController,
                //             eachFieldHeight: 4.h,
                //             eachFieldWidth: 6.w,
                //             selectedFieldDecoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(
                //                 1.7.h,
                //               ),
                //               border: Border.all(color: AppConst.black),
                //             ),
                //             followingFieldDecoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(
                //                   1.h,
                //                 ),
                //                 border: Border.all(color: AppConst.black)),
                //             submittedFieldDecoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(
                //                   1.h,
                //                 ),
                //                 border: Border.all(
                //                   color: AppConst.black,
                //                 )),
                //             onSubmit: (pin) async {
                //               _signInScreenController.submitOTP();
                //               // _signInScreenController.otpController.clear();
                //             },
                //           ),
                //         ),
                // ),

                // Obx(
                //   () => InkWell(
                //     onTap: Constants.start.value == 0
                //         ? () {
                //             _signInScreenController.submitPhoneNumber();
                //             _signInScreenController.startTimer();
                //           }
                //         : null,
                //     child: BottomWideButton(
                //       text: "Verify & Continue",
                //       color: _signInScreenController.isResendEnable.value
                //           ? AppConst
                //               .darkGreen //Colors.green //kSecondaryTextColor
                //           : AppConst.grey,
                //     ),
                //   ),
                // ),

                // Obx(
                //   () => _signInScreenController.isLoading.value
                //       ? ShimmerEffect(
                //           child: Container(
                //             child: Text(
                //               "Didn't get the code?",
                //               style: TextStyle(
                //                 fontSize: 12.5.sp,
                //                 fontFamily: 'MuseoSans-700.otf',
                //                 fontWeight: FontWeight.w500,
                //                 color: AppConst.grey,
                //                 letterSpacing: 0.5,
                //               ),
                //             ),
                //           ),
                //         )
                //       : Text(
                //           "Can't you receive any code?",
                //           style: TextStyle(
                //             fontSize: 12.5.sp,
                //             fontFamily: 'MuseoSans-700.otf',
                //             fontWeight: FontWeight.w500,
                //             letterSpacing: 0.5,
                //           ),
                //         ),
                // ),
                // SizedBox(
                //   height: 2.h,
                // ),
                // Obx(
                //   () => _signInScreenController.isLoading.value
                //       ? ShimmerEffect(
                //           child: Container(
                //             height: 7.h,
                //             // width: 50.w,
                //             decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(1.5.w),
                //               border: Border.all(color: AppConst.kSecondaryColor
                //                   // Colors.green
                //                   //  kSecondaryTextColor
                //                   ),
                //               color: _signInScreenController
                //                       .isResendEnable.value
                //                   ? AppConst
                //                       .kSecondaryColor //Colors.green //kSecondaryTextColor
                //                   : AppConst.transparent,
                //             ),
                //             child: Center(
                //               child: Row(
                //                 mainAxisAlignment: MainAxisAlignment.center,
                //                 children: [
                //                   Text(
                //                     'Resend OTP in ',
                //                     style: TextStyle(
                //                       fontSize: 13.sp,
                //                       fontFamily: 'MuseoSans-700.otf',
                //                       fontWeight: FontWeight.bold,
                //                       letterSpacing: 0.5,
                //                       color: _signInScreenController
                //                               .isResendEnable.value
                //                           ? AppConst.white
                //                           : AppConst.black,
                //                     ),
                //                   ),
                //                   Text(
                //                     '00:${Constants.start.value}',
                //                     style: TextStyle(
                //                       fontSize: 13.sp,
                //                       fontFamily: 'MuseoSans-700.otf',
                //                       letterSpacing: 0.5,
                //                       fontWeight: FontWeight.bold,
                //                       color: _signInScreenController
                //                               .isResendEnable.value
                //                           ? AppConst.white
                //                           : AppConst.black,
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           ),
                //         )
                //       : GestureDetector(
                // onTap: Constants.start.value == 0
                //     ? () {
                //         _signInScreenController.submitPhoneNumber();
                //         _signInScreenController.startTimer();
                //       }
                //     : null,
                //           child: Container(
                //             height: 7.h,
                //             width: 80.w,
                //             decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(1.5.w),
                //               border: Border.all(
                //                 color: _signInScreenController
                //                         .isResendEnable.value
                //                     ? AppConst
                //                         .kSecondaryColor //Colors.green //kSecondaryTextColor
                //                     : AppConst.lightGrey,
                //                 // Colors.green
                //                 //  kSecondaryTextColor
                //               ),
                //               color: _signInScreenController
                //                       .isResendEnable.value
                //                   ? AppConst
                //                       .kSecondaryColor //Colors.green //kSecondaryTextColor
                //                   : AppConst.transparent,
                //             ),
                //             child: Center(
                //               child: Row(
                //                 mainAxisAlignment: MainAxisAlignment.center,
                //                 children: [
                //                   Text(
                //                     'Resend OTP in ',
                //                     style: TextStyle(
                //                       fontSize: 13.sp,
                //                       fontFamily: 'MuseoSans-700.otf',
                //                       fontWeight: FontWeight.bold,
                //                       letterSpacing: 0.5,
                //                       color: _signInScreenController
                //                               .isResendEnable.value
                //                           ? AppConst.white
                //                           : AppConst.black,
                //                     ),
                //                   ),
                //                   Text(
                //                     '00:${Constants.start.value}',
                //                     style: TextStyle(
                //                       fontSize: 13.sp,
                //                       fontFamily: 'MuseoSans-700.otf',
                //                       letterSpacing: 0.5,
                //                       fontWeight: FontWeight.bold,
                //                       color: _signInScreenController
                //                               .isResendEnable.value
                //                           ? AppConst.white
                //                           : AppConst.kSecondaryColor,
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           ),
                //         ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
