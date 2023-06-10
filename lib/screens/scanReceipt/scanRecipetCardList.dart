import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:customer_app/app/constants/app_constants.dart';
import 'package:customer_app/app/ui/common/shimmer_widget.dart';
import 'package:customer_app/screens/more_stores/all_offers_listview.dart';
import 'package:customer_app/widgets/all_offers_listview_shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/ui/pages/stores/searchedStoresWihProductsShimmer.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/constants/string_constants.dart';
import 'package:customer_app/models/getRedeemCashStorePageDataModel.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/screens/wallet/controller/paymentController.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../app/ui/pages/search/controller/exploreContoller.dart';

class ScanReceiptCard extends StatelessWidget {
  ScanReceiptCard({
    Key? key,
  }) : super(key: key);
  @override
  final PaymentController _paymentController = Get.find();
  final ExploreController _exploreController = Get.find();

  Widget build(BuildContext context) {
    return Obx(
      () => (_paymentController.isLoading.value)
          ? ScanReciptShimmerView()
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
                return SizedBox();
                // Divider();
              },
            ),
    );
  }
}

class ListViewChild extends StatelessWidget {
  final RedeemCashInStorePageData storeSearchModel;

  ListViewChild({Key? key, required this.storeSearchModel}) : super(key: key);
  final ExploreController _exploreController = Get.find();
  final PaymentController _paymentController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () async {
            _paymentController.isLoading.value = true;
            await _exploreController.getStoreData(
                id: storeSearchModel.sId.toString(), isScanFunction: true);
            _paymentController.redeemCashInStorePageDataIndex.value =
                storeSearchModel;
            _paymentController.isLoading.value = false;
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.w),
            child: Row(
              children: [
                // Container(
                //   decoration: BoxDecoration(
                //       shape: BoxShape.circle,
                //       border: Border.all(color: AppConst.grey)),
                //   child: ClipOval(
                //     child: ClipRRect(
                //       borderRadius: BorderRadius.circular(100),
                //       child: CachedNetworkImage(
                //         width: 12.w,
                //         height: 6.h,
                //         fit: BoxFit.contain,
                //         imageUrl: storeSearchModel.logo ??
                //             'https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg',
                //         progressIndicatorBuilder:
                //             (context, url, downloadProgress) => Center(
                //                 child: CircularProgressIndicator(
                //                     value: downloadProgress.progress)),
                //         errorWidget: (context, url, error) => Container(
                //           color: Colors.primaries[
                //               Random().nextInt(Colors.primaries.length)],
                //           child: Center(
                //             child: Text(
                //                 storeSearchModel.name?.substring(0, 1) ?? "",
                //                 style: TextStyle(
                //                     fontSize:
                //                         SizeUtils.horizontalBlockSize * 6)),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
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
                // storeSearchModel.logo!.isEmpty
                //     ?

                //     Padding(
                //         padding: EdgeInsets.only(bottom: 3.h),
                //         child: Container(
                //           padding: const EdgeInsets.all(12.0),
                //           height: 7.h,
                //           decoration: BoxDecoration(
                //               shape: BoxShape.circle,
                //               color: AppConst.lightGrey,
                //               border: Border.all(
                //                 width: 0.1,
                //                 color: AppConst.lightGrey,
                //               )),
                //           child: Image(
                //             image: AssetImage(
                //               'assets/images/Store.png',
                //             ),
                //           ),
                //         ),
                //       )
                //     : Padding(
                //         padding: EdgeInsets.only(bottom: 3.h),
                //         child: CircleAvatar(
                //           backgroundImage:
                //               NetworkImage(storeSearchModel.logo ?? ''),
                //           backgroundColor: AppConst.white,
                //           radius: SizeUtils.horizontalBlockSize * 6.5,
                //         ),
                //       ),
                DispalyStoreLogo(
                  logo: storeSearchModel.store?.logo,
                  bottomPadding: 2,
                ),
                SizedBox(
                  width: 3.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 68.w,
                      child: Text(storeSearchModel.name ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'MuseoSans',
                            color: AppConst.black,
                            fontSize: SizeUtils.horizontalBlockSize * 4,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                          )),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Row(
                      children: [
                        (storeSearchModel.store?.distance != null)
                            ? Container(
                                // margin: EdgeInsets.only(top: 1.h),
                                padding: EdgeInsets.all(1.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  // border: Border.all(color: AppConst.grey),
                                ),
                                child: Text(
                                    "${(storeSearchModel.store!.distance!.toInt() / 1000).toStringAsFixed(2)} km",
                                    style: TextStyle(
                                        fontSize:
                                            SizeUtils.horizontalBlockSize * 3,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Stag',
                                        color: AppConst.darkGrey,
                                        letterSpacing: 0.5)),
                              )
                            : SizedBox(),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 1.w, right: 2.w, top: 0.5.h),
                          child: Icon(
                            Icons.circle,
                            color: AppConst.grey,
                            size: 0.8.h,
                          ),
                        ),
                        if (storeSearchModel.store?.storeType?.isNotEmpty ??
                            false)
                          if ((storeSearchModel.store?.storeType ?? '') ==
                              'online')
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Pickup",
                                    style: TextStyle(
                                      fontFamily: 'MuseoSans',
                                      color: AppConst.grey,
                                      fontSize:
                                          SizeUtils.horizontalBlockSize * 3.7,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                    )),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 2.w, right: 2.w, top: 1.h),
                                  child: Icon(
                                    Icons.circle,
                                    color: AppConst.grey,
                                    size: 0.8.h,
                                  ),
                                ),
                                Text("Delivery",
                                    style: TextStyle(
                                      fontFamily: 'MuseoSans',
                                      color: AppConst.grey,
                                      fontSize:
                                          SizeUtils.horizontalBlockSize * 3.7,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                    )),
                              ],
                            )
                          else
                            Text("Only Pickup",
                                style: TextStyle(
                                  fontFamily: 'MuseoSans',
                                  color: AppConst.grey,
                                  fontSize: SizeUtils.horizontalBlockSize * 3.7,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                )),
                      ],
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Row(
                      children: [
                        (storeSearchModel.store?.businesstype ==
                                Constants.fresh)
                            ? Container(
                                width: 18.w,
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Color(0xfffff0e9)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(Icons.star,
                                        size: 1.8.h, color: Color(0xfffc763b)),
                                    Text("Meat",
                                        style: TextStyle(
                                          fontFamily: 'MuseoSans',
                                          color: Color(0xff462f03),
                                          fontSize:
                                              SizeUtils.horizontalBlockSize *
                                                  3.2,
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.normal,
                                        )),
                                  ],
                                ),
                              )
                            : SizedBox(),
                        (storeSearchModel.store?.businesstype ==
                                Constants.fresh)
                            ? SizedBox(
                                width: 3.w,
                              )
                            : SizedBox(),
                        (storeSearchModel.earnedCashback != null)
                            ? Container(
                                width: 18.w,
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Color(0xffe1f7ff)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(Icons.account_balance_wallet_rounded,
                                        size: 1.8.h, color: Color(0xff009ed1)),
                                    Text("Wallet",
                                        style: TextStyle(
                                          fontFamily: 'MuseoSans',
                                          color: Color(0xff003d51),
                                          fontSize:
                                              SizeUtils.horizontalBlockSize *
                                                  3.2,
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.normal,
                                        )),
                                  ],
                                ),
                              )
                            : SizedBox(),
                        (storeSearchModel.store?.businesstype ==
                                Constants.fresh)
                            ? SizedBox(
                                width: 3.w,
                              )
                            : SizedBox(),
                        (storeSearchModel.store?.actualCashback != null)
                            ? Container(
                                width: 32.w,
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Color(0xffebf7f3)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xff00d18f)),
                                      child: Icon(Icons.currency_rupee_rounded,
                                          size: 1.8.h,
                                          color: Color(0xffebf7f3)),
                                    ),
                                    Text(
                                        "${storeSearchModel.store?.actualCashback ?? 0}% Cashback",
                                        style: TextStyle(
                                          fontFamily: 'MuseoSans',
                                          color: Color(0xff053e2a),
                                          fontSize:
                                              SizeUtils.horizontalBlockSize *
                                                  3.2,
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.normal,
                                        )),
                                  ],
                                ),
                              )
                            : SizedBox(width: 1.w),
                      ],
                    ),

                    // if (storeSearchModel.storeType?.isNotEmpty ?? false)
                    //   if ((storeSearchModel.storeType ?? '') == 'online')
                    //     Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Row(
                    //           children: [
                    //             Text("Pickup/", style: AppStyles.BOLD_STYLE),
                    //             Text(
                    //               "Delivery",
                    //               style: AppStyles.BOLD_STYLE_GREEN,
                    //             ),
                    //             SizedBox(
                    //               width: 2.w,
                    //             ),
                    //           ],
                    //         ),
                    //         SizedBox(
                    //           height: 0.5.h,
                    //         ),
                    //             (storeSearchModel.distance != null)
                    //                 ? Container(
                    //                     margin: EdgeInsets.only(),
                    //                     padding: EdgeInsets.all(1.w),
                    //                     decoration: BoxDecoration(
                    //                       borderRadius: BorderRadius.circular(4),
                    //                       border: Border.all(color: AppConst.grey),
                    //                     ),
                    //                     child: Text(
                    //                         "${(storeSearchModel.distance!.toInt() / 1000).toStringAsFixed(2)} km away",
                    //                         style: TextStyle(
                    //                             fontSize:
                    //                                 SizeUtils.horizontalBlockSize *
                    //                                     3,
                    //                             fontWeight: FontWeight.w500,
                    //                             fontFamily: 'Stag',
                    //                             color: AppConst.darkGrey,
                    //                             letterSpacing: 0.5)),
                    //                   )
                    //                 : SizedBox(),
                    //           ],
                    //         )
                    //       else
                    //         Column(
                    //           children: [
                    //             Text(StringContants.pickUp,
                    //                 style: AppStyles.BOLD_STYLE),
                    //             SizedBox(
                    //               width: 2.w,
                    //             ),
                    //             (storeSearchModel.distance != null)
                    //                 ? Container(
                    //                     margin: EdgeInsets.only(),
                    //                     padding: EdgeInsets.all(1.w),
                    //                     decoration: BoxDecoration(
                    //                       borderRadius: BorderRadius.circular(4),
                    //                       border: Border.all(color: AppConst.grey),
                    //                     ),
                    //                     child: Text(
                    //                         "${(storeSearchModel.distance!.toInt() / 1000).toStringAsFixed(2)} km away",
                    //                         style: TextStyle(
                    //                             fontSize:
                    //                                 SizeUtils.horizontalBlockSize *
                    //                                     3,
                    //                             fontWeight: FontWeight.w500,
                    //                             fontFamily: 'Stag',
                    //                             color: AppConst.darkGrey,
                    //                             letterSpacing: 0.5)),
                    //                   )
                    //                 : SizedBox(),
                    //           ],
                    //         ),
                  ],
                ),
                // Spacer(),
                // Padding(
                //   padding: EdgeInsets.only(right: 2.w),
                //   child: GestureDetector(
                //     onTap: () {},
                //     child: Text("${storeSearchModel.earnedCashback ?? 0}",
                //         style: AppStyles.BOLD_STYLE_GREEN),
                //   ),
                // ),
              ],
            ),
          ),
        ),
        Container(
          height: 1,
          width: 90.w,
          color: AppConst.grey,
        )
      ],
    );
  }
}

class ScanReciptShimmerView extends StatelessWidget {
  ScanReciptShimmerView({
    Key? key,
  }) : super(key: key);
  final PaymentController _paymentController = Get.find();
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 1.h),
      itemBuilder: (context, index) {
        return ScanListViewChildShimmer();
      },
      itemCount: 6,
      separatorBuilder: (context, index) {
        return SizedBox();
      },
    );
  }
}

class ScanListViewChildShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.w),
            child: Row(
              children: [
                ShimmerEffect(
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppConst.black, shape: BoxShape.circle),
                    child: ClipOval(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          width: 12.w,
                          height: 6.h,
                          fit: BoxFit.contain,
                          imageUrl:
                              'https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg',
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                                  child: CircularProgressIndicator(
                                      value: downloadProgress.progress)),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.primaries[
                                Random().nextInt(Colors.primaries.length)],
                            child: Center(),
                          ),
                        ),
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
                        color: AppConst.black,
                        height: 2.h,
                        width: 60.w,
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    ShimmerEffect(
                      child: Container(
                        color: AppConst.black,
                        height: 2.h,
                        width: 50.w,
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    ShimmerEffect(
                      child: Container(
                        color: AppConst.black,
                        height: 2.h,
                        width: 40.w,
                      ),
                    ),
                  ],
                ),
                // Spacer(),
                // Padding(
                //   padding: EdgeInsets.only(right: 2.w),
                //   child: ShimmerEffect(
                //     child: Container(
                //       color: AppConst.black,
                //       height: 2.h,
                //       width: 5.w,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
