import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/constants/app_const.dart';

class ArrowForwardIcon extends StatelessWidget {
  const ArrowForwardIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.arrow_forward_ios_rounded,
      color: AppConst.grey,
      size: SizeUtils.horizontalBlockSize * 5.3,
    );
  }
}
