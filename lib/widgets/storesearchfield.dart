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
      decoration: BoxDecoration(color: AppConst.veryLightGrey),
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
          Text("Search for items",
              overflow: TextOverflow.clip,
              maxLines: 1,
              style: TextStyle(
                fontFamily: 'MuseoSans',
                color: AppConst.grey,
                fontSize: SizeUtils.horizontalBlockSize * 3.7,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
              )),
        ],
      ),
    );
  }
}
