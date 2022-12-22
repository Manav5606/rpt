import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:customer_app/app/constants/colors.dart';
import 'package:customer_app/app/ui/pages/my_wallet/wallet_screen_shimmer.dart';
import 'package:customer_app/screens/addcart/Widgets/store_name_call_logo.dart';
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
          // true
          ? Container(height: 90.h, child: WalletScreenShimmer())
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
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.h),
                  child: Container(height: 1, color: AppConst.grey),
                );
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
    Color? color = randomGenerator();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
      child: Column(
        children: [
          InkWell(
            onTap: () => {
              _paymentController.redeemCashInStorePageDataIndex.value =
                  storeSearchModel,
              Get.toNamed(AppRoutes.PayView, arguments: {"color": color}),
            },
            child: CardlistView(
                color: color,
                isDisplayDistance: true,
                StoreID: "${storeSearchModel.sId ?? ""}",
                StoreName: "${storeSearchModel.name ?? ""}",
                distanceOrOffer: storeSearchModel.distance ?? 0,
                Balance: storeSearchModel.earnedCashback ?? 0),
          ),
        ],
      ),
    );
  }
}

class CardlistView extends StatelessWidget {
  CardlistView(
      {Key? key,
      required this.color,
      required this.StoreID,
      this.StoreName,
      this.Balance,
      this.distanceOrOffer,
      this.isDisplayDistance = false
      // required this.storeSearchModel,
      })
      : super(key: key);

  final Color? color;
  final String? StoreName;
  final num? distanceOrOffer;
  final num? Balance;
  final String? StoreID;
  bool isDisplayDistance;
  // final RedeemCashInStorePageData storeSearchModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 12.h,
          width: 35.w,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: color,
              // circleColors[new Random().nextInt(7)],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppConst.grey)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 12.w,
                  height: 5.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppConst.white.withOpacity(0.1),
                  ),
                  child: Center(
                    child: Text((StoreName ?? "S").substring(0, 1),
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: AppConst.white,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                            fontSize: SizeUtils.horizontalBlockSize * 6)),
                  ),
                ),
                Spacer(),
                Text(
                    ((StoreID != Null && StoreID!.length > 6)
                        ? "Card ID: ${StoreID?.substring(StoreID!.length - 6)}"
                        : "Card ID: 123456"),
                    style: TextStyle(
                      fontFamily: 'MuseoSans',
                      color: AppConst.white,
                      fontSize: SizeUtils.horizontalBlockSize * 3.5,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                    ))
              ],
            ),
          ),
        ),
        SizedBox(
          width: 4.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 50.w,
              // height: 4.5.h,
              child: Text(StoreName ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'MuseoSans',
                    color: AppConst.black,
                    fontSize: SizeUtils.horizontalBlockSize * 3.7,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  )),
            ),
            SizedBox(
              height: 0.5.h,
            ),
            Text(
                isDisplayDistance
                    ? "${(distanceOrOffer!.toInt() / 1000).toStringAsFixed(2)} km"
                    : "Welcome Offer \u{20B9} ${distanceOrOffer ?? 0}",
                style: TextStyle(
                  fontSize: SizeUtils.horizontalBlockSize * 3.5,
                  color: AppConst.grey,
                  fontFamily: 'MuseoSans',
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                )),
            SizedBox(
              height: 2.h,
            ),
            SizedBox(
              width: 50.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Withdrawal Limit",
                      style: TextStyle(
                        fontFamily: 'MuseoSans',
                        fontSize: SizeUtils.horizontalBlockSize * 3.7,
                        color: AppConst.grey,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                      )),
                  Text(
                      // "\u{20B9}${storeSearchModel.earnedCashback?.toStringAsFixed(2) ?? 0}",
                      "\u{20B9}${Balance?.toStringAsFixed(2) ?? 0}",
                      style: TextStyle(
                        fontFamily: 'MuseoSans',
                        fontSize: SizeUtils.horizontalBlockSize * 3.7,
                        color: AppConst.black,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      )),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
