import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:sizer/sizer.dart';

class CallDeliveryPersonWidget extends StatelessWidget {
  const CallDeliveryPersonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        color: AppConst.white,
        width: double.infinity,
        child: Row(
          children: [
            CircleAvatar(
              radius: 3.h,
              backgroundColor: AppConst.green,
            ),
            SizedBox(
              width: 3.w,
            ),
            Expanded(
              child: Text(
                "Mizanur Rahman",
                style: TextStyle(
                  fontSize: SizeUtils.horizontalBlockSize * 4.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ElevatedButton.icon(
              icon: Icon(
                Icons.call,
                size: 2.h,
                color: AppConst.kPrimaryColor,
              ),
              label: Text(
                "CALL",
                style: TextStyle(
                  color: AppConst.kPrimaryColor,
                  fontSize: SizeUtils.horizontalBlockSize * 4,
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                minimumSize: Size(0, 35),
                primary: AppConst.lightYellow,
              ),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
