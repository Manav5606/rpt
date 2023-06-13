import 'package:customer_app/app/controller/add_location_controller.dart';
import 'package:customer_app/app/ui/pages/signIn/phone_authentication_screen.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/widgets/copied/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ActivateAccountScreen extends StatelessWidget {
  ActivateAccountScreen({
    Key? key,
  }) : super(key: key);
  final AddLocationController _addLocationController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Activate Account",
                  style: TextStyle(
                    fontFamily: 'MuseoSans',
                    color: AppConst.black,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  )),
            ],
          ),
          SizedBox(
            height: 6.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 80.w,
                child: Text(
                    "Hi,\nwe found that you already have an account with provided number to proceed further please activate your account",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'MuseoSans',
                      color: AppConst.black,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    )),
              ),
            ],
          ),
          SizedBox(
            height: 7.h,
          ),
          GestureDetector(
            onTap: () {
              SeeyaConfirmDialog(
                  title: "Are you sure?",
                  subTitle: "You Want to Activate Your Account?",
                  onCancel: () => Get.back(),
                  onConfirm: () async {
                    //exit the dialog;
                    Get.back();
                    await _addLocationController.deleteCustomer("", false);
                    //exit this screen
                  }).show(context);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: BottomWideButton(
                text: "Activate Your Account",
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.offAllNamed(AppRoutes.Authentication);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 80.w,
                  child: Text("Continue with another number?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'MuseoSans',
                        color: AppConst.black,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                      )),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
        ],
      )),
    );
  }
}
