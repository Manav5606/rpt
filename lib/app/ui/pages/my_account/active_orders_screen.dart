import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/controller/account_controller.dart';
import 'package:customer_app/constants/app_const.dart';

import 'package:customer_app/screens/addcart/checkorder_status_screen.dart';
import 'package:customer_app/screens/history/history_screen.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ActiveOrdersScreen extends StatefulWidget {
  const ActiveOrdersScreen({Key? key}) : super(key: key);

  @override
  _ActiveOrdersScreenState createState() => _ActiveOrdersScreenState();
}

class _ActiveOrdersScreenState extends State<ActiveOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConst.white,
      body: SafeArea(
        minimum: EdgeInsets.only(top: 2.h, left: 2.w, right: 2.w),
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
                  children: [
                    Expanded(
                      child: GetX<MyAccountController>(
                        initState: (state) {
                          Get.find<MyAccountController>().getActiveOrders();
                        },
                        builder: (state) {
                          if (state.activeOrders.data == null) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return ListView.separated(
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(vertical: 1.h),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  // Get.toNamed(AppRoutes.OrderTreckScreen);
                                  state.selectIndex.value = index;
                                  state.formatDate();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => OrderTreckScreen(
                                        displayHour: state.displayHour.value,
                                        order: state.allOrders.data!
                                            .where(
                                                (c) => c.orderType == "online")
                                            .toList()[index],
                                      ),
                                    ),
                                  );
                                },
                                child: OrderTabViewCard(
                                  order: state.allOrders.data!
                                      .where((c) => c.orderType == "online")
                                      .toList()[index],
                                ),
                                // HistoryCardWidget(
                                //   tag: OrderCardTag.activeOrder,
                                //   order: state.activeOrders.data![index],
                                // ),
                              );
                            },
                            itemCount: state.allOrders.data!
                                .where((c) => c.orderType == "online")
                                .toList()
                                .length,
                            separatorBuilder: (context, index) {
                              return Container(
                                height: 2.h,
                                color: AppConst.veryLightGrey,
                              );
                            },
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: GetX<MyAccountController>(
                        // initState: (state) {
                        //   Get.find<MyAccountController>().getActiveOrders();
                        // },
                        builder: (state) {
                          if (state.activeOrders.data == null) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return ListView.separated(
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(vertical: 1.h),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  // Get.toNamed(AppRoutes.OrderTreckScreen);
                                  state.selectIndex.value = index;
                                  state.formatDate();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => OrderTreckScreen(
                                        displayHour: state.displayHour.value,
                                        order: state.allOrders.data!
                                            .where(
                                                (c) => c.orderType == "receipt")
                                            .toList()[index],
                                      ),
                                    ),
                                  );
                                },
                                child: OrderTabViewCard(
                                  order: state.allOrders.data!
                                      .where((c) => c.orderType == "receipt")
                                      .toList()[index],
                                ),
                                // HistoryCardWidget(
                                //   tag: OrderCardTag.activeOrder,
                                //   order: state.activeOrders.data![index],
                                // ),
                              );
                            },
                            itemCount: state.allOrders.data!
                                .where((c) => c.orderType == "receipt")
                                .toList()
                                .length,
                            separatorBuilder: (context, index) {
                              return Container(
                                height: 2.h,
                                color: AppConst.veryLightGrey,
                              );
                            },
                          );
                        },
                      ),
                    )
                  ],
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
    );
  }
}
