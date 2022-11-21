
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/data/model/order_model.dart';
import 'package:customer_app/app/ui/pages/stores/StoreScreen.dart';
import 'package:customer_app/constants/app_const.dart';

import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class HistoryCardWidget extends StatelessWidget {
  final OrderCardTag tag;
  final OrderData? order;

  const HistoryCardWidget({Key? key, required this.tag, this.order})
      : super(key: key);

  void _launchURL(url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    List<Products>? product = [];
    product = order?.products;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          color: AppConst.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    // order?.createdAt ?? "TODAY 3:31 PM",
                    DateFormat('E d MMM hh:mm a').format(
                      DateTime.fromMillisecondsSinceEpoch(
                        order?.createdAt != null
                            ? int.parse(order!.createdAt!)
                            : 1638362708701,
                      ),
                    ),
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: SizeUtils.horizontalBlockSize * 4.5,
                        color: AppConst.kIconColor),
                  ),
                  Spacer(),
                  // Text(
                  //   "14 items",
                  //   style: TextStyle(
                  //       fontWeight: FontWeight.w500,
                  //       fontSize: SizeUtils.horizontalBlockSize * 4.5,
                  //       color: AppConst.black54),
                  // ),
                  // SizedBox(
                  //   width: 3.w,
                  // ),
                  Text(
                    "Rs ${order?.total ?? 0}",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: SizeUtils.horizontalBlockSize * 4.5,
                        color: AppConst.kIconColor),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              Row(
                children: [
                  CircleAvatar(
                    child: Image.network(
                      'https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg',
                      fit: BoxFit.contain,
                    ),
                    backgroundColor: AppConst.lightGrey,
                    radius: 3.h,
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Container(
                    width: 50.w,
                    child: Text(
                      order?.store?.name ?? "Store name",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: SizeUtils.horizontalBlockSize * 4.5,
                      ),
                    ),
                  ),
                  Spacer(),
                  goToStore(),
                  SizedBox(
                    width: 2.w,
                  ),
                ],
              ),
              // SizedBox(
              //   height: 1.h,
              // ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Spacer(),

                  // Expanded(
                  //     child: GridView.builder(
                  //   itemCount: order?.products?.length,
                  //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //       crossAxisCount: 2),
                  //   itemBuilder: (BuildContext context, int index) {
                  //     var product = order?.products!;
                  //     return Text("${product?.length}");
                  //   },
                  // )),
                  Expanded(
                    child: RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        style: TextStyle(color: AppConst.kIconColor),
                        children: order?.products?.map((e) {
                          return TextSpan(
                            text: "${e.name} (${e.quantity}), ",
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  Container(
                      child: (product?.length != 0 &&
                              product?.length != 1 &&
                              product?.length != 2)
                          ? Badge(
                              toAnimate: false,
                              shape: BadgeShape.square,
                              badgeColor: AppConst.lightGrey,
                              borderRadius: BorderRadius.circular(8),
                              badgeContent: Text("${product?.length ?? 0}+",
                                  style: TextStyle(
                                    color: AppConst.black,
                                    fontSize:
                                        SizeUtils.horizontalBlockSize * 3.5,
                                    fontWeight: FontWeight.w500,
                                  )),
                            )
                          : Center()),

                  SizedBox(
                    width: 3.w,
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
          width: double.infinity,
          color: AppConst.white,
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              orderAgain(),
              Spacer(),
              callStore(),
              SizedBox(
                width: 2.w,
              ),
            ],
          ),
        ),
        Container(
          height: 1,
          color: AppConst.grey,
        ),
      ],
    );
  }

  GestureDetector callStore() {
    return GestureDetector(
      onTap: () => _launchURL("tel:+91${order?.store?.mobile}"),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppConst.blue),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
          child: Row(
            children: [
              Icon(
                Icons.call,
                size: SizeUtils.horizontalBlockSize * 4.5,
                color: AppConst.green,
              ),
              SizedBox(
                width: 1.w,
              ),
              Text(
                "CALL STORE",
                style: TextStyle(
                  color: AppConst.blue,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector orderAgain() {
    return GestureDetector(
      onTap: (() {}),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppConst.kPrimaryColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
          child: Text(
            order?.status?.toUpperCase() ?? "ORDER AGAIN",
            style: TextStyle(
              color: AppConst.kPrimaryColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector goToStore() {
    return GestureDetector(
      onTap: () {
        Get.to(() => StoreScreen());
        // Get.to(StoreScreen());
      },
      child: Container(
        height: 4.h,
        width: 24.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.w),
            border: Border.all(color: AppConst.green, width: 2)),
        child: Center(
          child: Text(
            "Go to store",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: SizeUtils.horizontalBlockSize * 3.5,
                color: AppConst.green),
          ),
        ),
      ),
    );
  }
}
