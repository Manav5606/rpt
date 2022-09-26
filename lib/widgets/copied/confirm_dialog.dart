import 'package:flutter/material.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/utils/ui_spacing_helper.dart';

import '../../app/constants/responsive.dart';

class SeeyaConfirmDialog {
  final String? title;
  final String? subTitle;

  final Function()? onConfirm;
  final Function()? onCancel;

  const SeeyaConfirmDialog(
      {this.title, this.subTitle, this.onConfirm, this.onCancel, Key? key});

  show(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeUtils.horizontalBlockSize * 4,
                  vertical: SizeUtils.verticalBlockSize * 2),
              color: AppConst.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? "",
                    style: AppConst.header2,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: SizeUtils.verticalBlockSize * 2,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          subTitle ?? "",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: AppConst.headerOpenSan,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: SizeUtils.verticalBlockSize * 3,
                  ),
                  Row(
                    children: [
                      Expanded(child: button("Cancel", onTap: onCancel!)),
                      UISpacingHelper.horizontalSpaceMedium,
                      Expanded(child: button("Confirm", onTap: onConfirm!)),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget button(String text, {Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: SizeUtils.horizontalBlockSize * 3,
            vertical: SizeUtils.verticalBlockSize * 1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: AppConst.white,
          border: Border.all(color: AppConst.themeBlue, width: 0.5),
          boxShadow: [
            BoxShadow(
              offset: Offset(0.0, 3.0),
              color: AppConst.black.withOpacity(0.15),
              blurRadius: 6.0,
            )
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: AppConst.smallBoxTextSan,
          ),
        ),
      ),
    );
  }
}
