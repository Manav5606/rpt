import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/constants/app_const.dart';

import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:customer_app/widgets/backButton.dart';
import 'package:customer_app/widgets/orderTypeOnline.dart';
import 'package:customer_app/widgets/orderTypeRedeem.dart';
import 'package:customer_app/widgets/orderTypeScan.dart';
import 'package:get/get.dart';

class OrderInformation extends StatelessWidget {
  OrderInformation({Key? key}) : super(key: key);

  bool orderTypeOnline = false;
  bool orderTypeScan = false;
  bool orderTypeRedeem = true;
  bool hasPaid = false;
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
                        InkWell(
                            onTap: () => Get.toNamed(AppRoutes.HelpSupport),
                            child: Text(
                              "Help",
                              style: TextStyle(
                                  color: AppConst.kPrimaryColor,
                                  fontSize: SizeUtils.horizontalBlockSize * 4),
                            ))
                      ])),
              Container(
                  height: SizeUtils.horizontalBlockSize * 25,
                  width: double.infinity,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: SizeUtils.horizontalBlockSize * 20,
                          width: SizeUtils.horizontalBlockSize * 65,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Domino's Pizza",
                                overflow: TextOverflow.ellipsis,
                                style: AppStyles.STORE_NAME_STYLE,
                              ),
                              Text(
                                "9:00AM-10:00PM",
                                style: AppStyles.STORES_SUBTITLE_STYLE,
                              ),
                              Flexible(
                                child: Text(
                                  "Whitefield main road,Bengaluru-560076",
                                  overflow: TextOverflow.clip,
                                  style: AppStyles.STORES_SUBTITLE_STYLE,
                                ),
                              )
                            ],
                          ),
                        ),
                        IconButton(
                            color: AppConst.black,
                            onPressed: () {},
                            icon: Icon(Icons.call_outlined))
                      ])),
              Container(
                height: SizeUtils.horizontalBlockSize * 12,
                width: double.infinity,
                alignment: Alignment.centerLeft,
                color: AppConst.lightGrey,
                child: Text(
                  " Bill Details",
                  style: AppStyles.STORE_NAME_STYLE,
                ),
              ),
              (orderTypeOnline)
                  ? OrderTypeOnline()
                  : (orderTypeScan)
                      ? OrderTypeScan()
                      : OrderTypeRedeem(),
              Container(
                  height: SizeUtils.horizontalBlockSize * 27,
                  width: double.infinity,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: SizeUtils.horizontalBlockSize * 20,
                          width: SizeUtils.horizontalBlockSize * 65,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Order Picked Up",
                                overflow: TextOverflow.ellipsis,
                                style: AppStyles.STORE_NAME_STYLE,
                              ),
                              Flexible(
                                child: Text(
                                  "Indira nagar main road,Bengaluru-560076",
                                  overflow: TextOverflow.clip,
                                  style: AppStyles.STORES_SUBTITLE_STYLE,
                                ),
                              ),
                              InkWell(
                                child: Text(
                                  "View conversation >",
                                  style: TextStyle(
                                      color: AppConst.kPrimaryColor,
                                      fontSize:
                                          SizeUtils.horizontalBlockSize * 5,
                                      fontWeight: FontWeight.w700),
                                ),
                              )
                            ],
                          ),
                        ),
                        IconButton(
                            color: AppConst.black,
                            onPressed: () {},
                            icon: Icon(CupertinoIcons.chat_bubble))
                      ])),
              Expanded(child: Container()),
              (hasPaid)
                  ? Container(
                      height: SizeUtils.horizontalBlockSize * 12,
                      width: double.infinity,
                      color: AppConst.darkGrey,
                      alignment: Alignment.center,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "You save \u20b950 on this order",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppConst.white,
                            fontSize: SizeUtils.horizontalBlockSize * 4,
                          ),
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () => {},
                      child: Container(
                        height: SizeUtils.horizontalBlockSize * 15,
                        width: double.infinity,
                        color: AppConst.kPrimaryColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: SizeUtils.horizontalBlockSize * 5,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("5 items",
                                      style: TextStyle(
                                          color: AppConst.white,
                                          fontSize:
                                              SizeUtils.horizontalBlockSize *
                                                  4)),
                                  Text("\u20B9650 plus taxes",
                                      style: TextStyle(
                                          color: AppConst.white,
                                          fontSize:
                                              SizeUtils.horizontalBlockSize *
                                                  4))
                                ],
                              ),
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Next ",
                                      style: TextStyle(
                                          color: AppConst.white,
                                          fontSize:
                                              SizeUtils.horizontalBlockSize *
                                                  4)),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: AppConst.white,
                                    size: SizeUtils.horizontalBlockSize * 3,
                                  )
                                ]),
                            SizedBox(
                              width: SizeUtils.horizontalBlockSize * 5,
                            ),
                          ],
                        ),
                      ),
                    )
            ])));
  }
}
