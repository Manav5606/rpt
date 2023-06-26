import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/ui/pages/location_picker/address_model.dart';
import 'package:customer_app/constants/app_const.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/add_location_controller.dart';

class BottomConfirmLocationSheet extends StatelessWidget {
  final Function() notifyParent;
  final Function() getUserLocation;
  final Function() getCurrentLocation;
  final Function() skipButton;
  final String address;
  final bool isFullAddesss;
  final bool isHome;
  String page;

  BottomConfirmLocationSheet(
      {Key? key,
      required this.address,
      required this.notifyParent,
      required this.isFullAddesss,
      required this.getCurrentLocation,
      required this.getUserLocation,
      required this.isHome,
      required this.skipButton,
      required this.page})
      : super(key: key);
  final AddLocationController _addLocationController = Get.find();

  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
    return Stack(children: [
      Positioned(
        right: 0,
        left: 0,
        bottom: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: getUserLocation,
                  // onTap: (() {
                  //   _addLocationController.getCurrentAddress();
                  // }),
                  child: Container(
                    // height: 5.h,
                    // width: 50.w,
                    margin: EdgeInsets.only(
                      bottom: 3.h,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppConst.white,
                      // borderRadius: BorderRadius.circular(12),
                      // border: Border.all(
                      //     // color: AppConst.black,
                      //     // width: SizeUtils.horizontalBlockSize - 2.92
                      //     ),
                      boxShadow: [
                        BoxShadow(
                          color: AppConst.grey.withOpacity(0.6),
                          blurRadius: 3,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Icon(
                          Icons.gps_fixed_rounded,
                          color: AppConst.black,
                          size: 2.7.h,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 4.w,
                )
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: AppConst.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12.0),
                  topLeft: Radius.circular(12.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppConst.grey,
                    blurRadius: 3,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_rounded,
                              color: AppConst.green,
                              size: 3.5.h,
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Container(
                              width: 64.w,
                              child: Text(
                                (address != null && address != "")
                                    ? _addLocationController.SortByCharactor(
                                        this.address.toString(), ",")
                                    : "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: AppConst.black,
                                  fontFamily: 'MuseoSans',
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  fontSize: SizeUtils.horizontalBlockSize * 4.2,
                                ),
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () async {
                            dynamic value = Get.to(AddressModel(
                              isSavedAddress: true,
                              page: page,
                            ));

                            if (value != null) {
                              getCurrentLocation.call();
                            }
                            log('value is:--->>>$value');
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 2.w, top: 1.h, bottom: 1.h),
                            child: Container(
                              // width: 20.w,
                              // height: 4.h,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.5, color: Color(0xff0082ab)),
                                  color: Color(0xffe1f7ff),
                                  borderRadius: BorderRadius.circular(18)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 2.w, vertical: 0.5.h),
                                child: Center(
                                  child: Text(
                                    "CHANGE",
                                    style: TextStyle(
                                      color: Color(0xff003d51),
                                      fontFamily: 'MuseoSans',
                                      fontSize: (SizerUtil.deviceType ==
                                              DeviceType.tablet)
                                          ? 7.5.sp
                                          : 8.5.sp,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                    ),
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
                          EdgeInsets.only(left: 4.w, bottom: 1.h, right: 2.w),
                      child: Container(
                        width: 85.w,
                        child: Text(
                          this.address,
                          maxLines: 2,
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                            fontFamily: 'MuseoSans',
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            color: AppConst.DarkColor,
                            fontSize:
                                (SizerUtil.deviceType == DeviceType.tablet)
                                    ? 8.5.sp
                                    : 9.5.sp,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    // Row(
                    //   children: [
                    //     Padding(
                    //       padding: EdgeInsets.only(bottom: 2.h),
                    //       child: Icon(
                    //         Icons.location_on_rounded,
                    //         color: AppConst.kPrimaryColor,
                    //         size: 3.4.h,
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       width: 2.w,
                    //     ),
                    //     Container(
                    //       width: 85.w,
                    //       child: Text(
                    //         this.address,
                    //         maxLines: 2,
                    //         overflow: TextOverflow.visible,
                    //         style: TextStyle(
                    //           color: AppConst.DarkColor,
                    //           fontSize: SizeUtils.horizontalBlockSize * 4.2,
                    //           fontWeight: FontWeight.w400,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),

                    // Padding(
                    //   padding:
                    //       EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       border: Border.all(color: AppConst.black, width: 0.6),
                    //       borderRadius: BorderRadius.circular(14),
                    //     ),
                    //     child: Column(
                    //       mainAxisAlignment: MainAxisAlignment.start,
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         // Padding(
                    //         //   padding: EdgeInsets.only(top: 1.h, left: 3.w),
                    //         //   child: Text(
                    //         //     "YOUR LOCATION",
                    //         //     style: TextStyle(
                    //         //       color: AppConst.black,
                    //         //       fontSize: SizeUtils.horizontalBlockSize * 3,
                    //         //     ),
                    //         //   ),
                    //         // ),
                    //         Padding(
                    //           padding: EdgeInsets.only(
                    //               top: 1.h, bottom: 1.h, left: 3.w, right: 2.w),
                    //           child: Row(
                    //             children: [
                    //               // Icon(
                    //               //   Icons.verified_outlined,
                    //               //   color: Colors.blue,
                    //               //   size: SizeUtils.horizontalBlockSize * 5.20,
                    //               // ),
                    //               // SizedBox(
                    //               //   width: 2.w,
                    //               // ),
                    //               Expanded(
                    //                 child: Text(
                    //                   this.address,
                    //                   maxLines: 2,
                    //                   overflow: TextOverflow.visible,
                    //                   style: TextStyle(
                    //                     color: AppConst.black,
                    //                     fontSize:
                    //                         SizeUtils.horizontalBlockSize * 4,
                    //                     fontWeight: FontWeight.w500,
                    //                   ),
                    //                 ),
                    //               ),
                    //               // InkWell(
                    //               //   onTap: () async {
                    //               //     dynamic value = Get.to(AddressModel(
                    //               //       isSavedAddress: false,
                    //               //     ));
                    //               //     // dynamic value = await showModalBottomSheet(
                    //               //     //   isScrollControlled: true,
                    //               //     //   context: context,
                    //               //     //   useRootNavigator: true,
                    //               //     //   builder: (context) {
                    //               //     //     return AddressModel(
                    //               //     //       isSavedAddress: false,
                    //               //     //     );
                    //               //     // },
                    //               //     // );
                    //               //     if (value != null) {
                    //               //       getCurrentLocation
                    //               //           .call(); // how to call this when i don't want bottom sheet ??
                    //               //     }
                    //               //     log('value is:--->>>$value');
                    //               //   },
                    //               //   child: Padding(
                    //               //     padding: EdgeInsets.symmetric(
                    //               //         horizontal: 2.w, vertical: 1.h),
                    //               //     child: Container(
                    //               //       width: 25.w,
                    //               //       height: 4.h,
                    //               //       decoration: BoxDecoration(
                    //               //           color: AppConst.lightYellow,
                    //               //           borderRadius:
                    //               //               BorderRadius.circular(12)),
                    //               //       child: Center(
                    //               //         child: Text(
                    //               //           "CHANGE",
                    //               //           style: TextStyle(
                    //               //             color: AppConst.black,
                    //               //             fontSize:
                    //               //                 SizeUtils.horizontalBlockSize *
                    //               //                     4,
                    //               //             fontWeight: FontWeight.w500,
                    //               //           ),
                    //               //         ),
                    //               //       ),
                    //               //     ),
                    //               //   ),
                    //               // )
                    //             ],
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),

                    // Row(
                    //   children: [
                    //     Icon(
                    //       Icons.verified_outlined,
                    //       color: Colors.blue,
                    //       size: SizeUtils.horizontalBlockSize * 5.20,
                    //     ),
                    //     SizedBox(
                    //       width: 2.w,
                    //     ),
                    //     Expanded(
                    //       child: Text(
                    //         this.address,
                    //         maxLines: 1,
                    //         overflow: TextOverflow.ellipsis,
                    //         style: TextStyle(
                    //           color: AppConst.black,
                    //           fontSize: SizeUtils.horizontalBlockSize * 4.5,
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       ),
                    //     ),
                    //     InkWell(
                    //       onTap: () async {
                    //         dynamic value = await showModalBottomSheet(
                    //           isScrollControlled: true,
                    //           context: context,
                    //           useRootNavigator: true,
                    //           builder: (context) {
                    //             return AddressModel(
                    //               isSavedAddress: false,
                    //             );
                    //           },
                    //         );
                    //         if (value != null) {
                    //           getCurrentLocation.call();
                    //         }
                    //         log('value is:--->>>$value');
                    //       },
                    //       child: Text(
                    //         "CHANGE",
                    //         style: TextStyle(
                    //           color: Colors.green,
                    //           fontSize: SizeUtils.horizontalBlockSize * 4.2,
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       ),
                    //     )
                    //   ],
                    // ),
                    // Divider(),
                    // SizedBox(height: 3.h),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 2.w,
                        right: 2.w,
                      ),
                      child: ConfirmLocationWideButton(
                        isHome: isHome,
                        notifyParent: notifyParent,
                        skipButton: skipButton,
                      ),
                    ),
                    // SizedBox(height: 1.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}

class ConfirmLocationWideButton extends StatelessWidget {
  const ConfirmLocationWideButton({
    Key? key,
    required this.notifyParent,
    required this.skipButton,
    required this.isHome,
  }) : super(key: key);
  final Function() skipButton;

  final Function() notifyParent;
  final bool isHome;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        notifyParent();
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 1.h),
        height: 6.h,
        decoration: BoxDecoration(
            color: AppConst.green,
            // border: Border.all(width: 1.5, color: AppConst.green),
            borderRadius: BorderRadius.circular(30)),
        child: Center(
          child: Text(
            "Confirm Location",
            style: TextStyle(
              fontFamily: 'MuseoSans',
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              fontSize:
                  (SizerUtil.deviceType == DeviceType.tablet) ? 10.sp : 12.sp,
              color: AppConst.white,
            ),
          ),
        ),
      ),
    );
  }
}
