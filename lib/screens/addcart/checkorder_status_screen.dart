import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/controller/account_controller.dart';
import 'package:customer_app/app/data/model/order_model.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/screens/addcart/productList.dart';
import 'package:customer_app/screens/addcart/shop_items.dart';
import 'package:customer_app/screens/base_screen.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/constants/responsive.dart';
import 'controller/addcart_controller.dart';

class OrderTreckScreen extends StatelessWidget {
  final OrderData order;
  final String displayHour;

  OrderTreckScreen({Key? key, required this.order, required this.displayHour}) : super(key: key);
  final AddCartController _addCartController = Get.find();
  // final MyAccountController _myAccountController = Get.find();

  final List<String> stepperItem = [
    'Pending',
    'Accepted',
    'Picked Up',
    'Completed',
  ];

  List<String> orderStatus() {
    switch (order.status) {
      case 'pending':
        return stepperItem.sublist(0);
      case 'accepted':
        return stepperItem.sublist(1);
      case 'picked_up':
        return stepperItem.sublist(2);
      case 'completed':
        return stepperItem.sublist(3);
      default:
        return stepperItem.sublist(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConst.lightGrey,
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.close,
            color: AppConst.black,
            size: SizeUtils.verticalBlockSize * 3,
          ),
        ),
        title: Text(
          "${order.store?.name ?? 'Store Name'}",
          style: TextStyle(
            color: AppConst.black,
            fontSize: SizeUtils.horizontalBlockSize * 4,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: AppConst.green,
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(
                  SizeUtils.horizontalBlockSize * 4,
                ),
                child: CircleAvatar(
                  backgroundColor: AppConst.green,
                  radius: 40,
                  child: Icon(
                    Icons.apple,
                    color: AppConst.kPrimaryColor,
                    size: SizeUtils.horizontalBlockSize * 10,
                  ),
                ),
              ),
            ),
          ),
          ...List.generate(
            orderStatus().length,
            (index) {
              if (index == 0) {
                return timelineFirst(context, index);
              }
              return Stack(
                children: [
                  Row(
                    children: [
                      SizedBox(width: SizeUtils.horizontalBlockSize * 5),
                      Container(
                        width: SizeUtils.verticalBlockSize * 2,
                        height: SizeUtils.verticalBlockSize * 2,
                        decoration: const BoxDecoration(
                            color: AppConst.grey, shape: BoxShape.circle),
                      ),
                      SizedBox(
                        width: SizeUtils.verticalBlockSize * 1.5,
                      ),
                      Container(
                        height: SizeUtils.verticalBlockSize * 5,
                        margin:
                            EdgeInsets.all(SizeUtils.horizontalBlockSize * 1),
                        alignment: Alignment.center,
                        child: Text(orderStatus()[index].toString()),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 0,
                    bottom: (orderStatus().length - 1) == index ? 30 : 0,
                    left: 26,
                    child: Container(
                      width: 2,
                      color: AppConst.grey,
                    ),
                  )
                ],
              );
            },
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.all(SizeUtils.horizontalBlockSize * 2),
            child: Row(
              children: [
                Icon(Icons.access_time_outlined),
                SizedBox(
                  width: SizeUtils.horizontalBlockSize * 2,
                ),
                Text(
                  "Delivery $displayHour ",
                  style: TextStyle(fontSize: SizeUtils.horizontalBlockSize * 4),
                )
              ],
            ),
          ),
          orderStatus().length == 4
              ? Container(
                  color: AppConst.black,
                  child: Padding(
                    padding: EdgeInsets.all(SizeUtils.horizontalBlockSize * 2),
                    child: Text(
                      "Ruby just started shopping! we'll notify you if there are any changes. your perishables will be temperature controlled until delivery",
                      style: TextStyle(
                          color: AppConst.white,
                          fontSize: SizeUtils.horizontalBlockSize * 4),
                    ),
                  ),
                )
              : SizedBox(),
          SizedBox(
            height: SizeUtils.verticalBlockSize * 2,
          ),
          Obx(() => _addCartController.isPaymentDone.value
              ? GestureDetector(
                  onTap: () {
                    Get.offAll(() => BaseScreen());
                  },
                  child: Container(
                    color: AppConst.green,
                    width: double.infinity,
                    child: Center(
                      child: Padding(
                        padding:
                            EdgeInsets.all(SizeUtils.horizontalBlockSize * 4),
                        child: Text(
                          "Close",
                          style: TextStyle(
                              fontSize: SizeUtils.horizontalBlockSize * 4,
                              color: AppConst.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                )
              : order.status == 'accepted' && order.total! > 0
                  ? GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductRawItemScreen(
                              order: order,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        color: AppConst.green,
                        width: double.infinity,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(
                                SizeUtils.horizontalBlockSize * 4),
                            child: Text(
                              "Review and MakePayment",
                              style: TextStyle(
                                  fontSize: SizeUtils.horizontalBlockSize * 4,
                                  color: AppConst.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(
                      color: AppConst.green,
                      width: double.infinity,
                      child: Center(
                        child: Padding(
                          padding:
                              EdgeInsets.all(SizeUtils.horizontalBlockSize * 4),
                          child: Text(
                            "Chat",
                            style: TextStyle(
                                fontSize: SizeUtils.horizontalBlockSize * 4,
                                color: AppConst.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ))
        ],
      ),
    );
  }

  Widget timelineFirst(BuildContext context, index) {
    return Container(
      color: AppConst.lightGreen,
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(width: SizeUtils.verticalBlockSize * 2),
              Container(
                width: SizeUtils.verticalBlockSize * 3,
                height: SizeUtils.verticalBlockSize * 3,
                decoration: const BoxDecoration(
                    color: AppConst.green, shape: BoxShape.circle),
              ),
              SizedBox(
                width: SizeUtils.verticalBlockSize * 2,
              ),
              Expanded(
                flex: 9,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: SizeUtils.verticalBlockSize * 1,
                          right: SizeUtils.verticalBlockSize * 3),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            orderStatus()[index].toString(),
                            style: TextStyle(
                                fontSize: SizeUtils.horizontalBlockSize * 5,
                                color: AppConst.white,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(SizeUtils.verticalBlockSize * 2),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: CachedNetworkImage(
                                width: 12.w,
                                height: 6.h,
                                fit: BoxFit.fill,
                                imageUrl: order.rider?.bankDocumentPhoto ??
                                    'https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg',
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                errorWidget: (context, url, error) => Image.network(
                                    'https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg'),
                              ),
                            ),
                            SizedBox(
                              width: SizeUtils.horizontalBlockSize * 2,
                            ),
                            Flexible(
                              child: Text(
                                order.rider?.firstName ??
                                    'We Will notify you for any changes to your order.',
                                style: TextStyle(
                                    color: AppConst.white,
                                    fontSize:
                                        SizeUtils.horizontalBlockSize * 4),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _launchURL(
                                    "tel:+91${order.rider?.mobile ?? ''}");
                              },
                              child: Icon(
                                Icons.call,
                                color: AppConst.white,
                                size: SizeUtils.verticalBlockSize * 3,
                              ),
                            ),
                          ]),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.all(SizeUtils.horizontalBlockSize * 2),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShopItemsScreen(
                                order: order,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: SizeUtils.horizontalBlockSize * 10,
                          decoration: BoxDecoration(
                              color: AppConst.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                              child: Text(
                            "See Shopped items",
                            style: TextStyle(
                                color: AppConst.green,
                                fontSize: SizeUtils.horizontalBlockSize * 4,
                                fontWeight: FontWeight.w500),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 20,
            bottom: (orderStatus().length - 1) == index ? 30 : 0,
            left: 26,
            child: Container(
              width: 2,
              color: AppConst.green,
            ),
          )
        ],
      ),
    );
  }

  Future<void> dialNumber(
      {required String phoneNumber, required BuildContext context}) async {
    final url = "tel:$phoneNumber";
    if (await canLaunch(url)) {
      await launch(url);
    }

    return;
  }

  void _launchURL(url) async {
    if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
  }
}
