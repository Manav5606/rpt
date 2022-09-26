import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/screens/home/controller/home_controller.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../screens/addcart/controller/addcart_controller.dart';

class CartWidget extends StatelessWidget {
  final GestureTapCallback onTap;
  final String count;
  final bool isRedButton;

  CartWidget({
    Key? key,
    required this.onTap,
    required this.count,
    this.isRedButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 2.w),
      child: GestureDetector(
        onTap: onTap,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 0.7.h,
                  horizontal: 2.w,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppConst.green,
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    children: [
                      Icon(
                        Icons.shopping_cart_rounded,
                        size: SizeUtils.horizontalBlockSize * 5.8,
                        color: AppConst.white,
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      Text(
                        count,
                        style: TextStyle(
                          color: AppConst.white,
                          fontSize: SizeUtils.horizontalBlockSize * 4,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (isRedButton)
                Container(
                  alignment: Alignment.bottomLeft,
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.red,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
