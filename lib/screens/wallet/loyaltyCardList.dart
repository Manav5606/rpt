import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:customer_app/app/constants/colors.dart';
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
            child: Row(
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 12.w,
                          height: 5.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppConst.white.withOpacity(0.1),
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Color(0x19000000),
                            //     blurRadius: 6,
                            //     offset: Offset(1, 2),
                            //   ),
                            // ],
                            // border: Border.all(
                            //   width: 0.2,
                            //   color: Color(0xff006d60),
                            // ),
                          ),
                          child: Center(
                            child: Text(
                                storeSearchModel.name?.substring(0, 1) ?? "",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: AppConst.white,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.normal,
                                    fontSize:
                                        SizeUtils.horizontalBlockSize * 6)),
                          ),

                          //  ClipOval(
                          //   child: ClipRRect(
                          //     borderRadius: BorderRadius.circular(100),
                          //     child:

                          //     CachedNetworkImage(
                          //       width: 10.w,
                          //       height: 5.h,
                          //       fit: BoxFit.contain,
                          //       imageUrl: storeSearchModel.logo ??
                          //           'https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg',
                          //       progressIndicatorBuilder:
                          //           (context, url, downloadProgress) => Center(
                          //               child: CircularProgressIndicator(
                          //                   value: downloadProgress.progress)),
                          //       errorWidget: (context, url, error) => Container(
                          // color: Colors.primaries[Random()
                          //     .nextInt(Colors.primaries.length)],
                          //         child: Center(
                          //           child: Text(
                          //               storeSearchModel.name
                          //                       ?.substring(0, 1) ??
                          //                   "",
                          //               style: TextStyle(
                          //                   fontSize:
                          //                       SizeUtils.horizontalBlockSize *
                          //                           6)),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ),
                        Spacer(),
                        Text(
                            "Card ID   ${storeSearchModel.sId?.substring((storeSearchModel.sId?.length ?? 6) - 6) ?? "123456"}",
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
                      width: 50.w,
                      height: 4.5.h,
                      // color: AppConst.yellow,
                      child: Text(storeSearchModel.name ?? '',
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
                        "${(storeSearchModel.distance!.toInt() / 1000).toStringAsFixed(2)} km",
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
                          Text("Balance",
                              style: TextStyle(
                                fontFamily: 'MuseoSans',
                                fontSize: SizeUtils.horizontalBlockSize * 3.7,
                                color: AppConst.grey,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                              )),
                          Text(
                              "\u{20B9}${storeSearchModel.earnedCashback?.toStringAsFixed(2) ?? 0}",
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

                    // if (storeSearchModel.storeType?.isNotEmpty ?? false)
                    //   if ((storeSearchModel.storeType ?? '') == 'online')
                    //     Row(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Text("Pickup/", style: AppStyles.BOLD_STYLE),
                    //         Text(
                    //           "Delivery",
                    //           style: AppStyles.BOLD_STYLE_GREEN,
                    //         ),
                    //         SizedBox(
                    //           width: 2.w,
                    //         ),
                    //         (storeSearchModel.distance != null)
                    //             ? Container(
                    //                 margin: EdgeInsets.only(),
                    //                 padding: EdgeInsets.all(1.w),
                    //                 decoration: BoxDecoration(
                    //                   borderRadius: BorderRadius.circular(4),
                    //                   border: Border.all(color: AppConst.grey),
                    //                 ),
                    //                 child: Text(
                    //                     "${(storeSearchModel.distance!.toInt() / 1000).toStringAsFixed(2)} km away",
                    //                     style: TextStyle(
                    //                         fontSize:
                    //                             SizeUtils.horizontalBlockSize *
                    //                                 3,
                    //                         fontWeight: FontWeight.w500,
                    //                         fontFamily: 'Stag',
                    //                         color: AppConst.darkGrey,
                    //                         letterSpacing: 0.5)),
                    //               )
                    //             : SizedBox(),
                    //       ],
                    //     )
                    //   else
                    //     Row(
                    //       children: [
                    //         Text(StringContants.pickUp,
                    //             style: AppStyles.BOLD_STYLE),
                    //         SizedBox(
                    //           width: 20.w,
                    //         ),
                    //         (storeSearchModel.distance != null)
                    //             ? Container(
                    //                 margin: EdgeInsets.only(),
                    //                 padding: EdgeInsets.all(1.w),
                    //                 decoration: BoxDecoration(
                    //                   borderRadius: BorderRadius.circular(4),
                    //                   border: Border.all(color: AppConst.grey),
                    //                 ),
                    //                 child: Text(
                    //                     "${(storeSearchModel.distance!.toInt() / 1000).toStringAsFixed(2)} km away",
                    //                     style: TextStyle(
                    //                         fontSize:
                    //                             SizeUtils.horizontalBlockSize *
                    //                                 3,
                    //                         fontWeight: FontWeight.w500,
                    //                         fontFamily: 'Stag',
                    //                         color: AppConst.darkGrey,
                    //                         letterSpacing: 0.5)),
                    //               )
                    //             : SizedBox(),
                    //       ],
                    //     ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
