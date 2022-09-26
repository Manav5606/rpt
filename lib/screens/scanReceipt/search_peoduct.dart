import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/ui/common/shimmer_widget.dart';
import 'package:customer_app/app/ui/pages/search/models/get_near_me_page_data.dart';
import 'package:customer_app/app/ui/pages/search/models/recentProductsData.dart';
import 'package:customer_app/app/utils/utils.dart';
import 'package:customer_app/data/storesearchmodel.dart';
import 'package:customer_app/data/storesearchmodeldata.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/screens/scanReceipt/storeview_screen.dart';
import 'package:customer_app/screens/wallet/controller/paymentController.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:get/get.dart';

import '../../app/ui/pages/search/controller/exploreContoller.dart';
import '../../constants/app_const.dart';

class SearchList extends StatelessWidget {
  SearchList({Key? key}) : super(key: key);

  final PaymentController _paymentController = Get.find();
  final ExploreController _exploreController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        NearMePageData? data =
            _paymentController.getNearMePageDataModel.value?.data;
        return (((data?.products?.isEmpty ?? true) &&
                (data?.stores?.isEmpty ?? true)))
            ? Center(
                child: Text(
                "No data",
                style: AppStyles.STORES_SUBTITLE_STYLE,
              ))
            : Column(
                children: [
                  _paymentController.isLoading.value
                      ? ListView.separated(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: storeSearchData.length,
                          itemBuilder: (context, index) {
                            return _listViewChildShimmer(
                                name:
                                    storeSearchData[index].storeName.toString(),
                                logo: storeSearchData[index]
                                    .storeImage
                                    .toString(),
                                icon: Icons.arrow_forward_ios_rounded,
                                color: colorList[index],
                                onTap: () {});
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: SizeUtils.horizontalBlockSize * 2.55,
                            );
                          },
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: data?.stores?.length ?? 0,
                          itemBuilder: (context, index) {
                            return _listViewChild(
                              name: data!.stores![index].name.toString(),
                              logo: data.stores![index].logo.toString(),
                              icon: Icons.arrow_forward_ios_rounded,
                              color: colorList[index],
                              onTap: () async {
                                RecentProductsData recentProductsData =
                                    RecentProductsData(
                                  name: data.stores![index].name.toString(),
                                  logo: data.stores![index].logo.toString(),
                                  sId: data.stores![index].sId.toString(),
                                  isStore: true,
                                );
                                var contain = _paymentController
                                    .scanRecentProductList
                                    .where((element) =>
                                        element.sId == data.stores![index].sId);
                                if (contain.isEmpty) {
                                  _paymentController.setScanNearDataProduct(
                                      recentProductsData);
                                }
                                await _exploreController.getStoreData(
                                    id: data.stores![index].sId.toString(),
                                    isScanFunction: true);
                              },
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: SizeUtils.horizontalBlockSize * 2.55,
                            );
                          },
                        ),
                  SizedBox(
                    height: SizeUtils.horizontalBlockSize * 2.55,
                  ),
                ],
              );
      },
    );
  }

  Widget _listViewChild(
      {required String logo,
      required String name,
      required IconData icon,
      required Color color,
      required GestureTapCallback onTap}) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              logo.isEmpty
                  ? CircleAvatar(
                      child: Text(name.substring(0, 1),
                          style: TextStyle(
                              fontSize: SizeUtils.horizontalBlockSize * 5)),
                      backgroundColor: color,
                      radius: SizeUtils.horizontalBlockSize * 5.3,
                    )
                  : CircleAvatar(
                      backgroundImage: NetworkImage(logo),
                      backgroundColor: AppConst.white,
                      radius: SizeUtils.horizontalBlockSize * 5.3,
                    ),
              SizedBox(
                width: SizeUtils.horizontalBlockSize * 2.55,
              ),
              Expanded(
                child: Text(
                  name,
                  style: AppStyles.BOLD_STYLE,
                ),
              ),
              Icon(
                icon,
                color: AppConst.grey,
                size: SizeUtils.horizontalBlockSize * 5.3,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _listViewChildShimmer(
      {required String logo,
      required String name,
      required IconData icon,
      required Color color,
      required GestureTapCallback onTap}) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              logo.isEmpty
                  ? ShimmerEffect(
                      child: CircleAvatar(
                        child: Text(name.substring(0, 1),
                            style: TextStyle(
                                fontSize: SizeUtils.horizontalBlockSize * 5)),
                        backgroundColor: color,
                        radius: SizeUtils.horizontalBlockSize * 5.3,
                      ),
                    )
                  : ShimmerEffect(
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(logo),
                        backgroundColor: AppConst.white,
                        radius: SizeUtils.horizontalBlockSize * 5.3,
                      ),
                    ),
              SizedBox(
                width: SizeUtils.horizontalBlockSize * 2.55,
              ),
              ShimmerEffect(
                child: Text(
                  name,
                  style: AppStyles.BOLD_STYLE,
                ),
              ),
              ShimmerEffect(
                child: Icon(
                  icon,
                  color: AppConst.grey,
                  size: SizeUtils.horizontalBlockSize * 5.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
