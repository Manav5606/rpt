import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/ui/pages/search/controller/exploreContoller.dart';
import 'package:customer_app/app/ui/pages/search/models/recentProductsData.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:customer_app/widgets/defaultstoreicon.dart';
import 'package:get/get.dart';

import '../screens/wallet/controller/paymentController.dart';

class RecentSearchList extends StatelessWidget {
  List<RecentProductsData>? foundedStores;
  final ScrollController? controller;
  bool isScanFunction;

  RecentSearchList(
      {Key? key,
      this.controller,
      required this.foundedStores,
      this.isScanFunction = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (foundedStores!.isEmpty)
        ? Center(
            child: Text(
            "No Recent Item!!",
            style: AppStyles.STORES_SUBTITLE_STYLE,
          ))
        : ListView.separated(
            controller: this.controller,
            shrinkWrap: true,
            reverse: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: foundedStores!.length,
            //data.length,
            itemBuilder: (context, index) {
              return ListViewChild(
                popularSearchModel: foundedStores![index],
                isScanFunction: isScanFunction,
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: SizeUtils.horizontalBlockSize * 2.55,
              );
            },
          );
  }
}

class ListViewChild extends StatelessWidget {
  final RecentProductsData popularSearchModel;
  final bool isScanFunction;

  ListViewChild(
      {Key? key,
      required this.popularSearchModel,
      required this.isScanFunction})
      : super(key: key);
  final ExploreController _exploreController = Get.find();
  final PaymentController _paymentController = Get.find();

  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);

    return Column(
      children: [
        InkWell(
          onTap: () => {
            if (isScanFunction == false)
              {
                _exploreController.searchText.value = popularSearchModel.name!,
                _exploreController.searchController.text =
                    _exploreController.searchText.value,
                _exploreController.getNearMePageData(
                    searchText: _exploreController.searchText.value),
              }
            else
              {
                _paymentController.searchText.value = popularSearchModel.name!,
                _paymentController.searchController.text =
                    _paymentController.searchText.value,
                _paymentController.getNearMePageData(
                    searchText: _paymentController.searchText.value),
              }
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              (popularSearchModel.logo!.isNotEmpty)
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(popularSearchModel.logo!),
                      backgroundColor: AppConst.white,
                      radius: SizeUtils.horizontalBlockSize * 5.3,
                    )
                  : defaultStoreWidget(),
              SizedBox(
                width: SizeUtils.horizontalBlockSize * 2.55,
              ),
              Expanded(
                child:
                    Text(popularSearchModel.name!, style: AppStyles.BOLD_STYLE),
              ),
              Icon(
                Icons.trending_up_sharp,
                color: AppConst.grey,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
