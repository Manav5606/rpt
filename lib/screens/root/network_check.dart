import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CheckInternetConnectionWidget extends StatelessWidget {
  final AsyncSnapshot<ConnectivityResult> snapshot;
  final Widget widget;
  final bool showsnankbar;
  CheckInternetConnectionWidget(
      {Key? key,
      required this.snapshot,
      required this.widget,
      this.showsnankbar = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (snapshot.connectionState) {
      case ConnectionState.active:
        final state = snapshot.data!;
        switch (state) {
          case ConnectivityResult.none:
            return showsnankbar
                ? NetworkCheckSnackbar()
                : NetworkCheckFullScreen();
          default:
            return widget;
        }
      case ConnectionState.done:
        final state = snapshot.data!;
        switch (state) {
          case ConnectivityResult.none:
            return showsnankbar
                ? NetworkCheckSnackbar()
                : NetworkCheckFullScreen();
          default:
            return widget;
        }

      default:
        return widget;
    }
  }
}

class NetworkCheckSnackbar extends StatelessWidget {
  NetworkCheckSnackbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 5.h,
      child: Stack(
        children: [
          Positioned(
              bottom: 0.h,
              left: 20.w,
              right: 20.w,
              child: Container(
                height: 5.h,
                padding: EdgeInsets.symmetric(
                  vertical: 1.h,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: AppConst.veryLightGrey,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "No Internet Connectivity",
                      style: TextStyle(
                        fontFamily: 'MuseoSans',
                        color: AppConst.black,
                        fontSize: (SizerUtil.deviceType == DeviceType.tablet)
                            ? 8.sp
                            : 11.sp,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Icon(
                      Icons.wifi_off_outlined,
                      size: 2.5.h,
                      color: AppConst.black,
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

class NetworkCheckFullScreen extends StatelessWidget {
  const NetworkCheckFullScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.wifi_off,
                size: 20.h,
                color: AppConst.grey,
              ),
            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          Container(
            width: 75.w,
            child: Text(
              "Could not connect to internet. Please check your internet connection. Try again",
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppConst.black,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'MuseoSans',
                  fontStyle: FontStyle.normal,
                  fontSize: (SizerUtil.deviceType == DeviceType.tablet)
                      ? 8.sp
                      : 11.5.sp),
            ),
          ),
        ],
      ),
    ));
  }
}
