import 'package:flutter/material.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/utils/ui_spacing_helper.dart';
import 'package:get/get.dart';

class SeeyaModalSheet {
  final String title;
  final Widget? child;
  final bool dismissable;

  SeeyaModalSheet({required this.title, this.child, this.dismissable: true});

  show(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        isScrollControlled: true,
        builder: (BuildContext _context) {
          return Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(child: Text(title, style: AppConst.header)),
                    (dismissable)
                        ? Container(
                            padding:
                                const EdgeInsets.fromLTRB(8.0, 4.0, 0.0, 8.0),
                            child: GestureDetector(
                              child: Icon(Icons.close),
                              onTap: () {
                                Get.back();
                              },
                            ))
                        : Container(),
                  ],
                ),
                UISpacingHelper.verticalSpaceMedium,
                Flexible(child: child ?? Container())
              ],
            ),
          );
        });
  }
}
