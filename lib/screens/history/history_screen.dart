import 'dart:math';

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/controller/account_controller.dart';
import 'package:customer_app/app/data/model/order_model.dart';
import 'package:customer_app/app/ui/pages/search/controller/exploreContoller.dart';
import 'package:customer_app/constants/app_const.dart';

import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/screens/addcart/checkorder_status_screen.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:customer_app/widgets/backButton.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: kGreyColor,
      body: SafeArea(
        minimum: EdgeInsets.only(top: 2.h, left: 2.w, right: 2.w),
        top: true,
        child: DefaultTabController(
          length: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackButtonAppbar(
                text: "History",
              ),
              ButtonstabBarCustom(
                  Tab1: 'Orders', Tab2: 'Receipt', Tab3: 'Refund'),
              Expanded(
                child: TabBarView(
                  children: [OrderTabView(), ReciptTabView(), RefundTabView()],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonstabBarCustom extends StatelessWidget {
  String? Tab1;
  String? Tab2;
  String? Tab3;

  ButtonstabBarCustom({
    Key? key,
    required this.Tab1,
    required this.Tab2,
    required this.Tab3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonsTabBar(
      buttonMargin: EdgeInsets.only(left: 2.w, top: 1.4.h, bottom: 1.h),
      backgroundColor: AppConst.lightGrey,
      unselectedBackgroundColor: AppConst.veryLightGrey,
      unselectedBorderColor: AppConst.lightGrey,
      unselectedLabelStyle: TextStyle(color: AppConst.black),
      radius: 2.h,
      borderColor: AppConst.black,
      contentPadding: EdgeInsets.symmetric(horizontal: 8),
      borderWidth: 1,
      labelStyle: TextStyle(
          fontSize: SizeUtils.horizontalBlockSize * 4,
          color: AppConst.black,
          fontWeight: FontWeight.w500),
      tabs: [
        Tab(text: Tab1 //'Orders',
            ),
        Tab(text: Tab2 //'Receipt',
            ),
        Tab(text: Tab3 //'Refund',
            ),
      ],
    );
  }
}

class BackButtonAppbar extends StatelessWidget {
  String? text;

  BackButtonAppbar({
    Key? key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BackButtonWidget(),
        SizedBox(
          height: 3.h,
        ),
        Container(
            // color: Colors.yellow,
            height: 5.h,
            width: 70.w,
            alignment: Alignment.topLeft,
            child: FittedBox(
              child: Text(
                text!, //" History",
                style: TextStyle(
                    fontSize: SizeUtils.horizontalBlockSize * 7.5,
                    fontWeight: FontWeight.bold),
              ),
            )),
        SizedBox(
          height: 2.h,
        ),
      ],
    );
  }
}

class OrderTabView extends StatelessWidget {
  OrderTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetX<MyAccountController>(
        initState: (_) {
          Get.find<MyAccountController>().getOrders();
        },
        builder: (_) {
          return Container(
            child: (_.allOrders.data == null || _.allOrders.data?.length == 0)
                ? Center(
                    child: EmptyHistoryPage(
                      icon: CupertinoIcons.cart_fill,
                      text1: " No orders placed yet!",
                      text2: "Orders that you save will appear here.   ",
                      text3: "Place your first order!",
                    ),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(vertical: 1.h),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Get.toNamed(AppRoutes.OrderTreckScreen);
                          _.selectIndex.value = index;
                          _.formatDate();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderTreckScreen(
                                displayHour: _.displayHour.value,
                                order: _.allOrders.data!
                                    .where((c) => c.orderType == "online")
                                    .toList()[index],
                              ),
                            ),
                          );
                        },
                        child: OrderTabViewCard(
                          order: _.allOrders.data!
                              .where((c) => c.orderType == "online")
                              .toList()[index],
                        ),
                      );
                    },
                    itemCount: _.allOrders.data!
                        .where((c) => c.orderType == "online")
                        .toList()
                        .length,
                    separatorBuilder: (context, index) {
                      return Container(
                        height: 2.h,
                        color: AppConst.veryLightGrey,
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}

class RefundTabView extends StatelessWidget {
  RefundTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetX<MyAccountController>(
        // initState: (_) {
        //   Get.find<MyAccountController>().getOrders();
        // },
        builder: (_) {
          return Container(
            child: (_.allOrders.data!
                        .where((c) => c.orderType == "redeem_cash")
                        .toList()
                        .length ==
                    0)
                ?
                // CircularProgressIndicator()
                Center(
                    child: EmptyHistoryPage(
                      icon: CupertinoIcons.cart_fill,
                      text1: " No orders placed yet!",
                      text2: "Orders that you save will appear here.   ",
                      text3: "Place your first order!",
                    ),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(vertical: 1.h),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Get.toNamed(AppRoutes.OrderTreckScreen);
                          // _.selectIndex.value = index;
                          // _.formatDate();
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => OrderTreckScreen(
                          //       order: _.activeOrders.data![index],
                          //     ),
                          //   ),
                          // );
                        },
                        child: RefundTabViewCard(
                          order: _.allOrders.data!
                              .where((c) => c.orderType == "redeem_cash")
                              .toList()[index],
                        ),
                      );
                    },
                    itemCount: _.allOrders.data!
                        .where((c) => c.orderType == "redeem_cash")
                        .toList()
                        .length,
                    separatorBuilder: (context, index) {
                      return Container(
                        height: 2.h,
                        color: AppConst.veryLightGrey,
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}

class ReciptTabView extends StatelessWidget {
  ReciptTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetX<MyAccountController>(
        // initState: (_) {
        //   Get.find<MyAccountController>().getOrders();
        // },
        builder: (_) {
          return Container(
            child: (_.allOrders.data!
                        .where((c) => c.orderType == "receipt")
                        .toList()
                        .length ==
                    0)
                ?
                // CircularProgressIndicator()
                Center(
                    child: EmptyHistoryPage(
                      icon: CupertinoIcons.cart_fill,
                      text1: " No orders placed yet!",
                      text2: "Orders that you save will appear here.   ",
                      text3: "Place your first order!",
                    ),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(vertical: 1.h),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          _.selectIndex.value = index;
                        },
                        child: OrderTabViewCard(
                          order: _.allOrders.data!
                              .where((c) => c.orderType == "receipt")
                              .toList()[index],
                        ),
                      );
                    },
                    itemCount: _.allOrders.data!
                        .where((c) => c.orderType == "receipt")
                        .toList()
                        .length,
                    separatorBuilder: (context, index) {
                      return Container(
                        height: 2.h,
                        color: AppConst.veryLightGrey,
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}

class OrderTabViewCard extends StatelessWidget {
  final OrderData? order;
  OrderTabViewCard({Key? key, this.order}) : super(key: key);
  // final MyAccountController _myAccountController = Get.find();
  final ExploreController _exploreController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            // decoration: BoxDecoration(
            //     border: Border.all(width: 0.5),
            //     borderRadius: BorderRadius.circular(8)),
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    "Order Placed ${order?.orderType}",
                    style: AppStyles.STORE_NAME_STYLE,
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  Text(
                    // 'May 1, 2020, 9:44 AM',
                    DateFormat('E d MMM hh:mm a').format(
                      DateTime.fromMillisecondsSinceEpoch(
                        order?.createdAt != null
                            ? int.parse(order!.createdAt!)
                            : 1638362708701,
                      ),
                    ),
                    style: AppStyles.STORES_SUBTITLE_STYLE,
                  )
                ]),
                Column(
                  children: [
                    Row(
                      children: [
                        Column(children: [
                          Text(
                            "Total",
                            style: AppStyles.STORE_NAME_STYLE,
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Text(
                            ' \u{20B9} ${order?.total ?? 0}',
                            style: AppStyles.STORES_SUBTITLE_STYLE,
                          )
                        ])
                      ],
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              children: [
                // CircleAvatar(),
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppConst.grey,
                      )),
                  child: ClipOval(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(
                        width: 12.w,
                        height: 6.h,
                        fit: BoxFit.contain,
                        imageUrl: order?.store?.logo ??
                            'https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg',
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress)),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.primaries[
                              Random().nextInt(Colors.primaries.length)],
                          child: Center(
                            child: Text(
                                order?.store?.name?.substring(0, 1) ?? "",
                                style: TextStyle(
                                    fontSize:
                                        SizeUtils.horizontalBlockSize * 6)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 2.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${order?.store?.name ?? "Defalut name "}",
                      // "Store name",
                      style: AppStyles.STORE_NAME_STYLE,
                    ),
                    // SizedBox(
                    //   height: 1.h,
                    // ),
                    Row(
                      children: [
                        Text(
                          '${order?.products?.length ?? 0} items.  Earned cashback \u{20B9} ${order?.total_cashback ?? 0}',
                          style: AppStyles.STORES_SUBTITLE_STYLE,
                        ),
                        // Icon(Icons.monetization_on,
                        //     color: AppConst.kSecondaryColor)
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 3.w,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 2.h),
                  child: Text(
                    "${order?.status ?? ""}",
                    style: TextStyle(
                        color: AppConst.kPrimaryColor,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () async {
                    if ((order?.orderType) == "online") {
                      _exploreController.isLoadingStoreData.value = true;

                      await _exploreController.getStoreData(
                          id: '${order?.store?.sId}');
                      Get.back();
                      (_exploreController.getStoreDataModel.value?.error ??
                              false)
                          ? null
                          : Get.toNamed(AppRoutes.StoreScreen);
                      // Get.toNamed(AppRoutes.StoreScreen);
                    } else {
                      Get.toNamed(AppRoutes.ScanStoreViewScreen);
                    }
                  },
                  child: Container(
                      height: 5.5.h,
                      width: 25.w,
                      decoration: BoxDecoration(
                          color: AppConst.green,
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(18)),
                      child: Center(
                        child: Text(
                          "${(order?.orderType) == "online" ? "go to store" : " scan recipt"}",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      )),
                ),
              ],
            ),
            SizedBox(
              height: 1.h,
            )
          ]),
        )),
      ],
    );
  }
}

class RefundTabViewCard extends StatelessWidget {
  final OrderData? order;
  RefundTabViewCard({Key? key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            // decoration: BoxDecoration(
            //     border: Border.all(width: 0.5),
            //     borderRadius: BorderRadius.circular(8)),
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    " ${order?.orderType}",
                    style: AppStyles.STORE_NAME_STYLE,
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  Text(
                    // 'May 1, 2020, 9:44 AM',
                    DateFormat('E d MMM hh:mm a').format(
                      DateTime.fromMillisecondsSinceEpoch(
                        order?.createdAt != null
                            ? int.parse(order!.createdAt!)
                            : 1638362708701,
                      ),
                    ),
                    style: AppStyles.STORES_SUBTITLE_STYLE,
                  )
                ]),
                Column(
                  children: [
                    Row(
                      children: [
                        Column(children: [
                          Text(
                            "Total",
                            style: AppStyles.STORE_NAME_STYLE,
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Text(
                            ' \u{20B9} ${order?.wallet_amount ?? 0}',
                            style: AppStyles.STORES_SUBTITLE_STYLE,
                          )
                        ])
                      ],
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              children: [
                // CircleAvatar(),
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppConst.grey,
                      )),
                  child: ClipOval(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(
                        width: 12.w,
                        height: 6.h,
                        fit: BoxFit.contain,
                        imageUrl: order?.store?.logo ??
                            'https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg',
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress)),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.primaries[
                              Random().nextInt(Colors.primaries.length)],
                          child: Center(
                            child: Text(
                                order?.store?.name?.substring(0, 1) ?? "",
                                style: TextStyle(
                                    fontSize:
                                        SizeUtils.horizontalBlockSize * 6)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 2.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      " ${order?.store?.name ?? "Store name"}",
                      style: AppStyles.STORE_NAME_STYLE,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    // Row(
                    //   children: [
                    //     Text(
                    //       '${order?.products?.length} items.  Earned cashback \u{20B9} ${order?.total_cashback ?? 0}',
                    //       style: AppStyles.STORES_SUBTITLE_STYLE,
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 3.w,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 2.h),
                  child: Text(
                    "${order?.status ?? ""}",
                    style: TextStyle(
                        color: AppConst.kPrimaryColor,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.PayView);
                  },
                  child: Container(
                      height: 5.5.h,
                      width: 25.w,
                      decoration: BoxDecoration(
                          color: AppConst.green,
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(18)),
                      child: Center(
                        child: Text(
                          "Pay again",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      )),
                ),
              ],
            ),
            SizedBox(
              height: 1.h,
            )
          ]),
        )),
      ],
    );
  }
}

class EmptyHistoryPage extends StatelessWidget {
  EmptyHistoryPage(
      {Key? key,
      required this.icon,
      required this.text1,
      required this.text2,
      required this.text3})
      : super(key: key);
  IconData? icon;
  String? text1;
  String? text2;
  String? text3;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Container(
              //   height: 15.h,
              //   width: 45.w,
              //   child: Lottie.asset(
              //       'assets/lottie/receipt.json'),
              // ),
              Icon(
                icon,
                // Icons.receipt,
                size: 20.h,
                color: AppConst.lightYellow,
              ),
            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            text1!,
            // "No saved orders yet ",
            style: TextStyle(
              fontSize: SizeUtils.horizontalBlockSize * 5.4,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            text2!,
            // "Orders that you save will appear here.   ",
            style: TextStyle(
              fontSize: SizeUtils.horizontalBlockSize * 4.5,
              fontWeight: FontWeight.w200,
            ),
          ),
          Text(
            text3!,
            // " Placed your first order!",
            style: TextStyle(
              fontSize: SizeUtils.horizontalBlockSize * 4.5,
              fontWeight: FontWeight.w200,
            ),
          )
        ],
      ),
    );
  }
}
