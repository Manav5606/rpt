import 'dart:math';

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:customer_app/app/data/model/active_order_model.dart';
import 'package:customer_app/app/ui/pages/search/controller/exploreContoller.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/screens/addcart/active_order_tracking_screen.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/controller/account_controller.dart';
import 'package:customer_app/constants/app_const.dart';

import 'package:customer_app/screens/addcart/checkorder_status_screen.dart';
import 'package:customer_app/screens/history/history_screen.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class ActiveOrdersScreen extends StatefulWidget {
  ActiveOrdersScreen({Key? key}) : super(key: key);
  final MyAccountController myAccountController = Get.find()..getActiveOrders();

  @override
  _ActiveOrdersScreenState createState() => _ActiveOrdersScreenState();
}

class _ActiveOrdersScreenState extends State<ActiveOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: AppConst.white,
          statusBarIconBrightness: Brightness.dark),
      child: Scaffold(
        backgroundColor: AppConst.white,
        body: SafeArea(
          minimum: EdgeInsets.only(top: 2.h, left: 1.w, right: 1.w),
          top: true,
          child: DefaultTabController(
            length: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BackButtonAppbar(
                  text: "Active Orders",
                ),

                ButtonsTabBar(
                  buttonMargin:
                      EdgeInsets.only(left: 2.w, top: 1.4.h, bottom: 1.h),
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
                    Tab(
                      text: 'Orders',
                    ),
                    Tab(
                      text: 'Receipt',
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [ActiveOrderTabView(), ActiveReciptTabView()],
                  ),
                ),

                // Container(
                //   color: AppConst.white,
                //   width: double.infinity,
                //   padding: EdgeInsets.only(
                //     top: 10,
                //     bottom: 5,
                //   ),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Padding(
                //         padding: const EdgeInsets.symmetric(
                //             horizontal: 8.0, vertical: 10),
                //         child: Row(
                //           children: [
                //             GestureDetector(
                //                 onTap: () => Navigator.pop(context),
                //                 child: Icon(Icons.arrow_back_ios_new_rounded)),
                //             Text(
                //               " Active Orders",
                //               style: TextStyle(
                //                 fontWeight: FontWeight.w700,
                //                 fontSize: SizeUtils.horizontalBlockSize * 4.5,
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ActiveReciptTabView extends StatelessWidget {
  const ActiveReciptTabView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<MyAccountController>(
      builder: (state) {
        return state.isActiveOrderloading == true
            ? ordershimmer()
            : Container(
                child: (state.activeOrdersModel.value?.data!
                                .where((c) => c.orderType == "receipt")
                                .toList() ==
                            null ||
                        state.activeOrdersModel.value?.data!
                                .where((c) => c.orderType == "receipt")
                                .toList()
                                .length ==
                            0)
                    ? Center(
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
                              state.selectIndex.value = index;
                              state.formatDate();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ActiveOrderTrackingScreen(
                                    // historyTab: false,
                                    // displayHour: state.displayHour.value,
                                    activeOrder: (state
                                        .activeOrdersModel.value!.data!
                                        .where((c) => c.orderType == "receipt")
                                        .toList())[(state
                                            .activeOrdersModel.value?.data!
                                            .where(
                                                (c) => c.orderType == "receipt")
                                            .toList()
                                            .length)! -
                                        1 -
                                        index],
                                  ),
                                ),
                              );
                            },
                            child: ActiveOrderTabViewCard(
                              order: state.activeOrdersModel.value?.data!
                                  .where((c) => c.orderType == "receipt")
                                  .toList()[(state
                                      .activeOrdersModel.value?.data!
                                      .where((c) => c.orderType == "receipt")
                                      .toList()
                                      .length)! -
                                  1 -
                                  index],
                            ),
                            // HistoryCardWidget(
                            //   tag: OrderCardTag.activeOrder,
                            //   order: state.activeOrders.data![index],
                            // ),
                          );
                        },
                        itemCount: state.activeOrdersModel.value!.data!
                            .where((c) => c.orderType == "receipt")
                            .toList()
                            .length,
                        separatorBuilder: (context, index) {
                          return Container(
                            height: 2.h,
                            color: AppConst.veryLightGrey,
                          );
                        },
                      ));
      },
    );
  }
}

class ActiveOrderTabView extends StatelessWidget {
  const ActiveOrderTabView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<MyAccountController>(
      builder: (state) {
        // if (state.activeOrdersModel.value?.data == null) {
        //   return Center(
        //     child: CircularProgressIndicator(),
        //   );
        // }
        return state.isActiveOrderloading == true
            ? ordershimmer()
            : Container(
                child: (state.activeOrdersModel.value?.data!
                                .where((c) => c.orderType == "online")
                                .toList() ==
                            null ||
                        state.activeOrdersModel.value?.data!
                                .where((c) => c.orderType == "online")
                                .toList()
                                .length ==
                            0)
                    ? Center(
                        child: EmptyHistoryPage(
                          icon: CupertinoIcons.cart_fill,
                          text1: " No orders found !",
                          text2: "Orders that you save will appear here.   ",
                          text3: "Place your first order!",
                        ),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        // padding: EdgeInsets.symmetric(vertical: 1.h),
                        itemBuilder: (context, index) {
                          return InkWell(
                            highlightColor: AppConst.highLightColor,
                            onTap: () {
                              // Get.toNamed(AppRoutes.OrderTreckScreen);
                              state.selectIndex.value = index;
                              state.formatDate();

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ActiveOrderTrackingScreen(
                                    // historyTab: false,
                                    // displayHour: state.displayHour.value,
                                    activeOrder: (state
                                        .activeOrdersModel.value!.data!
                                        .where((c) => c.orderType == "online")
                                        .toList())[(state
                                            .activeOrdersModel.value?.data!
                                            .where(
                                                (c) => c.orderType == "online")
                                            .toList()
                                            .length)! -
                                        1 -
                                        index],
                                  ),
                                ),
                              );
                            },
                            child: ActiveOrderTabViewCard(
                              order: state.activeOrdersModel.value?.data!
                                  .where((c) => c.orderType == "online")
                                  .toList()[(state
                                      .activeOrdersModel.value?.data!
                                      .where((c) => c.orderType == "online")
                                      .toList()
                                      .length)! -
                                  1 -
                                  index],
                            ),
                            // HistoryCardWidget(
                            //   tag: OrderCardTag.activeOrder,
                            //   order: state.activeOrders.data![index],
                            // ),
                          );
                        },
                        itemCount: state.activeOrdersModel.value!.data!
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
    );
  }
}

class ActiveOrderTabViewCard extends StatelessWidget {
  final ActiveOrderData? order;
  ActiveOrderTabViewCard({Key? key, this.order}) : super(key: key);
  // final MyAccountController _myAccountController = Get.find();
  final ExploreController _exploreController = Get.find();
  @override
  Widget build(BuildContext context) {
    int itemsLength = ((order?.products?.length ?? 0) +
        (order?.rawItems?.length ?? 0) +
        (order?.inventories?.length ?? 0));
    return Column(
      children: [
        Padding(
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
                    Container(
                      width: 70.w,
                      child: Text(
                        "${order?.store?.name ?? "Defalut name "}",

                        // "Store name",
                        style: AppStyles.STORE_NAME_STYLE,
                      ),
                    ),
                    // SizedBox(
                    //   height: 1.h,
                    // ),
                    Row(
                      children: [
                        Text(
                          '${itemsLength} items.  Earned cashback \u{20B9} ${order?.total_cashback ?? 0}',
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
        ),
      ],
    );
  }
}
