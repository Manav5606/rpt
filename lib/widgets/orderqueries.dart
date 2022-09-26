import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:customer_app/widgets/arrowIcon.dart';
import 'package:customer_app/widgets/orderquerydata.dart';

class OrderQueries extends StatelessWidget {
  const OrderQueries({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            height: SizeUtils.horizontalBlockSize * 30,
            child: Column(
              children: [
                Container(
                  height: SizeUtils.horizontalBlockSize * 10,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "${orderQueries[index].title}",
                          style: AppStyles.STORE_NAME_STYLE,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      ArrowForwardIcon()
                    ],
                  ),
                ),
                Container(
                    height: SizeUtils.horizontalBlockSize * 10,
                    width: double.infinity,
                    child: Row(children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "Order #${orderQueries[index].orderNo}",
                          style: AppStyles.STORES_SUBTITLE_STYLE,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          " | ${orderQueries[index].datetime}",
                          style: AppStyles.STORES_SUBTITLE_STYLE,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ])),
                Container(
                    height: SizeUtils.horizontalBlockSize * 10,
                    width: double.infinity,
                    child: Row(children: [
                      Icon(
                        Icons.message,
                        size: SizeUtils.horizontalBlockSize * 4,
                        color: AppConst.grey,
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "${orderQueries[index].status}",
                          style: AppStyles.STORES_SUBTITLE_STYLE,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ]))
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            thickness: SizeUtils.horizontalBlockSize * 0.5,
          );
        },
        itemCount: orderQueries.length);
  }
}
