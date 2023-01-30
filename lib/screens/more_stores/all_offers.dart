import 'package:flutter/material.dart';
import 'package:customer_app/constants/string_constants.dart';
import 'package:sizer/sizer.dart';

class AllOffers extends StatelessWidget {
  const AllOffers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                // "More Stores in Bengaluru",
                "Store near you ",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'MuseoSans-700.otf',
                ),
              )
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
