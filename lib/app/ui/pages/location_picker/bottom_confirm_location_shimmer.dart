import 'package:customer_app/app/ui/pages/signIn/phone_authentication_screen.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/ui/common/shimmer_widget.dart';
import 'package:customer_app/app/ui/pages/location_picker/bottom_confim_location.dart';
import 'package:customer_app/constants/app_const.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BottomConfirmLocationSheetShimmer extends StatelessWidget {
  // final Function() notifyParent;
  // final Function() getUserLocation;
  // final String address;
  // final bool isFullAddesss;

  const BottomConfirmLocationSheetShimmer({
    Key? key,
    // required this.address,
    // required this.notifyParent,
    // required this.isFullAddesss,
    // required this.getUserLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                Container(
                  // height: 5.h,
                  // width: 50.w,
                  margin: EdgeInsets.only(
                    bottom: 3.h,
                  ),
                  decoration: BoxDecoration(
                    // shape: BoxShape.circle,
                    color: AppConst.white,
                    borderRadius: BorderRadius.circular(12),
                    // border: Border.all(
                    //     // color: AppConst.black,
                    //     // width: SizeUtils.horizontalBlockSize - 2.92
                    //     ),
                    boxShadow: [
                      BoxShadow(
                        color: AppConst.grey,
                        blurRadius: 3,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: ShimmerEffect(
                        child: Icon(
                          Icons.gps_fixed_rounded,
                          color: AppConst.black,
                          size: SizeUtils.horizontalBlockSize * 6.5,
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
                    blurRadius: 8,
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
                            ShimmerEffect(
                              child: Icon(
                                Icons.location_on_rounded,
                                color: AppConst.green,
                                size: 3.5.h,
                              ),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            ShimmerEffect(
                              child: Container(
                                color: AppConst.black,
                                child: Text(
                                  "Display the addresss",
                                  style: TextStyle(
                                    color: AppConst.black,
                                    fontFamily: 'MuseoSans',
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                    fontSize:
                                        SizeUtils.horizontalBlockSize * 4.2,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 1.h),
                          child: ShimmerEffect(
                            child: Container(
                              // width: 20.w,
                              // height: 4.h,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: Color(0xff0082ab)),
                                  color: Color(0xffe1f7ff),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 2.w, vertical: 0.5.h),
                                child: Center(
                                  child: Text(
                                    "CHANGE",
                                    style: TextStyle(
                                      color: Color(0xff003d51),
                                      fontFamily: 'MuseoSans',
                                      fontWeight: FontWeight.w700,
                                      fontSize:
                                          SizeUtils.horizontalBlockSize * 3,
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
                          EdgeInsets.only(left: 2.w, bottom: 1.h, right: 2.w),
                      child: ShimmerEffect(
                          child: Container(
                        width: 80.w,
                        height: 3.5.h,
                        color: AppConst.black,
                      )),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    ShimmerEffect(
                      child: BottomWideButton(
                        text: "Confirm Location",
                      ),
                    )
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

// InkWell(
//           onTap: getUserLocation,
//           child: Container(
//             padding: EdgeInsets.all(2.w),
//             margin: EdgeInsets.only(right: 5.w, bottom: 2.h),
//             decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: AppConst.white,
//                 border: Border.all(color: Colors.grey.shade300, width: SizeUtils.horizontalBlockSize - 2.92),
//                 boxShadow: [AppConst.shadowBasic]),
//             child: Icon(
//               Icons.gps_fixed_rounded,
//               size: SizeUtils.horizontalBlockSize * 6.5,
//             ),
//           ),
//         ),
//         Container(
//           color: AppConst.white,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                   vertical: 1.h,
//                   horizontal: 2.w,
//                 ),
//                 child: Text(
//                   "Confirm Delivery Location",
//                   style: TextStyle(
//                     fontSize: SizeUtils.horizontalBlockSize * 5.5,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ),
//               ShimmerEffect(child: Divider(height: 0)),
//               ShimmerEffect(
//                 child: Padding(
//                   padding: EdgeInsets.only(
//                     top: 1.h,
//                     left: 2.w,
//                   ),
//                   child: Text(
//                     "YOUR LOCATION",
//                     style: TextStyle(
//                       color: Colors.grey,
//                       fontSize: SizeUtils.horizontalBlockSize * 3.5,
//                     ),
//                   ),
//                 ),
//               ),
//               ShimmerEffect(
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: 3.w,
//                     vertical: 0.5.h,
//                   ),
//                   child: Row(
//                     children: [
//                       Icon(
//                         Icons.verified_outlined,
//                         color: Colors.blue,
//                         size: SizeUtils.horizontalBlockSize * 5.20,
//                       ),
//                       SizedBox(
//                         width: 2.w,
//                       ),
//                       Expanded(
//                         child: Text(
//                           this.address,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                             color: AppConst.black,
//                             fontSize: SizeUtils.horizontalBlockSize * 4.5,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () {},
//                         child: Text(
//                           "CHANGE",
//                           style: TextStyle(
//                             color: kSecondaryTextColor,
//                             fontSize: SizeUtils.horizontalBlockSize * 4.2,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               ShimmerEffect(child: Divider()),
//               ShimmerEffect(
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 2.w),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             elevation: 0,
//                             primary: kSecondaryTextColor,
//                             padding: EdgeInsets.all(SizeUtils.horizontalBlockSize * 3),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(SizeUtils.horizontalBlockSize * 3),
//                             ),
//                           ),
//                           onPressed: () {},
//                           child: Text(
//                             "Confirm location & Proceed",
//                             style: TextStyle(
//                               fontSize: SizeUtils.horizontalBlockSize * 5,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 2.h),
//             ],
//           ),
//         ),