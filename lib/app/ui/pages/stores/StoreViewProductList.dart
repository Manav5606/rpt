import 'dart:developer';

import 'package:customer_app/app/ui/pages/stores/chatOrder/chatOrder.dart';
import 'package:customer_app/app/ui/pages/stores/storeswithproductslist.dart';
import 'package:customer_app/screens/more_stores/morestore_productlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/ui/pages/search/controller/exploreContoller.dart';
import 'package:customer_app/app/ui/pages/search/models/GetStoreDataModel.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:customer_app/widgets/custom_popupmenu.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class StoreViewProductsList extends StatelessWidget {
  final ScrollController? controller;
  final ScrollController? gridViewScroll;
  final Function(int)? onChange;

  StoreViewProductsList(
      {Key? key, this.controller, this.onChange, this.gridViewScroll})
      : super(key: key);

  final ExploreController _exploreController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (_exploreController
                  .getStoreDataModel.value?.data?.mainProducts?.isNotEmpty ??
              false)
          ? ListView.separated(
              controller: this.controller,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: _exploreController
                      .getStoreDataModel.value?.data?.mainProducts?.length ??
                  0,
              //data.length,
              itemBuilder: (context, index) {
                MainProducts? storesWithProductsModel = _exploreController
                    .getStoreDataModel.value?.data?.mainProducts?[index];
                return Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text(storesWithProductsModel?.name ?? "",
                          //     style: TextStyle(
                          //       fontFamily: 'MuseoSans',
                          //       color: AppConst.black,
                          //       fontSize: SizeUtils.horizontalBlockSize * 4,
                          //       fontWeight: FontWeight.w700,
                          //       fontStyle: FontStyle.normal,
                          //     )),
                          // ((storesWithProductsModel?.products?.length ?? 0) >
                          //         5)
                          //     ? Text(
                          //         "View More",
                          //         style: TextStyle(
                          //           fontSize:
                          //               SizeUtils.horizontalBlockSize * 4,
                          //         ),
                          //       )
                          //     : SizedBox(),
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   height: 1.h,
                    // ),
                    if (storesWithProductsModel!.products!.isEmpty)
                      SizedBox()
                    else
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                                // height: ((storesWithProductsModel
                                //                 .products?.length ??
                                //             0) >
                                //         2)
                                //     ? 50.h
                                //     : 25.h,
                                // color: AppConst.yellow,
                                width: double.infinity,
                                child: GridView(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  controller: gridViewScroll,
                                  scrollDirection: Axis.vertical,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 2.w,
                                          mainAxisSpacing: 1.h),
                                  children: List.generate(
                                      storesWithProductsModel
                                              .products?.length ??
                                          0, (index) {
                                    StoreModelProducts product =
                                        storesWithProductsModel
                                            .products![index];
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
                                              "Cashback \u20b9${product.cashback ?? 0}",
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
                                              Text(
                                                  "\u20b9${product.selling_price ?? ""}",
                                                  style: TextStyle(
                                                    fontFamily: 'MuseoSans',
                                                    color: AppConst.black,
                                                    fontSize: SizeUtils
                                                            .horizontalBlockSize *
                                                        3.5,
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle: FontStyle.normal,
                                                  )),
                                              SizedBox(
                                                width: 14.w,
                                                child: Text(
                                                    "/kg ${product.unit ?? ""}",
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                      fontFamily: 'MuseoSans',
                                                      color: AppConst.black,
                                                      fontSize: SizeUtils
                                                              .horizontalBlockSize *
                                                          3.3,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                    )),
                                              ),
                                              // RichText(
                                              //     text: TextSpan(children: [
                                              //   // TextSpan(
                                              //   //     text:
                                              //   //         "\u20b9${_addCartController.reviewCart.value?.data?.inventories?[
                                              //   //             index].mrp ?? ""}",
                                              //   //     style: TextStyle(
                                              //   //         fontFamily:
                                              //   //             'MuseoSans',
                                              //   //         color: AppConst
                                              //   //             .grey,
                                              //   //         fontSize:
                                              //   //             SizeUtils.horizontalBlockSize *
                                              //   //                 3.3,
                                              //   //         fontWeight:
                                              //   //             FontWeight
                                              //   //                 .w500,
                                              //   //         fontStyle:
                                              //   //             FontStyle
                                              //   //                 .normal,
                                              //   //         decoration:
                                              //   //             TextDecoration
                                              //   //                 .lineThrough)),
                                              //   TextSpan(
                                              //       text:
                                              //           " \u20b9${product.mrp ?? ""}",
                                              //       style: TextStyle(
                                              //         fontFamily: 'MuseoSans',
                                              //         color: AppConst.black,
                                              //         fontSize: SizeUtils
                                              //                 .horizontalBlockSize *
                                              //             3.5,
                                              //         fontWeight:
                                              //             FontWeight.w500,
                                              //         fontStyle:
                                              //             FontStyle.normal,
                                              //       )),
                                              //   TextSpan(
                                              //       text:
                                              //           "/ ${product.unit ?? ""}",
                                              //       style: TextStyle(
                                              //         fontFamily: 'MuseoSans',
                                              //         color: AppConst.black,
                                              //         fontSize: SizeUtils
                                              //                 .horizontalBlockSize *
                                              //             3.3,
                                              //         fontWeight:
                                              //             FontWeight.w500,
                                              //         fontStyle:
                                              //             FontStyle.normal,
                                              //       ))
                                              // ])),
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
                                                () => product.quntity!.value >
                                                            0 &&
                                                        product.isQunitityAdd
                                                                ?.value ==
                                                            false
                                                    ? _shoppingItem(product)
                                                    : GestureDetector(
                                                        onTap: () async {
                                                          if (product.quntity!
                                                                  .value ==
                                                              0) {
                                                            product.quntity!
                                                                .value++;
                                                            log("storesWithProductsModel?.products?[index] : ${product}");
                                                            _exploreController.addToCart(
                                                                cart_id: _exploreController
                                                                        .cartIndex
                                                                        .value
                                                                        ?.sId ??
                                                                    '',
                                                                store_id:
                                                                    storesWithProductsModel
                                                                            .sId ??
                                                                        '',
                                                                index: 0,
                                                                increment: true,
                                                                product:
                                                                    product);
                                                          }
                                                          if (product.quntity!
                                                                      .value !=
                                                                  0 &&
                                                              product.isQunitityAdd
                                                                      ?.value ==
                                                                  false) {
                                                            product
                                                                .isQunitityAdd
                                                                ?.value = false;
                                                            await Future.delayed(
                                                                    Duration(
                                                                        milliseconds:
                                                                            500))
                                                                .whenComplete(
                                                                    () => product
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
                                                            : DisplayAddPlus()
                                                        //  Container(
                                                        //     height: 3.5.h,
                                                        //     width: product.isQunitityAdd?.value ==
                                                        //                 true &&
                                                        //             product.quntity!.value !=
                                                        //                 0
                                                        //         ? 8.w
                                                        //         : 15.w,
                                                        //     decoration:
                                                        //         BoxDecoration(
                                                        //       border: Border.all(
                                                        //           color: AppConst
                                                        //               .green,
                                                        //           width:
                                                        //               0.8),
                                                        //       borderRadius: BorderRadius.circular(
                                                        //           product.isQunitityAdd?.value == true &&
                                                        //                   product.quntity!.value != 0
                                                        //               ? 25
                                                        //               : 8),
                                                        //       color: AppConst
                                                        //           .white,
                                                        //     ),
                                                        //     child: product.isQunitityAdd?.value ==
                                                        //                 true &&
                                                        //             product.quntity!.value !=
                                                        //                 0
                                                        //         ? Center(
                                                        //             child: Text(
                                                        //                 "${product.quntity?.value ?? "0"}",
                                                        //                 style:
                                                        //                     TextStyle(
                                                        //                   fontFamily: 'MuseoSans',
                                                        //                   color: AppConst.green,
                                                        //                   fontSize: SizeUtils.horizontalBlockSize * 3.8,
                                                        //                   fontWeight: FontWeight.w500,
                                                        //                   fontStyle: FontStyle.normal,
                                                        //                 )),
                                                        //           )
                                                        //         : Center(
                                                        //             child:
                                                        //                 Text(
                                                        //               " Add +",
                                                        //               style:
                                                        //                   TextStyle(
                                                        //                 fontFamily:
                                                        //                     'MuseoSans',
                                                        //                 color:
                                                        //                     AppConst.green,
                                                        //                 fontSize:
                                                        //                     SizeUtils.horizontalBlockSize * 3.8,
                                                        //                 fontWeight:
                                                        //                     FontWeight.w500,
                                                        //                 fontStyle:
                                                        //                     FontStyle.normal,
                                                        //               ),
                                                        //             ),
                                                        //           ),
                                                        //   ),
                                                        ),
                                              ),

                                              SizedBox(
                                                width: 3.w,
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                                )

                                // ListView.separated(
                                //   physics: ClampingScrollPhysics(),
                                //   shrinkWrap: true,
                                //   scrollDirection: Axis.horizontal,
                                //   itemCount:
                                //       storesWithProductsModel.products?.length ??
                                //           0,
                                //   itemBuilder: (context, i) {
                                //     StoreModelProducts product =
                                //         storesWithProductsModel.products![i];
                                //     return Container(
                                //       width: 45.w,
                                //       height: 24.h,
                                //       // color: AppConst.yellow,
                                //       child: Column(
                                //         mainAxisSize: MainAxisSize.min,
                                //         crossAxisAlignment:
                                //             CrossAxisAlignment.start,
                                //         children: [
                                //           Center(
                                //             child: (product.logo != null)
                                //                 ? Image.network(
                                //                     product.logo!,
                                //                     fit: BoxFit.cover,
                                //                     height: 12.h,
                                //                     width: 24.w,
                                //                   )
                                //                 : Center(
                                //                     child: Icon(
                                //                         CupertinoIcons.cart)),
                                //           ),
                                //           SizedBox(
                                //             height: 4.5.h,
                                //             child: Text(product.name.toString(),
                                //                 maxLines: 2,
                                //                 overflow: TextOverflow.ellipsis,
                                //                 style: TextStyle(
                                //                   fontFamily: 'MuseoSans',
                                //                   color: AppConst.black,
                                //                   fontSize: SizeUtils
                                //                           .horizontalBlockSize *
                                //                       3.7,
                                //                   fontWeight: FontWeight.w500,
                                //                   fontStyle: FontStyle.normal,
                                //                 )),
                                //           ),
                                //           SizedBox(
                                //             height: 1.h,
                                //           ),
                                //           Text(
                                //               "Cashback \u20b9${product.cashback.toString()}",
                                //               style: TextStyle(
                                //                 fontFamily: 'MuseoSans',
                                //                 color: AppConst.black,
                                //                 fontSize: SizeUtils
                                //                         .horizontalBlockSize *
                                //                     3.5,
                                //                 fontWeight: FontWeight.w700,
                                //                 fontStyle: FontStyle.normal,
                                //               )),
                                //           // SizedBox(
                                //           //   height: 0.5.h,
                                //           // ),
                                //           Row(
                                //             mainAxisAlignment:
                                //                 MainAxisAlignment.start,
                                //             children: [
                                //               Text("₹ 125 / 3Kg",
                                //                   style: TextStyle(
                                //                     fontFamily: 'MuseoSans',
                                //                     color: AppConst.black,
                                //                     fontSize: SizeUtils
                                //                             .horizontalBlockSize *
                                //                         3.3,
                                //                     fontWeight: FontWeight.w500,
                                //                     fontStyle: FontStyle.normal,
                                //                   )),
                                //               Spacer(),
                                //               // SizedBox(
                                //               //   width: 3.w,
                                //               // ),
                                //               Obx(
                                //                 () =>
                                //                     product.quntity!.value > 0 &&
                                //                             product.isQunitityAdd
                                //                                     ?.value ==
                                //                                 false
                                //                         ? _shoppingItem(product)
                                //                         : GestureDetector(
                                //                             onTap: () async {
                                //                               if (product.quntity!
                                //                                       .value ==
                                //                                   0) {
                                //                                 product.quntity!
                                //                                     .value++;
                                //                                 log("storesWithProductsModel?.products?[index] : ${product}");
                                //                                 _exploreController.addToCart(
                                //                                     cart_id: _exploreController
                                //                                             .cartIndex
                                //                                             .value
                                //                                             ?.sId ??
                                //                                         '',
                                //                                     store_id:
                                //                                         storesWithProductsModel.sId ??
                                //                                             '',
                                //                                     index: 0,
                                //                                     increment:
                                //                                         true,
                                //                                     product:
                                //                                         product);
                                //                               }
                                //                               if (product.quntity!
                                //                                           .value !=
                                //                                       0 &&
                                //                                   product.isQunitityAdd
                                //                                           ?.value ==
                                //                                       false) {
                                //                                 product
                                //                                     .isQunitityAdd
                                //                                     ?.value = false;
                                //                                 await Future.delayed(
                                //                                         Duration(
                                //                                             milliseconds:
                                //                                                 500))
                                //                                     .whenComplete(
                                //                                         () => product
                                //                                             .isQunitityAdd
                                //                                             ?.value = true);
                                //                               }
                                //                               // addItem(product);
                                //                             },
                                //                             child: product.isQunitityAdd
                                //                                             ?.value ==
                                //                                         true &&
                                //                                     product.quntity!
                                //                                             .value !=
                                //                                         0
                                //                                 ? _dropDown(
                                //                                     product,
                                //                                     storesWithProductsModel
                                //                                             .sId ??
                                //                                         '')
                                //                                 : Container(
                                //                                     height: 3.5.h,
                                //                                     width: product.isQunitityAdd?.value ==
                                //                                                 true &&
                                //                                             product.quntity!.value !=
                                //                                                 0
                                //                                         ? 8.w
                                //                                         : 15.w,
                                //                                     decoration:
                                //                                         BoxDecoration(
                                //                                       border: Border.all(
                                //                                           color: AppConst
                                //                                               .green,
                                //                                           width:
                                //                                               0.8),
                                //                                       borderRadius:
                                //                                           BorderRadius.circular(product.isQunitityAdd?.value == true &&
                                //                                                   product.quntity!.value != 0
                                //                                               ? 25
                                //                                               : 8),
                                //                                       color: AppConst
                                //                                           .white,
                                //                                     ),
                                //                                     child: product.isQunitityAdd?.value ==
                                //                                                 true &&
                                //                                             product.quntity!.value !=
                                //                                                 0
                                //                                         ? Center(
                                //                                             child: Text(
                                //                                                 "${product.quntity?.value ?? "0"}",
                                //                                                 style: TextStyle(
                                //                                                   fontFamily: 'MuseoSans',
                                //                                                   color: AppConst.green,
                                //                                                   fontSize: SizeUtils.horizontalBlockSize * 3.8,
                                //                                                   fontWeight: FontWeight.w500,
                                //                                                   fontStyle: FontStyle.normal,
                                //                                                 )),
                                //                                           )
                                //                                         : Center(
                                //                                             child:
                                //                                                 Text(
                                //                                               " Add +",
                                //                                               style:
                                //                                                   TextStyle(
                                //                                                 fontFamily: 'MuseoSans',
                                //                                                 color: AppConst.green,
                                //                                                 fontSize: SizeUtils.horizontalBlockSize * 3.8,
                                //                                                 fontWeight: FontWeight.w500,
                                //                                                 fontStyle: FontStyle.normal,
                                //                                               ),
                                //                                             ),
                                //                                           ),
                                //                                   ),
                                //                           ),
                                //               ),

                                //               SizedBox(
                                //                 width: 3.w,
                                //               )
                                //             ],
                                //           )
                                //         ],
                                //       ),
                                //     );
                                //   },
                                //   separatorBuilder: (context, index) {
                                //     return SizedBox(
                                //       width: 2.w,
                                //     );
                                //   },
                                // ),
                                ),
                          ),
                        ],
                      ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox();
                // Container(
                //   height: 1.5.w,
                //   color: AppConst.veryLightGrey,
                // );
              },
            )
          : Center(
              child: Text(
                'No data Found',
                style: TextStyle(
                  fontSize: SizeUtils.horizontalBlockSize * 5,
                ),
              ),
            ),
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
        // Align(
        //   alignment: Alignment.topRight,
        //   child: Container(
        //     height: 4.h,
        //     width: 8.w,
        //     decoration: BoxDecoration(
        //       shape: BoxShape.circle,
        //       border: Border.all(
        //         color: AppConst.green,
        //       ),
        //       color: AppConst.white,
        //     ),
        //     child: product.isQunitityAdd?.value == true &&
        //             product.quntity!.value != 0
        //         ? Center(
        //             child: Text(
        //               "${product.quntity!.value}",
        //               style: TextStyle(
        //                 fontFamily: 'MuseoSans',
        //                 color: AppConst.green,
        //                 fontSize: SizeUtils.horizontalBlockSize * 4,
        //                 fontWeight: FontWeight.w500,
        //                 fontStyle: FontStyle.normal,
        //               ),
        //             ),
        //           )
        //         : Icon(
        //             Icons.add,
        //             color: AppConst.white,
        //           ),
        //   ),
        // ),
        list: quntityList,
        onSelected: (value) async {
          product.quntity!.value = value;
          if (product.quntity!.value == 0) {
            product.isQunitityAdd?.value = false;
          }
          log('product :${product.name}');
          _exploreController.addToCart(
              cart_id: _exploreController.cartIndex.value?.sId ?? '',
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

    // Container(
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(25),
    //     color: AppConst.white,
    //   ),
    //   child: Padding(
    //     padding: EdgeInsets.symmetric(vertical: 0.h),
    //     child: Obx(

    //       () => Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceAround,
    //         children: <Widget>[
    //           // _decrementButton(product),
    //           Text(
    //             '${product.quntity!.value}',
    //             style: TextStyle(
    //                 fontSize: SizeUtils.horizontalBlockSize * 4,
    //                 fontWeight: FontWeight.w500,
    //                 color: AppConst.green),
    //           ),
    //           // _incrementButton(product),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }

  Widget _incrementButton(product) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppConst.white,
        ),
        child: Icon(
          Icons.add,
          color: AppConst.grey,
        ),
      ),
      onTap: () async {
        product.isQunitityAdd?.value = false;
        product.quntity!.value++;
        await Future.delayed(Duration(seconds: 2))
            .whenComplete(() => product.isQunitityAdd?.value = true);
        // addItem(products);
      },
    );
  }

  Widget _decrementButton(product) {
    return GestureDetector(
      onTap: () async {
        product.isQunitityAdd?.value = false;
        product.quntity!.value--;
        await Future.delayed(Duration(seconds: 2))
            .whenComplete(() => product.isQunitityAdd?.value = true);
        // addItem(products);
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppConst.white,
        ),
        child: Icon(
          Icons.remove,
          color: AppConst.grey,
        ),
      ),
    );
  }
}
