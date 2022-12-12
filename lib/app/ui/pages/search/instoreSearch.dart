import 'dart:developer';

import 'package:customer_app/screens/more_stores/morestore_productlist.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/ui/pages/search/controller/exploreContoller.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/screens/addcart/controller/addcart_controller.dart';
import 'package:customer_app/screens/more_stores/morestore_controller.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:customer_app/widgets/backButton.dart';
import 'package:customer_app/widgets/cartWidget.dart';
import 'package:customer_app/widgets/storeProductsList.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class InstoreSearch extends StatefulWidget {
  @override
  State<InstoreSearch> createState() => _InstoreSearch();
}

class _InstoreSearch extends State<InstoreSearch> {
  String storeID = '';

  @override
  void initState() {
    super.initState();
    Map arg = Get.arguments ?? {};
    storeID = arg['storeId'] ?? '';
    log("storeID :$storeID");
  }

  final MoreStoreController _moreStoreController = Get.find();
  final AddCartController _addCartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,

        // leading: Padding(
        //   padding: EdgeInsets.only(left: SizeUtils.horizontalBlockSize * 1.8),
        //   child: InkWell(
        //     onTap: () async {
        //       Get.back();
        //       _moreStoreController
        //           .autoCompleteProductsByStoreModel.value?.data?.products
        //           ?.clear();
        //       _moreStoreController
        //           .autoCompleteProductsByStoreModel.value?.data?.inventories
        //           ?.clear();
        //       _moreStoreController.storeSearchController.clear();
        //       _moreStoreController.storeSearchText.value = '';
        //       // await _exploreController.getStoreData(id: _addCartController.store.value?.sId ?? '');
        //     },
        //     child: Icon(
        //       Icons.arrow_back,
        //       color: AppConst.black,
        //       size: SizeUtils.horizontalBlockSize * 7.65,
        //     ),
        //   ),
        // ),
        // actions: [
        //   Obx(
        //     () => CartWidget(
        //       onTap: () async {
        //         Get.toNamed(
        //           AppRoutes.CartReviewScreen,
        //           arguments: {
        //             'logo': _moreStoreController
        //                 .getStoreDataModel.value?.data?.store?.logo,
        //             'storeName': _moreStoreController
        //                 .getStoreDataModel.value?.data?.store?.name,
        //             'totalCount': _moreStoreController
        //                     .getCartIDModel.value?.totalItemsCount
        //                     .toString() ??
        //                 "",
        //           },
        //         );
        //         await _addCartController.getReviewCartData(
        //             cartId:
        //                 _moreStoreController.getCartIDModel.value?.sId ?? "");
        //         // await _addCartController.getCartPageInformation(storeId: _moreStoreController.addToCartModel.value?.store ?? "");
        //         await _addCartController.getCartLocation(
        //             storeId: _moreStoreController.storeId.value,
        //             cartId:
        //                 _moreStoreController.getCartIDModel.value?.sId ?? "");
        //         _addCartController.cartId.value =
        //             _moreStoreController.getCartIDModel.value?.sId ?? "";
        //         if (_addCartController.store.value?.sId == null) {
        //           _addCartController.store.value?.sId =
        //               _moreStoreController.storeId.value;
        //         }
        //       },
        //       count:
        //           "${_moreStoreController.getCartIDModel.value?.totalItemsCount ?? 0}",
        //     ),
        //   ),
        // ],
        title: Column(
          children: [
            // Obx(
            //   () => CircleAvatar(
            //     radius: SizeUtils.horizontalBlockSize * 3.82,
            //     child: (_moreStoreController.getStoreDataModel.value?.data
            //                 ?.store?.logo?.isNotEmpty ??
            //             false)
            //         ? Image.network(_moreStoreController
            //             .getStoreDataModel.value!.data!.store!.logo
            //             .toString())
            //         : Image.asset("assets/images/image4.png"),
            //   ),
            // ),
            Text(
              _moreStoreController.getStoreDataModel.value?.data?.store?.name
                      .toString() ??
                  "",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                color: AppConst.black,
                fontFamily: 'MuseoSans',
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
                fontSize: SizeUtils.horizontalBlockSize * 4.5,
              ),
            ),
          ],
        ),
      ),
      bottomSheet: ((_moreStoreController
                      .getCartIDModel.value?.totalItemsCount ??
                  0) >
              0)
          ? Obx(
              () => InkWell(
                  onTap: () async {
                    Get.toNamed(
                      AppRoutes.CartReviewScreen,
                      arguments: {
                        'logo': _moreStoreController
                            .getStoreDataModel.value?.data?.store?.logo,
                        'storeName': _moreStoreController
                            .getStoreDataModel.value?.data?.store?.name,
                        'totalCount': _moreStoreController
                                .getCartIDModel.value?.totalItemsCount
                                .toString() ??
                            "",
                      },
                    );
                    await _addCartController.getReviewCartData(
                        cartId:
                            _moreStoreController.getCartIDModel.value?.sId ??
                                "");
                    // await _addCartController.getCartPageInformation(storeId: _moreStoreController.addToCartModel.value?.store ?? "");
                    await _addCartController.getCartLocation(
                        storeId: _moreStoreController.storeId.value,
                        cartId:
                            _moreStoreController.getCartIDModel.value?.sId ??
                                "");
                    _addCartController.cartId.value =
                        _moreStoreController.getCartIDModel.value?.sId ?? "";
                    if (_addCartController.store.value?.sId == null) {
                      _addCartController.store.value?.sId =
                          _moreStoreController.storeId.value;
                    }
                  },
                  child: CartRibbn(
                    totalItemsCount: _moreStoreController
                        .getCartIDModel.value?.totalItemsCount,
                  )),
            )
          : SizedBox(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.w),
                child: Container(
                  decoration: BoxDecoration(color: AppConst.veryLightGrey),
                  child: TextField(
                    textAlign: TextAlign.left,
                    textDirection: TextDirection.rtl,
                    controller: _moreStoreController.storeSearchController,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.only(left: 3.w),
                        prefixIcon:
                            (_moreStoreController.storeSearchText.value.isEmpty)
                                ? Icon(
                                    Icons.search,
                                    size: SizeUtils.horizontalBlockSize * 6,
                                    color: AppConst.grey,
                                  )
                                : null,
                        suffixIcon: (_moreStoreController
                                .storeSearchText.value.isEmpty)
                            ? null
                            : IconButton(
                                onPressed: () {
                                  _moreStoreController
                                      .autoCompleteProductsByStoreModel
                                      .value
                                      ?.data
                                      ?.products
                                      ?.clear();
                                  _moreStoreController
                                      .autoCompleteProductsByStoreModel
                                      .value
                                      ?.data
                                      ?.inventories
                                      ?.clear();
                                  _moreStoreController.storeSearchController
                                      .clear();
                                  _moreStoreController.storeSearchText.value =
                                      '';
                                  _moreStoreController
                                      .autoCompleteProductsByStoreModel
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
                      _moreStoreController.storeSearchText.value = value;
                      _moreStoreController.storeSearchText.value.isNotEmpty
                          ? _moreStoreController.getAutoCompleteProductsByStore(
                              name: value, storeId: storeID)
                          : _moreStoreController.getAutoCompleteProductsByStore(
                              name: " ", storeId: storeID);
                      // onSearch(value);
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Obx(() => (_moreStoreController
                                .autoCompleteProductsByStoreModel
                                .value
                                ?.data
                                ?.products
                                ?.isNotEmpty ??
                            false)
                        ? StoreProductSearchList(
                            foundedStores: _moreStoreController
                                .autoCompleteProductsByStoreModel
                                .value
                                ?.data
                                ?.products,
                          )
                        : SizedBox()),
                    SizedBox(
                      height: 2.h,
                    ),
                    Obx(
                      () => (_moreStoreController
                                  .autoCompleteProductsByStoreModel
                                  .value
                                  ?.data
                                  ?.inventories
                                  ?.isNotEmpty ??
                              false)
                          ? Column(
                              children: [
                                // Padding(
                                //   padding: EdgeInsets.all(
                                //       SizeUtils.horizontalBlockSize * 2),
                                //   child: Text(
                                //     "Inventories",
                                //     style: AppStyles.BOLD_STYLE,
                                //   ),
                                // ),
                                Inventories(
                                  inventoriesModel: _moreStoreController
                                      .autoCompleteProductsByStoreModel
                                      .value
                                      ?.data
                                      ?.inventories,
                                )
                              ],
                            )
                          : SizedBox(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
