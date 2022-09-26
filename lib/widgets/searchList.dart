import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/ui/common/shimmer_widget.dart';
import 'package:customer_app/app/ui/pages/search/controller/exploreContoller.dart';
import 'package:customer_app/app/ui/pages/search/models/get_near_me_page_data.dart';
import 'package:customer_app/app/ui/pages/search/models/recentProductsData.dart';
import 'package:customer_app/app/utils/utils.dart';
import 'package:customer_app/data/storesearchmodel.dart';
import 'package:customer_app/data/storesearchmodeldata.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:get/get.dart';

import '../constants/app_const.dart';

class SearchList extends StatelessWidget {
  List<StoreSearchModel>? foundedStores;
  final ScrollController? controller;

  SearchList({Key? key, this.controller, required this.foundedStores}) : super(key: key);

  final ExploreController _exploreController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        NearMePageData? data = _exploreController.getNearMePageDataModel.value?.data;
        return (((data?.products?.isEmpty ?? true) && (data?.stores?.isEmpty ?? true)))
            ? Center(
                child: Text(
                "No data",
                style: AppStyles.STORES_SUBTITLE_STYLE,
              ))
            : Column(
                children: [
                  _exploreController.isLoadingStoreData.value
                      ? ListView.separated(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: storeSearchData.length,
                          itemBuilder: (context, index) {
                            return _listViewChildShimmer(
                                name: storeSearchData[index].storeName.toString(),
                                logo: storeSearchData[index].storeImage.toString(),
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
                          controller: this.controller,
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
                                  RecentProductsData recentProductsData = RecentProductsData(
                                    name: data.stores![index].name.toString(),
                                    logo: data.stores![index].logo.toString(),
                                    sId: data.stores![index].sId.toString(),
                                    isStore: true,
                                  );
                                  var contain = _exploreController.recentProductList.where((element) => element.sId == data.stores![index].sId);
                                  if (contain.isEmpty) {
                                    _exploreController.setNearDataProduct(recentProductsData);
                                  }
                                  await _exploreController.getStoreData(
                                      id: data.stores![index].sId.toString(), businessId: data.stores![index].businesstype.toString());
                                });
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
                  _exploreController.isLoadingStoreData.value
                      ? SizedBox()
                      : ListView.separated(
                          controller: this.controller,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: data?.products?.length ?? 0,
                          itemBuilder: (context, index) {
                            return _listViewChild(
                                name: data!.products![index].name.toString(),
                                logo: data.products![index].logo.toString(),
                                icon: Icons.search,
                                color: colorList[index],
                                onTap: () async {
                                  RecentProductsData recentProductsData = RecentProductsData(
                                    name: data.products![index].name.toString(),
                                    logo: data.products![index].logo.toString(),
                                    sId: data.products![index].sId.toString(),
                                    isStore: false,
                                  );
                                  var contain =
                                      _exploreController.recentProductList.indexWhere((element) => element.sId == data.products![index].sId);
                                  if (contain == -1) {
                                    _exploreController.setNearDataProduct(recentProductsData);
                                  }
                                  _exploreController.searchText.value = data.products![index].name.toString();
                                  await _exploreController.getStoreData(
                                      id: data.products![index].store?.sId.toString() ?? '', businessId: data.stores![index].businesstype.toString());
                                  // Get.toNamed(AppRoutes.SearchStoresScreen);
                                  // await _exploreController.getProductsByName(name: data.products![index].name.toString());
                                });
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: SizeUtils.horizontalBlockSize * 2.55,
                            );
                          },
                        ),
                  _exploreController.isLoadingStoreData.value
                      ? SizedBox()
                      : Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(SizeUtils.horizontalBlockSize *2),
                          child: Text(
                            "Inventories",
                            style: AppStyles.BOLD_STYLE,
                          ),
                        ),
                          ListView.separated(
                              controller: this.controller,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: data?.inventories?.length ?? 0,
                              itemBuilder: (context, index) {
                                return _listViewChild(
                                    name: data!.inventories![index].name.toString(),
                                    logo: '',
                                    icon: Icons.search,
                                    color: colorList[index],
                                    onTap: () async {
                                      await _exploreController.getStoreData(
                                          id: data.inventories![index].store?.sId.toString() ?? '', businessId: data.stores![index].businesstype.toString());
                                    });
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: SizeUtils.horizontalBlockSize * 2.55,
                                );
                              },
                            ),
                        ],
                      ),
                ],
              );
      },
    );

    // return (foundedStores!.isEmpty)
    //     ? Text("No data")
    //     : ListView.separated(
    //         controller: this.controller,
    //         shrinkWrap: true,
    //         physics: NeverScrollableScrollPhysics(),
    //         itemCount: foundedStores!.length, //data.length,
    //         itemBuilder: (context, index) {
    //           return ListViewChild(
    //             storeSearchModel: foundedStores![index],
    //           );
    //         },
    //         separatorBuilder: (context, index) {
    //           return SizedBox(
    //             height: SizeUtils.horizontalBlockSize * 2.55,
    //           );
    //         },
    //       );
  }

  Widget _listViewChild(
      {required String logo, required String name, required IconData icon, required Color color, required GestureTapCallback onTap}) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              logo.isEmpty
                  ? CircleAvatar(
                      child: Text(name.substring(0, 1), style: TextStyle(fontSize: SizeUtils.horizontalBlockSize * 5)),
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
      {required String logo, required String name, required IconData icon, required Color color, required GestureTapCallback onTap}) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              logo.isEmpty
                  ? ShimmerEffect(
                      child: CircleAvatar(
                        child: Text(name.substring(0, 1), style: TextStyle(fontSize: SizeUtils.horizontalBlockSize * 5)),
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

// class ListViewChild extends StatelessWidget {
//   final StoreSearchModel storeSearchModel;
//   const ListViewChild({Key? key, required this.storeSearchModel})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     SizeUtils().init(context);
//
//     return Column(
//       children: [
//         InkWell(
//           onTap: () => (storeSearchModel.isExist!)
//               ? Get.toNamed(AppRoutes.StoreScreen)
//               : Get.toNamed(AppRoutes.SearchStoresScreen,
//                   arguments: storeSearchModel.storeName!),
//           child: Row(
//             children: [
//               (storeSearchModel.storeImage!.isNotEmpty)
//                   ? CircleAvatar(
//                       backgroundImage:
//                           NetworkImage(storeSearchModel.storeImage!),
//                       backgroundColor: AppConst.white,
//                       radius: SizeUtils.horizontalBlockSize * 5.3,
//                     )
//                   : defaultStoreWidget(),
//               SizedBox(
//                 width: SizeUtils.horizontalBlockSize * 2.55,
//               ),
//               Expanded(
//                 child: Text(
//                   storeSearchModel.storeName!,
//                   style: AppStyles.BOLD_STYLE,
//                 ),
//               ),
//               (storeSearchModel.isExist!) ? ArrowForwardIcon() : SearchIcon(),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
