import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/constants/string_constants.dart';

import 'package:customer_app/screens/home/controller/home_controller.dart';
import 'package:customer_app/screens/home/models/homeFavStoreModel.dart';
import 'package:customer_app/screens/home/models/homePageRemoteConfigModel.dart';
import 'package:customer_app/screens/more_stores/morestore_controller.dart';
import 'package:customer_app/theme/styles.dart';
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
      () => (_homeController.storeDataList.isEmpty)
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
                  color: colorList[index],
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox();
                // Divider(
                //   thickness: 1,
                //   height: 2.5.h,
                // );
              },
            ),
    );
  }
}

class ListViewChild extends StatelessWidget {
  final Data? inStoreModel;
  final Color color;

  ListViewChild({Key? key, required this.color, required this.inStoreModel})
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
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            inStoreModel!.logo!.isEmpty
                ? Padding(
                    padding: EdgeInsets.only(bottom: 3.h),
                    child: CircleAvatar(
                      child: Text(inStoreModel?.name?.substring(0, 1) ?? "",
                          style: TextStyle(
                              fontSize: SizeUtils.horizontalBlockSize * 6)),
                      backgroundColor: AppConst.blue,
                      radius: SizeUtils.horizontalBlockSize * 6.5,
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(bottom: 2.h),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(inStoreModel!.logo!),
                      backgroundColor: AppConst.white,
                      radius: SizeUtils.horizontalBlockSize * 6.5,
                    ),
                  ),
            SizedBox(
              width: 4.w,
            ),
            // inStoreModel!.logo!.isEmpty
            //     ? CircleAvatar(
            //         child: Text(
            //           inStoreModel?.name?.substring(0, 1) ?? "",
            //           style: TextStyle(fontSize: SizeUtils.horizontalBlockSize * 5),
            //         ),
            //         backgroundColor: color,
            //         radius: SizeUtils.horizontalBlockSize * 7,
            //       )
            //     : CircleAvatar(
            //         backgroundImage: NetworkImage(inStoreModel?.logo ?? ''),
            //         backgroundColor: AppConst.white,
            //         radius: SizeUtils.horizontalBlockSize * 7,
            //       ),
            // SizedBox(
            //   width: 3.w,
            // ),
            Expanded(
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
                  Text(
                    inStoreModel?.name ?? '',
                    maxLines: 1,
                    style: AppStyles.STORE_NAME_STYLE,
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
                          SizedBox(
                            width: 2.w,
                          ),
                          // (inStoreModel?.calculatedDistance != null)
                          //     ? Container(
                          //         // margin: EdgeInsets.only(top: 0.5.h),
                          //         padding: EdgeInsets.all(1.w),
                          //         decoration: BoxDecoration(
                          //             borderRadius: BorderRadius.circular(4),
                          //             border: Border.all(color: AppConst.grey)),
                          //         child: Text(
                          //             "${inStoreModel!.calculatedDistance!.toStringAsFixed(2)} km away",
                          //             style: TextStyle(
                          //                 fontSize:
                          //                     SizeUtils.horizontalBlockSize * 3,
                          //                 fontWeight: FontWeight.w500,
                          //                 fontFamily: 'Stag',
                          //                 color: AppConst.darkGrey,
                          //                 letterSpacing: 0.5)),
                          //       )
                          //     : SizedBox(),
                          SizedBox(
                            width: 2.w,
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
                      (inStoreModel?.calculatedDistance != null)
                          ? Container(
                              margin: EdgeInsets.only(top: 1.h),
                              padding: EdgeInsets.all(1.w),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: AppConst.grey)),
                              child: Text(
                                  "${(inStoreModel!.calculatedDistance!.toInt() / 1000).toStringAsFixed(2)} km away",
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
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppConst.grey,
              size: SizeUtils.horizontalBlockSize * 5,
            ),
            SizedBox(
              width: 2.w,
            ),
          ],
        ),
      ),
    );
  }
}
