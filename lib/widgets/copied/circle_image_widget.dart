import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:customer_app/constants/app_const.dart';

class CircleImageWidget extends StatelessWidget {
  final String? image;

  CircleImageWidget({this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      width: 52,
      // margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppConst.white,
        // border: Border.all(color: Colors.grey[500]),
        boxShadow: [
          BoxShadow(
            color: AppConst.lightGrey,
            spreadRadius: 5,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100.0),
        child: CachedNetworkImage(
          imageUrl: image!,
          placeholder: (context, url) =>
              SpinKitCircle(size: 24.0, color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}

class ImageFromNetwork extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final double? borderRadius;
  final BoxDecoration? decoration;

  ImageFromNetwork(
      {required this.image,
      this.height,
      this.width,
      this.borderRadius,
      this.decoration});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 50.0,
      width: width ?? 50.0,
      decoration: this.decoration ??
          BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius ?? 0.0),
            color: AppConst.white,
            // border: Border.all(color: Colors.grey[500]),
            boxShadow: [
              BoxShadow(
                color: AppConst.lightGrey,
                spreadRadius: 5,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius ?? 0.0),
        child: CachedNetworkImage(
          imageUrl: image,
          fit: BoxFit.fill,
          placeholder: (context, url) =>
              SpinKitCircle(size: 24.0, color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}
