import 'package:cached_network_image/cached_network_image.dart';
import 'package:customer_app/app/ui/pages/stores/chatOrder/chatOrder.dart';
import 'package:customer_app/screens/addcart/cartReviewScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../app/constants/responsive.dart';
import '../../../app/ui/common/shimmer_widget.dart';
import '../../../theme/styles.dart';
import '../controller/addcart_controller.dart';

class CartReviewScreenShimmer extends StatelessWidget {
  CartReviewScreenShimmer({Key? key}) : super(key: key);
  final AddCartController _addCartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: SizeUtils.horizontalBlockSize * 2,
            vertical: SizeUtils.verticalBlockSize * 1),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                child: ShimmerEffect(
                  child: Container(
                    width: double.infinity,
                    height: 10.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.w),
                        color: Color(0xfffe6faf1)),
                  ),
                ),
              ),
              ListView.separated(
                itemCount: _addCartController
                        .reviewCart.value?.data?.products?.length ??
                    0,
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: SizeUtils.verticalBlockSize * 1,
                  );
                },
                shrinkWrap: true,
                primary: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, i) {
                  return RevewCartShimmerWidget();
                },
              ),
              ListView.separated(
                itemCount: _addCartController
                        .reviewCart.value?.data?.rawItems?.length ??
                    0,
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: SizeUtils.verticalBlockSize * 1,
                  );
                },
                shrinkWrap: true,
                primary: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, i) {
                  return RevewCartShimmerWidget();
                },
              ),
              ListView.separated(
                itemCount: _addCartController
                        .reviewCart.value?.data?.inventories?.length ??
                    0,
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: SizeUtils.verticalBlockSize * 1,
                  );
                },
                shrinkWrap: true,
                primary: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, i) {
                  return RevewCartShimmerWidget();
                },
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class RevewCartShimmerWidget extends StatelessWidget {
  const RevewCartShimmerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 3.w, top: 1.h, bottom: 1.h),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ShimmerEffect(
                child: Container(
                  width: 15.w,
                  height: 8.h,
                  color: AppConst.black,
                ),
              ),
              SizedBox(
                width: 2.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerEffect(
                    child: Container(
                      width: 55.w,
                      height: 2.h,
                      color: AppConst.black,
                    ),
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  ShimmerEffect(
                    child: Container(
                      width: 45.w,
                      height: 2.h,
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
                ],
              ),
              Spacer(),
              ShimmerEffect(
                child: Container(
                  width: 15.w,
                  height: 3.5.h,
                  color: AppConst.black,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
