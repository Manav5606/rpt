import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/ui/common/shimmer_widget.dart';
import 'package:customer_app/app/ui/pages/location_picker/bottom_confim_location.dart';
import 'package:customer_app/constants/app_const.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BottomConfirmLocationSheetShimmer extends StatelessWidget {
  final Function() notifyParent;
  final Function() getUserLocation;
  final String address;
  final bool isFullAddesss;

  const BottomConfirmLocationSheetShimmer({
    Key? key,
    required this.address,
    required this.notifyParent,
    required this.isFullAddesss,
    required this.getUserLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        left: 0,
        right: 0,
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
                        child: ShimmerEffect(
                          child: Icon(
                            Icons.gps_fixed_rounded,
                            color: AppConst.kSecondaryTextColor,
                            size: SizeUtils.horizontalBlockSize * 6.5,
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   width: 2.w,
                      // ),
                      ShimmerEffect(
                        child: Text(
                          "Use current location",
                          style: TextStyle(
                              color: AppConst.green,
                              fontSize: SizeUtils.horizontalBlockSize * 4,
                              fontWeight: FontWeight.bold),
                        ),
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
                    child: ShimmerEffect(
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
                              child: ShimmerEffect(
                                child: Text(
                                  "YOUR LOCATION",
                                  style: TextStyle(
                                    color: AppConst.black,
                                    fontSize: SizeUtils.horizontalBlockSize * 3,
                                  ),
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
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: AppConst.black,
                                        fontSize:
                                            SizeUtils.horizontalBlockSize * 4.5,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  ShimmerEffect(
                                    child: InkWell(
                                      onTap: () async {},
                                      child: Text(
                                        "CHANGE",
                                        style: TextStyle(
                                          color: AppConst.green,
                                          fontSize:
                                              SizeUtils.horizontalBlockSize * 4,
                                          fontWeight: FontWeight.bold,
                                        ),
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
                  ),
                  ShimmerEffect(
                    child: ConfirmLocationWideButton(
                      isHome: false,
                      notifyParent: notifyParent,
                      skipButton: (){},
                    ),
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