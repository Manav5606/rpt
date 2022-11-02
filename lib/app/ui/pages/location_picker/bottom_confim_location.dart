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

  BottomConfirmLocationSheet({
    Key? key,
    required this.address,
    required this.notifyParent,
    required this.isFullAddesss,
    required this.getCurrentLocation,
    required this.getUserLocation,
    required this.isHome,
    required this.skipButton,
  }) : super(key: key);
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
            InkWell(
              onTap: getUserLocation,
              child: Container(
                height: 5.h,
                width: 50.w,
                margin: EdgeInsets.only(
                  bottom: 2.h,
                ),
                decoration: BoxDecoration(
                    // shape: BoxShape.circle,
                    color: AppConst.white,
                    borderRadius: BorderRadius.circular(
                        SizeUtils.horizontalBlockSize * 1.27),
                    border: Border.all(
                        color: AppConst.black,
                        width: SizeUtils.horizontalBlockSize - 2.92),
                    boxShadow: [AppConst.shadowBasic]),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                        child: Icon(
                          Icons.gps_fixed_rounded,
                          color: AppConst.kSecondaryTextColor,
                          size: SizeUtils.horizontalBlockSize * 6.5,
                        ),
                      ),
                      // SizedBox(
                      //   width: 2.w,
                      // ),
                      Text(
                        "Use current location",
                        style: TextStyle(
                            color: AppConst.green,
                            fontSize: SizeUtils.horizontalBlockSize * 4,
                            fontWeight: FontWeight.bold),
                      ),
                    ]),
              ),
            ),
            Container(
              color: AppConst.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
                    child: Text(
                      "Confirm Delivery Location",
                      style: TextStyle(
                        fontSize: SizeUtils.horizontalBlockSize * 5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Divider(height: 0),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppConst.black, width: 0.6),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 1.h, left: 3.w),
                            child: Text(
                              "YOUR LOCATION",
                              style: TextStyle(
                                color: AppConst.black,
                                fontSize: SizeUtils.horizontalBlockSize * 3,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 1.h, bottom: 1.h, left: 3.w, right: 2.w),
                            child: Row(
                              children: [
                                // Icon(
                                //   Icons.verified_outlined,
                                //   color: Colors.blue,
                                //   size: SizeUtils.horizontalBlockSize * 5.20,
                                // ),
                                // SizedBox(
                                //   width: 2.w,
                                // ),
                                Expanded(
                                  child: Text(
                                    this.address,
                                    maxLines: 2,
                                    overflow: TextOverflow.visible,
                                    style: TextStyle(
                                      color: AppConst.black,
                                      fontSize:
                                          SizeUtils.horizontalBlockSize * 4,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    dynamic value = Get.to(AddressModel(
                                      isSavedAddress: false,
                                    ));
                                    // dynamic value = await showModalBottomSheet(
                                    //   isScrollControlled: true,
                                    //   context: context,
                                    //   useRootNavigator: true,
                                    //   builder: (context) {
                                    //     return AddressModel(
                                    //       isSavedAddress: false,
                                    //     );
                                    // },
                                    // );
                                    if (value != null) {
                                      getCurrentLocation
                                          .call(); // how to call this when i don't want bottom sheet ??
                                    }
                                    log('value is:--->>>$value');
                                  },
                                  child: Text(
                                    "CHANGE",
                                    style: TextStyle(
                                      color: AppConst.green,
                                      fontSize:
                                          SizeUtils.horizontalBlockSize * 4,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

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
                  ConfirmLocationWideButton(
                    isHome: isHome,
                    notifyParent: notifyParent,
                    skipButton: skipButton,
                  ),
                  SizedBox(height: 1.h),
                ],
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: Row(
        children: [
          if (isHome)
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 7.3.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: AppConst.kSecondaryColor,
                          padding:
                              EdgeInsets.all(SizeUtils.horizontalBlockSize * 3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                SizeUtils.horizontalBlockSize * 3),
                          ),
                        ),
                        onPressed: () {
                          notifyParent();
                        },
                        child: Text(
                          "Confirm location",
                          style: TextStyle(
                            fontSize: SizeUtils.horizontalBlockSize * 5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: SizeUtils.verticalBlockSize * 1,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 7.3.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: AppConst.kSecondaryColor,
                          padding:
                              EdgeInsets.all(SizeUtils.horizontalBlockSize * 3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                SizeUtils.horizontalBlockSize * 3),
                          ),
                        ),
                        onPressed: () async {
                          skipButton();
                        },
                        child: Text(
                          "Skip",
                          style: TextStyle(
                            fontSize: SizeUtils.horizontalBlockSize * 5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          else
            Expanded(
              child: SizedBox(
                height: 7.3.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: AppConst.kSecondaryColor,
                    padding: EdgeInsets.all(SizeUtils.horizontalBlockSize * 3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          SizeUtils.horizontalBlockSize * 3),
                    ),
                  ),
                  onPressed: () {
                    notifyParent();
                  },
                  child: Text(
                    "Confirm location & Proceed",
                    style: TextStyle(
                      fontSize: SizeUtils.horizontalBlockSize * 5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
