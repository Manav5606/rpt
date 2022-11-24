import 'package:badges/badges.dart';
import 'package:bubble/bubble.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/data/model/active_order_model.dart';
import 'package:customer_app/app/ui/pages/chat/chat_controller.dart';
import 'package:customer_app/app/ui/pages/chat/freshchat_controller.dart';
import 'package:customer_app/app/ui/pages/signIn/phone_authentication_screen.dart';
import 'package:customer_app/app/ui/pages/stores/storedetailscreen.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/screens/addcart/Widgets/store_name_call_logo.dart';
import 'package:customer_app/screens/addcart/controller/addcart_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
        "${((activeOrder?.deliverySlot?.startTime?.hour ?? 0) > 12 ? ((activeOrder?.deliverySlot?.startTime?.hour ?? 0) - 12) : activeOrder?.deliverySlot?.startTime?.hour ?? 0)}:${activeOrder?.deliverySlot?.startTime?.minute ?? 00}";

    var date2 = (activeOrder?.deliverySlot?.startTime?.hour ?? 0) > 1
        ? "PM - "
        : "AM - ";
    var date3 =
        "${((activeOrder?.deliverySlot?.endTime?.hour ?? 0) > 12 ? ((activeOrder?.deliverySlot?.endTime?.hour ?? 0) - 12) : activeOrder?.deliverySlot?.endTime?.hour ?? 0)}:${activeOrder?.deliverySlot?.endTime?.minute ?? 00}";
    var date4 =
        (activeOrder?.deliverySlot?.endTime?.hour ?? 0) > 12 ? "PM" : "AM";

    var TimeSlot = DayName + " " + date1 + date2 + date3 + date4;
    return SafeArea(
      child: Scaffold(
        body: Padding(
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
                            "Order ID: #${activeOrder?.Id?.substring((activeOrder?.Id?.length ?? 10) - 10) ?? ""}",
                            style: TextStyle(
                                fontSize: SizeUtils.horizontalBlockSize * 4,
                                fontWeight: FontWeight.bold,
                                color: AppConst.black)),
                        SizedBox(height: 0.5.h),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Delivery Slot: ${TimeSlot} ",
                                // "Delivery Slot: 9am - 8pm", var date1 =
                                // "${(].startTime?.hour ?? 0) > 12 ? ((..startTime?.hour ?? 0) - 12) : _addCartController.getOrderConfirmPageDataModel.value?.oller.dayIndexForTimeSlot.value].slots?[index].startTime?.hour}:${_addCartController.getOrderConfirmPageDataModel.value?.data?.deliverySlots?[_addCartController.dayIndexForTimeSlot.value].slots?[index].startTime?.minute}";

                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        highlightColor: AppConst.highLightColor,
                        onTap: () async {
                          _freshChat.initState();
                          await _freshChat.showChatConversation(
                              "Have a problem with order \n${activeOrder?.Id}\n${activeOrder?.status}\n${activeOrder?.createdAt}\n${activeOrder?.address}\n");
                        },
                        child: Icon(
                          Icons.help,
                          size: SizeUtils.horizontalBlockSize * 6.5,
                          color: AppConst.black,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Text("HELP",
                          style: TextStyle(
                              fontSize: SizeUtils.horizontalBlockSize * 3.7,
                              fontWeight: FontWeight.bold,
                              color: AppConst.black)),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 3.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.5.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: "Status: ",
                              style: TextStyle(
                                  fontSize: SizeUtils.horizontalBlockSize * 4,
                                  fontWeight: FontWeight.bold,
                                  color: AppConst.black)),
                          TextSpan(
                              text: "${activeOrder?.status ?? ""}",
                              style: TextStyle(
                                color: AppConst.green,
                                fontSize: SizeUtils.horizontalBlockSize * 4,
                                fontWeight: FontWeight.w500,
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              (activeOrder?.rider != null)
                  ? SizedBox()
                  : Padding(
                      padding: EdgeInsets.only(left: 5.w, bottom: 1.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Rider is Not Assigned yet",
                            style: TextStyle(
                                fontSize: SizeUtils.horizontalBlockSize * 4,
                                fontWeight: FontWeight.w500,
                                color: AppConst.black),
                          ),
                        ],
                      ),
                    ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                child: Container(
                  height: 27.h,
                  decoration: BoxDecoration(
                      color: AppConst.ContainerColor,
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 50.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "View Order Items",
                                    style: TextStyle(
                                        fontSize:
                                            SizeUtils.horizontalBlockSize * 5,
                                        fontWeight: FontWeight.w600,
                                        color: AppConst.lightGreen),
                                  ),
                                  SizedBox(
                                    height: 1.5.h,
                                  ),
                                  Text(
                                    "Order Total- \u{20B9} ${activeOrder?.total ?? 0}",
                                    style: TextStyle(
                                        fontSize:
                                            SizeUtils.horizontalBlockSize * 4,
                                        fontWeight: FontWeight.w500,
                                        color: AppConst.white),
                                  ),
                                  SizedBox(
                                    height: 0.5.h,
                                  ),
                                  Text(
                                    "Cashback- \u{20B9} ${activeOrder?.total_cashback ?? 0}",
                                    style: TextStyle(
                                        fontSize:
                                            SizeUtils.horizontalBlockSize * 4,
                                        fontWeight: FontWeight.w500,
                                        color: AppConst.white),
                                  ),
                                  SizedBox(
                                    height: 0.5.h,
                                  ),
                                  Text(
                                    "Amount Paid- \u{20B9} ${activeOrder?.total ?? 0}",
                                    style: TextStyle(
                                        fontSize:
                                            SizeUtils.horizontalBlockSize * 4,
                                        fontWeight: FontWeight.w500,
                                        color: AppConst.white),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(top: 0.5.h),
                              child: Container(
                                height: 15.h,
                                width: 28.w,
                                child: SizedBox(),
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(16),
                                    color: AppConst.lightGrey),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        InkWell(
                          onTap: (() {}),
                          child: Container(
                            height: 6.h,
                            margin: EdgeInsets.only(top: 1.h),
                            decoration: BoxDecoration(
                                color: AppConst.lightGreen,
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                "View Items",
                                style: TextStyle(
                                  color: AppConst.ContainerColor,
                                  fontSize: SizeUtils.horizontalBlockSize * 4.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
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
                                  fontSize: SizeUtils.horizontalBlockSize * 5,
                                  fontWeight: FontWeight.bold),
                            )),
                            decoration: BoxDecoration(
                                color: AppConst.blue, shape: BoxShape.circle),
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
                                    "${activeOrder?.rider?.firstName ?? ""} ${activeOrder?.rider?.last_name ?? ""}", // add rider last name
                                    style: TextStyle(
                                        color: AppConst.black,
                                        fontSize:
                                            SizeUtils.horizontalBlockSize * 4,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 0.5.h,
                                  ),
                                  Text(
                                    "Information",
                                    style: TextStyle(
                                        color: AppConst.grey,
                                        fontSize:
                                            SizeUtils.horizontalBlockSize * 3.5,
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
                  _chatController.launchChat(
                      '${activeOrder?.Id}', "${activeOrder?.store?.name}");
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
                padding: EdgeInsets.only(left: 3.w, right: 3.w, bottom: 1.h),
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
                                  fontSize: SizeUtils.horizontalBlockSize * 4,
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
                                        SizeUtils.horizontalBlockSize * 3.5,
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
          ),
        ),
      ),
    );
  }
}

void _launchURL(url) async {
  if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
}
