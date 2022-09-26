import 'package:flutter/material.dart';
import 'package:customer_app/constants/app_const.dart';

class CustomOutlineButton extends StatelessWidget {
  final double? height;
  final double? width;
  final Function? onTap;
  final IconData? icon;
  final String? label;
  final TextStyle? fontStyle;

  CustomOutlineButton(
      {this.width,
      this.onTap,
      this.height,
      this.label,
      this.icon,
      this.fontStyle});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap,
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
            gradient: AppConst.gradient1,
            borderRadius: BorderRadius.circular(3)),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
                color: AppConst.white, borderRadius: BorderRadius.circular(3)),
            child: Center(
              child: Text(
                label!,
                style: fontStyle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
