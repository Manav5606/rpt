import 'dart:developer';

import 'package:customer_app/app/constants/app_constants.dart';
import 'package:customer_app/app/ui/common/shimmer_widget.dart';
import 'package:customer_app/app/ui/pages/my_wallet/wallet_details_screen.dart';
import 'package:customer_app/app/ui/pages/search/controller/exploreContoller.dart';
import 'package:customer_app/app/ui/pages/stores/chatOrder/chatOrder.dart';
import 'package:customer_app/screens/history/history_screen.dart';
import 'package:customer_app/screens/more_stores/all_offers_listview.dart';
import 'package:customer_app/screens/more_stores/morestore_productlist.dart';
import 'package:customer_app/widgets/custom_popupmenu.dart';
import 'package:customer_app/widgets/instorelist.dart';
import 'package:customer_app/widgets/snack.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/constants/string_constants.dart';
import 'package:customer_app/screens/home/controller/home_controller.dart';
import 'package:customer_app/screens/home/models/homePageRemoteConfigModel.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../screens/more_stores/morestore_controller.dart';

class StoreWithProductsList extends StatelessWidget {
  final ScrollController? controller;

  StoreWithProductsList({Key? key, this.controller}) : super(key: key);
  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (_homeController.isRemoteConfigPageLoading1.value)
          ? Column(
              children: [
                SizedBox(
                  height: 2.h,
                ),
                InstoreListViewChildShimmer(),
                ProductShimmerEffect(),
                InstoreListViewChildShimmer(),
                ProductShimmerEffect(),
                InstoreListViewChildShimmer(),
                ProductShimmerEffect(),
              ],
            )
          : (_homeController.storeDataList.isEmpty)
              ? Center(
                  child: Text(StringContants.noData),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: _homeController.storeDataList.length,
                  //data.length,
                  itemBuilder: (context, index) {
                    return ListViewChild(
                      storesWithProductsModel:
                          _homeController.storeDataList[index],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox();
                  },
                ),
    );
  }
}

class ProductShimmerEffect extends StatelessWidget {
  const ProductShimmerEffect({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 30.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 1.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 45.w,
                height: 22.h,
                child: Column(children: [
                  ShimmerEffect(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppConst.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      height: 11.h,
                      width: 30.w,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  ShimmerEffect(
                    child: Container(
                      width: 35.w,
                      height: 2.h,
                      color: AppConst.black,
                    ),
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  ShimmerEffect(
                    child: Container(
                      width: 35.w,
                      height: 2.h,
                      color: AppConst.black,
                    ),
                  ),
                ]),
              ),
              SizedBox(
                width: 3.w,
              ),
              Container(
                width: 45.w,
                height: 22.h,
                child: Column(children: [
                  ShimmerEffect(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppConst.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      height: 11.h,
                      width: 30.w,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  ShimmerEffect(
                    child: Container(
                      width: 35.w,
                      height: 2.h,
                      color: AppConst.black,
                    ),
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  ShimmerEffect(
                    child: Container(
                      width: 35.w,
                      height: 2.h,
                      color: AppConst.black,
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ListViewChild extends StatelessWidget {
  final Data storesWithProductsModel;

  ListViewChild({Key? key, required this.storesWithProductsModel})
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
                ),
                SizedBox(
                  width: 2.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 72.w,
                          child: Text(storesWithProductsModel.name ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'MuseoSans',
                                color: AppConst.black,
                                fontSize: SizeUtils.horizontalBlockSize * 3.8,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                              )),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: AppConst.black,
                          size: SizeUtils.horizontalBlockSize * 3.5,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Row(
                      children: [
                        (storesWithProductsModel.calculatedDistance != null)
                            ? DisplayDistance(
                                distance:
                                    storesWithProductsModel.calculatedDistance,
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
                        if (storesWithProductsModel.storeType?.isNotEmpty ??
                            false)
                          if ((storesWithProductsModel.storeType ?? '') ==
                              'online')
                            DsplayPickupDelivery()
                          else
                            Text("Only Pickup",
                                style: TextStyle(
                                  fontFamily: 'MuseoSans',
                                  color: AppConst.grey,
                                  fontSize: SizeUtils.horizontalBlockSize * 3.7,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                )),
                      ],
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Row(
                      children: [
                        ((storesWithProductsModel.premium ?? false) == true)
                            ? DisplayPreminumStore()
                            : (storesWithProductsModel.businesstype ==
                                    Constants.fresh)
                                ? DisplayFreshStore()
                                : SizedBox(),
                        (storesWithProductsModel.businesstype ==
                                Constants.fresh)
                            ? SizedBox(
                                width: 3.w,
                              )
                            : SizedBox(),
                        DisplayCashback(
                          cashback: int.parse(
                              "${storesWithProductsModel.defaultCashback}"),
                          iscashbackPercentage: true,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    )
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
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      DisplayProductInGridView(
                                          logo: product.logo),
                                      SizedBox(
                                        // height: 4.5.h,
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
                                            fontSize:
                                                SizeUtils.horizontalBlockSize *
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
                                          RichText(
                                              text: TextSpan(children: [
                                            // TextSpan(
                                            //     text:
                                            //         "\u20b9${_addCartController.reviewCart.value?.data?.inventories?[
                                            //             index].mrp ?? ""}",
                                            //     style: TextStyle(
                                            //         fontFamily:
                                            //             'MuseoSans',
                                            //         color: AppConst
                                            //             .grey,
                                            //         fontSize:
                                            //             SizeUtils.horizontalBlockSize *
                                            //                 3.3,
                                            //         fontWeight:
                                            //             FontWeight
                                            //                 .w500,
                                            //         fontStyle:
                                            //             FontStyle
                                            //                 .normal,
                                            //         decoration:
                                            //             TextDecoration
                                            //                 .lineThrough)),
                                            TextSpan(
                                                text:
                                                    " \u20b9${product.mrp ?? ""}",
                                                style: TextStyle(
                                                  fontFamily: 'MuseoSans',
                                                  color: AppConst.black,
                                                  fontSize: SizeUtils
                                                          .horizontalBlockSize *
                                                      3.5,
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle: FontStyle.normal,
                                                )),
                                            TextSpan(
                                                text: "/ ${product.unit ?? ""}",
                                                style: TextStyle(
                                                  fontFamily: 'MuseoSans',
                                                  color: AppConst.black,
                                                  fontSize: SizeUtils
                                                          .horizontalBlockSize *
                                                      3.3,
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle: FontStyle.normal,
                                                ))
                                          ])),
                                          // Text("₹ 125 / 3Kg",
                                          //     style: TextStyle(
                                          //       fontFamily: 'MuseoSans',
                                          //       color: AppConst.black,
                                          //       fontSize: SizeUtils
                                          //               .horizontalBlockSize *
                                          //           3.3,
                                          //       fontWeight: FontWeight.w500,
                                          //       fontStyle: FontStyle.normal,
                                          //     )),
                                          Spacer(),
                                          // SizedBox(
                                          //   width: 3.w,
                                          // ),
                                          Obx(
                                            () => product.quntity!.value > 0 &&
                                                    product.isQunitityAdd
                                                            ?.value ==
                                                        false
                                                ? _shoppingItem(product)
                                                : GestureDetector(
                                                    onTap: () async {
                                                      if (product
                                                              .quntity!.value ==
                                                          0) {
                                                        product
                                                            .quntity!.value++;

                                                        log("storesWithProductsModel?.products?[index] : ${product}");

                                                        _moreStoreController.addToCart(
                                                            store_id:
                                                                _moreStoreController
                                                                    .storeId
                                                                    .value,
                                                            index: 0,
                                                            increment: true,
                                                            cart_id:
                                                                _moreStoreController
                                                                        .getCartIDModel
                                                                        .value
                                                                        ?.sId ??
                                                                    '',
                                                            product: product);

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
                                                      }
                                                      if (product.quntity!
                                                                  .value !=
                                                              0 &&
                                                          product.isQunitityAdd
                                                                  ?.value ==
                                                              false) {
                                                        product.isQunitityAdd
                                                            ?.value = false;
                                                        await Future.delayed(
                                                                Duration(
                                                                    milliseconds:
                                                                        500))
                                                            .whenComplete(() =>
                                                                product
                                                                    .isQunitityAdd
                                                                    ?.value = true);
                                                      }
                                                      // addItem(product);
                                                    },
                                                    child: product.isQunitityAdd
                                                                    ?.value ==
                                                                true &&
                                                            product.quntity!
                                                                    .value !=
                                                                0
                                                        ? _dropDown(
                                                            product,
                                                            storesWithProductsModel
                                                                    .sId ??
                                                                '')
                                                        : DisplayAddPlus()),
                                          ),

                                          SizedBox(
                                            width: 3.w,
                                          )
                                        ],
                                      )
                                    ],
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

class DisplayProductInGridView extends StatelessWidget {
  DisplayProductInGridView({
    Key? key,
    required this.logo,
  }) : super(key: key);
  String? logo;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: (logo != null && logo != "")
          ? Image.network(
              logo!,
              fit: BoxFit.cover,
              height: 11.h,
              width: 24.w,
              errorBuilder: (context, error, stackTrace) {
                return SizedBox(
                  height: 11.h,
                  width: 30.w,
                  child: Image.asset("assets/images/noproducts.png"),
                );
              },
            )
          : Container(
              decoration: BoxDecoration(
                color: AppConst.veryLightGrey,
                borderRadius: BorderRadius.circular(8),
              ),
              height: 11.h,
              width: 30.w,
              child: Center(child: Image.asset("assets/images/noproducts.png")),
            ),
    );
  }
}
