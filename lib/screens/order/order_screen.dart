import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/data/model/order_model.dart';
import 'package:customer_app/constants/app_const.dart';

import 'package:customer_app/screens/order/widgets/store_name_widgte.dart';
import 'package:customer_app/screens/order/widgets/timeline_widget.dart';
import 'package:get/route_manager.dart';
import 'package:sizer/sizer.dart';
import 'widgets/call_delivery_person_widget.dart';
import 'widgets/contact_store_widget.dart';
import 'widgets/order_info_widget.dart';

class OrderScreen extends StatelessWidget {
  final OrderData order;
  const OrderScreen({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConst.kGreyColor,
      appBar: AppBar(
        elevation: 1,
        centerTitle: false,
        title: Text(
          "Order #${order.Id?.substring(0, 15)}...",
          style: TextStyle(
            color: AppConst.black,
            fontSize: SizeUtils.horizontalBlockSize * 5,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
          splashRadius: 3.h,
        ),
        actions: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: OutlinedButton(
                  child: Text(
                    "SUPPORT",
                    style: TextStyle(
                      color: AppConst.kPrimaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: SizeUtils.horizontalBlockSize * 3.7,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minimumSize: Size(0, 35),
                    side: BorderSide(
                      color: AppConst.grey,
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StoreNameWidget(order: order),
            ContactStoreWidget(),
            TimelineWidget(),
            OrderInfoWidget(),
            CallDeliveryPersonWidget()
          ],
        ),
      ),
    );
  }
}
