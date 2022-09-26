import 'package:flutter/material.dart';
import 'package:customer_app/constants/app_const.dart';

class GradientButton extends StatelessWidget {
  final double? height;
  final double? width;
  final Function()? onTap;
  final IconData? icon;
  final String label;
  final TextStyle? fontStyle;

  GradientButton(
      {this.width,
      this.onTap,
      this.height,
      required this.label,
      this.icon,
      this.fontStyle});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          // color: Colors.grey[200],
          borderRadius: BorderRadius.circular(4),
          gradient: AppConst.gradient1,
          // border: Border.all(width: 1, color: Colors.grey)
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null)
                Icon(
                  icon,
                  size: 25,
                ),
              if (icon != null)
                SizedBox(
                  width: 7,
                ),
              Text(
                label,
                style: fontStyle,
              )
            ],
          ),
        ),
      ),
    );
  }
}
