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
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
      child: Row(
        children: [
          ShimmerEffect(child: DispalyStoreLogo()),
          SizedBox(
            width: 4.w,
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmerEffect(
                  child: Container(
                    width: 73.w,
                    color: AppConst.black,
                    child: Text(
                      '',
                    ),
                  ),
                ),
                SizedBox(
                  height: 0.5.h,
                ),
                ShimmerEffect(
                  child: Container(
                    width: 55.w,
                    color: AppConst.black,
                    child: Text(
                      '',
                    ),
                  ),
                ),
                SizedBox(
                  height: 0.5.h,
                ),
                Row(
                  children: [ShimmerEffect(child: DisplayPreminumStore())],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                  child: ShimmerEffect(
                    child: Container(
                        width: 68.w, height: 1, color: Color(0xffcacaca)),
                  ),
                ),
                ShimmerEffect(
                  child: Container(
                    width: 73.w,
                    color: AppConst.black,
                    child: Text(
                      '',
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
