import 'package:flutter/material.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatelessWidget {
  final Widget child;
  const ShimmerEffect({required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppConst.shimmerbgColor,
      highlightColor: AppConst.white,
      period: const Duration(milliseconds: 1000),
      child: IgnorePointer(ignoring: true, child: child),
    );
  }
}
