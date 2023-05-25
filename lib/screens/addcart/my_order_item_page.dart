import 'package:badges/badges.dart' as badge;
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/data/model/active_order_model.dart';
import 'package:customer_app/app/ui/pages/chat/freshchat_controller.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/screens/addcart/Widgets/store_name_call_logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../app/ui/pages/chat/chat_controller.dart';

class MyOrderItems extends StatelessWidget {
  final ChatController _chatController = Get.find();
  final freshChatController _freshChat = Get.find();
  final ActiveOrderData? activeOrder;
  var TimeSlot;
  MyOrderItems({Key? key, this.activeOrder, this.TimeSlot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularCloseButton(
              icon: Icons.arrow_back,
            ),
            Spacer(),
            Container(
              width: 60.w,

              // height: 7.h,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("My Items",
                      style: TextStyle(
                          fontSize: SizeUtils.horizontalBlockSize * 4,
                          fontWeight: FontWeight.bold,
                          color: AppConst.black)),
                  SizedBox(height: 0.5.h),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              "Delivery Slot: ${TimeSlot ?? ''} ", // remove the minutes if min == 0
                          // "Delivery Slot: 9am - 8pm", var date1 =
                          // "${(].startTime?.hour ?? 0) > 12 ? ((..startTime?.hour ?? 0) - 12) : _addCartController.getOrderConfirmPageDataModel.value?.oller.dayIndexForTimeSlot.value].slots?[index].startTime?.hour}:${_addCartController.getOrderConfirmPageDataModel.value?.data?.deliverySlots?[_addCartController.dayIndexForTimeSlot.value].slots?[index].startTime?.minute}";

                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'MuseoSans',
                            fontSize: SizeUtils.horizontalBlockSize * 3.7,
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
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 2.w),
            child: InkWell(
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
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              highlightColor: AppConst.highLightColor,
              onTap: () {
                _chatController.launchChat(
                    '${activeOrder?.Id}', "${activeOrder?.store?.name}");
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 2.w,
                ),
                child: StoreChatBubble(
                  text: "Facing any issues?\nTell us your issue.",
                  buttonText: "Chat With us",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 2.w, right: 2.w, bottom: 2.h),
              child: StoreNameCallLogoWidget(
                logoLetter: activeOrder?.store?.name?.substring(0, 1),
                storeName: activeOrder?.store?.name,
                totalAmount: activeOrder?.total,
                paymentStatus: "Paid", // updated the status to Dynamic
                mobile: activeOrder?.store?.mobile,
                callLogo: false,
              ),
            ),
            Container(
              height: 1.4.h,
              color: AppConst.veryLightGrey,
            ),
            YetToReviewItems(
              activeOrder: activeOrder,
            ),
            AllFoundedItems(activeOrder: activeOrder),
            AllReplacedItems(activeOrder: activeOrder),
            AllModifiedItems(activeOrder: activeOrder),
          ],
        ),
      ),
    );
  }
}

class AllModifiedItems extends StatelessWidget {
  const AllModifiedItems({
    Key? key,
    required this.activeOrder,
  }) : super(key: key);

  final ActiveOrderData? activeOrder;

  @override
  Widget build(BuildContext context) {
    var foundItemCount = ((activeOrder?.products
            ?.where((c) => c.status == "modified")
            .toList()
            .length)! +
        (activeOrder?.rawItems
            ?.where((c) => c.status == "modified")
            .toList()
            .length)! +
        (activeOrder?.inventories
            ?.where((c) => c.status == "modified")
            .toList()
            .length)!);
    return foundItemCount != 0
        ? Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                child: Row(
                  children: [
                    Icon(
                      Icons.edit_note_outlined,
                      size: 4.h,
                      color: AppConst.orange,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      "Modified",
                      style: TextStyle(
                          color: AppConst.orange,
                          fontSize: SizeUtils.horizontalBlockSize * 4.5,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              (activeOrder?.products
                              ?.where((c) => c.status == "modified")
                              .toList() ==
                          null ||
                      activeOrder?.products
                              ?.where((c) => c.status == "modified")
                              .toList()
                              .length ==
                          0)
                  ? SizedBox()
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: (activeOrder!.products!
                          .where((c) => c.status == "modified")
                          .toList()
                          .length),
                      itemBuilder: (BuildContext context, int index) {
                        return ModifiedItemsList(
                          name: (activeOrder?.products?[index].name),
                          quantity: (activeOrder?.products?[index].quantity),
                          updatequantity:
                              (activeOrder?.products?[index].updatequantity),
                          units: "${activeOrder?.products?[index].unit}",
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(),
                    ),
              (activeOrder?.inventories
                              ?.where((c) => c.status == "modified")
                              .toList() ==
                          null ||
                      activeOrder?.inventories
                              ?.where((c) => c.status == "modified")
                              .toList()
                              .length ==
                          0)
                  ? SizedBox()
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: (activeOrder!.inventories!
                          .where((c) => c.status == "modified")
                          .toList()
                          .length),
                      itemBuilder: (BuildContext context, int index) {
                        return ModifiedItemsList(
                          name: (activeOrder?.inventories?[index].name),
                          quantity: (activeOrder?.inventories?[index].quantity),
                          updatequantity:
                              (activeOrder?.inventories?[index].updatequantity),
                          units: "${activeOrder?.inventories?[index].unit}",
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox()),
              (activeOrder?.rawItems
                              ?.where((c) => c.status == "modified")
                              .toList() ==
                          null ||
                      activeOrder?.rawItems
                              ?.where((c) => c.status == "modified")
                              .toList()
                              .length ==
                          0)
                  ? SizedBox()
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: (activeOrder!.rawItems!
                          .where((c) => c.status == "modified")
                          .toList()
                          .length),
                      itemBuilder: (BuildContext context, int index) {
                        return ModifiedItemsList(
                          name: (activeOrder?.rawItems?[index].item),
                          quantity: (activeOrder?.rawItems?[index].quantity),
                          updatequantity:
                              (activeOrder?.rawItems?[index].updatequantity),
                          units: "",
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox()),
              Container(
                height: 1.4.h,
                color: AppConst.veryLightGrey,
              ),
            ],
          )
        : SizedBox();
  }
}

class ModifiedItemsList extends StatelessWidget {
  ModifiedItemsList(
      {Key? key, this.name, this.quantity, this.units, this.updatequantity})
      : super(key: key);

  String? name;
  int? quantity;
  int? updatequantity;
  String? units;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          badge.Badge(
            shape: badge.BadgeShape.circle,
            borderRadius: BorderRadius.circular(2),
            elevation: 0,
            padding: EdgeInsets.zero,
            position: badge.BadgePosition.topEnd(top: -4, end: -6),
            badgeColor: AppConst.white,
            badgeContent: Icon(
              Icons.edit_note_outlined,
              size: 2.3.h,
              color: AppConst.green,
            ),
            child: Container(
              height: 6.h,
              width: 12.w,
              child: Center(
                  child: Text(
                "${name?.substring(0, 1) ?? "M"}",
                style: TextStyle(
                    color: AppConst.white,
                    fontSize: SizeUtils.horizontalBlockSize * 5,
                    fontWeight: FontWeight.bold),
              )),
              decoration: BoxDecoration(
                  color: AppConst.grey,
                  shape: BoxShape.rectangle,
                  border: Border.all(color: AppConst.grey),
                  borderRadius: BorderRadius.circular(3)),
            ),
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
                  Container(
                    width: 50.w,
                    child: Text(
                      // (activeOrder?.products?[index].name ?? ''),
                      name ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: AppConst.black,
                          fontSize: SizeUtils.horizontalBlockSize * 4,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  Text(
                    //  (activeOrder?.products?[index].name ?? ''),
                    units ?? "",
                    style: TextStyle(
                        color: AppConst.grey,
                        fontSize: SizeUtils.horizontalBlockSize * 3.5,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: "Quantity:",
                      style: TextStyle(
                          color: AppConst.black,
                          fontSize: SizeUtils.horizontalBlockSize * 4,
                          fontWeight: FontWeight.w500),
                    ),
                    TextSpan(
                        text:
                            "${quantity ?? 0}", // " ${(activeOrder?.products?[index].quantity ?? 0)} ",
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: AppConst.black,
                            fontSize: SizeUtils.horizontalBlockSize * 4,
                            fontWeight: FontWeight.w500)),
                    TextSpan(
                      text: " to ${updatequantity ?? 0}",
                      style: TextStyle(
                          color: AppConst.black,
                          fontSize: SizeUtils.horizontalBlockSize * 4,
                          fontWeight: FontWeight.w500),
                    )
                  ])),
                ],
              ),
            ],
          ),
          Spacer(),
          (updatequantity != 0)
              ? Container(
                  height: 5.h,
                  width: 10.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(width: 1, color: AppConst.grey),
                    color: AppConst.white,
                  ),
                  child: Center(
                    child: Text(
                      "${updatequantity ?? 0}",
                      // "2",
                      style: TextStyle(
                          color: AppConst.black,
                          fontSize: SizeUtils.horizontalBlockSize * 3.5,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              : Text(
                  "Out of Stock",
                  // "2",
                  style: TextStyle(
                      color: AppConst.red,
                      fontSize: SizeUtils.horizontalBlockSize * 3.5,
                      fontWeight: FontWeight.w500),
                ),
        ],
      ),
    );
  }
}

class AllReplacedItems extends StatelessWidget {
  const AllReplacedItems({
    Key? key,
    required this.activeOrder,
  }) : super(key: key);

  final ActiveOrderData? activeOrder;

  @override
  Widget build(BuildContext context) {
    var foundItemCount = ((activeOrder?.products
            ?.where((c) => c.status == "replaced")
            .toList()
            .length)! +
        (activeOrder?.rawItems
            ?.where((c) => c.status == "replaced")
            .toList()
            .length)! +
        (activeOrder?.inventories
            ?.where((c) => c.status == "replaced")
            .toList()
            .length)!);
    return foundItemCount != 0
        ? Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppConst.orange)),
                      child: Icon(
                        CupertinoIcons.arrow_right_arrow_left,
                        // size: 5.h,/
                        color: AppConst.orange,
                      ),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      "Replacement",
                      style: TextStyle(
                          color: AppConst.orange,
                          fontSize: SizeUtils.horizontalBlockSize * 4.5,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              (activeOrder?.products
                              ?.where((c) => c.status == "replaced")
                              .toList() ==
                          null ||
                      activeOrder?.products
                              ?.where((c) => c.status == "replaced")
                              .toList()
                              .length ==
                          0)
                  ? SizedBox()
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: (activeOrder!.products!
                          .where((c) => c.status == "replaced")
                          .toList()
                          .length),
                      itemBuilder: (BuildContext context, int index) {
                        return ReplaceItemsList(
                          name: activeOrder?.products?[index].name,
                          quantity: activeOrder?.products?[index].quantity,
                          updatename: activeOrder?.products?[index].updatename,
                          updatequantity:
                              activeOrder?.products?[index].updatequantity,
                          units: "${activeOrder?.products?[index].unit}",
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          Container(
                        height: 1,
                        color: AppConst.grey,
                      ),
                    ),
              Container(
                height: 1,
                color: AppConst.grey,
              ),
              (activeOrder?.inventories
                              ?.where((c) => c.status == "replaced")
                              .toList() ==
                          null ||
                      activeOrder?.inventories
                              ?.where((c) => c.status == "replaced")
                              .toList()
                              .length ==
                          0)
                  ? SizedBox()
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: (activeOrder!.inventories!
                          .where((c) => c.status == "replaced")
                          .toList()
                          .length),
                      itemBuilder: (BuildContext context, int index) {
                        return ReplaceItemsList(
                          name: activeOrder?.inventories?[index].name,
                          quantity: activeOrder?.inventories?[index].quantity,
                          updatename:
                              activeOrder?.inventories?[index].updatename,
                          updatequantity:
                              activeOrder?.inventories?[index].updatequantity,
                          units: "${activeOrder?.inventories?[index].unit}",
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          Container(
                            height: 1,
                            color: AppConst.grey,
                          )),
              Container(
                height: 1,
                color: AppConst.grey,
              ),
              (activeOrder?.rawItems
                              ?.where((c) => c.status == "replaced")
                              .toList() ==
                          null ||
                      activeOrder?.rawItems
                              ?.where((c) => c.status == "replaced")
                              .toList()
                              .length ==
                          0)
                  ? SizedBox()
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: (activeOrder!.rawItems!
                          .where((c) => c.status == "replaced")
                          .toList()
                          .length),
                      itemBuilder: (BuildContext context, int index) {
                        return ReplaceItemsList(
                          name: activeOrder?.rawItems?[index].item,
                          quantity: activeOrder?.rawItems?[index].quantity,
                          updatename: activeOrder?.rawItems?[index].updatename,
                          updatequantity:
                              activeOrder?.rawItems?[index].updatequantity,
                          units: "",
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          Container(
                        height: 1,
                        color: AppConst.grey,
                      ),
                    ),
              Container(
                height: 1.h,
                color: AppConst.veryLightGrey,
              ),
            ],
          )
        : SizedBox();
  }
}

class ReplaceItemsList extends StatelessWidget {
  ReplaceItemsList(
      {Key? key,
      this.name,
      this.quantity,
      this.units,
      this.updatename,
      this.updatequantity})
      : super(key: key);
  String? name;
  String? updatename;
  String? units;
  int? quantity;
  int? updatequantity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 6.h,
                width: 12.w,
                child: Center(
                    child: Text(
                  "${name?.substring(0, 1) ?? "R"}",
                  style: TextStyle(
                      color: AppConst.white,
                      fontSize: SizeUtils.horizontalBlockSize * 5,
                      fontWeight: FontWeight.bold),
                )),
                decoration: BoxDecoration(
                    color: AppConst.grey,
                    shape: BoxShape.rectangle,
                    border: Border.all(color: AppConst.grey),
                    borderRadius: BorderRadius.circular(3)),
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
                      Container(
                        width: 60.w,
                        child: Text(
                          "${name ?? ''}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: AppConst.black,
                              fontSize: SizeUtils.horizontalBlockSize * 4,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      Text(
                        // "${activeOrder?.total ?? 0} Paid", //updated the payment status
                        units ?? "",
                        style: TextStyle(
                            color: AppConst.grey,
                            fontSize: SizeUtils.horizontalBlockSize * 3.5,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              Container(
                height: 5.h,
                width: 10.w,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(width: 1, color: AppConst.grey),
                  color: AppConst.white,
                ),
                child: Center(
                  child: Text(
                    "${quantity ?? 0}",
                    style: TextStyle(
                        color: AppConst.black,
                        fontSize: SizeUtils.horizontalBlockSize * 3.5,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 0.5.h),
          child: Row(
            children: [
              Icon(
                CupertinoIcons.arrow_right_arrow_left,
                size: 2.h,
                color: AppConst.orange,
              ),
              SizedBox(
                width: 2.w,
              ),
              Text(
                "Replace with",
                style: TextStyle(
                    color: AppConst.grey,
                    fontSize: SizeUtils.horizontalBlockSize * 3.5,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 6.h,
                width: 12.w,
                child: Center(
                    child: Text(
                  "${updatename?.substring(0, 1) ?? "R"}",
                  style: TextStyle(
                      color: AppConst.white,
                      fontSize: SizeUtils.horizontalBlockSize * 5,
                      fontWeight: FontWeight.bold),
                )),
                decoration: BoxDecoration(
                    color: AppConst.grey,
                    shape: BoxShape.rectangle,
                    border: Border.all(color: AppConst.grey),
                    borderRadius: BorderRadius.circular(3)),
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
                      Container(
                        width: 60.w,
                        child: Text(
                          "${updatename ?? ""}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: AppConst.black,
                              fontSize: SizeUtils.horizontalBlockSize * 4,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      Text(
                        //updated the payment status
                        units ?? "",
                        style: TextStyle(
                            color: AppConst.grey,
                            fontSize: SizeUtils.horizontalBlockSize * 3.5,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              Container(
                height: 5.h,
                width: 10.w,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(width: 1, color: AppConst.grey),
                  color: AppConst.white,
                ),
                child: Center(
                  child: Text(
                    "${updatequantity ?? 0}",
                    style: TextStyle(
                        color: AppConst.black,
                        fontSize: SizeUtils.horizontalBlockSize * 3.5,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AllFoundedItems extends StatelessWidget {
  const AllFoundedItems({
    Key? key,
    required this.activeOrder,
  }) : super(key: key);

  final ActiveOrderData? activeOrder;

  @override
  Widget build(BuildContext context) {
    var foundItemCount = ((activeOrder?.products
            ?.where((c) => c.status == "found")
            .toList()
            .length)! +
        (activeOrder?.rawItems
            ?.where((c) => c.status == "found")
            .toList()
            .length)! +
        (activeOrder?.inventories
            ?.where((c) => c.status == "found")
            .toList()
            .length)!);
    return foundItemCount != 0
        ? Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                child: Row(
                  children: [
                    Icon(
                      Icons.file_download_done_rounded,
                      size: 4.h,
                      color: AppConst.orange,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      "found",
                      style: TextStyle(
                          color: AppConst.orange,
                          fontSize: SizeUtils.horizontalBlockSize * 4.5,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              (activeOrder?.products
                              ?.where((c) => c.status == "found")
                              .toList() ==
                          null ||
                      activeOrder?.products
                              ?.where((c) => c.status == "found")
                              .toList()
                              .length ==
                          0)
                  ? SizedBox()
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: (activeOrder!.products!
                          .where((c) => c.status == "found")
                          .toList()
                          .length),
                      itemBuilder: (BuildContext context, int index) {
                        return FoundItemsList(
                          name: activeOrder?.products?[index].name,
                          quantity: activeOrder?.products?[index].quantity,
                          units: "${activeOrder?.products?[index].unit}",
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox()),
              (activeOrder?.rawItems
                              ?.where((c) => c.status == "found")
                              .toList() ==
                          null ||
                      activeOrder?.rawItems
                              ?.where((c) => c.status == "found")
                              .toList()
                              .length ==
                          0)
                  ? SizedBox()
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: (activeOrder!.rawItems!
                          .where((c) => c.status == "found")
                          .toList()
                          .length),
                      itemBuilder: (BuildContext context, int index) {
                        return FoundItemsList(
                          name: activeOrder?.rawItems?[index].item,
                          quantity: activeOrder?.rawItems?[index].quantity,
                          units: "",
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox()),
              (activeOrder?.inventories
                              ?.where((c) => c.status == "found")
                              .toList() ==
                          null ||
                      activeOrder?.inventories
                              ?.where((c) => c.status == "found")
                              .toList()
                              .length ==
                          0)
                  ? SizedBox()
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: (activeOrder!.inventories!
                          .where((c) => c.status == "found")
                          .toList()
                          .length),
                      itemBuilder: (BuildContext context, int index) {
                        return FoundItemsList(
                          name: activeOrder?.inventories?[index].name,
                          quantity: activeOrder?.inventories?[index].quantity,
                          units: "${activeOrder?.inventories?[index].unit}",
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox()),
              Container(
                height: 1.4.h,
                color: AppConst.veryLightGrey,
              ),
            ],
          )
        : SizedBox();
  }
}

class FoundItemsList extends StatelessWidget {
  FoundItemsList({Key? key, this.name, this.quantity, this.units})
      : super(key: key);

  String? name;
  String? units;
  int? quantity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          badge.Badge(
            shape: badge.BadgeShape.circle,
            borderRadius: BorderRadius.circular(2),
            elevation: 0,
            padding: EdgeInsets.zero,
            position: badge.BadgePosition.topEnd(top: -4, end: -6),
            badgeColor: AppConst.white,
            badgeContent: Icon(
              Icons.check_circle_rounded,
              size: 2.3.h,
              color: AppConst.green,
            ),
            child: Container(
              height: 6.h,
              width: 12.w,
              child: Center(
                  child: Text(
                "${(name == "") ? "" : (name?.substring(0, 1) ?? "P")}",
                style: TextStyle(
                    color: AppConst.white,
                    fontSize: SizeUtils.horizontalBlockSize * 5,
                    fontWeight: FontWeight.bold),
              )),
              decoration: BoxDecoration(
                  color: AppConst.grey,
                  shape: BoxShape.rectangle,
                  border: Border.all(color: AppConst.grey),
                  borderRadius: BorderRadius.circular(3)),
            ),
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
                  Container(
                    width: 60.w,
                    child: Text(
                      (name ?? ''),
                      // "Amul Dark Chocolate ",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: AppConst.black,
                          fontSize: SizeUtils.horizontalBlockSize * 4,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  Text(
                    units ?? "",
                    style: TextStyle(
                        color: AppConst.grey,
                        fontSize: SizeUtils.horizontalBlockSize * 3.5,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
          Container(
            height: 5.h,
            width: 10.w,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(width: 1, color: AppConst.grey),
              color: AppConst.white,
            ),
            child: Center(
              child: Text(
                "${(quantity ?? "")}",
                // "4",
                style: TextStyle(
                    color: AppConst.black,
                    fontSize: SizeUtils.horizontalBlockSize * 3.5,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class YetToReviewItems extends StatelessWidget {
  const YetToReviewItems({
    Key? key,
    required this.activeOrder,
  }) : super(key: key);

  final ActiveOrderData? activeOrder;

  @override
  Widget build(BuildContext context) {
    var foundItemCount = ((activeOrder?.products
            ?.where((c) => c.status == null)
            .toList()
            .length)! +
        (activeOrder?.rawItems
            ?.where((c) => c.status == null)
            .toList()
            .length)! +
        (activeOrder?.inventories
            ?.where((c) => c.status == null)
            .toList()
            .length)!);
    return foundItemCount != 0
        ? Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                child: Row(
                  children: [
                    Icon(
                      Icons.more_time_rounded,
                      size: 4.h,
                      color: AppConst.orange,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      "Yet To Review",
                      style: TextStyle(
                          color: AppConst.orange,
                          fontSize: SizeUtils.horizontalBlockSize * 4.5,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              (activeOrder?.products?.where((c) => c.status == null).toList() ==
                          null ||
                      activeOrder?.products
                              ?.where((c) => c.status == null)
                              .toList()
                              .length ==
                          0)
                  ? SizedBox()
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: (activeOrder!.products!
                          .where((c) => c.status == null)
                          .toList()
                          .length),
                      itemBuilder: (BuildContext context, int index) {
                        return FoundItemsList(
                          name: activeOrder?.products?[index].name,
                          quantity: activeOrder?.products?[index].quantity,
                          units: "${activeOrder?.products?[index].unit}",
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox()),
              (activeOrder?.rawItems?.where((c) => c.status == null).toList() ==
                          null ||
                      activeOrder?.rawItems
                              ?.where((c) => c.status == null)
                              .toList()
                              .length ==
                          0)
                  ? SizedBox()
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: (activeOrder!.rawItems!
                          .where((c) => c.status == null)
                          .toList()
                          .length),
                      itemBuilder: (BuildContext context, int index) {
                        return FoundItemsList(
                          name: activeOrder?.rawItems?[index].item,
                          quantity: activeOrder?.rawItems?[index].quantity,
                          units: "",
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox()),
              (activeOrder?.inventories
                              ?.where((c) => c.status == null)
                              .toList() ==
                          null ||
                      activeOrder?.inventories
                              ?.where((c) => c.status == null)
                              .toList()
                              .length ==
                          0)
                  ? SizedBox()
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: (activeOrder!.inventories!
                          .where((c) => c.status == null)
                          .toList()
                          .length),
                      itemBuilder: (BuildContext context, int index) {
                        return FoundItemsList(
                          name: activeOrder?.inventories?[index].name,
                          quantity: activeOrder?.inventories?[index].quantity,
                          units: "${activeOrder?.inventories?[index].unit}",
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox()),
              Container(
                height: 1.4.h,
                color: AppConst.veryLightGrey,
              ),
            ],
          )
        : SizedBox();
  }
}
