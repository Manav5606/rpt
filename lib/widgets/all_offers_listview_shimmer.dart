import 'package:customer_app/app/constants/app_constants.dart';
import 'package:customer_app/screens/more_stores/all_offers_listview.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/ui/common/shimmer_widget.dart';
import 'package:customer_app/app/ui/pages/search/controller/exploreContoller.dart';
import 'package:customer_app/app/utils/utils.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/constants/string_constants.dart';
import 'package:customer_app/screens/home/controller/home_controller.dart';
import 'package:customer_app/screens/home/models/homeFavStoreModel.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AllOffersListViewShimmer extends StatelessWidget {
  final ScrollController? controller;
  final HomeController _homeController = Get.find();

  AllOffersListViewShimmer({Key? key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: this.controller,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 4,
      //data.length,
      itemBuilder: (context, index) {
        return ShimmerEffect(
          child: ListViewChildShimmer(
              // inStoreModel: _homeController.homePageFavoriteShopsList[index],
              // color: colorList[index],
              ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          thickness: 1,
          height: 2.5.h,
        );
      },
    );
  }
}

class ListViewChildShimmer extends StatelessWidget {
  ListViewChildShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 2.w, top: 1.h, bottom: 1.h),
      child: Row(
        children: [
          ShimmerEffect(
              child: Container(
            width: 20.w,
            height: 10.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppConst.black,
            ),
          )),
          SizedBox(
            width: 3.w,
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ShimmerEffect(
                    child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: AppConst.black,
                  ),
                  width: 50.w,
                  height: 1.5.h,
                )),
                SizedBox(
                  height: 1.h,
                ),
                ShimmerEffect(
                    child: Container(
                  width: 40.w,
                  height: 1.4.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: AppConst.black,
                  ),
                )),
                SizedBox(
                  height: 1.h,
                ),
                ShimmerEffect(
                    child: Container(
                  width: 30.w,
                  height: 1.2.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: AppConst.black,
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
