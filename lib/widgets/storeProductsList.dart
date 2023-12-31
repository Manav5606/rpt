import 'package:customer_app/app/ui/pages/stores/chatOrder/chatOrder.dart';
import 'package:customer_app/screens/more_stores/all_offers_listview.dart';
import 'package:customer_app/screens/more_stores/morestore_productlist.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/screens/more_stores/morestore_controller.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../app/ui/pages/search/models/autoCompleteProductsByStoreModel.dart';

class StoreProductSearchList extends StatelessWidget {
  List<Products>? foundedStores;
  final ScrollController? controller;

  StoreProductSearchList(
      {Key? key, this.controller, required this.foundedStores})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (foundedStores?.isEmpty ?? true)
        ? Text("No data")
        : ListView.separated(
            controller: this.controller,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: foundedStores!.length,
            //data.length,
            itemBuilder: (context, index) {
              return ListViewChild(
                storeSearchModel: foundedStores![index],
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
  final Products storeSearchModel;

  ListViewChild({Key? key, required this.storeSearchModel}) : super(key: key);
  final MoreStoreController _moreStoreController = Get.find();

  // final ExploreController _exploreController = Get.find();

  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);

    return Column(
      children: [
        InkWell(
          onTap: () => {},
          child: Row(
            children: [
              DisplayProductImage(logo: storeSearchModel.logo),
              // CircleAvatar(
              //   backgroundImage: NetworkImage(storeSearchModel.logo!),
              //   backgroundColor: AppConst.white,
              //   radius: SizeUtils.horizontalBlockSize * 5.3,
              // ),
              SizedBox(
                width: 2.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      DisplayProductName(name: storeSearchModel.name),
                      Obx(
                        () => (storeSearchModel.quntity?.value ?? 0) > 0 &&
                                storeSearchModel.isQunitityAdd?.value == false
                            ? _moreStoreController
                                .shoppingItem(storeSearchModel)
                            : GestureDetector(
                                onTap: () async {
                                  if (storeSearchModel.quntity!.value == 0) {
                                    storeSearchModel.quntity!.value++;
                                    await _moreStoreController.addToCart(
                                        store_id:
                                            storeSearchModel.store?.sId ?? '',
                                        index: 0,
                                        increment: true,
                                        cart_id: _moreStoreController
                                                .getCartIDModel.value?.sId ??
                                            '',
                                        product: storeSearchModel);
                                    // await _moreStoreController.getStoreData(
                                    //   id: storeSearchModel.store?.sId ?? '',
                                    // );
                                  }
                                  if (storeSearchModel.quntity!.value != 0 &&
                                      storeSearchModel.isQunitityAdd?.value ==
                                          false) {
                                    storeSearchModel.isQunitityAdd?.value =
                                        false;
                                    await Future.delayed(
                                            Duration(milliseconds: 500))
                                        .whenComplete(() => storeSearchModel
                                            .isQunitityAdd?.value = true);
                                  }
                                  // addItem(product);
                                },
                                child: storeSearchModel.isQunitityAdd?.value ==
                                            true &&
                                        storeSearchModel.quntity!.value != 0
                                    ? _moreStoreController.dropDown(
                                        storeSearchModel,
                                        storeSearchModel.store?.sId ?? '',
                                        true)
                                    : DisplayAddPlus()),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),

                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "\u20b9${storeSearchModel.mrp ?? ""}",
                        style: TextStyle(
                            fontFamily: 'MuseoSans',
                            color: AppConst.grey,
                            fontSize: SizeUtils.horizontalBlockSize * 3.3,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            decoration: TextDecoration.lineThrough)),
                    TextSpan(
                        text: " \u20b9${storeSearchModel.selling_price ?? ""}",
                        style: TextStyle(
                          fontFamily: 'MuseoSans',
                          color: AppConst.black,
                          fontSize: SizeUtils.horizontalBlockSize * 3.5,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                        )),
                    TextSpan(
                        text: "/ ${storeSearchModel.unit ?? ""}",
                        style: TextStyle(
                          fontFamily: 'MuseoSans',
                          color: AppConst.black,
                          fontSize: SizeUtils.horizontalBlockSize * 3.3,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                        ))
                  ])),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  DisplayCashback(
                    cashback: storeSearchModel.cashback,
                  ),
                  // Text(
                  //     "\u20b9${storeSearchModel.mrp ?? "--"} \u20b9${storeSearchModel.selling_price ?? ""}/ ${storeSearchModel.unit ?? ""}",
                  //     overflow: TextOverflow.ellipsis,
                  //     style: TextStyle(
                  //       fontFamily: 'MuseoSans',
                  //       color: AppConst.black,
                  //       fontSize: SizeUtils.horizontalBlockSize * 3.3,
                  //       fontWeight: FontWeight.w500,
                  //       fontStyle: FontStyle.normal,
                  //     )),
                ],
              ),

              // AddButtonWidget(
              //   onTap: () async {
              //     storeSearchModel.quntity?.value++;
              //     await _moreStoreController.addToCart(
              //         store_id: storeSearchModel.store?.sId ?? '',
              //         index: 0,
              //         increment: true,
              //         cart_id: _moreStoreController.addToCartModel.value?.sId ?? '',
              //         product: storeSearchModel);
              //     await _moreStoreController.getStoreData(
              //       id: storeSearchModel.store?.sId ?? '',
              //     );
              //     _moreStoreController.autoCompleteProductsByStoreModel.value?.data?.products?.clear();
              //     _moreStoreController.storeSearchController.clear();
              //     _moreStoreController.storeSearchText.value = '';
              //   },
              // ),
            ],
          ),
        ),
      ],
    );
  }
}

class Inventories extends StatelessWidget {
  final List<Products>? inventoriesModel;

  Inventories({Key? key, required this.inventoriesModel}) : super(key: key);
  final MoreStoreController _moreStoreController = Get.find();

  // final ExploreController _exploreController = Get.find();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: inventoriesModel?.length ?? 0,
      //data.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            InkWell(
              onTap: () => {},
              child: Row(
                children: [
                  DisplayProductImage(
                    logo: inventoriesModel?[index].img,
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DisplayProductName(
                        name: inventoriesModel?[index].name,
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      Text(
                          "\u20b9${inventoriesModel?[index].mrp ?? "--"}/ ${inventoriesModel?[index].unit ?? ""}",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'MuseoSans',
                            color: AppConst.black,
                            fontSize: SizeUtils.horizontalBlockSize * 3.3,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                          )),
                    ],
                  ),

                  // Expanded(
                  //   child: Text(
                  //     inventoriesModel?[index].name ?? '',
                  //     style: AppStyles.BOLD_STYLE,
                  //   ),
                  // ),
                  // AddButtonWidget(
                  //   onTap: () async {
                  //     inventoriesModel?[index].quntity?.value++;
                  //     await _moreStoreController.addToCartInventory(
                  //         cart_id: _moreStoreController.addToCartModel.value?.sId ?? '',
                  //         store_id: inventoriesModel?[index].store?.sId ?? '',
                  //         inventory: inventoriesModel?[index]);
                  //     //
                  //     // await _moreStoreController.getStoreData(
                  //     //   id: inventoriesModel?[index].store?.sId ?? '',
                  //     // );
                  //     // _moreStoreController.autoCompleteProductsByStoreModel.value?.data?.products?.clear();
                  //     // _moreStoreController.storeSearchController.clear();
                  //     // _moreStoreController.storeSearchText.value = '';
                  //   },
                  // ),
                  Obx(
                    () => (inventoriesModel?[index].quntity?.value ?? 0) > 0 &&
                            inventoriesModel?[index].isQunitityAdd?.value ==
                                false
                        ? _moreStoreController
                            .shoppingItem(inventoriesModel?[index])
                        : GestureDetector(
                            onTap: () async {
                              if (inventoriesModel?[index].quntity!.value ==
                                  0) {
                                inventoriesModel?[index].quntity!.value++;
                                await _moreStoreController.addToCartInventory(
                                  cart_id: _moreStoreController
                                          .getCartIDModel.value?.sId ??
                                      '',
                                  store_id:
                                      inventoriesModel?[index].store?.sId ?? '',
                                  name: inventoriesModel?[index].name ?? '',
                                  sId: inventoriesModel?[index].sId ?? '',
                                  quntity:
                                      inventoriesModel?[index].quntity?.value ??
                                          0,
                                );
                              }
                              if (inventoriesModel?[index].quntity!.value !=
                                      0 &&
                                  inventoriesModel?[index]
                                          .isQunitityAdd
                                          ?.value ==
                                      false) {
                                inventoriesModel?[index].isQunitityAdd?.value =
                                    false;
                                await Future.delayed(
                                        Duration(milliseconds: 500))
                                    .whenComplete(() => inventoriesModel?[index]
                                        .isQunitityAdd
                                        ?.value = true);
                              }
                              // addItem(product);
                            },
                            child: inventoriesModel?[index]
                                            .isQunitityAdd
                                            ?.value ==
                                        true &&
                                    inventoriesModel?[index].quntity!.value != 0
                                ? _moreStoreController.dropDown(
                                    inventoriesModel?[index],
                                    inventoriesModel?[index].store?.sId ?? '',
                                    false)
                                : DisplayAddPlus()
                            // Align(
                            //     alignment: Alignment.topRight,
                            //     child: Container(
                            //       height: SizeUtils.horizontalBlockSize * 8,
                            //       width: SizeUtils.horizontalBlockSize * 8,
                            //       decoration: BoxDecoration(
                            //         shape: BoxShape.circle,
                            //         color: AppConst.grey,
                            //       ),
                            //       child: inventoriesModel?[index]
                            //                       .isQunitityAdd
                            //                       ?.value ==
                            //                   true &&
                            //               inventoriesModel?[index]
                            //                       .quntity!
                            //                       .value !=
                            //                   0
                            //           ? Center(
                            //               child: Text(
                            //                   "${inventoriesModel?[index].quntity!.value}",
                            //                   style: TextStyle(
                            //                     color: AppConst.white,
                            //                     fontSize: SizeUtils
                            //                             .horizontalBlockSize *
                            //                         4,
                            //                   )),
                            //             )
                            //           : Icon(
                            //               Icons.add,
                            //               color: AppConst.white,
                            //             ),
                            //     ),
                            //   ),
                            ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 1.h,
        );
      },
    );
  }
}
