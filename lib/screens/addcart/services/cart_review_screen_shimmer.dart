import 'package:cached_network_image/cached_network_image.dart';
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
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeUtils.horizontalBlockSize * 3,
                                vertical: SizeUtils.verticalBlockSize * 1),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3.w),
                                  color: AppConst.lightYellow),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        SizeUtils.horizontalBlockSize * 3,
                                    vertical: SizeUtils.verticalBlockSize * 1),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ShimmerEffect(
                                      child: Text(
                                        "You could save ₹0 a month",
                                        style: TextStyle(
                                          color: AppConst.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize:
                                              SizeUtils.horizontalBlockSize *
                                                  4.5,
                                        ),
                                      ),
                                    ),
                                    ShimmerEffect(
                                      child: Text(
                                        "Unlock unlimited free delivery and more",
                                        style: TextStyle(
                                          color: AppConst.grey,
                                          fontSize:
                                              SizeUtils.horizontalBlockSize * 4,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              SizeUtils.verticalBlockSize * 1),
                                      child: ShimmerEffect(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.w),
                                              color: AppConst.orange),
                                          child: Padding(
                                            padding: EdgeInsets.all(
                                                SizeUtils.horizontalBlockSize *
                                                    2),
                                            child: Text(
                                              "Here's how",
                                              style: TextStyle(
                                                color: AppConst.black,
                                                fontSize: SizeUtils
                                                        .horizontalBlockSize *
                                                    4,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            thickness: 2,
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
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        SizeUtils.horizontalBlockSize * 3,
                                    vertical: SizeUtils.verticalBlockSize * 2),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ShimmerEffect(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: CachedNetworkImage(
                                              width: SizeUtils
                                                      .horizontalBlockSize *
                                                  12,
                                              height: 6.h,
                                              fit: BoxFit.contain,
                                              imageUrl:
                                                  'https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg',
                                              progressIndicatorBuilder: (context,
                                                      url, downloadProgress) =>
                                                  Center(
                                                      child: CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress)),
                                              errorWidget: (context, url,
                                                      error) =>
                                                  Image.network(
                                                      'https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg'),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 2.w),
                                          child: ShimmerEffect(
                                            child: Container(
                                              width: 50.w,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    _addCartController
                                                            .reviewCart
                                                            .value
                                                            ?.data
                                                            ?.products?[i]
                                                            .name ??
                                                        "",
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: AppStyles.BOLD_STYLE,
                                                  ),
                                                  Text(
                                                    '',
                                                    style: AppStyles
                                                        .STORES_SUBTITLE_STYLE,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        ShimmerEffect(
                                          child: Container(
                                            width: 12.w,
                                            height: 5.h,
                                            child: Center(
                                              child: ShimmerEffect(
                                                child: Text(
                                                  "     ",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: AppStyles.BOLD_STYLE,
                                                ),
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                border: Border.all(
                                                    color: AppConst.grey)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ShimmerEffect(
                                            child: FaIcon(
                                              FontAwesomeIcons.trash,
                                              size: SizeUtils
                                                      .horizontalBlockSize *
                                                  4,
                                              color: AppConst.green,
                                            ),
                                          ),
                                          ShimmerEffect(
                                            child: SizedBox(
                                              width: 3.w,
                                            ),
                                          ),
                                          ShimmerEffect(
                                            child: Text(
                                              "Remove",
                                              style: TextStyle(
                                                  fontSize: SizeUtils
                                                          .horizontalBlockSize *
                                                      4,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Obx(
                () => ShimmerEffect(
                  child: Container(
                    color: AppConst.lightGrey,
                    child: Padding(
                      padding: EdgeInsets.all(2.h),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _addCartController
                                      .selectAddressHouse.value.isNotEmpty ||
                                  _addCartController
                                      .selectAddress.value.isNotEmpty
                              ? Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () async {},
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.location_on_rounded,
                                            color: AppConst.black,
                                          ),
                                          SizedBox(
                                            width: 2.w,
                                          ),
                                          Expanded(
                                            child: Text(
                                              "${_addCartController.selectAddressHouse.value} ",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: AppConst.black,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: SizeUtils
                                                          .horizontalBlockSize *
                                                      4),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 2.w,
                                          ),
                                          Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            color: AppConst.grey,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Divider(
                                      height: 0,
                                    ),
                                  ],
                                )
                              : SizedBox(),
                          _addCartController.timeTitle.value.isNotEmpty ||
                                  _addCartController.timeZone.value.isNotEmpty
                              ? GestureDetector(
                                  onTap: () async {},
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.timer,
                                            color: AppConst.black,
                                          ),
                                          SizedBox(
                                            width: 2.w,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${_addCartController.timeTitle.value}",
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: AppConst.black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: SizeUtils
                                                              .horizontalBlockSize *
                                                          4),
                                                ),
                                                Text(
                                                  "${_addCartController.timeZone.value}",
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: AppConst.black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: SizeUtils
                                                              .horizontalBlockSize *
                                                          4),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            color: AppConst.grey,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Divider(
                                        height: 0,
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox(),
                          SizedBox(
                            height: 2.h,
                          ),
                          Obx(
                            () => GestureDetector(
                              onTap: () async {},
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppConst.green,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                height: 6.h,
                                child: Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    _addCartController
                                                .timeTitle.value.isNotEmpty ||
                                            _addCartController
                                                .timeZone.value.isNotEmpty
                                        ? Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 5.h,
                                              width: 14.w,
                                              decoration: BoxDecoration(
                                                color: AppConst.grey,
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "\$14.77",
                                                  style: TextStyle(
                                                      color: AppConst.white,
                                                      fontSize: 10.sp),
                                                ),
                                              ),
                                            ),
                                          )
                                        : SizedBox(),
                                    Center(
                                        child: Text(
                                      _addCartController.selectAddressHouse
                                                  .value.isEmpty &&
                                              _addCartController
                                                  .selectAddress.value.isEmpty
                                          ? "Add Delivery Address"
                                          : _addCartController
                                                      .selectAddressHouse
                                                      .value
                                                      .isNotEmpty ||
                                                  _addCartController
                                                      .selectAddress
                                                      .value
                                                      .isNotEmpty
                                              ? "Add Time"
                                              : "",
                                      style: TextStyle(color: AppConst.white),
                                    )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
