import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:sizer/sizer.dart';

class ContactStoreWidget extends StatelessWidget {
  const ContactStoreWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
      color: AppConst.white,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              "CONTACT STORE",
              style: TextStyle(
                  color: AppConst.kPrimaryColor,
                  fontWeight: FontWeight.w700,
                  fontSize: SizeUtils.horizontalBlockSize * 4),
            ),
          ),
          IconButton(
            onPressed: () {},
            constraints: BoxConstraints.tightFor(),
            splashRadius: 3.h,
            padding: EdgeInsets.zero,
            color: AppConst.kPrimaryColor,
            icon: Icon(
              Icons.message_outlined,
            ),
          ),
          SizedBox(
            width: 4.w,
          ),
          IconButton(
            onPressed: () {},
            constraints: BoxConstraints.tightFor(),
            splashRadius: 3.h,
            padding: EdgeInsets.zero,
            color: AppConst.green,
            icon: Icon(
              Icons.call,
              size: 3.h,
            ),
          ),
        ],
      ),
    );
  }
}
