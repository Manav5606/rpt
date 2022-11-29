import 'dart:developer';

import 'package:badges/badges.dart';
import 'package:bubble/bubble.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/data/model/active_order_model.dart';
import 'package:customer_app/app/data/model/order_model.dart';
import 'package:customer_app/app/ui/pages/chat/chat_controller.dart';
import 'package:customer_app/app/ui/pages/chat/freshchat_controller.dart';
import 'package:customer_app/app/ui/pages/signIn/phone_authentication_screen.dart';
import 'package:customer_app/app/ui/pages/stores/storedetailscreen.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/screens/addcart/Widgets/store_name_call_logo.dart';
import 'package:customer_app/screens/addcart/controller/addcart_controller.dart';
import 'package:customer_app/screens/addcart/my_order_item_page.dart';
import 'package:customer_app/screens/history/history_order_items_page.dart';
import 'package:customer_app/screens/history/history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class HistoryOrderTrackingScreen extends StatelessWidget {
  final OrderData? order;
  final ChatController _chatController = Get.find();
  final freshChatController _freshChat = Get.find();
  final AddCartController _addCartController = Get.find();
  HistoryOrderTrackingScreen({
    Key? key,
    this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DaySelection(int index) {
      var day = _addCartController.weekDayList[index].day
          .toString()
          .substring(0, 3)
          .toUpperCase();
      return day;
    }

    var date0 = "${order?.deliverySlot?.day ?? 0}";
    var DayName = DaySelection(int.parse(date0));
    var date1 =
        "${((order?.deliverySlot?.startTime?.hour ?? 0) > 12 ? ((order?.deliverySlot?.startTime?.hour ?? 0) - 12) : order?.deliverySlot?.startTime?.hour ?? 0)}${(order?.deliverySlot?.startTime?.minute == 0) ? "" : (":${order?.deliverySlot?.startTime?.minute ?? ""}")}";

    var date2 =
        (order?.deliverySlot?.startTime?.hour ?? 0) > 12 ? "pm - " : "am - ";
    var date3 =
        "${((order?.deliverySlot?.endTime?.hour ?? 0) > 12 ? ((order?.deliverySlot?.endTime?.hour ?? 0) - 12) : order?.deliverySlot?.endTime?.hour ?? 0)}${(order?.deliverySlot?.endTime?.minute == 0) ? "" : (":${order?.deliverySlot?.endTime?.minute ?? ""}")}";
    var date4 = (order?.deliverySlot?.endTime?.hour ?? 0) > 12 ? "pm" : "am";

    var TimeSlot = DayName + " " + date1 + date2 + date3 + date4;

    var modifiedOrReplacedItemCount = ((order?.products
                ?.where((c) => c.status == "modified")
                .toList()
                .length ??
            0) +
        (order?.rawItems
                ?.where((c) => c.status == "modified")
                .toList()
                .length ??
            0) +
        (order?.inventories
                ?.where((c) => c.status == "modified")
                .toList()
                .length ??
            0) +
        (order?.products
                ?.where((c) => c.status == "replaced")
                .toList()
                .length ??
            0) +
        (order?.rawItems
                ?.where((c) => c.status == "replaced")
                .toList()
                .length ??
            0) +
        (order?.inventories
                ?.where((c) => c.status == "replaced")
                .toList()
                .length ??
            0));
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
            child: Column(
              children: [
                ((order?.orderType == "receipt" &&
                            order?.status == "completed") ||
                        (order?.orderType == "redeem_cash" &&
                            order?.status == "completed"))
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularCloseButton(),
                          SizedBox(width: 3.w),
                          Spacer(),
                          InkWell(
                            highlightColor: AppConst.highLightColor,
                            onTap: () async {
                              _freshChat.initState();
                              await _freshChat.showChatConversation(
                                  "Have a problem with order \n${order?.Id}\n${order?.status}\n${order?.createdAt}\n${order?.address}\n");
                            },
                            child: Container(
                              width: 20.w,
                              height: 5.h,
                              padding: EdgeInsets.symmetric(
                                  vertical: 0.5.h, horizontal: 1.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(85),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0x19000000),
                                      offset: Offset(0, 2),
                                      blurRadius: 4,
                                      spreadRadius: 0)
                                ],
                                color: AppConst.white,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.help,
                                    size: SizeUtils.horizontalBlockSize * 6,
                                    color: AppConst.black,
                                  ),
                                  SizedBox(width: 1.w),
                                  Text("Help",
                                      style: TextStyle(
                                          fontSize:
                                              SizeUtils.horizontalBlockSize *
                                                  3.7,
                                          fontWeight: FontWeight.bold,
                                          color: AppConst.black)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularCloseButton(),
                          SizedBox(width: 3.w),
                          Container(
                            width: 65.w,
                            // height: 7.h,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "Order ID: xxx${order?.Id?.substring((order?.Id?.length ?? 10) - 10) ?? ""}",
                                    style: TextStyle(
                                        fontSize:
                                            SizeUtils.horizontalBlockSize * 4,
                                        fontWeight: FontWeight.bold,
                                        color: AppConst.black)),
                                SizedBox(height: 0.5.h),
                                (order?.orderType == "receipt")
                                    ? SizedBox()
                                    : RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text:
                                                  "Delivery Slot: ${TimeSlot} ",
                                              // "Delivery Slot: 9am - 8pm", var date1 =
                                              // "${(].startTime?.hour ?? 0) > 12 ? ((..startTime?.hour ?? 0) - 12) : _addCartController.getOrderConfirmPageDataModel.value?.oller.dayIndexForTimeSlot.value].slots?[index].startTime?.hour}:${_addCartController.getOrderConfirmPageDataModel.value?.data?.deliverySlots?[_addCartController.dayIndexForTimeSlot.value].slots?[index].startTime?.minute}";

                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'MuseoSans',
                                                fontSize: SizeUtils
                                                        .horizontalBlockSize *
                                                    3.7,
                                                fontWeight: FontWeight.w500,
                                                fontStyle: FontStyle.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            highlightColor: AppConst.highLightColor,
                            onTap: () async {
                              _freshChat.initState();
                              await _freshChat.showChatConversation(
                                  "Have a problem with order \n${order?.Id}\n${order?.status}\n${order?.createdAt}\n${order?.address}\n");
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.help,
                                  size: SizeUtils.horizontalBlockSize * 6.5,
                                  color: AppConst.black,
                                ),
                                SizedBox(width: 2.w),
                                Text("HELP",
                                    style: TextStyle(
                                        fontSize:
                                            SizeUtils.horizontalBlockSize * 3.7,
                                        fontWeight: FontWeight.bold,
                                        color: AppConst.black)),
                              ],
                            ),
                          ),
                        ],
                      ),
                (order?.status == "delivered" ||
                        ((order?.orderType == "receipt" &&
                                order?.status == "completed") ||
                            (order?.orderType == "redeem_cash" &&
                                order?.status == "completed")))
                    ? Column(
                        children: [
                          SizedBox(
                            height: 3.h,
                          ),
                          (order?.orderType == "redeem_cash" &&
                                  order?.status == "completed")
                              ? Text("Refunded Successfully",
                                  style: TextStyle(
                                      fontSize:
                                          SizeUtils.horizontalBlockSize * 4.4,
                                      fontFamily: 'MuseoSans',
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      color: AppConst.black))
                              : Text(
                                  (order?.orderType == "receipt" &&
                                          order?.status == "completed")
                                      ? "Receipt accepted Successfully"
                                      : "Order Delivered Successfully",
                                  style: TextStyle(
                                      fontSize:
                                          SizeUtils.horizontalBlockSize * 4.4,
                                      fontFamily: 'MuseoSans',
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      color: AppConst.black)),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Text(
                            "Order ID: xxx${order?.Id?.substring((order?.Id?.length ?? 10) - 10) ?? ""}",
                            style: TextStyle(
                              fontSize: SizeUtils.horizontalBlockSize * 3.7,
                              fontWeight: FontWeight.w500,
                              color: AppConst.grey,
                              fontFamily: 'MuseoSans',
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 1.h, horizontal: 4.w),
                            child: Bubble(
                              color: AppConst.lightSkyBlue,
                              margin: BubbleEdges.only(top: 1.h),
                              stick: true,
                              nip: BubbleNip.leftBottom,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 2.h, horizontal: 4.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text:
                                                "Thank you for placing Order with us!",
                                            style: TextStyle(
                                              color: Color(0xff003d29),
                                              fontSize: SizeUtils
                                                      .horizontalBlockSize *
                                                  3.7,
                                              fontFamily: 'MuseoSans',
                                              fontWeight: FontWeight.w500,
                                              fontStyle: FontStyle.normal,
                                            ),
                                          ),
                                          ((order?.total_cashback ?? 0) > 0)
                                              ? TextSpan(
                                                  text: "\nWe've added ",
                                                  style: TextStyle(
                                                    color: Color(0xff003d29),
                                                    fontSize: SizeUtils
                                                            .horizontalBlockSize *
                                                        3.7,
                                                    fontFamily: 'MuseoSans',
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle: FontStyle.normal,
                                                  ),
                                                )
                                              : TextSpan(),
                                          ((order?.total_cashback ?? 0) > 0)
                                              ? TextSpan(
                                                  text:
                                                      "\u{20B9}${order?.total_cashback ?? 0} cashback",
                                                  style: TextStyle(
                                                    color: Color(0xff003d29),
                                                    fontSize: SizeUtils
                                                            .horizontalBlockSize *
                                                        3.7,
                                                    fontFamily: 'MuseoSans',
                                                    fontWeight: FontWeight.w700,
                                                    fontStyle: FontStyle.normal,
                                                  ),
                                                )
                                              : TextSpan(),
                                          ((order?.total_cashback ?? 0) > 0)
                                              ? TextSpan(
                                                  text: " to your\nwallet.",
                                                  style: TextStyle(
                                                    color: Color(0xff003d29),
                                                    fontSize: SizeUtils
                                                            .horizontalBlockSize *
                                                        3.7,
                                                    fontFamily: 'MuseoSans',
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle: FontStyle.normal,
                                                  ),
                                                )
                                              : TextSpan(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          StoreNameCallLogoWidget(
                            logoLetter: order?.store?.name?.substring(0, 1),
                            storeName: order?.store?.name,
                            totalAmount: order?.total,
                            paymentStatus:
                                "Paid", // updated the status to Dynamic
                            mobile: order?.store?.mobile,
                            callLogo: false,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          (order?.orderType == "receipt" &&
                                  order?.status == "completed")
                              ? SizedBox()
                              : Container(
                                  height: 0.7.h,
                                  color: AppConst.veryLightGrey,
                                ),
                          ((order?.orderType == "receipt" &&
                                      order?.status == "completed") ||
                                  (order?.orderType == "redeem_cash" &&
                                      order?.status == "completed"))
                              ? SizedBox()
                              : Padding(
                                  padding: EdgeInsets.only(
                                      left: 5.w, top: 1.h, bottom: 1.h),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Distance_store_home_separator(),
                                      ),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 1.h, bottom: 1.h),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 80.w,
                                              child: RichText(
                                                maxLines: 1,
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                    text:
                                                        "${order?.store?.name ?? ""}  ",
                                                    style: TextStyle(
                                                      fontFamily: 'MuseoSans',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      color: AppConst.black,
                                                      fontSize: SizeUtils
                                                              .horizontalBlockSize *
                                                          3.5,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                      text:
                                                          "${order?.store?.address?.address ?? ""}",
                                                      style: TextStyle(
                                                        fontFamily: 'MuseoSans',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        color: AppConst.grey,
                                                        fontSize: SizeUtils
                                                                .horizontalBlockSize *
                                                            3.5,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                      ))
                                                ]),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Container(
                                              width: 80.w,
                                              child: RichText(
                                                maxLines: 1,
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                    text: "Deliver to ",
                                                    style: TextStyle(
                                                      fontFamily: 'MuseoSans',
                                                      color: AppConst.black,
                                                      fontSize: SizeUtils
                                                              .horizontalBlockSize *
                                                          3.5,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                      text:
                                                          "${order?.address ?? ""}",
                                                      style: TextStyle(
                                                        fontFamily: 'MuseoSans',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        color: AppConst.grey,
                                                        fontSize: SizeUtils
                                                                .horizontalBlockSize *
                                                            3.5,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                      ))
                                                ]),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          ((order?.orderType == "receipt" &&
                                      order?.status == "completed") ||
                                  (order?.orderType == "redeem_cash" &&
                                      order?.status == "completed"))
                              ? SizedBox()
                              : Container(
                                  height: 0.7.h,
                                  color: AppConst.veryLightGrey,
                                ),
                          ((order?.orderType == "receipt" &&
                                      order?.status == "completed") ||
                                  (order?.orderType == "redeem_cash" &&
                                      order?.status == "completed"))
                              ? SizedBox()
                              : Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 3.w, vertical: 2.h),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 6.h,
                                        width: 12.w,
                                        child: Center(
                                            child: Text(
                                          "${order?.rider?.firstName?.substring(0, 1) ?? "R"}",
                                          style: TextStyle(
                                              color: AppConst.white,
                                              fontSize: SizeUtils
                                                      .horizontalBlockSize *
                                                  5,
                                              fontWeight: FontWeight.bold),
                                        )),
                                        decoration: BoxDecoration(
                                            color: AppConst.blue,
                                            shape: BoxShape.circle),
                                      ),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${order?.rider?.firstName ?? "Rider"} ${order?.rider?.last_name ?? ""}", // add rider last name
                                                style: TextStyle(
                                                  color: AppConst.black,
                                                  fontSize: SizeUtils
                                                          .horizontalBlockSize *
                                                      4,
                                                  fontFamily: 'MuseoSans',
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle: FontStyle.normal,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 0.5.h,
                                              ),
                                              Text(
                                                "Delivery Rider",
                                                style: TextStyle(
                                                  color: AppConst.grey,
                                                  fontWeight: FontWeight.w300,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: SizeUtils
                                                          .horizontalBlockSize *
                                                      3.5,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      // Spacer(),
                                      // InkWell(
                                      //     onTap: (() {
                                      //       _launchURL(
                                      //           "tel:${order?.rider?.mobile ?? '+91'}");
                                      //     }),
                                      //     child: CallLogo())
                                    ],
                                  ),
                                ),
                          Container(
                            height: 1,
                            color: AppConst.veryLightGrey,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 1.h,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 1.h, bottom: 1.h, left: 3.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    (order?.orderType == "redeem_cash" &&
                                            order?.status == "completed")
                                        ? Text(
                                            "View Refund",
                                            style: TextStyle(
                                              fontFamily: 'MuseoSans',
                                              color: AppConst.black,
                                              fontSize: SizeUtils
                                                      .horizontalBlockSize *
                                                  5,
                                              fontWeight: FontWeight.w700,
                                              fontStyle: FontStyle.normal,
                                              letterSpacing: -0.36,
                                            ),
                                          )
                                        : Text(
                                            (order?.orderType == "receipt" &&
                                                    order?.status ==
                                                        "completed")
                                                ? "View Order Items"
                                                : "View Order Details",
                                            style: TextStyle(
                                              fontFamily: 'MuseoSans',
                                              color: AppConst.black,
                                              fontSize: SizeUtils
                                                      .horizontalBlockSize *
                                                  5,
                                              fontWeight: FontWeight.w700,
                                              fontStyle: FontStyle.normal,
                                              letterSpacing: -0.36,
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                              (order?.orderType == "redeem_cash" &&
                                      order?.status == "completed")
                                  ? ViewOrderDetailsTextfeilds(
                                      "Previous Amount", "\u{20B9}${123}")
                                  : (order?.orderType == "receipt" &&
                                          order?.status == "completed")
                                      ? ViewOrderDetailsTextfeilds(
                                          "Total Amount",
                                          "\u{20B9}${order?.total ?? 0}")
                                      : ViewOrderDetailsTextfeilds(
                                          "Total Amount",
                                          "\u{20B9}${order?.total ?? 0}"),
                              Container(
                                height: 0.5,
                                color: AppConst.lightGrey,
                              ),
                              (order?.orderType == "redeem_cash" &&
                                      order?.status == "completed")
                                  ? ViewOrderDetailsTextfeilds("Redeem Amount",
                                      "\u{20B9}${order?.wallet_amount ?? 0}")
                                  : (order?.orderType == "receipt" &&
                                          order?.status == "completed")
                                      ? ViewOrderDetailsTextfeilds(
                                          "Cashback percentage",
                                          "${order?.cashback_percentage ?? 0}%")
                                      : ViewOrderDetailsTextfeilds("CashBack",
                                          "\u{20B9}${order?.total_cashback ?? 0}"),
                              Container(
                                height: 0.5,
                                color: AppConst.lightGrey,
                              ),
                              (order?.orderType == "redeem_cash" &&
                                      order?.status == "completed")
                                  ? ViewOrderDetailsTextfeilds(
                                      "Current Amount", "\u{20B9}${123}")
                                  : (order?.orderType == "receipt" &&
                                          order?.status == "completed")
                                      ? ViewOrderDetailsTextfeilds(
                                          "Earned Cashback",
                                          "\u{20B9}${order?.total_cashback ?? 0}")
                                      : ViewOrderDetailsTextfeilds(
                                          "Amount Paid",
                                          "\u{20B9}${order?.total_cashback ?? 0}"),
                              Container(
                                height: 0.5,
                                color: AppConst.lightGrey,
                              ),
                              Container(
                                height: 0.5,
                                color: AppConst.lightGrey,
                              ),
                              (order?.orderType == "redeem_cash" &&
                                      order?.status == "completed")
                                  ? SizedBox()
                                  : InkWell(
                                      onTap: () {
                                        Get.to(HistoryOrderItems(
                                          order: order,
                                          TimeSlot: TimeSlot,
                                        ));
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 2.h,
                                            bottom: 1.h,
                                            right: 3.w,
                                            left: 3.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "View your Order Items",
                                              style: TextStyle(
                                                fontFamily: 'MuseoSans',
                                                color: Color(0xff005b41),
                                                fontSize: SizeUtils
                                                        .horizontalBlockSize *
                                                    3.5,
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 1.w,
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: Color(0xff005b41),
                                              size: 2.h,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                              (order?.orderType == "redeem_cash" &&
                                      order?.status == "completed")
                                  ? SizedBox()
                                  : Padding(
                                      padding: EdgeInsets.only(
                                          top: 1.h,
                                          bottom: 1.h,
                                          right: 3.w,
                                          left: 3.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 3.h,
                                            width: 60.w,
                                            child: Hero(
                                              tag: "View Image",
                                              child: GestureDetector(
                                                onTap: () {
                                                  Get.dialog(Dialog(
                                                    child: Stack(
                                                      children: [
                                                        PhotoView(
                                                          heroAttributes:
                                                              PhotoViewHeroAttributes(
                                                            tag: "View Image",
                                                          ),
                                                          imageProvider:
                                                              CachedNetworkImageProvider(
                                                                  order?.receipt ??
                                                                      ""),
                                                          tightMode: true,
                                                          customSize:
                                                              Size(98.w, 98.h),
                                                          backgroundDecoration:
                                                              BoxDecoration(
                                                                  color: AppConst
                                                                      .black),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child:
                                                              CircularCloseButton(),
                                                        )
                                                      ],
                                                    ),
                                                  ));
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "View your Reciept",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'MuseoSans',
                                                          color:
                                                              Color(0xff005b41),
                                                          fontSize: SizeUtils
                                                                  .horizontalBlockSize *
                                                              3.5,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 1.w,
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .arrow_forward_ios_rounded,
                                                        color:
                                                            Color(0xff005b41),
                                                        size: 2.h,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                            ],
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          SizedBox(
                            height: (order?.rider != null) ? 5.h : 3.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.w, vertical: 0.5.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                          text: "Status: ",
                                          style: TextStyle(
                                              fontSize: SizeUtils
                                                      .horizontalBlockSize *
                                                  4,
                                              fontWeight: FontWeight.bold,
                                              color: AppConst.black)),
                                      TextSpan(
                                          text: "${order?.status ?? ""}",
                                          style: TextStyle(
                                            color: AppConst.green,
                                            fontSize:
                                                SizeUtils.horizontalBlockSize *
                                                    4,
                                            fontWeight: FontWeight.w500,
                                          ))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ((order?.status == "accepted")
                              ? Padding(
                                  padding:
                                      EdgeInsets.only(left: 5.w, bottom: 1.h),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Please Review the list and approve.",
                                        style: TextStyle(
                                            fontSize:
                                                SizeUtils.horizontalBlockSize *
                                                    4,
                                            fontWeight: FontWeight.w500,
                                            color: AppConst.black),
                                      ),
                                    ],
                                  ),
                                )
                              : (order?.rider != null)
                                  ? SizedBox()
                                  : Padding(
                                      padding: EdgeInsets.only(
                                          left: 5.w, bottom: 1.h),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Please Review the receipt and Approve",
                                            style: TextStyle(
                                                fontSize: SizeUtils
                                                        .horizontalBlockSize *
                                                    4,
                                                fontWeight: FontWeight.w500,
                                                color: AppConst.black),
                                          ),
                                        ],
                                      ),
                                    )),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 0.5.h),
                            child: Container(
                              height: (order?.status != "pending" &&
                                      order?.orderType != "receipt")
                                  ? 31.h
                                  : 28.h,
                              decoration: BoxDecoration(
                                  color: AppConst.ContainerColor,
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 3.w, right: 3.w, top: 1.h),
                                child: Column(
                                  children: [
                                    (order?.status != "pending" &&
                                            order?.orderType != "receipt")
                                        ? InkWell(
                                            onTap: () {
                                              Get.to(HistoryOrderItems(
                                                order: order,
                                                TimeSlot: TimeSlot,
                                              ));
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: 0.5.h),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    "View Items",
                                                    style: TextStyle(
                                                      color:
                                                          AppConst.lightGreen,
                                                      fontSize: SizeUtils
                                                              .horizontalBlockSize *
                                                          4,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 1.w,
                                                  ),
                                                  Icon(
                                                    Icons
                                                        .arrow_forward_ios_rounded,
                                                    color: AppConst.lightGreen,
                                                    size: 2.h,
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        : SizedBox(),
                                    Row(
                                      children: [
                                        Container(
                                          width: 50.w,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "View Order Items",
                                                style: TextStyle(
                                                    fontSize: SizeUtils
                                                            .horizontalBlockSize *
                                                        5,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppConst.lightGreen),
                                              ),
                                              SizedBox(
                                                height: 1.5.h,
                                              ),
                                              Text(
                                                "Total Amount- \u{20B9} ${order?.total ?? 0}",
                                                style: TextStyle(
                                                    fontSize: SizeUtils
                                                            .horizontalBlockSize *
                                                        4,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppConst.white),
                                              ),
                                              SizedBox(
                                                height: 0.5.h,
                                              ),
                                              Text(
                                                (order?.orderType == "receipt")
                                                    ? "Cashback - \u{20B9} ${order?.cashback_percentage ?? 0}%"
                                                    : "Cashback- \u{20B9} ${order?.total_cashback ?? 0}",
                                                style: TextStyle(
                                                    fontSize: SizeUtils
                                                            .horizontalBlockSize *
                                                        4,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppConst.white),
                                              ),
                                              SizedBox(
                                                height: 0.5.h,
                                              ),
                                              Text(
                                                (order?.orderType == "receipt")
                                                    ? "Earned Cashback- \u{20B9} ${order?.total_cashback ?? 0}"
                                                    : "Amount Paid- \u{20B9} ${order?.total ?? 0}",
                                                style: TextStyle(
                                                    fontSize: SizeUtils
                                                            .horizontalBlockSize *
                                                        4,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppConst.white),
                                              ),
                                              SizedBox(
                                                height: 0.5.h,
                                              ),
                                              // Text(
                                              //   "Total Amount - \u{20B9} ${order?.total ?? 0}",
                                              //   style: TextStyle(
                                              //       fontSize: SizeUtils
                                              //               .horizontalBlockSize *
                                              //           4,
                                              //       fontWeight: FontWeight.w500,
                                              //       color: AppConst.white),
                                              // ),
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: EdgeInsets.only(top: 0.5.h),
                                          child: Container(
                                            height: 15.h,
                                            width: 28.w,
                                            child: Hero(
                                              tag: "View Image",
                                              child: GestureDetector(
                                                onTap: () {
                                                  Get.dialog(Dialog(
                                                    child: Stack(
                                                      children: [
                                                        PhotoView(
                                                          heroAttributes:
                                                              PhotoViewHeroAttributes(
                                                            tag: "View Image",
                                                          ),
                                                          imageProvider:
                                                              CachedNetworkImageProvider(
                                                                  order?.receipt ??
                                                                      ""),
                                                          tightMode: true,
                                                          customSize:
                                                              Size(98.w, 98.h),
                                                          backgroundDecoration:
                                                              BoxDecoration(
                                                                  color: AppConst
                                                                      .black),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child:
                                                              CircularCloseButton(),
                                                        )
                                                      ],
                                                    ),
                                                  ));
                                                },
                                                child: Container(
                                                    width: double.infinity,
                                                    child: (order?.receipt) !=
                                                            null
                                                        ? CachedNetworkImage(
                                                            imageUrl: order
                                                                    ?.receipt ??
                                                                "",
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Icon(Icons.image)),
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                                border: Border.all(),
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                color: AppConst.lightGrey),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    InkWell(
                                      highlightColor: AppConst.grey,
                                      onTap: (() {
                                        if (order?.status == "pending" ||
                                            (order?.orderType == "receipt")) {
                                          Get.to(HistoryOrderItems(
                                            order: order,
                                            TimeSlot: TimeSlot,
                                          ));
                                        } else if ((order?.status ==
                                                "picked_up" ||
                                            (order?.status == "accepted") ||
                                            (order?.status == "ready") &&
                                                (order?.total ?? 0) > 0)) {
                                          log("payment method ontap");
                                        } else {
                                          log("order paid ");
                                        }
                                        ;
                                      }),
                                      child: Container(
                                        height: 6.h,
                                        margin: EdgeInsets.only(top: 1.h),
                                        decoration: BoxDecoration(
                                            color: (order?.status ==
                                                        "pending" ||
                                                    (order?.orderType ==
                                                        "receipt"))
                                                ? AppConst.lightGreen
                                                : ((order?.status ==
                                                                "picked_up" ||
                                                            (order?.status ==
                                                                "accepted") ||
                                                            (order?.status ==
                                                                    "ready") &&
                                                                (order?.total ??
                                                                        0) >
                                                                    0) &&
                                                        (order?.orderType !=
                                                            "receipt")
                                                    ? AppConst.lightGreen
                                                    : AppConst.grey),
                                            border: Border.all(),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Center(
                                          child: (order?.status == "pending" ||
                                                  (order?.orderType ==
                                                      "receipt"))
                                              ? Text(
                                                  "View Items",
                                                  style: TextStyle(
                                                    color:
                                                        AppConst.ContainerColor,
                                                    fontSize: SizeUtils
                                                            .horizontalBlockSize *
                                                        4.5,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                )
                                              : ((order?.status ==
                                                              "picked_up" ||
                                                          (order?.status ==
                                                              "accepted") ||
                                                          (order?.status ==
                                                                  "ready") &&
                                                              (order?.total ??
                                                                      0) >
                                                                  0) &&
                                                      (order?.orderType !=
                                                          "receipt")
                                                  ? Text(
                                                      (modifiedOrReplacedItemCount >
                                                              0)
                                                          ? "Verify Items and Pay \u{20B9} ${order?.total ?? 0}"
                                                          : "Pay \u{20B9} ${order?.total ?? 0}",
                                                      style: TextStyle(
                                                        color: AppConst
                                                            .ContainerColor,
                                                        fontSize: SizeUtils
                                                                .horizontalBlockSize *
                                                            4.5,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    )
                                                  : Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.check,
                                                          size: 3.h,
                                                          color: AppConst.white,
                                                        ),
                                                        SizedBox(
                                                          width: 1.w,
                                                        ),
                                                        Text("Order Paid ",
                                                            style: TextStyle(
                                                              color: AppConst
                                                                  .white,
                                                              fontSize: SizeUtils
                                                                      .horizontalBlockSize *
                                                                  4.5,
                                                              fontFamily:
                                                                  'MuseoSans',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                            )),
                                                      ],
                                                    )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          (order?.rider != null)
                              ? Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 3.w, vertical: 1.h),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 6.h,
                                        width: 12.w,
                                        child: Center(
                                            child: Text(
                                          "${order?.rider?.firstName?.substring(0, 1) ?? "R"}",
                                          style: TextStyle(
                                              color: AppConst.white,
                                              fontSize: SizeUtils
                                                      .horizontalBlockSize *
                                                  5,
                                              fontWeight: FontWeight.bold),
                                        )),
                                        decoration: BoxDecoration(
                                            color: AppConst.blue,
                                            shape: BoxShape.circle),
                                      ),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${order?.rider?.firstName ?? ""} ${order?.rider?.last_name ?? ""}", // add rider last name
                                                style: TextStyle(
                                                    color: AppConst.black,
                                                    fontSize: SizeUtils
                                                            .horizontalBlockSize *
                                                        4,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              SizedBox(
                                                height: 0.5.h,
                                              ),
                                              Text(
                                                "Delivery Rider",
                                                style: TextStyle(
                                                    color: AppConst.grey,
                                                    fontSize: SizeUtils
                                                            .horizontalBlockSize *
                                                        3.5,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      InkWell(
                                          onTap: (() {
                                            _launchURL(
                                                "tel:${order?.rider?.mobile ?? ''}");
                                          }),
                                          child: CallLogo())
                                    ],
                                  ),
                                )
                              : SizedBox(),
                          (order?.rider != null)
                              ? Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 1.w),
                                  child: Divider(
                                    thickness: 1,
                                  ),
                                )
                              : SizedBox(),
                          InkWell(
                            highlightColor: AppConst.highLightColor,
                            onTap: () {
                              _chatController.launchChat(
                                  '${order?.Id}', "${order?.store?.name}");
                            },
                            child: StoreChatBubble(
                              text: "Facing any issues?\nTell us your issue.",
                              buttonText: "Chat With us",
                            ),
                          ),
                          StoreNameCallLogoWidget(
                            logoLetter: order?.store?.name?.substring(0, 1),
                            storeName: order?.store?.name,
                            totalAmount: order?.total,
                            paymentStatus:
                                "Paid", // updated the status to Dynamic
                            mobile: order?.store?.mobile,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 9.w),
                            child: Row(
                              // mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                    height: 3.h,
                                    child: FittedBox(
                                        child: Text(
                                      "|\n|\n|",
                                      style: TextStyle(
                                          color: AppConst.black,
                                          fontSize:
                                              SizeUtils.horizontalBlockSize * 4,
                                          fontWeight: FontWeight.bold),
                                    ))),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 3.w, right: 3.w, bottom: 1.h),
                            child: Row(
                              children: [
                                Container(
                                  height: 6.h,
                                  width: 12.w,
                                  child: Center(
                                    child: Icon(
                                      Icons.home,
                                      color: AppConst.white,
                                      size: 4.h,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      color: AppConst.green,
                                      shape: BoxShape.circle),
                                ),
                                SizedBox(
                                  width: 3.w,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Home",
                                          style: TextStyle(
                                              color: AppConst.black,
                                              fontSize: SizeUtils
                                                      .horizontalBlockSize *
                                                  4,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 0.5.h,
                                        ),
                                        Container(
                                          width: 70.w,
                                          child: Text(
                                            "${order?.address ?? ""}", // add cutomer full address that we selct at the time of placing the order
                                            // "Address, ABC Colony, Hyderabad, Telangana ",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: AppConst.grey,
                                                fontSize: SizeUtils
                                                        .horizontalBlockSize *
                                                    3.5,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding ViewOrderDetailsTextfeilds(String? text, String? amount) {
    return Padding(
      padding: EdgeInsets.only(top: 1.h, bottom: 1.h, right: 3.w, left: 3.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text ?? "Total Orders",
              style: TextStyle(
                fontFamily: 'MuseoSans',
                color: AppConst.black,
                fontSize: SizeUtils.horizontalBlockSize * 4,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
              )),
          Text("${amount ?? "0"}",
              style: TextStyle(
                fontFamily: 'MuseoSans',
                color: AppConst.black,
                fontSize: SizeUtils.horizontalBlockSize * 4,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
              )),
        ],
      ),
    );
  }
}

class Distance_store_home_separator extends StatelessWidget {
  const Distance_store_home_separator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppConst.grey, width: 0.8)),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Center(
              child: Icon(
                Icons.arrow_downward_outlined,
                size: 2.5.h,
                color: AppConst.grey,
              ),
            ),
          ),
        ),
        SizedBox(
            height: 4.h,
            child: FittedBox(
                child: Text(
              "|\n|\n|\n|",
              style: TextStyle(
                  color: AppConst.black,
                  fontSize: SizeUtils.horizontalBlockSize * 4,
                  fontWeight: FontWeight.bold),
            ))),
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppConst.grey, width: 0.8)),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Center(
              child: Icon(
                Icons.arrow_upward_outlined,
                size: 2.5.h,
                color: AppConst.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

void _launchURL(url) async {
  if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
}
