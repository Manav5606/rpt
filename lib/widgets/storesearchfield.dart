import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:sizer/sizer.dart';

import '../constants/app_const.dart';

class StoreSearchField extends StatelessWidget {
  const StoreSearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 2,
      child: Container(
        padding: EdgeInsets.all(SizeUtils.horizontalBlockSize * 2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Color(0xffE7EFF4),
            )),
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  "Search market",
                  overflow: TextOverflow.clip,
                  maxLines: 1,
                  style: TextStyle(
                    fontFamily: 'MuseoSans',
                    fontSize: SizeUtils.horizontalBlockSize * 4.5,
                    color: AppConst.black,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: Icon(
                Icons.search,
                color: AppConst.black,
                size: SizeUtils.horizontalBlockSize * 6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
