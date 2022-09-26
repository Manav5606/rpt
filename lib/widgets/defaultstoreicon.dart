import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/constants/app_const.dart';

class defaultStoreWidget extends StatelessWidget {
  const defaultStoreWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: Icon(Icons.store_rounded),
      backgroundColor: AppConst.white,
      radius: SizeUtils.horizontalBlockSize * 5.2,
    );
  }
}
