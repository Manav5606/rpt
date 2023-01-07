import 'dart:developer';

import 'package:customer_app/app/constants/app_constants.dart';
import 'package:customer_app/app/ui/pages/stores/chatOrder/chatOrder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/utils/utils.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/constants/string_constants.dart';
import 'package:customer_app/screens/home/controller/home_controller.dart';
import 'package:customer_app/screens/home/models/homeFavStoreModel.dart';
import 'package:customer_app/screens/more_stores/morestore_controller.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:customer_app/widgets/all_offers_listview_shimmer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AllOffersListView extends StatelessWidget {
  final ScrollController? controller;
  final HomeController _homeController = Get.find();

  final MoreStoreController _moreStoreController =
      Get.put(MoreStoreController());

  AllOffersListView({Key? key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: this.controller,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _homeController.homePageFavoriteShopsList.length,
      //data.length,
      itemBuilder: (context, index) {
        return Obx(() => _homeController.isPageLoading.value
            ? ListViewChildShimmer(
                // inStoreModel: _homeController.homePageFavoriteShopsList[index],
                // color: colorList[index],
                )
            : ListViewChild(
                inStoreModel: _homeController.homePageFavoriteShopsList[index],
                color: colorList[index],
              ));
      },
      separatorBuilder: (context, index) {
        return SizedBox(
            // height: 2.5.h,
            );
      },
    );
  }
}

class ListViewChild extends StatelessWidget {
  final HomeFavModel? inStoreModel;
  final Color color;

  ListViewChild({Key? key, required this.color, required this.inStoreModel})
      : super(key: key);
  final MoreStoreController _moreStoreController = Get.find();
  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: AppConst.highLightColor,
      onTap: () async {
        log('inStoreModel?.id : ${inStoreModel?.id}');
        log('businessId?.id : ${inStoreModel?.businesstype ?? ''}');
        // _homeController.getAllCartsModel.value?.carts?.forEach((element) {
        //
        // });
        _moreStoreController.storeId.value = inStoreModel?.id ?? '';
        await _moreStoreController.getStoreData(
            id: inStoreModel?.id ?? '',
            businessId: inStoreModel?.businesstype ?? '');
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
        child: Row(
          children: [
            DispalyStoreLogo(logo: inStoreModel?.logo),
            SizedBox(
              width: 4.w,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // ((inStoreModel?.premium ?? false) == true)
                  //     ? Text(
                  //         StringContants.latest,
                  //         style: TextStyle(
                  //             color: AppConst.kPrimaryColor,
                  //             fontSize: SizeUtils.horizontalBlockSize * 4),
                  //       )
                  //     : SizedBox(),
                  Row(
                    children: [
                      Container(
                        width: 68.w,
                        child: Text(inStoreModel?.name ?? '',
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
                        width: 2.w,
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppConst.grey,
                        size: SizeUtils.horizontalBlockSize * 5,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  // if (inStoreModel?.storeType?.isNotEmpty ?? false)
                  //   if ((inStoreModel?.storeType ?? '') == 'online')
                  //     Row(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Text("Pickup /", style: AppStyles.BOLD_STYLE),
                  //         Text(
                  //           " Delivery",
                  //           style: AppStyles.BOLD_STYLE_GREEN,
                  //         ),
                  //       ],
                  //     )
                  //   else
                  //     Text(StringContants.pickUp, style: AppStyles.BOLD_STYLE),
                  // Text(
                  //   "${StringContants.instoreprice}",
                  //   style: AppStyles.BOLD_STYLE,
                  // ),
                  Row(
                    children: [
                      (inStoreModel?.calculateDistance != null)
                          ? DisplayDistance(
                              distance: inStoreModel?.calculateDistance)
                          : SizedBox(),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 1.w, right: 2.w, top: 0.5.h),
                        child: Icon(
                          Icons.circle,
                          color: AppConst.grey,
                          size: 0.8.h,
                        ),
                      ),
                      if (inStoreModel?.storeType?.isNotEmpty ?? false)
                        if ((inStoreModel?.storeType ?? '') == 'online')
                          DsplayPickupDelivery()
                        else
                          Text("Only Pickup",
                              style: TextStyle(
                                fontFamily: 'MuseoSans',
                                color: AppConst.grey,
                                fontSize: SizeUtils.horizontalBlockSize * 3.7,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                              )),
                      // Container(
                      //   padding: EdgeInsets.all(1.w),
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(4),
                      //   ),
                      //   child: Text(
                      //     "In-Stores prices",
                      //     style: TextStyle(
                      //         fontSize: SizeUtils.horizontalBlockSize * 3,
                      //         fontWeight: FontWeight.w500,
                      //         fontFamily: 'Stag',
                      //         color: AppConst.darkGrey,
                      //         letterSpacing: 0.5),
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  Row(
                    children: [
                      ((inStoreModel?.premium ?? false) == true)
                          ? DisplayPreminumStore()
                          : (inStoreModel?.businesstype == Constants.fresh)
                              ? DisplayFreshStore()
                              : SizedBox(),
                      (inStoreModel?.businesstype == Constants.fresh)
                          ? SizedBox(
                              width: 3.w,
                            )
                          : SizedBox(),
                      DisplayCashback(
                        cashback: inStoreModel?.defaultCashback,
                        iscashbackPercentage: true,
                      ),
                    ],
                  ),
                  (inStoreModel?.bill_discount_offer_status ?? false)
                      ? Padding(
                          padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                          child: Container(
                              width: 68.w, height: 1, color: Color(0xffcacaca)),
                        )
                      : SizedBox(
                          height: 2.h,
                        ),
                  (inStoreModel?.bill_discount_offer_status ?? false)
                      ? Row(
                          children: [
                            Icon(
                              Icons.local_offer,
                              color: Color(0xffa12aff),
                              size: 1.8.h,
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Text(
                                "Get \u{20B9}${inStoreModel?.bill_discount_offer_amount} off for orders avove \u{20B9}${inStoreModel?.bill_discount_offer_target}",
                                style: TextStyle(
                                  fontFamily: 'MuseoSans',
                                  color: AppConst.black,
                                  fontSize: SizeUtils.horizontalBlockSize * 3.5,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                ))
                          ],
                        )
                      : SizedBox()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DisplayDistance extends StatelessWidget {
  DisplayDistance({Key? key, this.distance}) : super(key: key);

  num? distance;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(top: 1.h),
      padding: EdgeInsets.all(1.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        // border: Border.all(color: AppConst.grey),
      ),
      child: Text(
          //  "${(inStoreModel!.calculateDistance!.toInt() / 1000).toStringAsFixed(2)} km",
          "${(distance!.toInt() / 1000).toStringAsFixed(2)} km",
          style: TextStyle(
              fontSize: SizeUtils.horizontalBlockSize * 3,
              fontWeight: FontWeight.w500,
              fontFamily: 'Stag',
              color: AppConst.darkGrey,
              letterSpacing: 0.5)),
    );
  }
}

class DispalyStoreLogo extends StatelessWidget {
  DispalyStoreLogo({Key? key, this.logo, this.height, this.bottomPadding})
      : super(key: key);

  String? logo;
  num? height;
  num? bottomPadding;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: logo != null && logo != ""
          ? Padding(
              padding: EdgeInsets.only(bottom: 6.h),
              child: CircleAvatar(
                backgroundImage: NetworkImage(logo ?? ''),
                backgroundColor: AppConst.white,
                radius: SizeUtils.horizontalBlockSize * 6.5,
              ),
            )
          : Padding(
              padding: EdgeInsets.only(bottom: (bottomPadding ?? 5).h),
              child: Container(
                padding: const EdgeInsets.all(12.0),
                height: (height ?? 7).h,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppConst.lightGrey,
                    border: Border.all(
                      width: 0.1,
                      color: AppConst.lightGrey,
                    )),
                child: Image(
                  image: AssetImage(
                    'assets/images/Store.png',
                  ),
                ),
              ),
            ),
    );
  }
}

class DisplayFreshStore extends StatelessWidget {
  const DisplayFreshStore({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18.w,
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4), color: Color(0xfffff0e9)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.star, size: 1.8.h, color: Color(0xfffc763b)),
          Text("Meat",
              style: TextStyle(
                fontFamily: 'MuseoSans',
                color: Color(0xff462f03),
                fontSize: SizeUtils.horizontalBlockSize * 3.2,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
              )),
        ],
      ),
    );
  }
}

class DisplayPreminumStore extends StatelessWidget {
  const DisplayPreminumStore({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24.w,
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: AppConst.lightPichYellow),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(FontAwesomeIcons.crown, size: 1.8.h, color: Color(0xffe7a408)),
          Text("Premium",
              style: TextStyle(
                fontFamily: 'MuseoSans',
                color: Color(0xff462f03),
                fontSize: SizeUtils.horizontalBlockSize * 3.2,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
              )),
        ],
      ),
    );
  }
}

class DsplayPickupDelivery extends StatelessWidget {
  const DsplayPickupDelivery({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Pickup",
            style: TextStyle(
              fontFamily: 'MuseoSans',
              color: AppConst.grey,
              fontSize: SizeUtils.horizontalBlockSize * 3.7,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
            )),
        Padding(
          padding: EdgeInsets.only(left: 2.w, right: 2.w, top: 1.h),
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
              fontSize: SizeUtils.horizontalBlockSize * 3.7,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
            )),
      ],
    );
  }
}

class DisplayCashback extends StatelessWidget {
  DisplayCashback({Key? key, this.cashback, this.iscashbackPercentage})
      : super(key: key);

  bool? iscashbackPercentage;
  int? cashback;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 33.w,
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4), color: Color(0xffebf7f3)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: EdgeInsets.all(2),
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Color(0xff00d18f)),
            child: Icon(Icons.currency_rupee_rounded,
                size: 1.8.h, color: Color(0xffebf7f3)),
          ),
          Text(
              (iscashbackPercentage ?? false)
                  ? "${cashback ?? 0}% Cashback"
                  : "${cashback ?? 0} Cashback",
              style: TextStyle(
                fontFamily: 'MuseoSans',
                color: Color(0xff053e2a),
                fontSize: SizeUtils.horizontalBlockSize * 3.2,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
              )),
        ],
      ),
    );
  }
}
