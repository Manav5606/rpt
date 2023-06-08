import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:sizer/sizer.dart';

import '../constants/app_const.dart';

class StoreSearchField extends StatelessWidget {
  const StoreSearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: AppConst.white,
        // border: Border.all(color: AppConst.grey, width: 0.5),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppConst.grey,
            blurRadius: 1,
            // offset: Offset(1, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.search,
            color: AppConst.grey,
            size: SizeUtils.horizontalBlockSize * 6,
          ),
          SizedBox(
            width: 3.w,
          ),
          Text("Search for item",
              overflow: TextOverflow.clip,
              maxLines: 1,
              style: TextStyle(
                fontFamily: 'MuseoSans',
                color: AppConst.black,
                fontSize: 11.sp,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
              )),
        ],
      ),
    );
  }
}
