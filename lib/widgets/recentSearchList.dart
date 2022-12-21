import 'dart:developer';

import 'package:customer_app/app/constants/app_constants.dart';
import 'package:customer_app/app/ui/pages/stores/chatOrder/chatOrder.dart';
import 'package:customer_app/screens/more_stores/all_offers_listview.dart';
import 'package:customer_app/screens/more_stores/morestore_controller.dart';
import 'package:customer_app/screens/more_stores/morestore_productlist.dart';
import 'package:customer_app/widgets/custom_popupmenu.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/ui/pages/search/controller/exploreContoller.dart';
import 'package:customer_app/app/ui/pages/search/models/recentProductsData.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:customer_app/widgets/defaultstoreicon.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../screens/home/models/homePageRemoteConfigModel.dart';
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
            "No Recent Item!",
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

    return Wrap(
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
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
            decoration: BoxDecoration(
                color: AppConst.lightGrey,
                borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.access_time_rounded,
                  color: AppConst.grey,
                ),
                SizedBox(
                  width: 2.w,
                ),
                Text(
                  popularSearchModel.name ?? "",
                  style: TextStyle(
                    fontSize: SizeUtils.horizontalBlockSize * 3.2,
                    fontFamily: 'MuseoSans',
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    color: AppConst.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class HotProducts extends StatelessWidget {
  final ScrollController? controller;

  List<Data>? foundedStores;
  HotProducts({Key? key, this.controller, this.foundedStores})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (foundedStores!.isEmpty)
        ? Center(
            child: Text(
            "Loading Hot products...",
            style: AppStyles.STORES_SUBTITLE_STYLE,
          ))
        : Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                child: Row(
                  children: [
                    Icon(
                      Icons.trending_up_sharp,
                      color: AppConst.black,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text("Hot Products",
                        style: TextStyle(
                          fontFamily: 'MuseoSans',
                          color: AppConst.black,
                          fontSize: SizeUtils.horizontalBlockSize * 4.5,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                        )),
                  ],
                ),
              ),
              ListView.separated(
                controller: this.controller,
                shrinkWrap: true,
                reverse: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: foundedStores!.length,
                //data.length,
                itemBuilder: (context, index) {
                  return DisplayHotProducts(
                    storesWithProductsModel: foundedStores![index],
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: SizeUtils.horizontalBlockSize * 2.55,
                  );
                },
              ),
            ],
          );
  }
}

class DisplayHotProducts extends StatelessWidget {
  final Data storesWithProductsModel;

  DisplayHotProducts({Key? key, required this.storesWithProductsModel})
      : super(key: key);
  final MoreStoreController _moreStoreController = Get.find();
  final ExploreController _exploreController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          highlightColor: AppConst.highLightColor,
          onTap: () async {
            _moreStoreController.storeId.value =
                storesWithProductsModel.sId ?? '';
            await _moreStoreController.getStoreData(
              id: storesWithProductsModel.sId ?? '',
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 2.w,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DispalyStoreLogo(
                  logo: storesWithProductsModel.logo,
                  height: 5.5,
                  bottomPadding: 0,
                ),
                SizedBox(
                  width: 2.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 72.w,
                              child: Text(storesWithProductsModel.name ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: 'MuseoSans',
                                    color: AppConst.black,
                                    fontSize:
                                        SizeUtils.horizontalBlockSize * 3.8,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                  )),
                            ),
                            SizedBox(
                              height: 0.5.h,
                            ),
                            Row(
                              children: [
                                (storesWithProductsModel.calculatedDistance !=
                                        null)
                                    ? DisplayDistance(
                                        distance: storesWithProductsModel
                                            .calculatedDistance,
                                      )
                                    : SizedBox(),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 1.w, right: 2.w, top: 0.5.h),
                                  child: Icon(
                                    Icons.circle,
                                    color: AppConst.grey,
                                    size: 0.8.h,
                                  ),
                                ),
                                if (storesWithProductsModel
                                        .storeType?.isNotEmpty ??
                                    false)
                                  if ((storesWithProductsModel.storeType ??
                                          '') ==
                                      'online')
                                    DsplayPickupDelivery()
                                  else
                                    Text("Only Pickup",
                                        style: TextStyle(
                                          fontFamily: 'MuseoSans',
                                          color: AppConst.grey,
                                          fontSize:
                                              SizeUtils.horizontalBlockSize *
                                                  3.7,
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.normal,
                                        )),
                              ],
                            ),
                            SizedBox(
                              height: 0.5.h,
                            ),
                            // SizedBox(
                            //   width: 2.w,
                            // ),
                            // Icon(
                            //   Icons.arrow_forward,
                            //   color: AppConst.black,
                            //   size: SizeUtils.horizontalBlockSize * 6,
                            // ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 4.h),
                          child: Icon(
                            Icons.arrow_forward,
                            color: AppConst.black,
                            size: SizeUtils.horizontalBlockSize * 6,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        // SizedBox(
        //   height: 1.h,
        // ),
        storesWithProductsModel.products!.isEmpty
            ? InkWell(
                highlightColor: AppConst.highLightColor,
                onTap: () async {
                  _moreStoreController.storeId.value =
                      storesWithProductsModel.sId ?? '';
                  await _moreStoreController.getStoreData(
                    id: storesWithProductsModel.sId ?? '',
                  );
                },
                child: Container(
                  height: 30.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 1.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_cart,
                            // Icons.receipt,
                            size: 10.h,
                            color: AppConst.lightYellow,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        "To view products",
                        style: TextStyle(
                          fontSize: SizeUtils.horizontalBlockSize * 4.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "Go to store and start shopping",
                        style: TextStyle(
                          fontSize: SizeUtils.horizontalBlockSize * 4.5,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            // Padding(
            //     padding: EdgeInsets.only(bottom: 1.h),
            //     child: Text(
            //       "No Products",
            //       style: AppStyles.STORE_NAME_STYLE,
            //     ),
            //   )
            : Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 1.h, left: 3.w, right: 3.w),
                      child: Container(
                          // height: 30.h,
                          width: double.infinity,
                          child: GridView(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              // controller: gridViewScroll,
                              scrollDirection: Axis.vertical,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 2.w,
                                      mainAxisSpacing: 1.h),
                              children: List.generate(
                                  storesWithProductsModel.products?.length ?? 0,
                                  (index) {
                                Products product =
                                    storesWithProductsModel.products![index];
                                return Container(
                                  width: 45.w,
                                  height: 25.h,
                                  // color: AppConst.yellow,
                                  child: InkWell(
                                    onTap: (() async {
                                      _moreStoreController.storeId.value =
                                          storesWithProductsModel.sId ?? '';

                                      await _moreStoreController.getStoreData(
                                        id: storesWithProductsModel.sId ?? '',
                                      );
                                    }),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: (product.logo != null &&
                                                  product.logo != "")
                                              ? Image.network(
                                                  product.logo!,
                                                  fit: BoxFit.cover,
                                                  height: 11.h,
                                                  width: 24.w,
                                                )
                                              : Container(
                                                  decoration: BoxDecoration(
                                                    color:
                                                        AppConst.veryLightGrey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  height: 11.h,
                                                  width: 30.w,
                                                  child: Center(
                                                      child: Image.asset(
                                                          "assets/images/noimage.png")),
                                                ),
                                        ),
                                        SizedBox(
                                          height: 4.5.h,
                                          child: Text(product.name.toString(),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontFamily: 'MuseoSans',
                                                color: AppConst.black,
                                                fontSize: SizeUtils
                                                        .horizontalBlockSize *
                                                    3.7,
                                                fontWeight: FontWeight.w500,
                                                fontStyle: FontStyle.normal,
                                              )),
                                        ),
                                        SizedBox(
                                          height: 0.5.h,
                                        ),
                                        Text(
                                            "Cashback \u20b9${product.cashback.toString()}",
                                            style: TextStyle(
                                              fontFamily: 'MuseoSans',
                                              color: AppConst.black,
                                              fontSize: SizeUtils
                                                      .horizontalBlockSize *
                                                  3.5,
                                              fontWeight: FontWeight.w700,
                                              fontStyle: FontStyle.normal,
                                            )),
                                        // SizedBox(
                                        //   height: 0.5.h,
                                        // ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text("₹ 125 / 3Kg",
                                                style: TextStyle(
                                                  fontFamily: 'MuseoSans',
                                                  color: AppConst.black,
                                                  fontSize: SizeUtils
                                                          .horizontalBlockSize *
                                                      3.3,
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle: FontStyle.normal,
                                                )),
                                            Spacer(),
                                            // SizedBox(
                                            //   width: 3.w,
                                            // ),

                                            InkWell(
                                                onTap: (() async {
                                                  _moreStoreController
                                                          .storeId.value =
                                                      storesWithProductsModel
                                                              .sId ??
                                                          '';

                                                  await _moreStoreController
                                                      .getStoreData(
                                                    id: storesWithProductsModel
                                                            .sId ??
                                                        '',
                                                  );
                                                }),
                                                child: DisplayAddPlus()),
                                            // Obx(
                                            //   () => product.quntity!.value > 0 &&
                                            //           product.isQunitityAdd
                                            //                   ?.value ==
                                            //               false
                                            //       ? _shoppingItem(product)
                                            //       : GestureDetector(
                                            //           onTap: () async {
                                            //             if (product
                                            //                     .quntity!.value ==
                                            //                 0) {
                                            //               product
                                            //                   .quntity!.value++;

                                            //               log("storesWithProductsModel?.products?[index] : ${product}");

                                            //               _moreStoreController.addToCart(
                                            //                   store_id:
                                            //                       _moreStoreController
                                            //                           .storeId
                                            //                           .value,
                                            //                   index: 0,
                                            //                   increment: true,
                                            //                   cart_id:
                                            //                       _moreStoreController
                                            //                               .getCartIDModel
                                            //                               .value
                                            //                               ?.sId ??
                                            //                           '',
                                            //                   product: product);

                                            //               _moreStoreController
                                            //                       .storeId.value =
                                            //                   storesWithProductsModel
                                            //                           .sId ??
                                            //                       '';

                                            //               await _moreStoreController
                                            //                   .getStoreData(
                                            //                 id: storesWithProductsModel
                                            //                         .sId ??
                                            //                     '',
                                            //               );

                                            //             }
                                            //             if (product.quntity!
                                            //                         .value !=
                                            //                     0 &&
                                            //                 product.isQunitityAdd
                                            //                         ?.value ==
                                            //                     false) {
                                            //               product.isQunitityAdd
                                            //                   ?.value = false;
                                            //               await Future.delayed(
                                            //                       Duration(
                                            //                           milliseconds:
                                            //                               500))
                                            //                   .whenComplete(() =>
                                            //                       product
                                            //                           .isQunitityAdd
                                            //                           ?.value = true);
                                            //             }

                                            //           },
                                            //           child: product.isQunitityAdd
                                            //                           ?.value ==
                                            //                       true &&
                                            //                   product.quntity!
                                            //                           .value !=
                                            //                       0
                                            //               ? _dropDown(
                                            //                   product,
                                            //                   storesWithProductsModel
                                            //                           .sId ??
                                            //                       '')
                                            //               : DisplayAddPlus()),
                                            // ),

                                            SizedBox(
                                              width: 3.w,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }))),
                    ),
                  ),
                  // SizedBox(
                  //   width: 3.w,
                  // ),
                ],
              ),
        Padding(
          padding: EdgeInsets.only(bottom: 1.h),
          child: Container(height: 1.2.w, color: AppConst.veryLightGrey),
        ),
      ],
    );
  }

  List<String> quntityList = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10'
  ];

  Widget _dropDown(product, String sId) {
    return Obx(
      () => CustomPopMenu(
        title: 'Quantity',
        child: DisplayProductCount(
          count: product.quntity!.value,
        ),
        list: quntityList,
        onSelected: (value) async {
          product.quntity!.value = value;
          if (product.quntity!.value == 0) {
            product.isQunitityAdd?.value = false;
          }
          log('product :${product.name}');
          _moreStoreController.addToCart(
              cart_id: _moreStoreController.getCartIDModel.value?.sId ?? '',
              store_id: sId,
              index: 0,
              increment: true,
              product: product);
        },
      ),
    );
  }

  Widget _shoppingItem(product) {
    return Obx(
      () => DisplayProductCount(
        count: product.quntity!.value,
      ),
    );
  }
}
