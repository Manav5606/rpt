import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:loading_overlay/loading_overlay.dart';

class IsScreenLoading extends StatelessWidget {
  final bool screenLoading;
  final Widget child;
  IsScreenLoading({required this.screenLoading, required this.child});

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overScroll) {
          overScroll.disallowGlow();
          return false;
        },
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: LoadingOverlay(
            isLoading: screenLoading,
            progressIndicator:
                SpinKitDualRing(color: Theme.of(context).primaryColor),
            color: AppConst.grey,
            child: WillPopScope(
                onWillPop: () async => screenLoading ? false : true,
                child: child),
          ),
        ));
  }
}
