import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/data/model/order_model.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/constants/string_constants.dart';
import 'package:sizer/sizer.dart';

class StoreNameWidget extends StatelessWidget {
  final OrderData order;

  const StoreNameWidget({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
        color: AppConst.white,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "ORDERED FROM",
              style: TextStyle(
                fontSize: SizeUtils.horizontalBlockSize * 4,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              order.store?.name ?? "Star Kebab & Restaurent Banani",
              style: TextStyle(
                color: AppConst.darkGrey,
                fontSize: SizeUtils.horizontalBlockSize * 4,
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Text(
              "DELIVER TO",
              style: TextStyle(
                fontSize: SizeUtils.horizontalBlockSize * 4,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              order.address ?? StringContants.orderScreenAddress,
              style: TextStyle(
                color: AppConst.black,
                fontSize: SizeUtils.horizontalBlockSize * 4,
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Text(
              "ORDER DATE",
              style: TextStyle(
                fontSize: SizeUtils.horizontalBlockSize * 4,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              "12-09-2021 at 11:02 AM",
              style: TextStyle(
                fontSize: SizeUtils.horizontalBlockSize * 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
