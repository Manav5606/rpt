import 'package:customer_app/app/constants/app_constants.dart';
import 'package:customer_app/screens/more_stores/all_offers_listview.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/ui/pages/location_picker/address_model.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/data/popularsearchdata.dart';
import 'package:customer_app/data/popularsearchmodel.dart';
import 'package:customer_app/data/storesearchmodel.dart';
import 'package:customer_app/data/storesearchmodeldata.dart';
import 'package:customer_app/screens/home/controller/home_controller.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:customer_app/widgets/recentSearchList.dart';
import 'package:customer_app/widgets/searchList.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'controller/exploreContoller.dart';

class ExploreScreen extends StatefulWidget {
  @override
  State<ExploreScreen> createState() => _ExploreScreen();
}

class _ExploreScreen extends State<ExploreScreen> {
  List<StoreSearchModel>? foundStores;
  List<PopularSearchModel> recentSearch = popularSearchData;
  List<StoreSearchModel> storeSearch = storeSearchData;

  // TextEditingController searchController = TextEditingController();

  final ExploreController _exploreController = Get.find();
  final HomeController _homeController = Get.find();

  // @override
  // void initState() {
  //   super.initState();
  //   setState(() {
  //     foundStores = storeSearch;
  //   });
  // }
  //
  // onSearch(String name) {
  //   setState(() {
  //     foundStores = storeSearch
  //         .where((store) => store.storeName!.toLowerCase().contains(name))
  //         .toList();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      minimum: EdgeInsets.only(top: 2.h, left: 3.w, right: 3.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: SizeUtils.horizontalBlockSize * 15,
            decoration: BoxDecoration(color: AppConst.white, boxShadow: []),
            child: GestureDetector(
              onTap: () async {
                dynamic value = await Get.to(AddressModel(
                  // isSavedAddress: false,
                  isHomeScreen: true,
                ));
                _exploreController.searchController.clear();
                _exploreController.searchText.value = '';
                _exploreController.getNearMePageDataModel.value?.data?.products
                    ?.clear();
                _exploreController.getNearMePageDataModel.value?.data?.stores
                    ?.clear();
                _exploreController.getNearMePageDataModel.refresh();
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on_rounded,
                    color: AppConst.kPrimaryColor,
                    size: SizeUtils.horizontalBlockSize * 7,
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Flexible(
                    child: Obx(
                      () => Row(
                        children: [
                          Text(
                            _homeController.userAddressTitle.value,
                            style: AppStyles.ADDRESS_STYLE,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Flexible(
                            child: Text(
                              _homeController.userAddress.value,
                              overflow: TextOverflow.ellipsis,
                              style: AppStyles.ADDRESS_STYLE,
                            ),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Icon(
                            Icons.keyboard_arrow_down_outlined,
                            size: 6.w,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Obx(
            () {
              print(_exploreController.isLoading.value);
              return TextField(
                  textAlign: TextAlign.left,
                  textDirection: TextDirection.rtl,
                  controller: _exploreController.searchController,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                      isDense: true,
                      suffixIcon: (_exploreController.searchText.value.isEmpty)
                          ? Icon(
                              Icons.search,
                              size: SizeUtils.horizontalBlockSize * 6,
                              color: AppConst.black,
                            )
                          : IconButton(
                              onPressed: () {
                                _exploreController.searchController.clear();
                                _exploreController.searchText.value = '';
                                _exploreController.getNearMePageDataModel.value
                                    ?.data?.products
                                    ?.clear();
                                _exploreController
                                    .getNearMePageDataModel.value?.data?.stores
                                    ?.clear();
                                _exploreController.getNearMePageDataModel
                                    .refresh();
                              },
                              icon: Icon(
                                Icons.cancel,
                                color: AppConst.black,
                                size: SizeUtils.horizontalBlockSize * 6,
                              )),
                      counterText: "",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: AppConst.black),
                      ),
                      hintTextDirection: TextDirection.rtl,
                      hintText: " Search products,stores & recipes",
                      hintStyle: TextStyle(
                          color: AppConst.grey,
                          fontSize: SizeUtils.horizontalBlockSize * 4)),
                  showCursor: true,
                  cursorColor: AppConst.black,
                  cursorHeight: SizeUtils.horizontalBlockSize * 5,
                  maxLength: 30,
                  style: TextStyle(
                    color: AppConst.black,
                    fontSize: SizeUtils.horizontalBlockSize * 4,
                  ),
                  onChanged: (value) {
                    _exploreController.searchText.value = value;
                    _exploreController.searchText.value.isNotEmpty
                        ? _exploreController.getNearMePageData(
                            searchText: value)
                        : _exploreController.getNearMePageData(searchText: " ");
                    // onSearch(value);
                  });
            },
          ),
          SizedBox(
            height: 2.h,
          ),
          Obx(
            () => (((_exploreController.getNearMePageDataModel.value?.data
                            ?.products?.isEmpty ??
                        true) &&
                    (_exploreController.getNearMePageDataModel.value?.data
                            ?.stores?.isEmpty ??
                        true)))
                ? _exploreController.searchText.value.isNotEmpty
                    ? Center(
                        child: Text(
                          'No Results found !',
                          style: AppStyles.STORE_NAME_STYLE,
                        ),
                      )
                    : Text(
                        'Recently Searched',
                        style: AppStyles.STORE_NAME_STYLE,
                      )
                : Text(
                    'Results',
                    style: AppStyles.STORE_NAME_STYLE,
                  ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Obx(
            () => (((_exploreController.getNearMePageDataModel.value?.data
                            ?.products?.isEmpty ??
                        true) &&
                    (_exploreController.getNearMePageDataModel.value?.data
                            ?.stores?.isEmpty ??
                        true) &&
                    (_exploreController.getNearMePageDataModel.value?.data
                            ?.inventories?.isEmpty ??
                        true)))
                ? _exploreController.searchText.value.isNotEmpty
                    ? SizedBox()
                    : Expanded(
                        child: SingleChildScrollView(
                          child: RecentSearchList(
                            foundedStores:
                                _exploreController.recentProductList.value,
                          ),
                        ),
                      )
                : Expanded(
                    child: SingleChildScrollView(
                      child: SearchList(
                        foundedStores: foundStores,
                      ),
                    ),
                  ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Obx(
            () => (((_exploreController.getNearMePageDataModel.value?.data
                            ?.products?.isEmpty ??
                        true) &&
                    (_exploreController.getNearMePageDataModel.value?.data
                            ?.stores?.isEmpty ??
                        true) &&
                    (_exploreController.getNearMePageDataModel.value?.data
                            ?.inventories?.isEmpty ??
                        true)))
                ? _exploreController.searchText.value.isNotEmpty
                    ? SizedBox()
                    : Expanded(
                        child: SingleChildScrollView(
                          child: RecentSearchList(
                            foundedStores:
                                _exploreController.recentProductList.value,
                          ),
                        ),
                      )
                : Expanded(
                    child: SingleChildScrollView(
                      child: SearchList(
                        foundedStores: foundStores,
                      ),
                    ),
                  ),
          )
        ],
      ),
    ));
  }
}
