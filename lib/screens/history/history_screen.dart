import 'dart:math';

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:customer_app/app/ui/common/shimmer_widget.dart';
import 'package:customer_app/screens/history/history_order_tracking_screen.dart';
import 'package:customer_app/screens/more_stores/all_offers_listview.dart';
import 'package:customer_app/screens/more_stores/morestore_controller.dart';
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
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class HistoryScreen extends StatefulWidget {
  HistoryScreen({Key? key}) : super(key: key);
  final MyAccountController myAccountController = Get.find()..getOrders();

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: kGreyColor,
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Color(0xffe6faf1),
            statusBarIconBrightness: Brightness.dark),
        backgroundColor: Color(0xffe6faf1),
        title: Row(
          children: [
            Container(
              height: 3.2.h,
              child: Image(
                image: AssetImage(
                  'assets/images/CART.png',
                ),
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            Text("Orders & Receipts & Redeems",
                style: TextStyle(
                  fontFamily: 'MuseoSans',
                  color: AppConst.black,
                  fontSize: SizeUtils.horizontalBlockSize * 4,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                )),
          ],
        ),
      ),
      body: SafeArea(
        minimum: EdgeInsets.only(top: 0.h, left: 1.w, right: 1.w),
        top: true,
        child: DefaultTabController(
          length: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 5.h,
                child: ListView.builder(
                    itemCount: 15,
                    physics: PageScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemExtent: 11.w,
                    itemBuilder: (context, index) {
                      return SemiCircleContainer(
                        color: Color(0xffe6faf1),
                      );
                    }),
              ),
              TabBar(tabs: [
                Padding(
                  padding: EdgeInsets.only(bottom: 1.h),
                  child: Text("Orders",
                      style: TextStyle(
                        fontFamily: 'MuseoSans',
                        color: AppConst.black,
                        fontSize: SizeUtils.horizontalBlockSize * 4,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 1.h),
                  child: Text("Receipts",
                      style: TextStyle(
                        fontFamily: 'MuseoSans',
                        color: AppConst.black,
                        fontSize: SizeUtils.horizontalBlockSize * 4,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 1.h),
                  child: Text("Redeems",
                      style: TextStyle(
                        fontFamily: 'MuseoSans',
                        color: AppConst.black,
                        fontSize: SizeUtils.horizontalBlockSize * 4,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      )),
                ),
              ]),
              // ButtonstabBarCustom(
              //     Tab1: 'Orders', Tab2: 'Receipt', Tab3: 'Refund'),
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

class SemiCircleContainer extends StatelessWidget {
  final Color color;
  SemiCircleContainer({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
        clipper: Clip2Clipper(),
        child: Container(
          height: 4.h,
          width: 6.w,
          color: color, //=Color(0xffe6faf1)
        ));
  }
}

class Clip2Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path0 = Path(); // 0,0
    path0.lineTo(size.width, 0); //1,0

    path0.quadraticBezierTo(size.width / 2, size.height / 1.5, 0, 0);

    return path0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
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
          height: 2.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 2.w),
          child: Container(
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
        ),
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
    return GetX<MyAccountController>(
      builder: (_) {
        return _.isOrderloading == true
            // true
            ? ordershimmer()
            : Container(
                child: (_.allOrdersModel.value?.data
                                ?.where((c) => c.orderType == "online")
                                .toList() ==
                            null ||
                        _.allOrdersModel.value?.data
                                ?.where((c) => c.orderType == "online")
                                .toList()
                                .length ==
                            0)
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
                          return InkWell(
                            highlightColor: AppConst.highLightColor,
                            onTap: () async {
                              // Get.toNamed(AppRoutes.OrderTreckScreen);
                              _.selectIndex.value = index;
                              _.formatDate();
                              await Get.to(
                                () => HistoryOrderTrackingScreen(
                                  // historyTab: true,
                                  // displayHour: _.displayHour.value,
                                  order:
                                      // _.allOrdersModel.value!.data!
                                      //     .where((c) => c.orderType == "online")
                                      //     .toList()[index],
                                      _.allOrdersModel.value?.data
                                          ?.where(
                                              (c) => c.orderType == "online")
                                          .toList()[(_
                                              .allOrdersModel.value?.data
                                              ?.where((c) =>
                                                  c.orderType == "online")
                                              .toList()
                                              .length)! -
                                          1 -
                                          index],
                                ),
                              );
                            },
                            child: OrderTabViewCard(
                              order:
                                  // _.allOrdersModel.value!.data!
                                  //     .where((c) => c.orderType == "online")
                                  //     .toList()[index],
                                  _.allOrdersModel.value?.data
                                      ?.where((c) => c.orderType == "online")
                                      .toList()[_.allOrdersModel.value!.data!
                                          .where((c) => c.orderType == "online")
                                          .toList()
                                          .length -
                                      1 -
                                      index],
                            ),
                          );
                        },
                        itemCount: _.allOrdersModel.value!.data!
                            .where((c) => c.orderType == "online")
                            .toList()
                            .length,
                        separatorBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                  height: 1.5.h, color: AppConst.veryLightGrey),
                              Container(
                                  height: 4.h,
                                  child: ListView.builder(
                                      itemCount: 15,
                                      physics: PageScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemExtent: 7.w,
                                      itemBuilder: (context, index) {
                                        return SemiCircleContainer(
                                          color: AppConst.veryLightGrey,
                                        );
                                      })),
                            ],
                          );
                        },
                      ),
              );
      },
    );
  }
}

class RefundTabView extends StatelessWidget {
  RefundTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<MyAccountController>(
      builder: (_) {
        return Container(
          child: (_.allOrdersModel.value?.data
                          ?.where((c) => c.orderType == "redeem_cash")
                          .toList() ==
                      null ||
                  _.allOrdersModel.value?.data
                          ?.where((c) => c.orderType == "redeem_cash")
                          .toList()
                          .length ==
                      0)
              ?
              // CircularProgressIndicator()
              Center(
                  child: EmptyHistoryPage(
                    icon: CupertinoIcons.money_dollar_circle_fill,
                    text1: " No refund found yet!",
                    text2: "refund that you get will appear here.   ",
                    text3: "Place orders to get the refund!",
                  ),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(vertical: 1.h),
                  itemBuilder: (context, index) {
                    return InkWell(
                      highlightColor: AppConst.highLightColor,
                      onTap: () {
                        // Get.toNamed(AppRoutes.OrderTreckScreen);
                        _.selectIndex.value = index;
                        _.formatDate();
                        Get.to(
                          () => HistoryOrderTrackingScreen(
                            order:
                                // _.allOrdersModel.value!.data!
                                //     .where((c) => c.orderType == "redeem_cash")
                                //     .toList()[index],
                                _.allOrdersModel.value?.data
                                    ?.where((c) => c.orderType == "redeem_cash")
                                    .toList()[(_.allOrdersModel.value?.data!
                                        .where(
                                            (c) => c.orderType == "redeem_cash")
                                        .toList()
                                        .length)! -
                                    1 -
                                    index],
                            // displayHour: _.displayHour.value,
                            // historyTab: true,
                          ),
                        );
                      },
                      child: OrderTabViewCard(
                        isRefund: true,
                        order:
                            //  _.allOrdersModel.value!.data!
                            //     .where((c) => c.orderType == "redeem_cash")
                            //     .toList()[index],
                            _.allOrdersModel.value?.data
                                ?.where((c) => c.orderType == "redeem_cash")
                                .toList()[_.allOrdersModel.value!.data!
                                    .where((c) => c.orderType == "redeem_cash")
                                    .toList()
                                    .length -
                                1 -
                                index],
                      ),
                    );
                  },
                  itemCount: _.allOrdersModel.value!.data!
                      .where((c) => c.orderType == "redeem_cash")
                      .toList()
                      .length,
                  separatorBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(height: 1.5.h, color: AppConst.veryLightGrey),
                        Container(
                            height: 4.h,
                            child: ListView.builder(
                                itemCount: 15,
                                physics: PageScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemExtent: 7.w,
                                itemBuilder: (context, index) {
                                  return SemiCircleContainer(
                                    color: AppConst.veryLightGrey,
                                  );
                                })),
                      ],
                    );
                  },
                ),
        );
      },
    );
  }
}

class ReciptTabView extends StatelessWidget {
  ReciptTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<MyAccountController>(
      builder: (_) {
        return Container(
          child: (_.allOrdersModel.value?.data
                          ?.where((c) => c.orderType == "receipt")
                          .toList() ==
                      null ||
                  _.allOrdersModel.value?.data
                          ?.where((c) => c.orderType == "receipt")
                          .toList()
                          .length ==
                      0)
              ?
              // CircularProgressIndicator()
              Center(
                  child: EmptyHistoryPage(
                    icon: Icons.receipt,
                    text1: " No receipt placed yet!",
                    text2: "receipt that you save will appear here.   ",
                    text3: "Scan your first receipt!",
                  ),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(vertical: 1.h),
                  itemBuilder: (context, index) {
                    return InkWell(
                      highlightColor: AppConst.highLightColor,
                      onTap: () {
                        // Get.toNamed(AppRoutes.OrderTreckScreen);
                        _.selectIndex.value = index;
                        _.formatDate();
                        Get.to(
                          () => HistoryOrderTrackingScreen(
                            order:
                                // _.allOrdersModel.value!.data!
                                //     .where((c) => c.orderType == "receipt")
                                //     .toList()[index],
                                _.allOrdersModel.value?.data
                                    ?.where((c) => c.orderType == "receipt")
                                    .toList()[(_.allOrdersModel.value?.data!
                                        .where((c) => c.orderType == "receipt")
                                        .toList()
                                        .length)! -
                                    1 -
                                    index],
                            // displayHour: _.displayHour.value,
                            // historyTab: true,
                          ),
                        );
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //   builder: (context) => OrderTreckScreen(
                        //     order: _.activeOrders.data![index],
                        //     displayHour: _.displayHour.value,
                        //     historyTab: true,
                        //   ),
                        // ),
                        // );
                      },
                      child: OrderTabViewCard(
                        order:
                            //  _.allOrdersModel.value!.data!
                            //     .where((c) => c.orderType == "receipt")
                            //     .toList()[index],
                            _.allOrdersModel.value?.data
                                ?.where((c) => c.orderType == "receipt")
                                .toList()[_.allOrdersModel.value!.data!
                                    .where((c) => c.orderType == "receipt")
                                    .toList()
                                    .length -
                                1 -
                                index],
                      ),
                    );
                  },
                  itemCount: _.allOrdersModel.value!.data!
                      .where((c) => c.orderType == "receipt")
                      .toList()
                      .length,
                  separatorBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(height: 1.5.h, color: AppConst.veryLightGrey),
                        Container(
                            height: 4.h,
                            child: ListView.builder(
                                itemCount: 15,
                                physics: PageScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemExtent: 7.w,
                                itemBuilder: (context, index) {
                                  return SemiCircleContainer(
                                    color: AppConst.veryLightGrey,
                                  );
                                })),
                      ],
                    );
                  },
                ),
        );
      },
    );
  }
}

class OrderTabViewCard extends StatelessWidget {
  final OrderData? order;
  bool? isRefund;
  OrderTabViewCard({Key? key, this.order, this.isRefund = false})
      : super(key: key);
  // final MyAccountController _myAccountController = Get.find();
  final ExploreController _exploreController = Get.find();
  final MoreStoreController _moreStoreController = Get.find();
  @override
  Widget build(BuildContext context) {
    int itemsLength = ((order?.products?.length ?? 0) +
        (order?.rawItems?.length ?? 0) +
        (order?.inventories?.length ?? 0));
    return Column(
      children: [
        Container(
            // decoration: BoxDecoration(
            //     border: Border.all(width: 0.5),
            //     color: AppConst.yellow,
            //     borderRadius: BorderRadius.circular(8)),
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text(
            //             "Order Placed ${order?.orderType}",
            //             style: AppStyles.STORE_NAME_STYLE,
            //           ),
            //           SizedBox(
            //             height: 0.5.h,
            //           ),
            //           Text(
            //             // 'May 1, 2020, 9:44 AM',
            //             DateFormat('E d MMM hh:mm a').format(
            //               DateTime.fromMillisecondsSinceEpoch(
            //                 order?.createdAt != null
            //                     ? int.parse(order!.createdAt!)
            //                     : 1638362708701,
            //               ),
            //             ),
            //             style: AppStyles.STORES_SUBTITLE_STYLE,
            //           )
            //         ]),
            //     Column(
            //       children: [
            //         Row(
            //           children: [
            //             Column(children: [
            //               Text(
            //                 "Total",
            //                 style: AppStyles.STORE_NAME_STYLE,
            //               ),
            //               SizedBox(
            //                 height: 0.5.h,
            //               ),
            //               Text(
            //                 ' \u{20B9} ${order?.total ?? 0}',
            //                 style: AppStyles.STORES_SUBTITLE_STYLE,
            //               )
            //             ])
            //           ],
            //         )
            //       ],
            //     )
            //   ],
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DispalyStoreLogo(
                  logo: order?.store?.logo,
                  height: 5.5,
                  bottomPadding: 0,
                  logoPadding: 8,
                ),
                SizedBox(
                  width: 4.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 68.w,
                      child: Text("${order?.store?.name ?? ""}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'MuseoSans',
                            color: AppConst.black,
                            fontSize: SizeUtils.horizontalBlockSize * 4,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                          )),
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
                        style: TextStyle(
                          fontFamily: 'MuseoSans',
                          color: AppConst.grey,
                          fontSize: SizeUtils.horizontalBlockSize * 3.8,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                        ))
                  ],
                ),
                SizedBox(
                  width: 2.w,
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppConst.grey,
                  size: SizeUtils.horizontalBlockSize * 5,
                ),
              ],
            ),
            SizedBox(
              height: 1.h,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: Wrap(
                direction: Axis.horizontal,
                children: [
                  (order?.products != null)
                      ? Wrap(
                          direction: Axis.horizontal,
                          children: order!.products!
                              .asMap()
                              .map(
                                (i, product) => MapEntry(
                                  i,
                                  Text('${i == 0 ? '' : ', '}${product.name}',
                                      style: TextStyle(
                                        fontFamily: 'MuseoSans',
                                        color: AppConst.grey,
                                        fontSize:
                                            SizeUtils.horizontalBlockSize * 3.8,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                      )),
                                ),
                              )
                              .values
                              .toList(),
                        )
                      : SizedBox(),
                  (order?.inventories != null)
                      ? Wrap(
                          direction: Axis.horizontal,
                          children: order!.inventories!
                              .asMap()
                              .map(
                                (i, product) => MapEntry(
                                  i,
                                  Text('${i == 0 ? '' : ', '}${product.name}',
                                      style: TextStyle(
                                        fontFamily: 'MuseoSans',
                                        color: AppConst.grey,
                                        fontSize:
                                            SizeUtils.horizontalBlockSize * 3.8,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                      )),
                                ),
                              )
                              .values
                              .toList(),
                        )
                      : SizedBox(),
                  (order?.rawItems != null)
                      ? Wrap(
                          children: order!.rawItems!
                              .asMap()
                              .map(
                                (i, product) => MapEntry(
                                  i,
                                  Text(
                                      '${i == 0 ? ' | ' : ', '}${product.item}',
                                      style: TextStyle(
                                        fontFamily: 'MuseoSans',
                                        color: AppConst.grey,
                                        fontSize:
                                            SizeUtils.horizontalBlockSize * 3.8,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                      )),
                                ),
                              )
                              .values
                              .toList(),
                        )
                      : SizedBox(),
                ],
              ),
            ),

            (isRefund == true)
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                                'Previous Amount: \u{20B9} ${order?.previous_total ?? 0}',
                                style: TextStyle(
                                  fontFamily: 'MuseoSans',
                                  color: AppConst.grey,
                                  fontSize: SizeUtils.horizontalBlockSize * 3.8,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                                'Redeem Amount: \u{20B9} ${order?.wallet_amount ?? 0}',
                                style: TextStyle(
                                  fontFamily: 'MuseoSans',
                                  color: AppConst.grey,
                                  fontSize: SizeUtils.horizontalBlockSize * 3.8,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                )),
                          ],
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('${itemsLength} items  ',
                            style: TextStyle(
                              fontFamily: 'MuseoSans',
                              color: AppConst.grey,
                              fontSize: SizeUtils.horizontalBlockSize * 3.8,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                            )),
                        Container(
                            height: 1.5.w,
                            width: 1.5.w,
                            decoration: BoxDecoration(
                              color: AppConst.grey,
                              shape: BoxShape.circle,
                            )),
                        Text(
                            '  Earned cashback: \u{20B9} ${order?.total_cashback ?? 0}',
                            style: TextStyle(
                              fontFamily: 'MuseoSans',
                              color: AppConst.grey,
                              fontSize: SizeUtils.horizontalBlockSize * 3.8,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                            ))
                      ],
                    ),
                  ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Total: \u{20B9} ${order?.total ?? 0}',
                      style: TextStyle(
                        fontFamily: 'MuseoSans',
                        color: AppConst.grey,
                        fontSize: SizeUtils.horizontalBlockSize * 3.8,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                      )),
                ],
              ),
            ),
            // Row(
            //   children: [
            //     // CircleAvatar(),
            //     Container(
            //       decoration: BoxDecoration(
            //           shape: BoxShape.circle,
            //           border: Border.all(
            //             color: AppConst.grey,
            //           )),
            //       child: ClipOval(
            //         child: ClipRRect(
            //           borderRadius: BorderRadius.circular(100),
            //           child: CachedNetworkImage(
            //             width: 12.w,
            //             height: 6.h,
            //             fit: BoxFit.contain,
            //             imageUrl: order?.store?.logo ??
            //                 'https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg',
            //             progressIndicatorBuilder:
            //                 (context, url, downloadProgress) => Center(
            //                     child: CircularProgressIndicator(
            //                         value: downloadProgress.progress)),
            //             errorWidget: (context, url, error) => Container(
            //               color: Colors.primaries[
            //                   Random().nextInt(Colors.primaries.length)],
            //               child: Center(
            //                 child: Text(
            //                     order?.store?.name?.substring(0, 1) ?? "",
            //                     style: TextStyle(
            //                         fontSize:
            //                             SizeUtils.horizontalBlockSize * 6)),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //     SizedBox(
            //       width: 2.w,
            //     ),
            //     Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Container(
            //           width: 70.w,
            //           child: Text(
            //             "${order?.store?.name ?? "Defalut name "}",
            //             // "Store name",
            //             style: AppStyles.STORE_NAME_STYLE,
            //           ),
            //         ),
            //         // SizedBox(
            //         //   height: 1.h,
            //         // ),
            //         Row(
            //           children: [
            // Text(
            //   '${itemsLength} items.  Earned cashback \u{20B9} ${order?.total_cashback ?? 0}',
            //   style: AppStyles.STORES_SUBTITLE_STYLE,
            // ),
            //             // Icon(Icons.monetization_on,
            //             //     color: AppConst.kSecondaryColor)
            //           ],
            //         ),
            //       ],
            //     ),
            //   ],
            // ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 1.w,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 2.h),
                  child: (order?.status == "rejected" ||
                          order?.status == "completed")
                      ? Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (order?.status == "rejected")
                                  ? AppConst.red
                                  : AppConst.green),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Icon(
                              (order?.status == "rejected")
                                  ? Icons.close
                                  : Icons.done,
                              color: AppConst.white,
                              size: 2.h,
                            ),
                          ))
                      : Icon(
                          Icons.timelapse_rounded,
                          color: AppConst.green,
                          size: 3.2.h,
                        ),

                  // Container(
                  //     decoration: BoxDecoration(
                  //         shape: BoxShape.circle,
                  //         border:
                  //             Border.all(color: AppConst.green, width: 1.5),
                  //         color: AppConst.white),
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(2.0),
                  //       child: Icon(
                  //         Icons.timelapse_rounded,
                  //         color: AppConst.green,
                  //         size: 2.h,
                  //       ),
                  //     )),
                ),
                SizedBox(
                  width: 2.w,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 2.h),
                  child: Text(
                    "${order?.status ?? ""}",
                    style: TextStyle(
                      fontFamily: 'MuseoSans',
                      color: Color(0xff005b41),
                      fontSize: SizeUtils.horizontalBlockSize * 4,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () async {
                    // if ((order?.orderType) == "online") {
                    _moreStoreController.isLoadingStoreData.value = true;

                    await _moreStoreController.getStoreData(
                        id: '${order?.store?.sId}');
                    Get.back();
                    (_moreStoreController.getStoreDataModel.value?.error ??
                            false)
                        ? null
                        : Get.toNamed(AppRoutes.MoreStoreProductView);
                    // Get.toNamed(AppRoutes.StoreScreen);
                    // }

                    // else {
                    //   Get.toNamed(AppRoutes.ScanStoreViewScreen);
                    // }
                  },
                  child: Container(
                      height: 5.h,
                      width: 27.w,
                      decoration: BoxDecoration(
                          color: AppConst.darkGreen,
                          border: Border.all(color: AppConst.darkGreen),
                          borderRadius: BorderRadius.circular(25)),
                      child: Center(
                        child: Text(
                          "View Store",
                          // "${(order?.orderType) == "online" ? "View Store" : " scan recipt"}",
                          style: TextStyle(
                              fontFamily: 'MuseoSans',
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              color: Colors.white,
                              fontSize: SizeUtils.horizontalBlockSize * 3.8),
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

// class RefundTabViewCard extends StatelessWidget {
//   final OrderData? order;
//   RefundTabViewCard({Key? key, this.order}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//             // decoration: BoxDecoration(
//             //     border: Border.all(width: 0.5),
//             //     borderRadius: BorderRadius.circular(8)),
//             child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
//           child: Column(mainAxisSize: MainAxisSize.min, children: [
//             // Row(
//             //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //   children: [
//             //     Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             //       Text(
//             //         " ${order?.orderType}",
//             //         style: AppStyles.STORE_NAME_STYLE,
//             //       ),
//             //       SizedBox(
//             //         height: 0.5.h,
//             //       ),
//             //       Text(
//             //         // 'May 1, 2020, 9:44 AM',
//             //         DateFormat('E d MMM hh:mm a').format(
//             //           DateTime.fromMillisecondsSinceEpoch(
//             //             order?.createdAt != null
//             //                 ? int.parse(order!.createdAt!)
//             //                 : 1638362708701,
//             //           ),
//             //         ),
//             //         style: AppStyles.STORES_SUBTITLE_STYLE,
//             //       )
//             //     ]),
//             //     Column(
//             //       children: [
//             //         Row(
//             //           children: [
//             //             Column(children: [
//             //               Text(
//             //                 "Total",
//             //                 style: AppStyles.STORE_NAME_STYLE,
//             //               ),
//             //               SizedBox(
//             //                 height: 0.5.h,
//             //               ),
//             //               Text(
//             //                 ' \u{20B9} ${order?.wallet_amount ?? 0}',
//             //                 style: AppStyles.STORES_SUBTITLE_STYLE,
//             //               )
//             //             ])
//             //           ],
//             //         )
//             //       ],
//             //     )
//             //   ],
//             // ),
//             // SizedBox(
//             //   height: 2.h,
//             // ),
//             Row(
//               children: [
//                 // CircleAvatar(),
//                 Container(
//                   decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(
//                         color: AppConst.grey,
//                       )),
//                   child: ClipOval(
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(100),
//                       child: CachedNetworkImage(
//                         width: 12.w,
//                         height: 6.h,
//                         fit: BoxFit.contain,
//                         imageUrl: order?.store?.logo ??
//                             'https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg',
//                         progressIndicatorBuilder:
//                             (context, url, downloadProgress) => Center(
//                                 child: CircularProgressIndicator(
//                                     value: downloadProgress.progress)),
//                         errorWidget: (context, url, error) => Container(
//                           color: Colors.primaries[
//                               Random().nextInt(Colors.primaries.length)],
//                           child: Center(
//                             child: Text(
//                                 order?.store?.name?.substring(0, 1) ?? "",
//                                 style: TextStyle(
//                                     fontSize:
//                                         SizeUtils.horizontalBlockSize * 6)),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 2.w,
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       width: 70.w,
//                       child: Text(
//                         " ${order?.store?.name ?? "Store name"}",
//                         style: AppStyles.STORE_NAME_STYLE,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 1.h,
//                     ),
//                     // Row(
//                     //   children: [
//                     //     Text(
//                     //       '${order?.products?.length} items.  Earned cashback \u{20B9} ${order?.total_cashback ?? 0}',
//                     //       style: AppStyles.STORES_SUBTITLE_STYLE,
//                     //     ),
//                     //   ],
//                     // ),
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 2.h,
//             ),
//             Row(
//               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 SizedBox(
//                   width: 3.w,
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(top: 2.h),
//                   child: Text(
//                     "${order?.status ?? ""}",
//                     style: TextStyle(
//                         color: AppConst.kPrimaryColor,
//                         fontSize: 13.sp,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 Spacer(),
//                 GestureDetector(
//                   onTap: () {
//                     Get.toNamed(AppRoutes.PayView);
//                   },
//                   child: Container(
//                       height: 5.5.h,
//                       width: 25.w,
//                       decoration: BoxDecoration(
//                           color: AppConst.green,
//                           border: Border.all(color: Colors.green),
//                           borderRadius: BorderRadius.circular(18)),
//                       child: Center(
//                         child: Text(
//                           "Pay again",
//                           style: TextStyle(
//                               color: Colors.white, fontWeight: FontWeight.bold),
//                         ),
//                       )),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 1.h,
//             )
//           ]),
//         )),
//       ],
//     );
//   }
// }

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

class ordershimmer extends StatelessWidget {
  const ordershimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 1.h),
      itemBuilder: (context, index) {
        return TabViewShimmer();
      },
      itemCount: 8,
      separatorBuilder: (context, index) {
        return Container(
          height: 2.h,
          color: AppConst.veryLightGrey,
        );
      },
    );
  }
}

class TabViewShimmer extends StatelessWidget {
  final OrderData? order;
  bool? isRefund;
  TabViewShimmer({Key? key, this.order, this.isRefund = false})
      : super(key: key);
  // final MyAccountController _myAccountController = Get.find();
  final ExploreController _exploreController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerEffect(
                  child: DispalyStoreLogo(
                    logo: order?.store?.logo,
                    height: 5.5,
                    bottomPadding: 0,
                  ),
                ),
                SizedBox(
                  width: 4.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ShimmerEffect(
                      child: Container(
                        width: 68.w,
                        color: AppConst.black,
                        child: Text(
                          " ",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    ShimmerEffect(
                      child: Container(
                        width: 40.w,
                        color: AppConst.black,
                        child: Text(
                          " ",
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 2.w,
                ),
                ShimmerEffect(
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppConst.grey,
                    size: SizeUtils.horizontalBlockSize * 5,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 1.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ShimmerEffect(
                    child: Container(
                      width: 70.w,
                      color: AppConst.black,
                      child: Text(
                        " ",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 0.5.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ShimmerEffect(
                    child: Container(
                      width: 50.w,
                      color: AppConst.black,
                      child: Text(
                        " ",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 1.w,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 2.h),
                  child: ShimmerEffect(
                    child: Icon(
                      Icons.timelapse_rounded,
                      color: AppConst.green,
                      size: 3.2.h,
                    ),
                  ),
                ),
                SizedBox(
                  width: 2.w,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 2.h),
                  child: ShimmerEffect(
                    child: Container(
                      width: 30.w,
                      color: AppConst.black,
                      child: Text(
                        " ",
                      ),
                    ),
                  ),
                ),
                Spacer(),
                ShimmerEffect(
                  child: Container(
                    height: 5.h,
                    width: 27.w,
                    decoration: BoxDecoration(
                        color: AppConst.darkGreen,
                        border: Border.all(color: AppConst.darkGreen),
                        borderRadius: BorderRadius.circular(25)),
                  ),
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

    //  Column(
    //   children: [
    //     Container(
    //         // decoration: BoxDecoration(
    //         //     border: Border.all(width: 0.5),
    //         //     borderRadius: BorderRadius.circular(8)),
    //         child: Padding(
    //       padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
    //       child: Column(mainAxisSize: MainAxisSize.min, children: [
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    //               ShimmerEffect(
    //                 child: Container(
    //                   color: AppConst.black,
    //                   height: 2.5.h,
    //                   width: 60.w,
    //                   child: Text(
    //                     "Order Placed ${order?.orderType}",
    //                     style: AppStyles.STORE_NAME_STYLE,
    //                   ),
    //                 ),
    //               ),
    //               SizedBox(
    //                 height: 0.5.h,
    //               ),
    //               ShimmerEffect(
    //                 child: Container(
    //                   color: AppConst.black,
    //                   height: 2.5.h,
    //                   width: 60.w,
    //                   child: Text(
    //                     // 'May 1, 2020, 9:44 AM',
    //                     DateFormat('E d MMM hh:mm a').format(
    //                       DateTime.fromMillisecondsSinceEpoch(
    //                         order?.createdAt != null
    //                             ? int.parse(order!.createdAt!)
    //                             : 1638362708701,
    //                       ),
    //                     ),
    //                     style: AppStyles.STORES_SUBTITLE_STYLE,
    //                   ),
    //                 ),
    //               )
    //             ]),
    //             Column(
    //               children: [
    //                 Row(
    //                   children: [
    //                     Column(children: [
    //                       ShimmerEffect(
    //                         child: Container(
    //                           color: AppConst.black,
    //                           height: 2.5.h,
    //                           width: 20.w,
    //                           child: Text(
    //                             "Total",
    //                             style: AppStyles.STORE_NAME_STYLE,
    //                           ),
    //                         ),
    //                       ),
    //                       SizedBox(
    //                         height: 0.5.h,
    //                       ),
    //                       ShimmerEffect(
    //                         child: Container(
    //                           color: AppConst.black,
    //                           height: 2.5.h,
    //                           width: 20.w,
    //                           child: Text(
    //                             ' \u{20B9} ${order?.total ?? 0}',
    //                             style: AppStyles.STORES_SUBTITLE_STYLE,
    //                           ),
    //                         ),
    //                       )
    //                     ])
    //                   ],
    //                 )
    //               ],
    //             )
    //           ],
    //         ),
    //         SizedBox(
    //           height: 2.h,
    //         ),
    //         Row(
    //           children: [
    //             // CircleAvatar(),
    //             ShimmerEffect(
    //               child: Container(
    //                 decoration: BoxDecoration(
    //                     shape: BoxShape.circle,
    //                     border: Border.all(
    //                       color: AppConst.grey,
    //                     )),
    //                 child: ClipOval(
    //                   child: ClipRRect(
    //                     borderRadius: BorderRadius.circular(100),
    //                     child: CachedNetworkImage(
    //                       width: 12.w,
    //                       height: 6.h,
    //                       fit: BoxFit.contain,
    //                       imageUrl: order?.store?.logo ??
    //                           'https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg',
    //                       progressIndicatorBuilder:
    //                           (context, url, downloadProgress) => Center(
    //                               child: CircularProgressIndicator(
    //                                   value: downloadProgress.progress)),
    //                       errorWidget: (context, url, error) => Container(
    //                         color: Colors.primaries[
    //                             Random().nextInt(Colors.primaries.length)],
    //                         child: Center(
    //                           child: Text(
    //                               order?.store?.name?.substring(0, 1) ?? "",
    //                               style: TextStyle(
    //                                   fontSize:
    //                                       SizeUtils.horizontalBlockSize * 6)),
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //             SizedBox(
    //               width: 2.w,
    //             ),
    //             Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 ShimmerEffect(
    //                   child: Container(
    //                     color: AppConst.black,
    //                     height: 2.5.h,
    //                     width: 60.w,
    //                     child: Text(
    //                       "${order?.store?.name ?? "Defalut name "}",
    //                       // "Store name",
    //                       style: AppStyles.STORE_NAME_STYLE,
    //                     ),
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   height: 1.h,
    //                 ),
    //                 Row(
    //                   children: [
    //                     ShimmerEffect(
    //                       child: Container(
    //                         color: AppConst.black,
    //                         height: 2.5.h,
    //                         width: 60.w,
    //                         child: Text(
    //                           '${order?.products?.length ?? 0} items.  Earned cashback \u{20B9} ${order?.total_cashback ?? 0}',
    //                           style: AppStyles.STORES_SUBTITLE_STYLE,
    //                         ),
    //                       ),
    //                     ),
    //                     // Icon(Icons.monetization_on,
    //                     //     color: AppConst.kSecondaryColor)
    //                   ],
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //         SizedBox(
    //           height: 2.h,
    //         ),
    //         Row(
    //           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             SizedBox(
    //               width: 3.w,
    //             ),
    //             Padding(
    //               padding: EdgeInsets.only(top: 2.h),
    //               child: ShimmerEffect(
    //                 child: Container(
    //                   color: AppConst.black,
    //                   // height: 2.5.h,
    //                   width: 40.w,
    //                   child: Text(
    //                     "${order?.status ?? ""}",
    //                     style: TextStyle(
    //                         color: AppConst.kPrimaryColor,
    //                         fontSize: 13.sp,
    //                         fontWeight: FontWeight.bold),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //             Spacer(),
    //             ShimmerEffect(
    //               child: Container(
    //                   height: 5.5.h,
    //                   width: 25.w,
    //                   decoration: BoxDecoration(
    //                       color: AppConst.green,
    //                       border: Border.all(color: Colors.green),
    //                       borderRadius: BorderRadius.circular(18)),
    //                   child: Center(
    //                     child: Text(
    //                       "${(order?.orderType) == "online" ? "go to store" : " scan recipt"}",
    //                       style: TextStyle(
    //                           color: Colors.white, fontWeight: FontWeight.bold),
    //                     ),
    //                   )),
    //             ),
    //           ],
    //         ),
    //         SizedBox(
    //           height: 1.h,
    //         )
    //       ]),
    //     )),
    //   ],
    // );
  }
}
