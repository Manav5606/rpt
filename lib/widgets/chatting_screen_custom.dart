import 'dart:developer';
import 'dart:io';

import 'package:bubble/bubble.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/widgets/snack.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:sizer/sizer.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class MainChatScreen extends StatefulWidget {
  MainChatScreen({Key? key}) : super(key: key);

  @override
  State<MainChatScreen> createState() => _MainChatScreenState();
}

class _MainChatScreenState extends State<MainChatScreen> {
  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      Snack.top('Error', 'No Image selected');
    }
  }

  @override
  bool isUserMessage = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        // elevation: 1,
        title: Text(
          "Chats",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13.sp,
              color: AppConst.black),
        ),
        // leading: Icon(
        //   Icons.close_rounded,
        //   size: 3.h,
        // ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 80.h,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                  child: Container(
                    child: Column(
                      children: [
                        OwerMessage(
                            "Please tell your doubts and Queries ", "12.07 PM"),
                        CustomerMessage(
                            "When My Order is deliverd?", "12:12 PM"),
                        OwerMessage(
                            "I have 8 out of 9  produts and 1 alternatatives saop lifeboy  ",
                            "12:14 PM"),
                        CustomerMessage("OK it will fine ", "12:16 PM"),
                        OwerMessage(
                            "Please tell your doubts and Queries ", "12.07 PM"),
                        CustomerMessage(
                            "When My Order is deliverd?", "12:12 PM"),
                        OwerMessage(
                            "I have 8 out of 9  produts and 1 alternatatives saop lifeboy  ",
                            "12:14 PM"),
                        CustomerMessage("OK it will fine ", "12:16 PM"),
                        OwerMessage(
                            "Please tell your doubts and Queries ", "12.07 PM"),
                        CustomerMessage(
                            "When My Order is deliverd?", "12:12 PM"),
                        OwerMessage(
                            "I have 8 out of 9  produts and 1 alternatatives saop lifeboy  ",
                            "12:14 PM"),
                        CustomerMessage("OK it will fine ", "12:16 PM")
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
              child: Container(
                // color: Colors.grey,
                height: 8.h,
                child: TextFormField(
                    cursorColor: AppConst.black,
                    decoration: InputDecoration(
                      hintText: "Enter Text here !",
                      prefixIcon: GestureDetector(
                        onTap: () => pickImage(),
                        child: Icon(
                          Icons.camera_alt_rounded,
                          size: 2.7.h,
                          color: AppConst.black,
                        ),
                      ),
                      suffixIcon: Icon(
                        Icons.send,
                        size: 3.h,
                        color: AppConst.black,
                      ),
                      fillColor: AppConst.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: AppConst.black,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: AppConst.black,
                          width: 1.0,
                        ),
                      ),
                    )),
              ),
            )
          ],
        ),
      ),
    ));
  }

  Row CustomerMessage(String? msg, String? time) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _MessageContainer(
                  message: msg,
                  //  "When My Order is deliverd?",
                  isUserMessage: true,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(right: 3.w),
              child: Text(
                time!,
                // "12.05 PM ",
              ),
            ),
          ],
        ),
      ],
    );
  }

  Row OwerMessage(String? msg, String? time) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: isUserMessage
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                _MessageContainer(
                  message: msg!,
                  // "Please tell your doubts and Queries ",
                  // isUserMessage: true,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w),
              child: Text(
                time!,
                // "12.00 PM ",
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _MessageContainer extends StatelessWidget {
  final String? message;
  final bool isUserMessage;

  const _MessageContainer({
    Key? key,
    required this.message,
    this.isUserMessage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Bubble(
          padding: BubbleEdges.all(0),
          radius: const Radius.circular(12.0),
          color: !isUserMessage ? Colors.blue : Colors.orangeAccent,
          elevation: 0.0,
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // SizedBox(
                //   width: 10.0,
                // ),
                Flexible(
                    child: Container(
                  padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                  constraints: BoxConstraints(maxWidth: 70.w, minWidth: 40.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(12),
                      topRight: const Radius.circular(12),
                      bottomRight: isUserMessage
                          ? const Radius.circular(0)
                          : const Radius.circular(12),
                      bottomLeft: !isUserMessage
                          ? const Radius.circular(0)
                          : const Radius.circular(12),
                    ),
                    color: isUserMessage ? Colors.blue[400]! : Colors.grey[300],
                  ),
                  child: Text(
                    message ?? '',
                    style: TextStyle(
                        color: !isUserMessage ? Colors.black : Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ))
              ],
            ),
          )),
    );
  }
}
