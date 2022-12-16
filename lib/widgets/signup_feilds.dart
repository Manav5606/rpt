import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/ui/common/shimmer_widget.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/widgets/textfield_clear_button.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SignUpFeilds extends StatelessWidget {
  SignUpFeilds(
      {Key? key,
      // this.text,
      this.hinttext,
      this.labelText,
      this.controller,
      this.keyboardtype,
      this.maxlength,
      this.onChange,
      this.focusNode,
      this.prefixIcon,
      this.readOnly})
      : super(key: key);
  // String? text;
  String? hinttext;
  String? labelText;
  TextEditingController? controller;
  TextInputType? keyboardtype;
  int? maxlength;
  bool? readOnly;
  FocusNode? focusNode;
  Widget? prefixIcon;
  final void Function(String)? onChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 3.h),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: TextFormField(
                style: TextStyle(
                    fontFamily: 'MuseoSans',
                    color: AppConst.black,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    fontSize: SizeUtils.horizontalBlockSize * 4),
                focusNode: focusNode,
                textAlign: TextAlign.start,
                cursorColor: AppConst.black,
                maxLength: maxlength,
                keyboardType: keyboardtype ?? TextInputType.name,
                controller: controller,
                onChanged: onChange,
                readOnly: readOnly ?? false,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: hinttext ?? '',
                  hintStyle: TextStyle(
                      color: AppConst.grey,
                      fontSize: SizeUtils.horizontalBlockSize * 4.2),
                  contentPadding: EdgeInsets.only(left: 2.w, bottom: 1.h),
                  hintTextDirection: TextDirection.ltr,
                  counterText: "",
                  labelText: labelText ?? "",
                  labelStyle: TextStyle(
                      fontFamily: 'MuseoSans',
                      color: AppConst.darkGrey,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      fontSize: SizeUtils.horizontalBlockSize * 4),
                  prefixIcon: prefixIcon,
                  // (controller?.text.length)! > 0
                  //     ? TextFieldClearButton(
                  //         onTap: () {
                  //           controller?.clear();
                  //         },
                  //       )
                  //     : null,
                  // suffixIcon: (controller?.text.length)! > 0
                  //     ? TextFieldClearButton(
                  //         onTap: () {
                  //           controller?.clear();
                  //         },
                  //       )
                  //     : null,
                  suffixIconConstraints: BoxConstraints.tightFor(),
                  disabledBorder: InputBorder.none,
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppConst.grey, width: 1),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppConst.green, width: 1.5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpFeildsShimmer extends StatelessWidget {
  SignUpFeildsShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 3.h),
      child: ShimmerEffect(
        child: Container(
          height: 5.h,
          color: AppConst.black,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: TextFormField(
                  style: TextStyle(fontSize: 14.sp),
                  textAlign: TextAlign.start,
                  cursorColor: AppConst.black,
                  decoration: InputDecoration(
                    isDense: true,
                    hintStyle: TextStyle(
                        color: AppConst.grey,
                        fontSize: SizeUtils.horizontalBlockSize * 4.2),
                    contentPadding: EdgeInsets.only(left: 2.w, bottom: 1.h),
                    hintTextDirection: TextDirection.ltr,
                    counterText: "",
                    suffixIconConstraints: BoxConstraints.tightFor(),
                    disabledBorder: InputBorder.none,
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppConst.grey, width: 1),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppConst.green, width: 1.5),
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
