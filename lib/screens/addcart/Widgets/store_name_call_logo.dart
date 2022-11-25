import 'package:badges/badges.dart';
import 'package:bubble/bubble.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreNameCallLogoWidget extends StatelessWidget {
  StoreNameCallLogoWidget(
      {Key? key,
      this.logoLetter,
      this.mobile,
      this.storeName,
      this.totalAmount,
      this.callLogo,
      this.paymentStatus})
      : super(key: key);

  String? logoLetter;
  String? storeName;
  var mobile;
  int? totalAmount;
  String? paymentStatus;
  bool? callLogo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 3.w, right: 3.w, top: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Badge(
            shape: BadgeShape.square,
            borderRadius: BorderRadius.circular(2),
            elevation: 0,
            padding: EdgeInsets.zero,
            position: BadgePosition.bottomEnd(bottom: -4, end: -2),
            badgeColor: AppConst.white,
            badgeContent: Padding(
              padding: const EdgeInsets.all(0.8),
              child: Icon(
                Icons.chat,
                size: 2.3.h,
                color: AppConst.green,
              ),
            ),
            child: Container(
              height: 6.h,
              width: 12.w,
              child: Center(
                  child: Text(
                logoLetter ?? "S",
                // "${activeOrder?.store?.name?.substring(0, 1) ?? "S"}",
                style: TextStyle(
                    color: AppConst.white,
                    fontSize: SizeUtils.horizontalBlockSize * 5,
                    fontWeight: FontWeight.bold),
              )),
              decoration:
                  BoxDecoration(color: AppConst.black, shape: BoxShape.circle),
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
                      storeName ?? "Store Name",
                      // "${activeOrder?.store?.name ?? "Store Name"}",
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
                    "${totalAmount ?? 0} ${paymentStatus ?? ""}",
                    // "${activeOrder?.total ?? 0} Paid", //updated the payment status
                    // "100 Paid",
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
          (callLogo ?? true)
              ? InkWell(
                  onTap: (() {
                    _launchURL("tel:${mobile ?? '+91'}");
                  }),
                  child: CallLogo())
              : SizedBox()
        ],
      ),
    );
  }
}

void _launchURL(url) async {
  if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
}

class StoreChatBubble extends StatelessWidget {
  String? text;
  String? buttonText;
  StoreChatBubble({Key? key, this.buttonText, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
      child: Bubble(
        color: AppConst.lightSkyBlue,
        margin: BubbleEdges.only(top: 1.h),
        stick: true,
        nip: BubbleNip.leftBottom,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text ?? "Facing any issues?\nTell us your issue.",
                // "Facing any issues?\nTell us your issue.",
                style: TextStyle(
                  color: Color(0xff003d29),
                  fontSize: 14,
                ),
              ),
              Container(
                width: 28.w,
                height: 5.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(85),
                  color: Color(0xff005b41),
                ),
                child: Center(
                  child: Text(
                    buttonText ?? "Chat with Us",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CallLogo extends StatelessWidget {
  const CallLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 1, color: AppConst.black)),
      child: Icon(
        Icons.call,
        size: 3.5.h,
      ),
    );
  }
}

class CircularCloseButton extends StatelessWidget {
  IconData? icon;
  CircularCloseButton({Key? key, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      child: GestureDetector(
        // color: Colors.white,
        onTap: (() => Get.back()),
        child: Icon(
          icon ?? Icons.close,
          size: SizeUtils.horizontalBlockSize * 5.5,
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
    );
  }
}
