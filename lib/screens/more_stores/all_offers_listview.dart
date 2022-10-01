import 'dart:developer';

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
                inStoreModel: _homeController.homePageFavoriteShopsList[index],
                color: colorList[index],
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
            inStoreModel!.logo!.isEmpty
                ? Padding(
                    padding: EdgeInsets.only(bottom: 3.h),
                    child: CircleAvatar(
                      child: Text(inStoreModel?.name?.substring(0, 1) ?? "",
                          style: TextStyle(
                              fontSize: SizeUtils.horizontalBlockSize * 6)),
                      backgroundColor: color,
                      radius: SizeUtils.horizontalBlockSize * 6.5,
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(bottom: 2.h),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(inStoreModel?.logo ?? ''),
                      backgroundColor: AppConst.white,
                      radius: SizeUtils.horizontalBlockSize * 6.5,
                    ),
                  ),
            SizedBox(
              width: 4.w,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ((inStoreModel?.premium ?? false) == true)
                      ? Text(
                          StringContants.latest,
                          style: TextStyle(
                              color: AppConst.kPrimaryColor,
                              fontSize: SizeUtils.horizontalBlockSize * 4),
                        )
                      : SizedBox(),
                  Container(
                    width: 70.w,
                    child: Text(
                      inStoreModel?.name ?? '',
                      style: AppStyles.STORE_NAME_STYLE,
                    ),
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  if (inStoreModel?.storeType?.isNotEmpty ?? false)
                    if ((inStoreModel?.storeType ?? '') == 'online')
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Pickup /", style: AppStyles.BOLD_STYLE),
                          Text(
                            " Delivery",
                            style: AppStyles.BOLD_STYLE_GREEN,
                          ),
                        ],
                      )
                    else
                      Text(StringContants.pickUp, style: AppStyles.BOLD_STYLE),
                  // Text(
                  //   "${StringContants.instoreprice}",
                  //   style: AppStyles.BOLD_STYLE,
                  // ),
                  Row(
                    children: [
                      (inStoreModel?.calculateDistance != null)
                          ? Container(
                              margin: EdgeInsets.only(top: 1.h),
                              padding: EdgeInsets.all(1.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: AppConst.grey),
                              ),
                              child: Text(
                                  "${(inStoreModel!.calculateDistance!.toInt() / 1000).toStringAsFixed(2)} km away",
                                  style: TextStyle(
                                      fontSize:
                                          SizeUtils.horizontalBlockSize * 3,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Stag',
                                      color: AppConst.darkGrey,
                                      letterSpacing: 0.5)),
                            )
                          : SizedBox(),
                      SizedBox(
                        width: 2.w,
                      ),
                      // Container(
                      //   margin: EdgeInsets.only(top: 1.h),
                      //   padding: EdgeInsets.all(1.w),
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(4),
                      //       border: Border.all(color: AppConst.grey)),
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
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppConst.grey,
              size: SizeUtils.horizontalBlockSize * 5,
            ),
          ],
        ),
      ),
    );
  }
}
