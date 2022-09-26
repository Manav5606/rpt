import 'package:flutter/material.dart';
import 'package:customer_app/constants/app_const.dart';

class TextFieldClearButton extends StatelessWidget {
  final Function() onTap;
  const TextFieldClearButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 18,
          width: 18,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppConst.grey,
          ),
          child: Icon(Icons.close, color: AppConst.white, size: 13)),
    );
  }
}
