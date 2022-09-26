import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/constants/app_const.dart';

import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:customer_app/widgets/backButton.dart';
import 'package:get/get.dart';

class HelpSupport extends StatelessWidget {
  const HelpSupport({Key? key}) : super(key: key);

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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        BackButtonWidget(),
                        SizedBox(
                          width: SizeUtils.horizontalBlockSize * 5,
                        ),
                        Text(
                          "Help & Support",
                          style: TextStyle(
                              color: AppConst.black,
                              fontSize: SizeUtils.horizontalBlockSize * 4),
                        )
                      ])),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Divider(
                      thickness: SizeUtils.horizontalBlockSize * 1,
                    ),
                    Container(
                      height: SizeUtils.horizontalBlockSize * 25,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: SizeUtils.horizontalBlockSize * 5,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("You have 2 active refunds",
                                    style: AppStyles.STORE_NAME_STYLE),
                                InkWell(
                                  onTap: () =>
                                      Get.toNamed(AppRoutes.OrderListpage),
                                  child: Container(
                                    height: SizeUtils.horizontalBlockSize * 8,
                                    width: SizeUtils.horizontalBlockSize * 45,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppConst.kPrimaryColor,
                                        width:
                                            SizeUtils.horizontalBlockSize * 0.5,
                                      ),
                                    ),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text("\u20B9650 plus taxes >",
                                          style: TextStyle(
                                              color: AppConst.kPrimaryColor,
                                              fontSize: SizeUtils
                                                      .horizontalBlockSize *
                                                  4.5)),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          CircleAvatar(
                            radius: SizeUtils.horizontalBlockSize * 8,
                            backgroundColor: AppConst.grey,
                            child: Image.network(
                              "https://media.istockphoto.com/photos/golden-rupee-currency-icon-isolated-3d-gold-rupee-symbol-with-white-picture-id1319630118?b=1&k=20&m=1319630118&s=170667a&w=0&h=Y_9aXvSdhmy-A0ulccVSWQ1iDoKsdXgcNGuThMnxg7c=",
                              fit: BoxFit.contain,
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      thickness: SizeUtils.horizontalBlockSize * 1,
                    ),
                    Container(
                      height: SizeUtils.horizontalBlockSize * 40,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: SizeUtils.horizontalBlockSize * 6,
                            width: SizeUtils.horizontalBlockSize * 55,
                            alignment: Alignment.topLeft,
                            color: AppConst.white,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "  Credits,promos & gifts cards",
                                overflow: TextOverflow.ellipsis,
                                style: AppStyles.STORES_SUBTITLE_STYLE,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: SizeUtils.horizontalBlockSize * 2,
                          ),
                          Center(
                            child: Container(
                              height: SizeUtils.horizontalBlockSize * 30,
                              width: SizeUtils.horizontalBlockSize * 85,
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () => {},
                                    child: Row(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.dollarSign,
                                          size:
                                              SizeUtils.horizontalBlockSize * 5,
                                        ),
                                        SizedBox(
                                          width:
                                              SizeUtils.horizontalBlockSize * 3,
                                        ),
                                        Flexible(
                                            child: Text(
                                          "Invite friends and get \$1000",
                                          style: AppStyles.STORE_NAME_STYLE,
                                        ))
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => {},
                                    child: Row(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.gift,
                                          size:
                                              SizeUtils.horizontalBlockSize * 5,
                                        ),
                                        SizedBox(
                                          width:
                                              SizeUtils.horizontalBlockSize * 3,
                                        ),
                                        Flexible(
                                            child: Text(
                                          "Buy gift card",
                                          style: AppStyles.STORE_NAME_STYLE,
                                        ))
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => {},
                                    child: Row(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.store,
                                          size:
                                              SizeUtils.horizontalBlockSize * 5,
                                        ),
                                        SizedBox(
                                          width:
                                              SizeUtils.horizontalBlockSize * 3,
                                        ),
                                        Flexible(
                                            child: Text(
                                          "Track credits and promos",
                                          style: AppStyles.STORE_NAME_STYLE,
                                        ))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      thickness: SizeUtils.horizontalBlockSize * 1,
                    ),
                    Container(
                      height: SizeUtils.horizontalBlockSize * 40,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: SizeUtils.horizontalBlockSize * 6,
                            width: SizeUtils.horizontalBlockSize * 55,
                            alignment: Alignment.topLeft,
                            color: AppConst.white,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "  Support",
                                overflow: TextOverflow.ellipsis,
                                style: AppStyles.STORES_SUBTITLE_STYLE,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: SizeUtils.horizontalBlockSize * 2,
                          ),
                          Center(
                            child: Container(
                              height: SizeUtils.horizontalBlockSize * 30,
                              width: SizeUtils.horizontalBlockSize * 85,
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () => Get.toNamed(
                                        AppRoutes.QuestionsAndAnswers),
                                    child: Row(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.inbox,
                                          size:
                                              SizeUtils.horizontalBlockSize * 5,
                                        ),
                                        SizedBox(
                                          width:
                                              SizeUtils.horizontalBlockSize * 3,
                                        ),
                                        Flexible(
                                            child: Text(
                                          "Commonly asked questions",
                                          style: AppStyles.STORE_NAME_STYLE,
                                        ))
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () =>
                                        Get.toNamed(AppRoutes.OrderInformation),
                                    child: Row(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.gift,
                                          size:
                                              SizeUtils.horizontalBlockSize * 5,
                                        ),
                                        SizedBox(
                                          width:
                                              SizeUtils.horizontalBlockSize * 3,
                                        ),
                                        Flexible(
                                            child: Text(
                                          "Order Information",
                                          style: AppStyles.STORE_NAME_STYLE,
                                        ))
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () =>
                                        Get.toNamed(AppRoutes.OrderQueriespage),
                                    child: Row(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.store,
                                          size:
                                              SizeUtils.horizontalBlockSize * 5,
                                        ),
                                        SizedBox(
                                          width:
                                              SizeUtils.horizontalBlockSize * 3,
                                        ),
                                        Flexible(
                                            child: Text(
                                          "Order Queries",
                                          style: AppStyles.STORE_NAME_STYLE,
                                        ))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      thickness: SizeUtils.horizontalBlockSize * 1,
                    ),
                    Container(
                      height: SizeUtils.horizontalBlockSize * 40,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: SizeUtils.horizontalBlockSize * 6,
                            width: SizeUtils.horizontalBlockSize * 55,
                            alignment: Alignment.topLeft,
                            color: AppConst.white,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "  Credits,promos & gifts cards",
                                overflow: TextOverflow.ellipsis,
                                style: AppStyles.STORES_SUBTITLE_STYLE,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: SizeUtils.horizontalBlockSize * 2,
                          ),
                          Center(
                            child: Container(
                              height: SizeUtils.horizontalBlockSize * 30,
                              width: SizeUtils.horizontalBlockSize * 85,
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () => {},
                                    child: Row(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.dollarSign,
                                          size:
                                              SizeUtils.horizontalBlockSize * 5,
                                        ),
                                        SizedBox(
                                          width:
                                              SizeUtils.horizontalBlockSize * 3,
                                        ),
                                        Flexible(
                                            child: Text(
                                          "Invite friends and get \$1000",
                                          style: AppStyles.STORE_NAME_STYLE,
                                        ))
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => {},
                                    child: Row(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.gift,
                                          size:
                                              SizeUtils.horizontalBlockSize * 5,
                                        ),
                                        SizedBox(
                                          width:
                                              SizeUtils.horizontalBlockSize * 3,
                                        ),
                                        Flexible(
                                            child: Text(
                                          "Buy gift card",
                                          style: AppStyles.STORE_NAME_STYLE,
                                        ))
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => {},
                                    child: Row(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.store,
                                          size:
                                              SizeUtils.horizontalBlockSize * 5,
                                        ),
                                        SizedBox(
                                          width:
                                              SizeUtils.horizontalBlockSize * 3,
                                        ),
                                        Flexible(
                                            child: Text(
                                          "Track credits and promos",
                                          style: AppStyles.STORE_NAME_STYLE,
                                        ))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      thickness: SizeUtils.horizontalBlockSize * 1,
                    ),
                  ],
                ),
              ))
            ])));
  }
}
