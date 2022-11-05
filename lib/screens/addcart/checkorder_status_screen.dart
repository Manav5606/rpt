import 'package:cached_network_image/cached_network_image.dart';
import 'package:customer_app/app/data/model/active_order_model.dart';
import 'package:customer_app/app/ui/pages/chat/chat_controller.dart';
import 'package:customer_app/app/ui/pages/chat/freshchat_controller.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/controller/account_controller.dart';
import 'package:customer_app/app/data/model/order_model.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/screens/addcart/productList.dart';
import 'package:customer_app/screens/addcart/shop_items.dart';
import 'package:customer_app/screens/base_screen.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/constants/responsive.dart';
import 'controller/addcart_controller.dart';

class OrderTreckScreen extends StatelessWidget {
  final OrderData? order;
  final ActiveOrderData? activeOrder;
  final String displayHour;
  final bool? historyTab;

  OrderTreckScreen(
      {Key? key,
      this.order,
      this.activeOrder,
      required this.displayHour,
      this.historyTab = false})
      : super(key: key);
  final AddCartController _addCartController = Get.find();
  final ChatController _chatController = Get.find();
  // final MyAccountController _myAccountController = Get.find();
  final freshChatController _freshChat = Get.find();

  final List<String> stepperItem = [
    'Pending',
    'Accepted',
    'Picked Up',
    'Completed',
  ];

  List<String> orderStatus() {
    switch (historyTab! ? order?.status : activeOrder?.status) {
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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            historyTab!
                ? Text("${order?.store?.name ?? 'Store Name'}",
                    style: AppStyles.STORE_NAME_STYLE)
                : Text("${activeOrder?.store?.name ?? 'Store Name'}",
                    style: AppStyles.STORE_NAME_STYLE),
            Row(
              children: [
                (historyTab!)
                    ? Text(
                        // 'May 1, 2020, 9:44 AM',
                        DateFormat('E d MMM hh:mm a').format(
                          DateTime.fromMillisecondsSinceEpoch(
                            order?.createdAt != null
                                ? int.parse(order!.createdAt!)
                                : 1638362708701,
                          ),
                        ),
                        style: AppStyles.STORE_NAME_STYLE,
                      )
                    : Text(
                        // 'May 1, 2020, 9:44 AM',
                        DateFormat('E d MMM hh:mm a').format(
                          DateTime.fromMillisecondsSinceEpoch(
                            activeOrder?.createdAt != null
                                ? int.parse(activeOrder!.createdAt!)
                                : 1638362708701,
                          ),
                        ),
                        style: AppStyles.STORE_NAME_STYLE,
                      ),
                Spacer(),
                InkWell(
                    highlightColor: AppConst.highLightColor,
                    onTap: () async {
                      _freshChat.initState();
                      await _freshChat.showChatConversation(historyTab!
                          ? "Have a problem with Order\n${order?.Id}\n${order?.status}\n${order?.createdAt}\n${order?.address}\n"
                          : "Have a problem with order \n${activeOrder?.Id}\n${activeOrder?.status}\n${activeOrder?.createdAt}\n${activeOrder?.address}\n");
                    },
                    child: Container(
                      width: 15.w,
                      child: Center(
                        child: Text(
                          "HELP",
                          style: TextStyle(
                              fontSize: SizeUtils.horizontalBlockSize * 4,
                              fontWeight: FontWeight.bold,
                              color: AppConst.black,
                              fontFamily: "MuseoSans",
                              letterSpacing: 0.5),
                        ),
                      ),
                    )),
                // RichText(
                //   text: TextSpan(
                //     text: 'HELP',
                //     style: TextStyle(
                //         color: AppConst.black,
                //         fontSize: SizeUtils.horizontalBlockSize * 4,
                //         fontWeight: FontWeight.bold),
                //     children: <TextSpan>[
                //       TextSpan(
                //         text: historyTab!
                //             ? order?.orderType
                //             : activeOrder?.orderType,
                //         style: TextStyle(
                //             color: AppConst.green,
                //             fontSize: SizeUtils.horizontalBlockSize * 4.5,
                //             fontWeight: FontWeight.bold),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: AppConst.green,
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
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
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (historyTab!)
                    ? Text(
                        "Order total: ${order?.total ?? ""} ",
                        style: TextStyle(
                            fontSize: SizeUtils.horizontalBlockSize * 4),
                      )
                    : Text(
                        "Order total: ${activeOrder?.total ?? ""} ",
                        style: TextStyle(
                            fontSize: SizeUtils.horizontalBlockSize * 4),
                      ),
                (historyTab!)
                    ? Text(
                        "Total cashback: ${order?.total_cashback ?? "0"} ",
                        style: TextStyle(
                            fontSize: SizeUtils.horizontalBlockSize * 4),
                      )
                    : Text(
                        "Total cashback: ${activeOrder?.total_cashback ?? "0"} ",
                        style: TextStyle(
                            fontSize: SizeUtils.horizontalBlockSize * 4),
                      ),
                (historyTab!)
                    ? Text(
                        "Wallet amount: ${order?.wallet_amount ?? ""} ",
                        style: TextStyle(
                            fontSize: SizeUtils.horizontalBlockSize * 4),
                      )
                    : Text(
                        "Wallet amount: ${activeOrder?.wallet_amount ?? ""} ",
                        style: TextStyle(
                            fontSize: SizeUtils.horizontalBlockSize * 4),
                      ),
              ],
            ),
          ),

          (historyTab!)
              ? ((order?.orderType == "online")
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 98.w,
                        decoration: BoxDecoration(color: AppConst.lightYellow),
                        child: Text(
                          "Payment Status: ${_addCartController.isPaymentDone.value ? "Successful" : "Pending"}",
                          style: TextStyle(
                              fontSize: SizeUtils.horizontalBlockSize * 4,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  : SizedBox())
              : (activeOrder?.orderType == "online")
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 98.w,
                        decoration: BoxDecoration(color: AppConst.lightYellow),
                        child: Text(
                          //doubt how to get the payment value for each order
                          "Payment Status: ${_addCartController.isPaymentDone.value ? "Successful" : "Pending"}",
                          style: TextStyle(
                              fontSize: SizeUtils.horizontalBlockSize * 4,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  : SizedBox(),
          (historyTab!)
              ? ((order?.orderType == "online")
                  ? Padding(
                      padding:
                          EdgeInsets.all(SizeUtils.horizontalBlockSize * 2),
                      child: Row(
                        children: [
                          Icon(Icons.access_time_outlined),
                          SizedBox(
                            width: SizeUtils.horizontalBlockSize * 2,
                          ),
                          Text(
                            "Delivery on $displayHour ",
                            style: TextStyle(
                                fontSize: SizeUtils.horizontalBlockSize * 4),
                          )
                        ],
                      ),
                    )
                  : SizedBox())
              : ((activeOrder?.orderType == "online")
                  ? Padding(
                      padding:
                          EdgeInsets.all(SizeUtils.horizontalBlockSize * 2),
                      child: Row(
                        children: [
                          Icon(Icons.access_time_outlined),
                          SizedBox(
                            width: SizeUtils.horizontalBlockSize * 2,
                          ),
                          Text(
                            "Delivery on $displayHour ",
                            style: TextStyle(
                                fontSize: SizeUtils.horizontalBlockSize * 4),
                          )
                        ],
                      ),
                    )
                  : SizedBox()),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Container(
          //     width: 98.w,
          //     decoration: BoxDecoration(color: AppConst.lightYellow),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text(
          //           "Rider Information:",
          //           style: TextStyle(
          //               fontSize: SizeUtils.horizontalBlockSize * 4,
          //               fontWeight: FontWeight.bold),
          //         ),
          //         (historyTab!)
          //             ? Text(
          //                 "Rider name: ${order?.rider?.firstName ?? ""} ",
          //                 style: TextStyle(
          //                     fontSize: SizeUtils.horizontalBlockSize * 4),
          //               )
          //             : Text(
          //                 "Rider name: ${activeOrder?.rider?.firstName ?? ""} ",
          //                 style: TextStyle(
          //                     fontSize: SizeUtils.horizontalBlockSize * 4),
          //               ),
          //         (historyTab!)
          //             ? Text(
          //                 "Rider contact: ${order?.rider?.mobile ?? ""} ",
          //                 style: TextStyle(
          //                     fontSize: SizeUtils.horizontalBlockSize * 4),
          //               )
          //             : Text(
          //                 "Rider contact: ${activeOrder?.rider?.mobile ?? ""} ",
          //                 style: TextStyle(
          //                     fontSize: SizeUtils.horizontalBlockSize * 4),
          //               ),
          //       ],
          //     ),
          //   ),
          // ),

          // orderStatus().length == 4
          //     ? Container(
          //         color: AppConst.black,
          //         child: Padding(
          //           padding: EdgeInsets.all(SizeUtils.horizontalBlockSize * 2),
          //           child: Text(
          //             "Ruby just started shopping! we'll notify you if there are any changes. your perishables will be temperature controlled until delivery",
          //             style: TextStyle(
          //                 color: AppConst.white,
          //                 fontSize: SizeUtils.horizontalBlockSize * 4),
          //           ),
          //         ),
          //       )
          //     : SizedBox(),
          SizedBox(
            height: SizeUtils.verticalBlockSize * 2,
          ),
          Obx(
            () => _addCartController.isPaymentDone.value
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
                : (historyTab!)
                    ? ((order?.status == 'accepted' &&
                            order!.total! > 0 &&
                            order?.orderType == "online")
                        ? GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => ProductRawItemScreen(
                              //       order: order,
                              //     ),
                              //   ),
                              // );
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
                                        fontSize:
                                            SizeUtils.horizontalBlockSize * 4,
                                        color: AppConst.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              ((order?.status == "completed" ||
                                      order?.status == "accepted")
                                  ? SizedBox()
                                  : _chatController.launchChat(
                                      '${order?.Id}', "${order?.store?.name}"));
                              // _chatController.launchChat(
                              //     '${order?.Id}', "${order?.store?.name}");
                            },
                            child: Container(
                              color: ((order?.status == "completed" ||
                                      order?.status == "accepted")
                                  ? AppConst.grey
                                  : AppConst.green),
                              width: double.infinity,
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      SizeUtils.horizontalBlockSize * 4),
                                  child: Text(
                                    "Chat",
                                    style: TextStyle(
                                        fontSize:
                                            SizeUtils.horizontalBlockSize * 4,
                                        color: AppConst.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                          ))
                    : ((activeOrder?.status == 'accepted' &&
                            activeOrder!.total! > 0 &&
                            activeOrder?.orderType == "online")
                        ? GestureDetector(
                            onTap: () {
                              // Get.to(
                              //   ProductRawItemScreen(
                              //     // need to convert order to  activeorder
                              //     order: order,
                              //   ),
                              // );
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
                                        fontSize:
                                            SizeUtils.horizontalBlockSize * 4,
                                        color: AppConst.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              _chatController.launchChat('${activeOrder?.Id}',
                                  "${activeOrder?.store?.name}");
                            },
                            child: Container(
                              color: ((activeOrder?.status == "completed" ||
                                      activeOrder?.status == "accepted")
                                  ? AppConst.grey
                                  : AppConst.green),
                              width: double.infinity,
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      SizeUtils.horizontalBlockSize * 4),
                                  child: Text(
                                    "Chat",
                                    style: TextStyle(
                                        fontSize:
                                            SizeUtils.horizontalBlockSize * 4,
                                        color: AppConst.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                          )),
          )
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
                                imageUrl: (historyTab!
                                        ? order?.rider?.bankDocumentPhoto
                                        : activeOrder
                                            ?.rider?.bankDocumentPhoto) ??
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
                                (historyTab!
                                        ? order?.rider?.firstName
                                        : activeOrder?.rider?.firstName) ??
                                    'We Will notify you for any changes to your order.',
                                style: TextStyle(
                                    color: AppConst.white,
                                    fontSize:
                                        SizeUtils.horizontalBlockSize * 4),
                              ),
                            ),
                            (order?.orderType == "online")
                                ? GestureDetector(
                                    onTap: () {
                                      historyTab!
                                          ? _launchURL(
                                              "tel:+91${order?.rider?.mobile ?? ''}")
                                          : _launchURL(
                                              "tel:+91${activeOrder?.rider?.mobile ?? ''}");
                                    },
                                    child: Icon(
                                      Icons.call,
                                      color: AppConst.white,
                                      size: SizeUtils.verticalBlockSize * 3,
                                    ),
                                  )
                                : SizedBox(),
                          ]),
                    ),
                    (historyTab!)
                        ? (order?.orderType == "redeem_cash")
                            ? SizedBox()
                            : Padding(
                                padding: EdgeInsets.all(
                                    SizeUtils.horizontalBlockSize * 2),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(ShopItemsScreen(
                                      allorder: true,
                                      order: order,
                                    ));
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
                                          fontSize:
                                              SizeUtils.horizontalBlockSize * 4,
                                          fontWeight: FontWeight.w500),
                                    )),
                                  ),
                                ),
                              )
                        : Padding(
                            padding: EdgeInsets.all(
                                SizeUtils.horizontalBlockSize * 2),
                            child: GestureDetector(
                              onTap: () {
                                Get.to(ShopItemsScreen(
                                  activeOrder: activeOrder,
                                ));
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
                                      fontSize:
                                          SizeUtils.horizontalBlockSize * 4,
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
