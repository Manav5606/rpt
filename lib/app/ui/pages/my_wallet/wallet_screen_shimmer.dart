import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/controller/my_wallet_controller.dart';
import 'package:customer_app/app/ui/common/shimmer_widget.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/widgets/backButton.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class WalletScreenShimmer extends StatefulWidget {
  WalletScreenShimmer({Key? key}) : super(key: key);

  @override
  State<WalletScreenShimmer> createState() => _WalletScreenShimmerState();
}

class _WalletScreenShimmerState extends State<WalletScreenShimmer> {
  // final MyWalletController _myWalletController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ShimmerEffect(
            //   child: Container(
            //     color: AppConst.black,
            //     height: 2.h,
            //     width: 40.w,
            //   ),
            // ),
            Expanded(
              child: ShimmerEffect(
                  child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
                      child: Column(children: [
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          children: [
                            ShimmerEffect(
                              child: Container(
                                height: 12.h,
                                width: 35.w,
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: AppConst.black,
                                    // circleColors[new Random().nextInt(7)],
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: AppConst.grey)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 2.w, vertical: 1.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 12.w,
                                        height: 5.h,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:
                                              AppConst.white.withOpacity(0.1),
                                        ),
                                      ),
                                      Spacer(),
                                      ShimmerEffect(
                                        child: Container(
                                          color: AppConst.black,
                                          height: 2.h,
                                          width: 30.w,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ShimmerEffect(
                                  child: Container(
                                    width: 50.w,
                                    height: 4.5.h,
                                    color: AppConst.black,
                                  ),
                                ),
                                SizedBox(
                                  height: 0.5.h,
                                ),
                                ShimmerEffect(
                                  child: Container(
                                    width: 30.w,
                                    height: 2.h,
                                    color: AppConst.black,
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                ShimmerEffect(
                                  child: Container(
                                    color: AppConst.black,
                                    height: 2.h,
                                    width: 50.w,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ]));
                },
                itemCount: 6,
                // _myWalletController.myWalletModel.value?.data?.length ?? 0,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox();
                },
              )),
            ),
          ],
        ),
      ),
    );
  }
}
