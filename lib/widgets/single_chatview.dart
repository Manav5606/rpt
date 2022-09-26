import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:bubble/bubble.dart';

class SingleChatview extends StatefulWidget {
  SingleChatview({Key? key}) : super(key: key);

  @override
  State<SingleChatview> createState() => _SingleChatviewState();
}

class _SingleChatviewState extends State<SingleChatview> {
  @override
  dynamic currentTime = DateFormat.jm().format(DateTime.now());
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () => Get.back(),
            child: Icon(
              CupertinoIcons.back,
              size: 3.h,
            )),
        elevation: 1,
        title: Text(
          "Storename shopping",
          style: TextStyle(
              fontSize: SizeUtils.horizontalBlockSize * 5,
              fontWeight: FontWeight.bold,
              color: AppConst.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
        child: Column(
          children: [
            store_message_tamplate(
                'Hii my name is briteny Today i personally shopping for you please feel free to communicate with me while i gather things for you!'),
            store_message_tamplate(
                "your shopping will proceed wait for few seconds i can gather all stuff!"),
            SizedBox(
              height: 2.h,
            ),
            Expanded(
              child: Stack(children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: TextFormField(
                    autofocus: true,
                    decoration: InputDecoration(
                      prefixIcon: GestureDetector(
                          onTap: (() {}),
                          child: Icon(
                            Icons.camera_alt_rounded,
                            size: 3.h,
                          )),
                      suffixIcon: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 2.h, horizontal: 2.w),
                        child: GestureDetector(
                          onTap: (() {
                            // print("Send");
                          }),
                          child: Text(
                            "Send",
                            style: TextStyle(
                                fontSize: SizeUtils.horizontalBlockSize * 4,
                                fontWeight: FontWeight.bold,
                                color: AppConst.blue),
                          ),
                        ),
                      ),
                      hintText: "Enter the message ",
                      hintStyle: TextStyle(
                          fontSize: SizeUtils.horizontalBlockSize * 4),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: AppConst.grey),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Padding store_message_tamplate(String message) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Stack(children: [
            CircleAvatar(
              backgroundColor: AppConst.green,
              child: Icon(
                Icons.person,
                size: 5.h,
                color: AppConst.white,
              ),
              radius: 3.h,
            ),
            Positioned(
                bottom: 0,
                left: 4,
                child: CircleAvatar(
                  backgroundColor: AppConst.kPrimaryColor,
                  radius: 1.h,
                ))
          ]),
          SizedBox(
            width: 3.w,
          ),
          Expanded(
            child: Column(
              children: [
                Bubble(
                  elevation: 1,
                  margin: BubbleEdges.only(top: 10),
                  alignment: Alignment.topLeft,
                  child: Text(
                    message,
                    style: TextStyle(
                      fontSize: SizeUtils.horizontalBlockSize * 4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
