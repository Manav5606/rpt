import 'package:bubble/bubble.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class StoreChatBubble extends StatelessWidget {
  String? text;
  String? buttonText;
  final Function? onTap;
  StoreChatBubble({Key? key, this.buttonText, this.text, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
      child: Bubble(
        color: Color(0xffE6FAF1),
        margin: BubbleEdges.only(top: 1.h),
        stick: true,
        nip: BubbleNip.no,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  text ?? "Facing any issues?\nTell us your issue.",
                  // "Facing any issues?\nTell us your issue.",
                  style: TextStyle(
                    color: Color(0xff003D29),
                    fontSize: 14,
                  ),
                ),
              ),
              InkWell(
                onTap: () => onTap != null ? onTap!() : null,
                child: Container(
                  // width: 28.w,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 5.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(85),
                    color: AppConst.darkGreen,
                  ),
                  child: Center(
                    child: Text(
                      buttonText ?? "Chat",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
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
