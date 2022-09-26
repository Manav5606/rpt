import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/utils/ui_spacing_helper.dart';

class BaseButton extends StatelessWidget {
  final Function? onTap;
  final Color? filledColor;
  final Widget? prefix;
  final String? title;
  final bool? enabled;
  final bool? isLoading;
  final double? height;

  const BaseButton(
      {Key? key,
      this.onTap,
      this.title,
      this.enabled: true,
      this.prefix,
      this.height: 44.0,
      this.filledColor: AppConst.themePurple,
      this.isLoading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: RaisedButton(
          color: this.filledColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
          onPressed: isLoading! || !enabled! ? null : onTap as void Function(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              (prefix != null)
                  ? Container(
                      margin: const EdgeInsets.only(right: 16.0),
                      child: prefix,
                    )
                  : Container(),
            ]..addAll((isLoading!)
                ? [
                    Text(
                      title!,
                      style: AppConst.body.copyWith(color: AppConst.white),
                    ),
                    UISpacingHelper.horizontalSpaceMedium,
                    SpinKitThreeBounce(
                      color: AppConst.white,
                      size: 17.0,
                    )
                  ]
                : [
                    Text(
                      title!.toUpperCase(),
                      style: AppConst.body.copyWith(color: AppConst.white),
                    )
                  ]),
          )),
      height: height ?? 44.0,
    );
  }
}
