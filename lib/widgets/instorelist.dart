import 'dart:developer';

import 'package:customer_app/app/constants/app_constants.dart';
import 'package:customer_app/app/ui/common/shimmer_widget.dart';
import 'package:customer_app/screens/more_stores/all_offers_listview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/constants/string_constants.dart';

import 'package:customer_app/screens/home/controller/home_controller.dart';
import 'package:customer_app/screens/home/models/homeFavStoreModel.dart';
import 'package:customer_app/screens/home/models/homePageRemoteConfigModel.dart';
import 'package:customer_app/screens/more_stores/morestore_controller.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../app/utils/utils.dart';

class InStoreList extends StatelessWidget {
  final ScrollController? controller;

  InStoreList({Key? key, this.controller}) : super(key: key);
  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (_homeController.isRemoteConfigPageLoading1.value)
          ? InstoreListShimmer()
          : (_homeController.storeDataList.isEmpty)
              ? Center(
                  child: Text(
                    StringContants.noData,
                  ),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _homeController.storeDataList.length,
                  itemBuilder: (context, index) {
                    return ListViewChild(
                      inStoreModel: _homeController.storeDataList[index],
                      // color: colorList[index],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox();
                  },
                ),
    );
  }
}

class ListViewChild extends StatelessWidget {
  final Data? inStoreModel;
  // final Color color;

  ListViewChild(
      {Key? key,
      // required this.color,
      required this.inStoreModel})
      : super(key: key);
  final MoreStoreController _moreStoreController = Get.find();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: AppConst.highLightColor,
      onTap: () async {
        _moreStoreController.storeId.value = inStoreModel?.sId ?? '';
        log('fghbjkl;');
        await _moreStoreController.getStoreData(
            id: inStoreModel?.sId ?? '',
            businessId: inStoreModel?.businesstype ?? '');
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 2.w,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DispalyStoreLogo(
              logo: inStoreModel?.logo,
            ),
            SizedBox(
              width: 2.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 72.w,
                      child: Text(inStoreModel?.name ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'MuseoSans',
                            color: AppConst.black,
                            fontSize: SizeUtils.horizontalBlockSize * 3.8,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                          )),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppConst.black,
                      size: SizeUtils.horizontalBlockSize * 3.5,
                    ),
                  ],
                ),
                SizedBox(
                  height: 0.5.h,
                ),
                Row(
                  children: [
                    (inStoreModel?.calculatedDistance != null)
                        ? DisplayDistance(
                            distance: inStoreModel?.calculatedDistance,
                          )
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
                      cashback: int.parse("${inStoreModel?.defaultCashback}"),
                      iscashbackPercentage: true,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                  child: Container(
                      width: 68.w, height: 1, color: Color(0xffcacaca)),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class InstoreListShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      InstoreListViewChildShimmer(),
      InstoreListViewChildShimmer(),
      InstoreListViewChildShimmer(),
      InstoreListViewChildShimmer(),
      InstoreListViewChildShimmer(),
      InstoreListViewChildShimmer(),
      InstoreListViewChildShimmer(),
    ]);
  }
}

class InstoreListViewChildShimmer extends StatelessWidget {
  InstoreListViewChildShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ShimmerEffect(
            child: DispalyStoreLogo(),
          ),
          SizedBox(
            width: 2.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ShimmerEffect(
                    child: Container(
                      width: 72.w,
                      height: 2.5.h,
                      color: AppConst.black,
                    ),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  ShimmerEffect(
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppConst.black,
                      size: SizeUtils.horizontalBlockSize * 3.5,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 0.7.h,
              ),
              Row(
                children: [
                  ShimmerEffect(
                    child: Container(
                      width: 55.w,
                      height: 2.5.h,
                      color: AppConst.black,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 0.7.h,
              ),
              Row(
                children: [
                  ShimmerEffect(
                    child: Container(
                      width: 20.w,
                      height: 2.5.h,
                      color: AppConst.black,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                child: ShimmerEffect(
                  child: Container(
                      width: 68.w, height: 1, color: Color(0xffcacaca)),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
