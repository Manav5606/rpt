import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/widgets/copied/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hive/hive.dart';
import 'package:sizer/sizer.dart';

import '../../../../routes/app_list.dart';
import '../../../controller/add_location_controller.dart';
import '../../../data/model/user_model.dart';
import '../../../data/provider/hive/hive_constants.dart';

class DeleteAcccountFinalScreen extends StatefulWidget {
  final String? reason;
  const DeleteAcccountFinalScreen({Key? key, this.reason}) : super(key: key);

  @override
  State<DeleteAcccountFinalScreen> createState() =>
      _DeleteAcccountFinalScreenState();
}

class _DeleteAcccountFinalScreenState extends State<DeleteAcccountFinalScreen> {
  @override
  Widget build(BuildContext context) {
    final AddLocationController _addLocationController = Get.find();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
              alignment: Alignment.center,
              child: Text(
                "You're about to deactivate your account",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'MuseoSans'),
              )),
          SizedBox(
            height: 2.h,
          ),
          SizedBox(
              width: Device.screenWidth / 1.2,
              child: Text(
                "All the data associated with the account will be permanently deleted",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'MuseoSans',
                    color: AppConst.grey),
              )),
          SizedBox(
            height: 4.h,
          ),
          GestureDetector(
            onTap: () async {
              SeeyaConfirmDialog(
                  title: "Are you sure?",
                  subTitle: "You Want to Deactivate Your account?",
                  onCancel: () => Get.back(),
                  onConfirm: () async {
                    Get.back();
                    //exit this screen

                    await _addLocationController.deleteCustomer(
                        widget.reason ?? "", true);
                  }).show(context);
            },
            child: Container(
              height: 6.h,
              width: Device.screenWidth / 1.2,
              decoration: BoxDecoration(
                color: AppConst.green,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                  child: Text(
                "Deactivate Account",
                style: TextStyle(
                    color: AppConst.white,
                    fontFamily: 'MuseoSans',
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
