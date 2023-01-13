import 'dart:developer';

import 'package:customer_app/screens/more_stores/all_offers_listview.dart';
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
import 'package:sizer/sizer.dart';

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
                      ? shimmereffectsearch()
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
              DispalyStoreLogo(
                logo: logo,
                bottomPadding: 1,
              ),
              SizedBox(
                width: 3.w,
              ),
              Container(
                width: 68.w,
                child: Text(name,
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
              Spacer(),
              Icon(
                icon,
                color: AppConst.grey,
                size: SizeUtils.horizontalBlockSize * 5.3,
              ),
              SizedBox(
                width: 2.w,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class singleshimmer1 extends StatelessWidget {
  const singleshimmer1({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ShimmerEffect(
              child: DispalyStoreLogo(
                bottomPadding: 1,
              ),
            ),
            SizedBox(
              width: 3.w,
            ),
            ShimmerEffect(
                child: Container(
              height: 3.5.h,
              width: 70.w,
              color: AppConst.black,
            )),
            Spacer(),
            ShimmerEffect(
              child: Icon(
                Icons.arrow_forward_ios_outlined,
                color: AppConst.grey,
                size: SizeUtils.horizontalBlockSize * 5.3,
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
          ],
        ),
      ],
    );
  }
}

class shimmereffectsearch extends StatelessWidget {
  const shimmereffectsearch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        singleshimmer1(),
        SizedBox(
          height: 1.h,
        ),
        singleshimmer1(),
        SizedBox(
          height: 1.h,
        ),
        singleshimmer1(),
        SizedBox(
          height: 1.h,
        ),
        singleshimmer1(),
        SizedBox(
          height: 1.h,
        ),
        singleshimmer1(),
        SizedBox(
          height: 1.h,
        ),
      ],
    );
  }
}
