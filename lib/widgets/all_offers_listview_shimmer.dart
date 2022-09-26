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
      itemCount: _homeController.homePageFavoriteShopsList.length,
      //data.length,
      itemBuilder: (context, index) {
        return ShimmerEffect(
          child: ListViewChildShimmer(
            inStoreModel: _homeController.homePageFavoriteShopsList[index],
            color: colorList[index],
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
  final HomeFavModel? inStoreModel;
  final Color color;

  ListViewChildShimmer(
      {Key? key, required this.color, required this.inStoreModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // await _exploreController.getStoreData(id: inStoreModel?.id ?? '');
        // _exploreController.getStoreDataModel.refresh();
      },
      child: Row(
        children: [
          inStoreModel!.logo!.isEmpty
              ? ShimmerEffect(
                  child: CircleAvatar(
                    child: Text(inStoreModel?.name?.substring(0, 1) ?? "",
                        style: TextStyle(
                            fontSize: SizeUtils.horizontalBlockSize * 5)),
                    backgroundColor: color,
                    radius: SizeUtils.horizontalBlockSize * 7,
                  ),
                )
              : ShimmerEffect(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(inStoreModel?.logo ?? ''),
                    backgroundColor: AppConst.white,
                    radius: SizeUtils.horizontalBlockSize * 7,
                  ),
                ),
          SizedBox(
            width: 3.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ((inStoreModel?.premium ?? false) == true)
                    ? ShimmerEffect(
                        child: Text(
                          StringContants.latest,
                          style: TextStyle(
                              color: AppConst.kPrimaryColor,
                              fontSize: SizeUtils.horizontalBlockSize * 4),
                        ),
                      )
                    : ShimmerEffect(child: Container()),
                ShimmerEffect(
                  child: Text(
                    inStoreModel?.name ?? '',
                    style: AppStyles.STORE_NAME_STYLE,
                  ),
                ),
                if (inStoreModel?.storeType?.isNotEmpty ?? false)
                  if ((inStoreModel?.storeType ?? '') == 'online')
                    ShimmerEffect(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Pickup/", style: AppStyles.BOLD_STYLE),
                          Text(
                            "Delivery",
                            style: AppStyles.BOLD_STYLE_GREEN,
                          ),
                        ],
                      ),
                    )
                  else
                    ShimmerEffect(
                        child: Text(StringContants.pickUp,
                            style: AppStyles.BOLD_STYLE)),
                ShimmerEffect(
                  child: Text(
                    "${StringContants.instoreprice}",
                    style: AppStyles.BOLD_STYLE,
                  ),
                ),
                ShimmerEffect(
                  child: Row(
                    children: [
                      (inStoreModel?.calculateDistance != null)
                          ? Container(
                              margin: EdgeInsets.all(1.w),
                              padding: EdgeInsets.all(1.w),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      SizeUtils.horizontalBlockSize * 1.5),
                                  border: Border.all(color: AppConst.grey)),
                              child: Text(
                                "${inStoreModel!.calculateDistance!.toStringAsFixed(2)} mi away",
                                style: AppStyles.STORES_SUBTITLE_STYLE,
                              ),
                            )
                          : SizedBox(),
                      Container(
                        margin: EdgeInsets.all(1.w),
                        padding: EdgeInsets.all(1.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                SizeUtils.horizontalBlockSize * 1.5),
                            border: Border.all(color: AppConst.grey)),
                        child: Text(
                          "In-Stores prices",
                          style: AppStyles.STORES_SUBTITLE_STYLE,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ShimmerEffect(
            child: Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppConst.grey,
              size: SizeUtils.horizontalBlockSize * 5,
            ),
          ),
        ],
      ),
    );
  }
}
