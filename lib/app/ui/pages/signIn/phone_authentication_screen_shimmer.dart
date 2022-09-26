import 'package:flutter/material.dart';
import 'package:customer_app/app/controller/signInScreenController.dart';
import 'package:customer_app/app/ui/common/shimmer_widget.dart';
import 'package:customer_app/app/ui/pages/signIn/phone_authentication_screen.dart';
import 'package:customer_app/constants/app_const.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SignInScreenShimmer extends StatelessWidget {
  final SignInScreenController _signInController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 2.h, left: 1.h, right: 1.h),
            child: ShimmerEffect(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BackButton(
                      color: AppConst.black,
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      " Log In ",
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: "MuseoSans_700.otf"),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      // height: 9.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: AppConst.black, width: 1.5)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 2.w, top: 0.5.h, bottom: 0.5.h),
                            child: Text(
                              "Mobile",
                              style: TextStyle(
                                  fontSize: 9.sp, fontWeight: FontWeight.w500),
                            ),
                          ),
                          TextField(
                            style: TextStyle(fontSize: 14.sp),
                            textAlign: TextAlign.start,
                            cursorColor: AppConst.kPrimaryColor,
                            maxLength: 10,
                            keyboardType: TextInputType.number,
                            controller: _signInController.phoneNumberController,
                            decoration: InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              hintText: 'Enter Phone Number',
                              contentPadding:
                                  EdgeInsets.only(left: 2.w, bottom: 1.h),
                              hintTextDirection: TextDirection.ltr,
                              counterText: "",
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    GestureDetector(
                        // onTap: (_signInController
                        //             .phoneNumberController.value.text.length ==
                        //         10)
                        //     ? () {
                        //         _signInController.submitPhoneNumber();
                        //       }
                        //     : null,
                        child: BottomWideButton())
                  ]),
              // Column(
              //   children: [
              //     Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              //       InkWell(
              //         onTap: () {},
              //         child: Container(
              //           padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.h),
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(2.h),
              //             color: kGreyColor,
              //           ),
              //           child: Center(
              //               child: Text(
              //             'Skip',
              //             style: TextStyle(fontSize: 14.sp),
              //           )),
              //         ),
              //       )
              //     ]),
              //     Container(
              //       height: 15.h,
              //       width: 45.w,
              //     ),
              //     Container(
              //       height: 15.h,
              //       width: 45.w,
              //     ),
              //     Container(
              //       height: 4.h,
              //       child: FittedBox(
              //         fit: BoxFit.scaleDown,
              //         child: Text(
              //           'Welcome to Recipto',
              //           style: TextStyle(fontSize: 18.sp, color: kSecondaryTextColor),
              //         ),
              //       ),
              //     ),
              //     SizedBox(
              //       height: 3.h,
              //     ),
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Flexible(
              //           child: Divider(
              //             thickness: 2,
              //           ),
              //         ),
              //         Padding(
              //           padding: EdgeInsets.all(2.h),
              //           child: FittedBox(
              //             fit: BoxFit.scaleDown,
              //             child: Text(
              //               'Login or Signup',
              //               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
              //             ),
              //           ),
              //         ),
              //         Flexible(
              //           child: Divider(
              //             thickness: 2,
              //           ),
              //         ),
              //       ],
              //     ),
              //     SizedBox(
              //       height: 3.h,
              //     ),
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Container(
              //           width: 12.w,
              //           decoration: BoxDecoration(border: Border.all(color: AppConst.black)),
              //           child: TextField(
              //             style: TextStyle(fontSize: 14.sp),
              //             textAlign: TextAlign.center,
              //             enabled: false,
              //             decoration: InputDecoration(
              //               border: InputBorder.none,
              //               hintText: '+91',
              //               hintStyle: TextStyle(fontSize: 14.sp, color: AppConst.black),
              //               hintTextDirection: TextDirection.ltr,
              //               counterText: "",
              //             ),
              //           ),
              //         ),
              //         SizedBox(
              //           width: 1.w,
              //         ),
              //         Container(
              //           width: 65.w,
              //           decoration: BoxDecoration(border: Border.all(color: AppConst.black)),
              //           child: TextField(
              //             style: TextStyle(fontSize: 14.sp),
              //             textAlign: TextAlign.center,
              //             cursorColor: kPrimaryColor,
              //             maxLength: 10,
              //             keyboardType: TextInputType.number,
              //             controller: _signInController.phoneNumberController,
              //             decoration: InputDecoration(
              //               border: InputBorder.none,
              //               hintText: 'Enter Phone Number',
              //               hintTextDirection: TextDirection.ltr,
              //               counterText: "",
              //             ),
              //           ),
              //         )
              //       ],
              //     ),
              //     SizedBox(
              //       height: 3.h,
              //     ),
              //     SizedBox(
              //       height: SizeUtils.horizontalBlockSize * 12,
              //       width: SizeUtils.horizontalBlockSize * 72,
              //       child: Button(
              //         onTap: () {},
              //         child: Text(
              //           'Continue',
              //           style: TextStyle(color: ColorConstants.secondaryDarkAppColor),
              //         ),
              //         bgColor: kPrimaryColor,
              //       ),
              //     ),
              //     SizedBox(
              //       height: 3.h,
              //     ),
              //     Divider(
              //       thickness: 1,
              //     )
              //   ],
              // ),
            ),
          ),
        ));
  }
}
