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
  final MyWalletController _myWalletController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerEffect(child: BackButtonWidget()),
            SizedBox(
              height: 1.h,
            ),
            ShimmerEffect(
              child: Container(
                  // color: Colors.red,
                  height: 5.h,
                  width: 65.w,
                  alignment: Alignment.topLeft,
                  child: FittedBox(
                    child: Text(
                      "Wallet",
                      style: TextStyle(
                          fontSize: SizeUtils.horizontalBlockSize * 7,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
            ),
            SizedBox(
              height: 2.h,
            ),

            // ShimmerEffect(
            //   child: Container(
            //     color: AppConst.black,
            //     height: 2.h,
            //     width: 40.w,
            //   ),
            // ),
            Container(
              height: MediaQuery.of(context).size.height - 20.h,
              // color: AppConst.black,
              width: MediaQuery.of(context).size.width,
              child: ShimmerEffect(
                  child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 5.w,
                          backgroundColor: AppConst.white,
                          foregroundImage: NetworkImage(
                              "https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg"),
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ShimmerEffect(
                              child: Container(
                                color: AppConst.black,
                                height: 2.5.h,
                                width: 50.w,
                                child: Text(
                                  _myWalletController.myWalletModel.value
                                          ?.data?[index].name ??
                                      'Store Name',
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            ShimmerEffect(
                              child: Container(
                                color: AppConst.black,
                                height: 2.h,
                                width: 60.w,
                              ),
                            )
                          ],
                        ),
                        Spacer(),
                        Column(
                          children: [
                            ShimmerEffect(
                              child: Container(
                                color: AppConst.black,
                                height: 2.h,
                                width: 8.w,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                itemCount:
                    //  8,
                    _myWalletController.myWalletModel.value?.data?.length ?? 0,
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
              )),
            ),
          ],
        ),
      ),
    );
  }
}
