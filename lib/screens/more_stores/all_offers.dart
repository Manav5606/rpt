import 'package:flutter/material.dart';
import 'package:customer_app/constants/string_constants.dart';
import 'package:sizer/sizer.dart';

class AllOffers extends StatelessWidget {
  const AllOffers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 3.w, bottom: 1.h, top: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text("All stores near you", //"Recent Transactions",
                  style: TextStyle(
                      fontFamily: 'MuseoSans',
                      color: Colors.black87,
                      fontSize: (SizerUtil.deviceType == DeviceType.tablet)
                          ? 9.5.sp
                          : 11.5.sp,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      letterSpacing: -0.5)),
            ],
          ),
          // Row(
          //   children: [
          //     Text(
          //       StringContants.orderScreensortBy,
          //       style: TextStyle(
          //         fontSize: 13.sp,
          //         fontWeight: FontWeight.w700,
          //       ),
          //     ),
          //     Icon(Icons.keyboard_arrow_down_outlined)
          //   ],
          // ),
        ],
      ),
    );
  }
}
