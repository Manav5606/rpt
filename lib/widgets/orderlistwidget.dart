import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:customer_app/widgets/arrowIcon.dart';
import 'package:customer_app/widgets/orderListdata.dart';

class OrderList extends StatelessWidget {
  const OrderList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: orderListData.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          height: SizeUtils.horizontalBlockSize * 36,
          child: Column(
            children: [
              Container(
                height: SizeUtils.horizontalBlockSize * 10,
                width: double.infinity,
                child: Row(
                  children: [
                    SizedBox(
                      width: SizeUtils.horizontalBlockSize * 3,
                    ),
                    Text(
                      "\$${orderListData[index].price!}",
                      style: TextStyle(
                          fontSize: SizeUtils.horizontalBlockSize * 5,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: SizeUtils.horizontalBlockSize * 3,
                    ),
                    Expanded(
                        child: Text(
                      orderListData[index].noOfOrders!,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.STORES_SUBTITLE_STYLE,
                    )),
                    ArrowForwardIcon(),
                  ],
                ),
              ),
              Container(
                height: SizeUtils.horizontalBlockSize * 10,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: SizeUtils.horizontalBlockSize * 3,
                    ),
                    Icon(
                      FontAwesomeIcons.truck,
                      size: SizeUtils.horizontalBlockSize * 4,
                    ),
                    SizedBox(
                      width: SizeUtils.horizontalBlockSize * 3,
                    ),
                    SizedBox(
                      width: SizeUtils.horizontalBlockSize * 3,
                    ),
                    Expanded(
                        child: Text(
                      "${orderListData[index].distance!} miles",
                      style: AppStyles.STORES_SUBTITLE_STYLE,
                      overflow: TextOverflow.ellipsis,
                    )),
                    Icon(
                      FontAwesomeIcons.shopify,
                      size: SizeUtils.horizontalBlockSize * 4,
                      color: AppConst.grey,
                    ),
                    Text(
                      "${orderListData[index].items} items \/ ${orderListData[index].units} units",
                      style: AppStyles.STORES_SUBTITLE_STYLE,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      width: SizeUtils.horizontalBlockSize * 3,
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: SizeUtils.horizontalBlockSize * 0.5,
              ),
              Row(
                children: [
                  SizedBox(
                    width: SizeUtils.horizontalBlockSize * 3,
                  ),
                  Text(
                    orderListData[index].address!,
                    style: AppStyles.STORE_NAME_STYLE,
                  )
                ],
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          thickness: SizeUtils.horizontalBlockSize * 5,
        );
      },
    );
  }
}
