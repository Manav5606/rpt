import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/constants/app_const.dart';

import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:customer_app/widgets/arrowIcon.dart';
import 'package:customer_app/widgets/backButton.dart';
import 'package:customer_app/widgets/orderListdata.dart';
import 'package:customer_app/widgets/orderlistwidget.dart';
import 'package:get/get.dart';

class OrdersListPage extends StatelessWidget {
  const OrdersListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            minimum: EdgeInsets.only(
                top: SizeUtils.horizontalBlockSize * 3.82,
                left: SizeUtils.horizontalBlockSize * 2.55,
                right: SizeUtils.horizontalBlockSize * 2.55),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                  height: SizeUtils.horizontalBlockSize * 15,
                  decoration:
                      BoxDecoration(color: AppConst.white, boxShadow: []),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        BackButtonWidget(),
                        Text(
                          "Available Batches",
                          style: TextStyle(
                              color: AppConst.kPrimaryColor,
                              fontSize: SizeUtils.horizontalBlockSize * 4),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              FontAwesomeIcons.question,
                              size: SizeUtils.horizontalBlockSize * 5,
                            ))
                      ])),
              Expanded(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: OrderList(),
                ),
              )
            ])));
  }
}
