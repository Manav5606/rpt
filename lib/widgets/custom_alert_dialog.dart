import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/constants/app_const.dart';

class CustomDialog extends StatefulWidget {
  final String? title, content, buttontext;
  final VoidCallback? onTap;

  CustomDialog({
    this.title,
    this.content,
    this.buttontext,
    this.onTap,
  });

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.all(14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
      title: Text(
        '${widget.title}',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: SizeUtils.horizontalBlockSize * 5.0,
        ),
      ),
      content: Builder(builder: (context) {
        return SizedBox(
          width: SizeUtils.screenWidth! - 70,
          child: Padding(
            padding: EdgeInsets.only(bottom: SizeUtils.verticalBlockSize * 2, top: SizeUtils.verticalBlockSize),
            child: Text(
              '${widget.content}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: SizeUtils.verticalBlockSize * 2,
                color: AppConst.black,
              ),
            ),
          ),
        );
      }),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeUtils.horizontalBlockSize * 3,
            vertical: SizeUtils.horizontalBlockSize * 2,
          ),
          child: GestureDetector(
            onTap: widget.onTap,
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                gradient: AppConst.gradient1,
                borderRadius: BorderRadius.circular(3),
                color: AppConst.yellow,
              ),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(color: AppConst.white, borderRadius: BorderRadius.circular(3)),
                  child: Center(
                    child: Text(
                      widget.buttontext!,
                      style: TextStyle(fontFamily: 'open', fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
