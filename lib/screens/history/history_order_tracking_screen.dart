import 'dart:async';
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
import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/screens/addcart/Widgets/store_name_call_logo.dart';
import 'package:customer_app/screens/addcart/controller/addcart_controller.dart';
import 'package:customer_app/screens/addcart/my_order_item_page.dart';
import 'package:customer_app/screens/addcart/order_sucess_screen.dart';
import 'package:customer_app/screens/base_screen.dart';
import 'package:customer_app/screens/history/history_order_items_page.dart';
import 'package:customer_app/screens/history/history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class HistoryOrderTrackingScreen extends StatefulWidget {
  final OrderData? order;
  String? type;

  HistoryOrderTrackingScreen({Key? key, this.order, this.type})
      : super(key: key);

  @override
  State<HistoryOrderTrackingScreen> createState() =>
      _HistoryOrderTrackingScreenState();
}

class _HistoryOrderTrackingScreenState
    extends State<HistoryOrderTrackingScreen> {
  final ChatController _chatController = Get.find();

  final freshChatController _freshChat = Get.find();

  final AddCartController _addCartController = Get.find();
  late Razorpay _razorpay;
  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    //todo handle paymentError
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    //if the payment is success checkout
    postOrderCustomerCollectAmount(response: response);
    //todo handle PaymentSuccess
  }

  void postOrderCustomerCollectAmount(
      {PaymentSuccessResponse? response}) async {
    await _addCartController.postOrderCustomerCollectAmount(
        razorPayPaymentId: response?.paymentId ?? '',
        razorPayOrderId: response?.orderId ?? '',
        razorPaySignature: response?.signature ?? '',
        orderId: widget.order?.Id ?? "");

    if (_addCartController.orderModel.value != null) {
      // _addCartController.formatDate();
      // await Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(
      //         builder: (BuildContext context) => OrderSucessScreen(
      //               order: _addCartController.orderModel.value!,
      //               type: "order",
      //             )),
      //     (Route<dynamic> route) => route.isFirst);
      // _addCartController.refresh();
      // _homeController.apiCall();
      // Get.back();
    } else {
      Get.to(
          OrderFailScreen(
            order: _addCartController.orderModel.value!,
            type: "order",
          ),
          transition: Transition.fadeIn);
      Timer(Duration(seconds: 2), () {
        Get.offAllNamed(AppRoutes.BaseScreen);
      });
    }
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    //todo handle external wallets
  }

  @override
  Widget build(BuildContext context) {
    // DaySelection(int index) {
    //   var day = _addCartController.weekDayList[index].day
    //       .toString()
    //       .substring(0, 3)
    //       .toUpperCase();
    //   return day;
    // }

    List Weekdays = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"];

    var date0 = "${widget.order?.deliverySlot?.day ?? 0}";
    // var DayName = DaySelection(int.parse(date0));
    var DayName = Weekdays[int.parse(date0)];
    var date1 =
        "${((widget.order?.deliverySlot?.startTime?.hour ?? 0) > 12 ? ((widget.order?.deliverySlot?.startTime?.hour ?? 0) - 12) : widget.order?.deliverySlot?.startTime?.hour ?? 0)}${(widget.order?.deliverySlot?.startTime?.minute == 0) ? "" : (":${widget.order?.deliverySlot?.startTime?.minute ?? ""}")}";

    var date2 = (widget.order?.deliverySlot?.startTime?.hour ?? 0) > 12
        ? "pm - "
        : "am - ";
    var date3 =
        "${((widget.order?.deliverySlot?.endTime?.hour ?? 0) > 12 ? ((widget.order?.deliverySlot?.endTime?.hour ?? 0) - 12) : widget.order?.deliverySlot?.endTime?.hour ?? 0)}${(widget.order?.deliverySlot?.endTime?.minute == 0) ? "" : (":${widget.order?.deliverySlot?.endTime?.minute ?? ""}")}";
    var date4 =
        (widget.order?.deliverySlot?.endTime?.hour ?? 0) > 12 ? "pm" : "am";

    var TimeSlot = DayName + " " + date1 + date2 + date3 + date4;

    var modifiedOrReplacedItemCount = ((widget.order?.products
                ?.where((c) => c.status == "modified")
                .toList()
                .length ??
            0) +
        (widget.order?.rawItems
                ?.where((c) => c.status == "modified")
                .toList()
                .length ??
            0) +
        (widget.order?.inventories
                ?.where((c) => c.status == "modified")
                .toList()
                .length ??
            0) +
        (widget.order?.products
                ?.where((c) => c.status == "replaced")
                .toList()
                .length ??
            0) +
        (widget.order?.rawItems
                ?.where((c) => c.status == "replaced")
                .toList()
                .length ??
            0) +
        (widget.order?.inventories
                ?.where((c) => c.status == "replaced")
                .toList()
                .length ??
            0));
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: AppConst.white,
          statusBarIconBrightness: Brightness.dark),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
              child: Column(
                children: [
                  ((widget.order?.orderType == "receipt" &&
                              widget.order?.status == "completed") ||
                          (widget.order?.orderType == "redeem_cash" &&
                              widget.order?.status == "completed"))
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            (widget.type == "order")
                                ? Container(
                                    width: 36,
                                    height: 36,
                                    child: GestureDetector(
                                      // color: Colors.white,
                                      onTap: (() =>
                                          Get.offAll(() => BaseScreen())),
                                      child: Icon(
                                        Icons.close,
                                        size:
                                            SizeUtils.horizontalBlockSize * 5.5,
                                        color: AppConst.black,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0x19000000),
                                          blurRadius: 4,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                      color: AppConst.white,
                                    ),
                                  )
                                : CircularCloseButton(),
                            SizedBox(width: 3.w),
                            Spacer(),
                            InkWell(
                              highlightColor: AppConst.highLightColor,
                              onTap: () async {
                                _freshChat.initState();
                                await _freshChat.showChatConversation(
                                    "Have a problem with order \n${widget.order?.Id}\n${widget.order?.status}\n${widget.order?.createdAt}\n${widget.order?.address}\n");
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
                                      "Order ID: xxx${widget.order?.Id?.substring((widget.order?.Id?.length ?? 10) - 10) ?? ""}",
                                      style: TextStyle(
                                          fontSize:
                                              SizeUtils.horizontalBlockSize * 4,
                                          fontWeight: FontWeight.bold,
                                          color: AppConst.black)),
                                  SizedBox(height: 0.5.h),
                                  (widget.order?.orderType == "receipt")
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
                                    "Have a problem with order \n${widget.order?.Id}\n${widget.order?.status}\n${widget.order?.createdAt}\n${widget.order?.address}\n");
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
                                              SizeUtils.horizontalBlockSize *
                                                  3.7,
                                          fontWeight: FontWeight.bold,
                                          color: AppConst.black)),
                                ],
                              ),
                            ),
                          ],
                        ),
                  (widget.order?.status == "delivered" ||
                          ((widget.order?.orderType == "receipt" &&
                                  widget.order?.status == "completed") ||
                              (widget.order?.orderType == "redeem_cash" &&
                                  widget.order?.status == "completed")))
                      ? Column(
                          children: [
                            SizedBox(
                              height: 3.h,
                            ),
                            (widget.order?.orderType == "redeem_cash" &&
                                    widget.order?.status == "completed")
                                ? Text("Refunded Successfully",
                                    style: TextStyle(
                                        fontSize:
                                            SizeUtils.horizontalBlockSize * 4.4,
                                        fontFamily: 'MuseoSans',
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                        color: AppConst.black))
                                : Text(
                                    (widget.order?.orderType == "receipt" &&
                                            widget.order?.status == "completed")
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
                              "Order ID: xxx${widget.order?.Id?.substring((widget.order?.Id?.length ?? 10) - 10) ?? ""}",
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            ((widget.order?.total_cashback ??
                                                        0) >
                                                    0)
                                                ? TextSpan(
                                                    text: "\nWe've added ",
                                                    style: TextStyle(
                                                      color: Color(0xff003d29),
                                                      fontSize: SizeUtils
                                                              .horizontalBlockSize *
                                                          3.7,
                                                      fontFamily: 'MuseoSans',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                    ),
                                                  )
                                                : TextSpan(),
                                            ((widget.order?.total_cashback ??
                                                        0) >
                                                    0)
                                                ? TextSpan(
                                                    text:
                                                        "\u{20B9}${widget.order?.total_cashback ?? 0} cashback",
                                                    style: TextStyle(
                                                      color: Color(0xff003d29),
                                                      fontSize: SizeUtils
                                                              .horizontalBlockSize *
                                                          3.7,
                                                      fontFamily: 'MuseoSans',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                    ),
                                                  )
                                                : TextSpan(),
                                            ((widget.order?.total_cashback ??
                                                        0) >
                                                    0)
                                                ? TextSpan(
                                                    text: " to your\nwallet.",
                                                    style: TextStyle(
                                                      color: Color(0xff003d29),
                                                      fontSize: SizeUtils
                                                              .horizontalBlockSize *
                                                          3.7,
                                                      fontFamily: 'MuseoSans',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontStyle:
                                                          FontStyle.normal,
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
                              logoLetter:
                                  widget.order?.store?.name?.substring(0, 1),
                              storeName: widget.order?.store?.name,
                              totalAmount: widget.order?.wallet_amount,
                              paymentStatus:
                                  "Redeem", // updated the status to Dynamic
                              mobile: widget.order?.store?.mobile,
                              callLogo: false,
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            (widget.order?.orderType == "receipt" &&
                                    widget.order?.status == "completed")
                                ? SizedBox()
                                : Container(
                                    height: 0.7.h,
                                    color: AppConst.veryLightGrey,
                                  ),
                            ((widget.order?.orderType == "receipt" &&
                                        widget.order?.status == "completed") ||
                                    (widget.order?.orderType == "redeem_cash" &&
                                        widget.order?.status == "completed"))
                                ? SizedBox()
                                : Padding(
                                    padding: EdgeInsets.only(
                                        left: 5.w, top: 1.h, bottom: 1.h),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child:
                                              Distance_store_home_separator(),
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
                                                          "${widget.order?.store?.name ?? ""}  ",
                                                      style: TextStyle(
                                                        fontFamily: 'MuseoSans',
                                                        overflow: TextOverflow
                                                            .ellipsis,
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
                                                            "${widget.order?.store?.address?.address ?? ""}",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'MuseoSans',
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
                                                            "${widget.order?.address ?? ""}",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'MuseoSans',
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
                            ((widget.order?.orderType == "receipt" &&
                                        widget.order?.status == "completed") ||
                                    (widget.order?.orderType == "redeem_cash" &&
                                        widget.order?.status == "completed"))
                                ? SizedBox()
                                : Container(
                                    height: 0.7.h,
                                    color: AppConst.veryLightGrey,
                                  ),
                            ((widget.order?.orderType == "receipt" &&
                                        widget.order?.status == "completed") ||
                                    (widget.order?.orderType == "redeem_cash" &&
                                        widget.order?.status == "completed"))
                                ? SizedBox()
                                : Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 3.w, vertical: 2.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 6.h,
                                          width: 12.w,
                                          child: Center(
                                              child: Text(
                                            "${widget.order?.rider?.firstName?.substring(0, 1) ?? "R"}",
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
                                                  "${widget.order?.rider?.firstName ?? "Rider"} ${widget.order?.rider?.last_name ?? ""}", // add rider last name
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
                                      (widget.order?.orderType ==
                                                  "redeem_cash" &&
                                              widget.order?.status ==
                                                  "completed")
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
                                              (widget.order?.orderType ==
                                                          "receipt" &&
                                                      widget.order?.status ==
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
                                (widget.order?.orderType == "redeem_cash" &&
                                        widget.order?.status == "completed")
                                    ? ViewOrderDetailsTextfeilds(
                                        "Previous Amount",
                                        "\u{20B9}${widget.order?.previous_total ?? 0}")
                                    : (widget.order?.orderType == "receipt" &&
                                            widget.order?.status == "completed")
                                        ? ViewOrderDetailsTextfeilds(
                                            "Total Amount",
                                            "\u{20B9}${widget.order?.total ?? 0}")
                                        : ViewOrderDetailsTextfeilds(
                                            "Total Amount",
                                            "\u{20B9}${widget.order?.total ?? 0}"),
                                Container(
                                  height: 0.5,
                                  color: AppConst.lightGrey,
                                ),
                                (widget.order?.orderType == "redeem_cash" &&
                                        widget.order?.status == "completed")
                                    ? ViewOrderDetailsTextfeilds(
                                        "Redeem Amount",
                                        "\u{20B9}${widget.order?.wallet_amount ?? 0}")
                                    : (widget.order?.orderType == "receipt" &&
                                            widget.order?.status == "completed")
                                        ? ViewOrderDetailsTextfeilds(
                                            "Cashback percentage",
                                            "${widget.order?.cashback_percentage ?? 0}%")
                                        : ViewOrderDetailsTextfeilds("CashBack",
                                            "\u{20B9}${widget.order?.total_cashback ?? 0}"),
                                Container(
                                  height: 0.5,
                                  color: AppConst.lightGrey,
                                ),
                                (widget.order?.orderType == "redeem_cash" &&
                                        widget.order?.status == "completed")
                                    ? ViewOrderDetailsTextfeilds(
                                        "Current Amount",
                                        "\u{20B9}${widget.order?.total ?? 0}")
                                    : (widget.order?.orderType == "receipt" &&
                                            widget.order?.status == "completed")
                                        ? ViewOrderDetailsTextfeilds(
                                            "Earned Cashback",
                                            "\u{20B9}${widget.order?.total_cashback ?? 0}")
                                        : ViewOrderDetailsTextfeilds(
                                            "Amount Paid",
                                            "\u{20B9}${widget.order?.total_cashback ?? 0}"),
                                Container(
                                  height: 0.5,
                                  color: AppConst.lightGrey,
                                ),
                                Container(
                                  height: 0.5,
                                  color: AppConst.lightGrey,
                                ),
                                (widget.order?.orderType == "redeem_cash" &&
                                        widget.order?.status == "completed")
                                    ? SizedBox()
                                    : InkWell(
                                        onTap: () {
                                          Get.to(HistoryOrderItems(
                                            order: widget.order,
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
                                (widget.order?.orderType == "redeem_cash" &&
                                        widget.order?.status == "completed")
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
                                                                    widget.order
                                                                            ?.receipt ??
                                                                        ""),
                                                            tightMode: true,
                                                            customSize: Size(
                                                                98.w, 98.h),
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
                                                            color: Color(
                                                                0xff005b41),
                                                            fontSize: SizeUtils
                                                                    .horizontalBlockSize *
                                                                3.5,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontStyle: FontStyle
                                                                .normal,
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
                              height: (widget.order?.rider != null) ? 5.h : 3.h,
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
                                            text:
                                                "${widget.order?.status ?? ""}",
                                            style: TextStyle(
                                              color: AppConst.green,
                                              fontSize: SizeUtils
                                                      .horizontalBlockSize *
                                                  4,
                                              fontWeight: FontWeight.w500,
                                            ))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ((widget.order?.status == "accepted")
                                ? Padding(
                                    padding:
                                        EdgeInsets.only(left: 5.w, bottom: 1.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Please Review the list and approve.",
                                          style: TextStyle(
                                              fontSize: SizeUtils
                                                      .horizontalBlockSize *
                                                  4,
                                              fontWeight: FontWeight.w500,
                                              color: AppConst.black),
                                        ),
                                      ],
                                    ),
                                  )
                                : (widget.order?.rider != null)
                                    ? SizedBox()
                                    : Padding(
                                        padding: EdgeInsets.only(
                                            left: 5.w, bottom: 1.h),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Reviewing and Approving the receipt",
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
                                height: (widget.order?.status != "pending" &&
                                        widget.order?.orderType != "receipt")
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
                                      (widget.order?.status != "pending" &&
                                              widget.order?.orderType !=
                                                  "receipt")
                                          ? InkWell(
                                              onTap: () {
                                                Get.to(HistoryOrderItems(
                                                  order: widget.order,
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
                                                      color:
                                                          AppConst.lightGreen,
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
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          AppConst.lightGreen),
                                                ),
                                                SizedBox(
                                                  height: 1.5.h,
                                                ),
                                                Text(
                                                  "Total Amount- \u{20B9} ${widget.order?.total ?? 0}",
                                                  style: TextStyle(
                                                      fontSize: SizeUtils
                                                              .horizontalBlockSize *
                                                          4,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppConst.white),
                                                ),
                                                SizedBox(
                                                  height: 0.5.h,
                                                ),
                                                Text(
                                                  (widget.order?.orderType ==
                                                          "receipt")
                                                      ? "Cashback - \u{20B9} ${widget.order?.cashback_percentage ?? 0}%"
                                                      : "Cashback- \u{20B9} ${widget.order?.final_payable_wallet_amount?.toStringAsFixed(2) ?? 0}", //final
                                                  style: TextStyle(
                                                      fontSize: SizeUtils
                                                              .horizontalBlockSize *
                                                          4,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppConst.white),
                                                ),
                                                SizedBox(
                                                  height: 0.5.h,
                                                ),
                                                Text(
                                                  (widget.order?.orderType ==
                                                          "receipt")
                                                      ? "Earned Cashback- \u{20B9} ${widget.order?.total_cashback ?? 0}"
                                                      : "Amount Paid- \u{20B9} ${widget.order?.iPayment ?? 0}", //ipayment
                                                  style: TextStyle(
                                                      fontSize: SizeUtils
                                                              .horizontalBlockSize *
                                                          4,
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                            padding:
                                                EdgeInsets.only(top: 0.5.h),
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
                                                                    widget.order
                                                                            ?.receipt ??
                                                                        ""),
                                                            tightMode: true,
                                                            customSize: Size(
                                                                98.w, 98.h),
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
                                                      child: (widget.order
                                                                  ?.receipt) !=
                                                              null
                                                          ? CachedNetworkImage(
                                                              imageUrl: widget
                                                                      .order
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
                                        onTap: (() async {
                                          if (widget.order?.status ==
                                                  "pending" ||
                                              (widget.order?.orderType ==
                                                  "receipt")) {
                                            Get.to(HistoryOrderItems(
                                              order: widget.order,
                                              TimeSlot: TimeSlot,
                                            ));
                                          } else if (((widget.order?.status ==
                                                      "picked_up") ||
                                                  (widget.order?.status ==
                                                      "accepted") ||
                                                  (widget.order?.status ==
                                                      "ready")) &&
                                              ((widget.order
                                                          ?.final_payable_amount ??
                                                      0) >
                                                  0) &&
                                              (widget.order?.orderType !=
                                                  "receipt")) {
                                            log("payment method ontap");
                                            await _addCartController
                                                .createRazorPayOrder(
                                                    storeId: widget.order?.store
                                                            ?.sId ??
                                                        '',
                                                    amount: double.parse(widget
                                                            .order
                                                            ?.final_payable_amount
                                                            ?.toStringAsFixed(
                                                                2) ??
                                                        "0.0"));
                                            if (_addCartController
                                                    .createRazorpayResponseModel
                                                    .value !=
                                                null) {
                                              await launchPayment(
                                                      widget.order
                                                              ?.final_payable_amount
                                                              ?.toInt() ??
                                                          00,
                                                      _addCartController
                                                              .createRazorpayResponseModel
                                                              .value
                                                              ?.orderId ??
                                                          '')
                                                  .then((value) {
                                                if (value == true) {
                                                  postOrderCustomerCollectAmount();
                                                }
                                              });
                                            } else {
                                              Get.showSnackbar(GetBar(
                                                message:
                                                    "failed to create razor order",
                                                duration: Duration(seconds: 2),
                                              ));
                                            }

                                            // postOrderCustomerCollectAmount();
                                          } else {
                                            log("order paid ");
                                          }
                                          ;
                                        }),
                                        child: Container(
                                          height: 6.h,
                                          margin: EdgeInsets.only(top: 1.h),
                                          decoration: BoxDecoration(
                                              color: (widget.order?.status ==
                                                          "pending" ||
                                                      (widget.order?.orderType ==
                                                          "receipt"))
                                                  ? AppConst.lightGreen
                                                  : (((widget.order?.status ==
                                                                  "picked_up") ||
                                                              (widget.order
                                                                      ?.status ==
                                                                  "accepted") ||
                                                              (widget.order
                                                                      ?.status ==
                                                                  "ready")) &&
                                                          ((widget.order
                                                                      ?.final_payable_amount ??
                                                                  0) >
                                                              0) &&
                                                          (widget.order
                                                                  ?.orderType !=
                                                              "receipt")
                                                      ? AppConst.lightGreen
                                                      : AppConst.grey),
                                              border: Border.all(),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Center(
                                            child: (widget.order?.status ==
                                                        "pending" ||
                                                    (widget.order?.orderType ==
                                                        "receipt"))
                                                ? Text(
                                                    "View Items",
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
                                                : (((widget.order?.status ==
                                                                "picked_up") ||
                                                            (widget.order
                                                                    ?.status ==
                                                                "accepted") ||
                                                            (widget.order
                                                                    ?.status ==
                                                                "ready")) &&
                                                        ((widget.order
                                                                    ?.final_payable_amount ??
                                                                0) >
                                                            0) &&
                                                        (widget.order
                                                                ?.orderType !=
                                                            "receipt")
                                                    ? Text(
                                                        (modifiedOrReplacedItemCount >
                                                                    0 ||
                                                                (widget.order
                                                                            ?.final_payable_amount ??
                                                                        0) >
                                                                    0)
                                                            ? "Verify Items and Pay \u{20B9} ${widget.order?.final_payable_amount ?? 0}"
                                                            : "Pay \u{20B9} ${widget.order?.final_payable_amount ?? 0}", //pay 0 disable the button
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
                                                            color:
                                                                AppConst.white,
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
                            (widget.order?.rider != null)
                                ? Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 3.w, vertical: 1.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 6.h,
                                          width: 12.w,
                                          child: Center(
                                              child: Text(
                                            "${widget.order?.rider?.firstName?.substring(0, 1) ?? "R"}",
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
                                                  "${widget.order?.rider?.firstName ?? ""} ${widget.order?.rider?.last_name ?? ""}", // add rider last name
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
                                                  "tel:${widget.order?.rider?.mobile ?? ''}");
                                            }),
                                            child: CallLogo())
                                      ],
                                    ),
                                  )
                                : SizedBox(),
                            (widget.order?.rider != null)
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
                                    '${widget.order?.Id}',
                                    "${widget.order?.store?.name}");
                              },
                              child: StoreChatBubble(
                                text: "Facing any issues?\nTell us your issue.",
                                buttonText: "Chat With us",
                              ),
                            ),
                            StoreNameCallLogoWidget(
                              logoLetter:
                                  widget.order?.store?.name?.substring(0, 1),
                              storeName: widget.order?.store?.name,
                              totalAmount: widget.order?.total,
                              paymentStatus:
                                  "Paid", // updated the status to Dynamic
                              mobile: widget.order?.store?.mobile,
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
                                                SizeUtils.horizontalBlockSize *
                                                    4,
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
                                              "${widget.order?.address ?? ""}", // add cutomer full address that we selct at the time of placing the order
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

  Future<bool> launchPayment(int amount, String orderId) async {
    var options = {
      'key': 'rzp_test_n1q5GFiD3BLkNw', //'rzp_test_K5F950Y92Z3p6X',
      'amount': (amount * 100),
      'order_id': orderId,
      'name': 'Seeya',
      'prefill': {'contact': '9876543210', 'email': 'ujjwolmainali7@gmail.com'},
      'external': {'wallets': []}
    };

    try {
      _razorpay.open(options);
      return true;
    } catch (e) {
      log('e :$e');
      return false;
    }
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
