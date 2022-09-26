import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/ui/pages/stores/searchedStoresWihProductsShimmer.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/constants/string_constants.dart';
import 'package:customer_app/models/getRedeemCashStorePageDataModel.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'controller/paymentController.dart';

class loyaltyCardList extends StatelessWidget {
  loyaltyCardList({
    Key? key,
  }) : super(key: key);
  @override
  final PaymentController _paymentController = Get.find();

  Widget build(BuildContext context) {
    return Obx(
      () => _paymentController.isLoading.value
          ? SearchedStoreProductsListShimmer()
          : ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _paymentController
                      .getRedeemCashInStorePageData.value?.data?.length ??
                  0,
              itemBuilder: (context, index) {
                return ListViewChild(
                  storeSearchModel: _paymentController
                      .getRedeemCashInStorePageData.value!.data![index],
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            ),
    );
  }
}

class ListViewChild extends StatelessWidget {
  final RedeemCashInStorePageData storeSearchModel;

  ListViewChild({Key? key, required this.storeSearchModel}) : super(key: key);
  final PaymentController _paymentController = Get.find();

  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);

    return Column(
      children: [
        InkWell(
          onTap: () => {
            _paymentController.redeemCashInStorePageDataIndex.value =
                storeSearchModel,
            Get.toNamed(AppRoutes.PayView),
          },
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppConst.grey)),
                child: ClipOval(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                      width: 12.w,
                      height: 6.h,
                      fit: BoxFit.contain,
                      imageUrl: storeSearchModel.logo ??
                          'https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg',
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(
                                  value: downloadProgress.progress)),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.primaries[
                            Random().nextInt(Colors.primaries.length)],
                        child: Center(
                          child: Text(
                              storeSearchModel.name?.substring(0, 1) ?? "",
                              style: TextStyle(
                                  fontSize: SizeUtils.horizontalBlockSize * 6)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // (storeSearchModel.logo!.isEmpty)
              //     ? CircleAvatar(
              //         child: Text(storeSearchModel.name?.substring(0, 1) ?? "",
              //             style: TextStyle(
              //                 fontSize: SizeUtils.horizontalBlockSize * 6)),
              //         backgroundColor: Colors
              //             .primaries[Random().nextInt(Colors.primaries.length)],
              //         radius: SizeUtils.horizontalBlockSize * 6.5,
              //       )
              //     : CircleAvatar(
              //         backgroundImage:
              //             NetworkImage(storeSearchModel.logo ?? ''),
              //         backgroundColor: AppConst.white,
              //         radius: SizeUtils.horizontalBlockSize * 6.5,
              //       ),
              SizedBox(
                width: 4.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 60.w,
                    child: Text(
                      storeSearchModel.name ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.BOLD_STYLE,
                    ),
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  if (storeSearchModel.storeType?.isNotEmpty ?? false)
                    if ((storeSearchModel.storeType ?? '') == 'online')
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Pickup/", style: AppStyles.BOLD_STYLE),
                          Text(
                            "Delivery",
                            style: AppStyles.BOLD_STYLE_GREEN,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          (storeSearchModel.distance != null)
                              ? Container(
                                  margin: EdgeInsets.only(),
                                  padding: EdgeInsets.all(1.w),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(color: AppConst.grey),
                                  ),
                                  child: Text(
                                      "${(storeSearchModel.distance!.toInt() / 1000).toStringAsFixed(2)} km away",
                                      style: TextStyle(
                                          fontSize:
                                              SizeUtils.horizontalBlockSize * 3,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Stag',
                                          color: AppConst.darkGrey,
                                          letterSpacing: 0.5)),
                                )
                              : SizedBox(),
                        ],
                      )
                    else
                      Row(
                        children: [
                          Text(StringContants.pickUp,
                              style: AppStyles.BOLD_STYLE),
                          SizedBox(
                            width: 20.w,
                          ),
                          (storeSearchModel.distance != null)
                              ? Container(
                                  margin: EdgeInsets.only(),
                                  padding: EdgeInsets.all(1.w),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(color: AppConst.grey),
                                  ),
                                  child: Text(
                                      "${(storeSearchModel.distance!.toInt() / 1000).toStringAsFixed(2)} km away",
                                      style: TextStyle(
                                          fontSize:
                                              SizeUtils.horizontalBlockSize * 3,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Stag',
                                          color: AppConst.darkGrey,
                                          letterSpacing: 0.5)),
                                )
                              : SizedBox(),
                        ],
                      ),
                ],
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(right: 2.w),
                child: GestureDetector(
                  onTap: () {},
                  child: Text("${storeSearchModel.earnedCashback ?? 0}",
                      style: AppStyles.BOLD_STYLE_GREEN),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
