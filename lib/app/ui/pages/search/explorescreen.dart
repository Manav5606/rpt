import 'package:customer_app/app/constants/app_constants.dart';
import 'package:customer_app/app/controller/add_location_controller.dart';
import 'package:customer_app/app/data/model/user_model.dart';
import 'package:customer_app/app/ui/pages/search/models/recentProductsData.dart';
import 'package:customer_app/screens/more_stores/all_offers_listview.dart';
import 'package:customer_app/widgets/homescreen_appbar.dart';
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
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:sizer/sizer.dart';

import '../../../data/provider/hive/hive_constants.dart';
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
  final ExploreController _controller = Get.find()..homePageRemoteConfigData1();

  final AddLocationController _addLocationController = Get.find();

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
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: AppConst.darkGreen,
          statusBarIconBrightness: Brightness.light),
      child: Scaffold(
          body: SafeArea(
        // minimum: EdgeInsets.only(top: 2.h, left: 3.w, right: 3.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              child: Obx(
                () => Container(
                  padding: EdgeInsets.only(
                      left: 2.w, top: 1.h, bottom: 2.h, right: 2.w),
                  color: Color(0xff005b41),
                  child: GestureDetector(
                    onTap: () async {
                      dynamic value = await Get.to(AddressModel(
                        // isSavedAddress: false,
                        isHomeScreen: false,
                        page: "explore",
                      ));
                      _exploreController.searchController.clear();
                      _exploreController.searchText.value = '';
                      _exploreController
                          .getNearMePageDataModel.value?.data?.products
                          ?.clear();
                      _exploreController
                          .getNearMePageDataModel.value?.data?.stores
                          ?.clear();
                      _exploreController.getNearMePageDataModel.refresh();
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 4.h,
                          width: 10.w,
                          child: FittedBox(
                            child: Icon(
                              Icons.keyboard_arrow_down_outlined,
                              size: 3.h,
                              color: AppConst.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 1.w,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 85.w,
                              child: Text(
                                "${_addLocationController.userAddressTitle.value} ${_addLocationController.userAddress.value}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: SizeUtils.horizontalBlockSize * 4,
                                    fontFamily: 'MuseoSans',
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                    color: AppConst.white,
                                    letterSpacing: 0.4),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Obx(
              () {
                print(_exploreController.isLoading.value);
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: Container(
                    decoration: BoxDecoration(color: AppConst.veryLightGrey),
                    child: TextField(
                        textAlign: TextAlign.left,
                        textDirection: TextDirection.rtl,
                        controller: _exploreController.searchController,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 3.w),
                            isDense: true,
                            prefixIcon:
                                (_exploreController.searchText.value.isEmpty)
                                    ? Icon(
                                        Icons.search,
                                        size: SizeUtils.horizontalBlockSize * 6,
                                        color: AppConst.grey,
                                      )
                                    : null,
                            suffixIcon: (_exploreController
                                    .searchText.value.isEmpty)
                                ? null
                                : IconButton(
                                    onPressed: () {
                                      _exploreController.searchController
                                          .clear();
                                      _exploreController.searchText.value = '';
                                      _exploreController.getNearMePageDataModel
                                          .value?.data?.products
                                          ?.clear();
                                      _exploreController.getNearMePageDataModel
                                          .value?.data?.stores
                                          ?.clear();
                                      _exploreController.getNearMePageDataModel
                                          .refresh();
                                    },
                                    icon: Icon(
                                      Icons.cancel,
                                      color: AppConst.grey,
                                      size: SizeUtils.horizontalBlockSize * 6,
                                    )),
                            counterText: "",
                            border: InputBorder.none,
                            // OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(12),
                            //   borderSide:
                            //       BorderSide(width: 1, color: AppConst.transparent),
                            // ),
                            focusedBorder: InputBorder.none,
                            // OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(12),
                            //   borderSide: BorderSide(color: AppConst.black),
                            // ),
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
                              : _exploreController.getNearMePageData(
                                  searchText: " ");
                          // onSearch(value);
                        }),
                  ),
                );
              },
            ),
            SizedBox(
              height: 1.h,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      child: Obx(
                        () => (((_exploreController.getNearMePageDataModel.value
                                        ?.data?.products?.isEmpty ??
                                    true) &&
                                (_exploreController.getNearMePageDataModel.value
                                        ?.data?.stores?.isEmpty ??
                                    true)))
                            ? _exploreController.searchText.value.isNotEmpty
                                ? Center(
                                    child: Text('No Results found !',
                                        style: TextStyle(
                                          fontFamily: 'MuseoSans',
                                          color: AppConst.black,
                                          fontSize:
                                              SizeUtils.horizontalBlockSize *
                                                  3.5,
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.normal,
                                        )),
                                  )
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Recently Searches',
                                          style: TextStyle(
                                            fontFamily: 'MuseoSans',
                                            color: AppConst.black,
                                            fontSize:
                                                SizeUtils.horizontalBlockSize *
                                                    3.5,
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.normal,
                                          )),
                                      InkWell(
                                        onTap: () {
                                          _exploreController
                                              .DeleteNearDataProduct();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('Clear all   ',
                                              style: TextStyle(
                                                fontFamily: 'MuseoSans',
                                                color: AppConst.green,
                                                fontSize: SizeUtils
                                                        .horizontalBlockSize *
                                                    3.5,
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                              )),
                                        ),
                                      ),
                                    ],
                                  )
                            : Text('Results',
                                style: TextStyle(
                                  fontFamily: 'MuseoSans',
                                  color: AppConst.black,
                                  fontSize: SizeUtils.horizontalBlockSize * 3.5,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                )),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Obx(
                      () => (((_exploreController.getNearMePageDataModel.value
                                      ?.data?.products?.isEmpty ??
                                  true) &&
                              (_exploreController.getNearMePageDataModel.value
                                      ?.data?.stores?.isEmpty ??
                                  true)))
                          //  (((_exploreController.getNearMePageDataModel.value
                          //                 ?.data?.products?.isEmpty ??
                          //             true) &&
                          //         (_exploreController.getNearMePageDataModel.value
                          //                 ?.data?.stores?.isEmpty ??
                          //             true) &&
                          //         (_exploreController.getNearMePageDataModel.value
                          //                 ?.data?.inventories?.isEmpty ??
                          //             true)))
                          ? _exploreController.searchText.value.isNotEmpty
                              ? SizedBox()
                              : Wrap(
                                  children: _exploreController
                                      .recentProductList.value
                                      .map((e) => InkWell(
                                            onTap: () => {
                                              _exploreController
                                                  .searchText.value = e.name!,
                                              _exploreController
                                                      .searchController.text =
                                                  _exploreController
                                                      .searchText.value,
                                              _exploreController
                                                  .getNearMePageData(
                                                      searchText:
                                                          _exploreController
                                                              .searchText
                                                              .value),
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 1.w,
                                                  vertical: 0.5.h),
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 2.w,
                                                    vertical: 0.5.h),
                                                decoration: BoxDecoration(
                                                    color: AppConst.lightGrey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.access_time_rounded,
                                                      color: AppConst.grey,
                                                      size: 2.h,
                                                    ),
                                                    SizedBox(
                                                      width: 1.w,
                                                    ),
                                                    Text(
                                                      e.name ?? "",
                                                      style: TextStyle(
                                                        fontSize: SizeUtils
                                                                .horizontalBlockSize *
                                                            3,
                                                        fontFamily: 'MuseoSans',
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        color: AppConst.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ))
                                      .toSet()
                                      .toList(),
                                )
                          : SearchList(
                              foundedStores: foundStores,
                            ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Obx(() => _exploreController.searchText.value.isNotEmpty
                        ? SizedBox()
                        : HotProducts(
                            foundedStores:
                                _exploreController.storeDataList.value,
                          ))
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
