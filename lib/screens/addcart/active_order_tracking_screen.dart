import 'dart:developer';

import 'package:badges/badges.dart';
import 'package:bubble/bubble.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/data/model/active_order_model.dart';
import 'package:customer_app/app/ui/pages/chat/chat_controller.dart';
import 'package:customer_app/app/ui/pages/chat/freshchat_controller.dart';
import 'package:customer_app/app/ui/pages/signIn/phone_authentication_screen.dart';
import 'package:customer_app/app/ui/pages/stores/storedetailscreen.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/screens/addcart/Widgets/store_name_call_logo.dart';
import 'package:customer_app/screens/addcart/controller/addcart_controller.dart';
import 'package:customer_app/screens/addcart/my_order_item_page.dart';
import 'package:customer_app/screens/history/history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class ActiveOrderTrackingScreen extends StatelessWidget {
  final ActiveOrderData? activeOrder;
  final ChatController _chatController = Get.find();
  final freshChatController _freshChat = Get.find();
  final AddCartController _addCartController = Get.find();
  ActiveOrderTrackingScreen({
    Key? key,
    this.activeOrder,
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

    var date0 = "${activeOrder?.deliverySlot?.day ?? 0}";
    var DayName = DaySelection(int.parse(date0));
    var date1 =
        "${((activeOrder?.deliverySlot?.startTime?.hour ?? 0) > 12 ? ((activeOrder?.deliverySlot?.startTime?.hour ?? 0) - 12) : activeOrder?.deliverySlot?.startTime?.hour ?? 0)}${(activeOrder?.deliverySlot?.startTime?.minute == 0) ? "" : (":${activeOrder?.deliverySlot?.startTime?.minute ?? ""}")}";

    var date2 = (activeOrder?.deliverySlot?.startTime?.hour ?? 0) > 12
        ? "pm - "
        : "am - ";
    var date3 =
        "${((activeOrder?.deliverySlot?.endTime?.hour ?? 0) > 12 ? ((activeOrder?.deliverySlot?.endTime?.hour ?? 0) - 12) : activeOrder?.deliverySlot?.endTime?.hour ?? 0)}${(activeOrder?.deliverySlot?.endTime?.minute == 0) ? "" : (":${activeOrder?.deliverySlot?.endTime?.minute ?? ""}")}";
    var date4 =
        (activeOrder?.deliverySlot?.endTime?.hour ?? 0) > 12 ? "pm" : "am";

    var TimeSlot = DayName + " " + date1 + date2 + date3 + date4;

    var modifiedOrReplacedItemCount = ((activeOrder?.products
                ?.where((c) => c.status == "modified")
                .toList()
                .length ??
            0) +
        (activeOrder?.rawItems
                ?.where((c) => c.status == "modified")
                .toList()
                .length ??
            0) +
        (activeOrder?.inventories
                ?.where((c) => c.status == "modified")
                .toList()
                .length ??
            0) +
        (activeOrder?.products
                ?.where((c) => c.status == "replaced")
                .toList()
                .length ??
            0) +
        (activeOrder?.rawItems
                ?.where((c) => c.status == "replaced")
                .toList()
                .length ??
            0) +
        (activeOrder?.inventories
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
                Row(
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
                              "Order ID: xxx${activeOrder?.Id?.substring((activeOrder?.Id?.length ?? 10) - 10) ?? ""}",
                              style: TextStyle(
                                  fontSize: SizeUtils.horizontalBlockSize * 4,
                                  fontWeight: FontWeight.bold,
                                  color: AppConst.black)),
                          SizedBox(height: 0.5.h),
                          (activeOrder?.orderType == "receipt")
                              ? SizedBox()
                              : RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Delivery Slot: ${TimeSlot} ",
                                        // "Delivery Slot: 9am - 8pm", var date1 =
                                        // "${(].startTime?.hour ?? 0) > 12 ? ((..startTime?.hour ?? 0) - 12) : _addCartController.getOrderConfirmPageDataModel.value?.oller.dayIndexForTimeSlot.value].slots?[index].startTime?.hour}:${_addCartController.getOrderConfirmPageDataModel.value?.data?.deliverySlots?[_addCartController.dayIndexForTimeSlot.value].slots?[index].startTime?.minute}";

                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'MuseoSans',
                                          fontSize:
                                              SizeUtils.horizontalBlockSize *
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
                            "Have a problem with order \n${activeOrder?.Id}\n${activeOrder?.status}\n${activeOrder?.createdAt}\n${activeOrder?.address}\n");
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
                                  fontSize: SizeUtils.horizontalBlockSize * 3.7,
                                  fontWeight: FontWeight.bold,
                                  color: AppConst.black)),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: (activeOrder?.rider != null) ? 5.h : 3.h,
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
                                        fontSize:
                                            SizeUtils.horizontalBlockSize * 4,
                                        fontWeight: FontWeight.bold,
                                        color: AppConst.black)),
                                TextSpan(
                                    text: "${activeOrder?.status ?? ""}",
                                    style: TextStyle(
                                      color: AppConst.green,
                                      fontSize:
                                          SizeUtils.horizontalBlockSize * 4,
                                      fontWeight: FontWeight.w500,
                                    ))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    ((activeOrder?.status == "accepted")
                        ? Padding(
                            padding: EdgeInsets.only(left: 5.w, bottom: 1.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Please Review the list and approve.",
                                  style: TextStyle(
                                      fontSize:
                                          SizeUtils.horizontalBlockSize * 4,
                                      fontWeight: FontWeight.w500,
                                      color: AppConst.black),
                                ),
                              ],
                            ),
                          )
                        : (activeOrder?.rider != null)
                            ? SizedBox()
                            : Padding(
                                padding:
                                    EdgeInsets.only(left: 5.w, bottom: 1.h),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Rider is Not Assigned yet",
                                      style: TextStyle(
                                          fontSize:
                                              SizeUtils.horizontalBlockSize * 4,
                                          fontWeight: FontWeight.w500,
                                          color: AppConst.black),
                                    ),
                                  ],
                                ),
                              )),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                      child: Container(
                        height: (activeOrder?.status != "") ? 30.h : 27.h,
                        decoration: BoxDecoration(
                            color: AppConst.ContainerColor,
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 3.w, vertical: 1.h),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(MyOrderItems(
                                    activeOrder: activeOrder,
                                    TimeSlot: TimeSlot,
                                  ));
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 0.5.h),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "View Items",
                                        style: TextStyle(
                                          color: AppConst.lightGreen,
                                          fontSize:
                                              SizeUtils.horizontalBlockSize * 4,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 1.w,
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: AppConst.lightGreen,
                                        size: 2.h,
                                      )
                                    ],
                                  ),
                                ),
                              ),
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
                                          "Total Amount- \u{20B9} ${activeOrder?.total ?? 0}",
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
                                          (activeOrder?.orderType == "receipt")
                                              ? "Cashback - ${activeOrder?.cashback_percentage ?? 0}%"
                                              : "Cashback- \u{20B9} ${activeOrder?.total_cashback ?? 0}",
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
                                          (activeOrder?.orderType == "receipt")
                                              ? "Earned Cashback- \u{20B9} ${activeOrder?.total_cashback ?? 0}"
                                              : "Amount Paid- \u{20B9} ${activeOrder?.total ?? 0}",
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
                                        //   "Total Amount - \u{20B9} ${activeOrder?.total ?? 0}",
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
                                                            activeOrder
                                                                    ?.receipt ??
                                                                ""),
                                                    tightMode: true,
                                                    customSize:
                                                        Size(98.w, 98.h),
                                                    backgroundDecoration:
                                                        BoxDecoration(
                                                            color:
                                                                AppConst.black),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child:
                                                        CircularCloseButton(),
                                                  )
                                                ],
                                              ),
                                            ));
                                          },
                                          child: Container(
                                              width: double.infinity,
                                              child:
                                                  (activeOrder?.receipt) != null
                                                      ? CachedNetworkImage(
                                                          imageUrl: activeOrder
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
                                  if (activeOrder?.status == "pending" ||
                                      (activeOrder?.orderType == "receipt")) {
                                    Get.to(MyOrderItems(
                                      activeOrder: activeOrder,
                                      TimeSlot: TimeSlot,
                                    ));
                                  } else if ((activeOrder?.status ==
                                          "picked_up" ||
                                      (activeOrder?.status == "accepted") ||
                                      (activeOrder?.status == "ready") &&
                                          (activeOrder?.total ?? 0) > 0)) {
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
                                      color: (activeOrder?.status ==
                                                  "pending" ||
                                              (activeOrder?.orderType ==
                                                  "receipt"))
                                          ? AppConst.lightGreen
                                          : ((activeOrder?.status ==
                                                          "picked_up" ||
                                                      (activeOrder?.status ==
                                                          "accepted") ||
                                                      (activeOrder?.status ==
                                                              "ready") &&
                                                          (activeOrder?.total ??
                                                                  0) >
                                                              0) &&
                                                  (activeOrder?.orderType !=
                                                      "receipt")
                                              ? AppConst.lightGreen
                                              : AppConst.grey),
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: (activeOrder?.status == "pending" ||
                                            (activeOrder?.orderType ==
                                                "receipt"))
                                        ? Text(
                                            "View Items",
                                            style: TextStyle(
                                              color: AppConst.ContainerColor,
                                              fontSize: SizeUtils
                                                      .horizontalBlockSize *
                                                  4.5,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        : ((activeOrder?.status ==
                                                        "picked_up" ||
                                                    (activeOrder?.status ==
                                                        "accepted") ||
                                                    (activeOrder?.status ==
                                                            "ready") &&
                                                        (activeOrder?.total ??
                                                                0) >
                                                            0) &&
                                                (activeOrder?.orderType !=
                                                    "receipt")
                                            ? Text(
                                                (modifiedOrReplacedItemCount >
                                                        0)
                                                    ? "Verify Items and Pay \u{20B9} ${activeOrder?.total ?? 0}"
                                                    : "Pay \u{20B9} ${activeOrder?.total ?? 0}",
                                                style: TextStyle(
                                                  color:
                                                      AppConst.ContainerColor,
                                                  fontSize: SizeUtils
                                                          .horizontalBlockSize *
                                                      4.5,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
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
                                                        color: AppConst.white,
                                                        fontSize: SizeUtils
                                                                .horizontalBlockSize *
                                                            4.5,
                                                        fontFamily: 'MuseoSans',
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontStyle:
                                                            FontStyle.normal,
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
                    (activeOrder?.rider != null)
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
                                    "${activeOrder?.rider?.firstName?.substring(0, 1) ?? "R"}",
                                    style: TextStyle(
                                        color: AppConst.white,
                                        fontSize:
                                            SizeUtils.horizontalBlockSize * 5,
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${activeOrder?.rider?.firstName ?? ""} ${activeOrder?.rider?.last_name ?? ""}", // add rider last name
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
                                        Text(
                                          "Delivery Rider",
                                          style: TextStyle(
                                              color: AppConst.grey,
                                              fontSize: SizeUtils
                                                      .horizontalBlockSize *
                                                  3.5,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Spacer(),
                                InkWell(
                                    onTap: (() {
                                      _launchURL(
                                          "tel:${activeOrder?.rider?.mobile ?? ''}");
                                    }),
                                    child: CallLogo())
                              ],
                            ),
                          )
                        : SizedBox(),
                    (activeOrder?.rider != null)
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 1.w),
                            child: Divider(
                              thickness: 1,
                            ),
                          )
                        : SizedBox(),
                    InkWell(
                      highlightColor: AppConst.highLightColor,
                      onTap: () {
                        _chatController.launchChat('${activeOrder?.Id}',
                            "${activeOrder?.store?.name}");
                      },
                      child: StoreChatBubble(
                        text: "Facing any issues?\nTell us your issue.",
                        buttonText: "Chat With us",
                      ),
                    ),
                    StoreNameCallLogoWidget(
                      logoLetter: activeOrder?.store?.name?.substring(0, 1),
                      storeName: activeOrder?.store?.name,
                      totalAmount: activeOrder?.total,
                      paymentStatus: "Paid", // updated the status to Dynamic
                      mobile: activeOrder?.store?.mobile,
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
                                    fontSize: SizeUtils.horizontalBlockSize * 4,
                                    fontWeight: FontWeight.bold),
                              ))),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 3.w, right: 3.w, bottom: 1.h),
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
                                color: AppConst.green, shape: BoxShape.circle),
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Home",
                                    style: TextStyle(
                                        color: AppConst.black,
                                        fontSize:
                                            SizeUtils.horizontalBlockSize * 4,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 0.5.h,
                                  ),
                                  Container(
                                    width: 70.w,
                                    child: Text(
                                      "${activeOrder?.address ?? ""}", // add cutomer full address that we selct at the time of placing the order
                                      // "Address, ABC Colony, Hyderabad, Telangana ",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: AppConst.grey,
                                          fontSize:
                                              SizeUtils.horizontalBlockSize *
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
