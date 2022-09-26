import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/constants/app_const.dart';

class AddButtonWidget extends StatelessWidget {
  final GestureTapCallback? onTap;

  const AddButtonWidget({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppConst.grey),
          color: AppConst.white,
          boxShadow: [
            BoxShadow(
              color: AppConst.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1.5,
            ),
          ],
        ),
        child: Icon(
          Icons.add,
          color: AppConst.black,
          size: SizeUtils.horizontalBlockSize * 6,
        ),
      ),
    );
  }
}
