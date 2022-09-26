import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/theme/styles.dart';

class OrderTypeScan extends StatelessWidget {
  const OrderTypeScan({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        "No Orders",
        style: TextStyle(
            color: AppConst.black,
            fontWeight: FontWeight.w600,
            fontSize: SizeUtils.horizontalBlockSize * 4),
      ),
      tilePadding: EdgeInsets.all(SizeUtils.horizontalBlockSize - 1),
      expandedAlignment: Alignment.center,
      textColor: AppConst.black,
      trailing: Text("View bill",
          style: TextStyle(
              color: AppConst.kPrimaryColor,
              fontSize: SizeUtils.horizontalBlockSize * 4)),
      children: [
        Container(
          height: SizeUtils.horizontalBlockSize * 8,
          child: ListTile(
            title: Text(
              "Bill amount Total",
              style: AppStyles.STORES_SUBTITLE_STYLE,
            ),
            trailing: Text(
              "\u20B9 1500",
              style: AppStyles.STORES_SUBTITLE_STYLE,
            ),
          ),
        ),
        Container(
          height: SizeUtils.horizontalBlockSize * 8,
          child: ListTile(
            title: Text(
              "Cashback percentage",
              style: AppStyles.STORES_SUBTITLE_STYLE,
            ),
            trailing: Text(
              "10%",
              style: AppStyles.STORES_SUBTITLE_STYLE,
            ),
          ),
        ),
        Container(
          height: SizeUtils.horizontalBlockSize * 8,
          child: ListTile(
            title: Text(
              "Product total",
              style: AppStyles.STORES_SUBTITLE_STYLE,
            ),
            trailing: Text(
              "\u20B9 1300",
              style: AppStyles.STORES_SUBTITLE_STYLE,
            ),
          ),
        ),
        Container(
          height: SizeUtils.horizontalBlockSize * 12,
          child: ListTile(
            title: Text(
              "Total cashback Amount",
              style: AppStyles.STORE_NAME_STYLE,
            ),
            trailing: Text(
              "\u20B9 1300",
              style: AppStyles.STORE_NAME_STYLE,
            ),
          ),
        )
      ],
    );
  }
}
