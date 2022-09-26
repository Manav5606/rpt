import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:sizer/sizer.dart';

class OrderInfoWidget extends StatelessWidget {
  const OrderInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
        color: AppConst.white,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Order Info",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: SizeUtils.horizontalBlockSize * 5.5,
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Text(
              "DELIVER BY 11:23 AM",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: SizeUtils.horizontalBlockSize * 4.5,
                color: AppConst.darkGrey,
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 1.h),
                  child: Icon(
                    Icons.circle,
                    size: 1.5.h,
                    color: AppConst.black,
                  ),
                ),
                SizedBox(
                  width: 3.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Star Kebab & Restaurant Banani",
                        style: TextStyle(
                          fontSize: SizeUtils.horizontalBlockSize * 5,
                          color: AppConst.darkGrey,
                        ),
                      ),
                      Text(
                        "32/A Banani Kacha Bazar, Kemal Attarul Avenue Park",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: SizeUtils.horizontalBlockSize * 3.5,
                          // height: 1.h,
                          color: AppConst.grey,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 3.w,
                ),
                CircleAvatar(
                  backgroundColor: AppConst.black,
                  radius: 3.h,
                )
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 1.h),
                  child: Icon(
                    Icons.circle,
                    size: 1.5.h,
                    color: AppConst.kPrimaryColor,
                  ),
                ),
                SizedBox(
                  width: 3.w,
                ),
                Expanded(
                  child: Text(
                    "Work (Level 6, Genetic Baro Bhuiyan, 37, South Gulshan, Circle 1 Dhaka 1212)",
                    style: TextStyle(
                      fontSize: SizeUtils.horizontalBlockSize * 4,
                      color: AppConst.darkGrey,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
