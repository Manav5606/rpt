import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:customer_app/app/ui/common/loader.dart';
// import 'package:customer_app/app/data/model/active_order_model.dart';
import 'package:customer_app/app/ui/pages/stores/chatOrder/chatOrder.dart';
import 'package:customer_app/screens/history/history_screen.dart';
import 'package:customer_app/screens/more_stores/all_offers_listview.dart';
import 'package:customer_app/screens/more_stores/morestore_controller.dart';
import 'package:customer_app/screens/more_stores/morestore_productlist.dart';
import 'package:customer_app/widgets/custom_popupmenu.dart';
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
import 'package:sizer/sizer.dart';

import '../app/ui/pages/search/models/autoCompleteProductsByStoreModel.dart';
import '../constants/app_const.dart';

class SearchList extends StatefulWidget {
  List<StoreSearchModel>? foundedStores;
  final ScrollController? controller;

  SearchList({Key? key, this.controller, required this.foundedStores})
      : super(key: key);

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  final ExploreController _exploreController = Get.find();

  final MoreStoreController _moreStoreController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        NearMePageData? data =
            _exploreController.getNearMePageDataModel.value?.data;

        int totalProducts =
            (data?.products?.length ?? 0) + (data?.inventories?.length ?? 0);
        return (((data?.products?.isEmpty ?? true) &&
                (data?.stores?.isEmpty ?? true)))
            ? Center(
                child: Text(
                "",
                style: AppStyles.STORES_SUBTITLE_STYLE,
              ))
            : Container(
                height: 70.h,
                // color: AppConst.yellow,
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TabBar(
                        tabs: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Stores (${data?.stores?.length ?? 0})',
                                style: TextStyle(
                                  fontFamily: 'MuseoSans',
                                  color: AppConst.black,
                                  fontSize: SizeUtils.horizontalBlockSize * 4,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Products  (${totalProducts})',
                                style: TextStyle(
                                  fontFamily: 'MuseoSans',
                                  color: AppConst.black,
                                  fontSize: SizeUtils.horizontalBlockSize * 4,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                )),
                          ),
                          // Tab(
                          //   text: 'Stores',
                          // ),
                          // Tab(text: 'Products'),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 2.w, vertical: 1.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    (_exploreController.isLoadingStoreData.value
                                        ? ListView.separated(
                                            shrinkWrap: true,
                                            primary: false,
                                            itemCount:
                                                1, //storeSearchData.length,
                                            itemBuilder: (context, index) {
                                              return LoadingWidget();
                                            },
                                            separatorBuilder: (context, index) {
                                              return SizedBox(
                                                height: SizeUtils
                                                        .horizontalBlockSize *
                                                    2.55,
                                              );
                                            },
                                          )
                                        : ListView.separated(
                                            controller: this.widget.controller,
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount:
                                                data?.stores?.length ?? 0,
                                            itemBuilder: (context, index) {
                                              return StoreListViewChild(
                                                  Stores: data!.stores![index]);
                                            },
                                            separatorBuilder: (context, index) {
                                              return SizedBox(
                                                height: SizeUtils
                                                        .horizontalBlockSize *
                                                    2.55,
                                              );
                                            },
                                          )),
                                  ],
                                ),
                              ),
                            ),
                            SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.only(left: 2.w, top: 1.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _exploreController.isLoadingStoreData.value
                                        ? SizedBox()
                                        : ListView.separated(
                                            controller: this.widget.controller,
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount:
                                                data?.products?.length ?? 0,
                                            itemBuilder: (context, index) {
                                              return ExploreSearchProducts(
                                                product: data!.products![index],
                                              );
                                            },
                                            separatorBuilder: (context, index) {
                                              return SizedBox(height: 2.h);
                                            },
                                          ),
                                    _exploreController.isLoadingStoreData.value
                                        ? SizedBox()
                                        : Column(
                                            children: [
                                              // Padding(
                                              //   padding: EdgeInsets.all(SizeUtils
                                              //           .horizontalBlockSize *
                                              //       2),
                                              //   child: Text(
                                              //     "Inventories",
                                              //     style: AppStyles.BOLD_STYLE,
                                              //   ),
                                              // ),
                                              ListView.separated(
                                                controller:
                                                    this.widget.controller,
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemCount:
                                                    data?.inventories?.length ??
                                                        0,
                                                itemBuilder: (context, index) {
                                                  return ExploreSearchProducts(
                                                    product: data!
                                                        .inventories![index],
                                                  );
                                                },
                                                separatorBuilder:
                                                    (context, index) {
                                                  return SizedBox(height: 2.h);
                                                },
                                              ),
                                            ],
                                          ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
      },
    );
  }
}

class ExploreSearchProducts extends StatelessWidget {
  final Products product;
  final MoreStoreController _moreStoreController = Get.find();
  final ExploreController _exploreController = Get.find();
  ExploreSearchProducts({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() async {
        // store search results of stores  in Hive
        RecentProductsData recentProductsData = RecentProductsData(
          name: product.name.toString(),
          logo: "",
          sId: "",
          isStore: false,
        );
        var contain = _exploreController.recentProductList
            .where((element) => element.name == product.name);
        if (contain.isEmpty) {
          _exploreController.setNearDataProduct(recentProductsData);
        }
        _moreStoreController.storeId.value = product.store?.sId ?? '';

        await _moreStoreController.getStoreData(
          id: product.store?.sId ?? '',
        );
      }),
      child: Row(
        children: [
          DisplayProductImage(
            logo: product.logo ?? product.img,
          ),
          SizedBox(
            width: 2.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              DisplayProductName(
                name: product.name,
              ),
              SizedBox(
                height: 0.5.h,
              ),
              (product.cashback == null || product.cashback == "")
                  ? SizedBox()
                  : Text("Cashback \u20b9${product.cashback.toString()}",
                      style: TextStyle(
                        fontFamily: 'MuseoSans',
                        color: AppConst.black,
                        fontSize: SizeUtils.horizontalBlockSize * 3.5,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      )),
              SizedBox(
                height: 0.5.h,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4.0),
                          height: 2.5.h,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppConst.lightGrey,
                              border: Border.all(
                                width: 0.1,
                                color: AppConst.lightGrey,
                              )),
                          child: Image(
                            image: AssetImage(
                              'assets/images/Store.png',
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 1.w,
                        ),
                        Container(
                          width: 52.w,
                          child: Text(product.store?.name ?? "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'MuseoSans',
                                color: AppConst.black,
                                fontSize: SizeUtils.horizontalBlockSize * 3.5,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 1.w,
                    ),
                    InkWell(
                      onTap: (() async {
                        _moreStoreController.storeId.value =
                            product.store?.sId ?? '';

                        await _moreStoreController.getStoreData(
                          id: product.store?.sId ?? '',
                        );
                      }),
                      child: Container(
                        height: 3.h,
                        width: 15.w,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: AppConst.darkGreen, width: 0.8),
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0xffe6faf1),
                        ),
                        child: Center(
                          child: Text(
                            " Add +",
                            style: TextStyle(
                              fontFamily: 'MuseoSans',
                              color: AppConst.darkGreen,
                              fontSize: SizeUtils.horizontalBlockSize * 3.5,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Obx(
                    //   () => product.quntity!.value > 0 &&
                    //           product.isQunitityAdd?.value == false
                    //       ? _shoppingItem(product)
                    //       : GestureDetector(
                    //           onTap: () async {
                    //             if (product.quntity!.value == 0) {
                    //               product.quntity!.value++;

                    //               _moreStoreController.addToCart(
                    //                   store_id:
                    //                       _moreStoreController.storeId.value,
                    //                   index: 0,
                    //                   increment: true,
                    //                   cart_id: _moreStoreController
                    //                           .getCartIDModel.value?.sId ??
                    //                       '',
                    //                   product: product);

                    //               _moreStoreController.storeId.value =
                    //                   product.store?.sId ?? '';

                    //               await _moreStoreController.getStoreData(
                    //                 id: product.store?.sId ?? '',
                    //               );
                    //             }
                    //             if (product.quntity!.value != 0 &&
                    //                 product.isQunitityAdd?.value == false) {
                    //               product.isQunitityAdd?.value = false;
                    //               await Future.delayed(
                    //                       Duration(milliseconds: 500))
                    //                   .whenComplete(() =>
                    //                       product.isQunitityAdd?.value = true);
                    //             }
                    //             // addItem(product);
                    //           },
                    //           child: product.isQunitityAdd?.value == true &&
                    //                   product.quntity!.value != 0
                    //               ? _dropDown(product, product.store?.sId ?? '')
                    //               : Container(
                    //                   height: 3.h,
                    //                   width: 15.w,
                    //                   decoration: BoxDecoration(
                    //                     border: Border.all(
                    //                         color: AppConst.darkGreen,
                    //                         width: 0.8),
                    //                     borderRadius: BorderRadius.circular(12),
                    //                     color: Color(0xffe6faf1),
                    //                   ),
                    //                   child: Center(
                    //                     child: Text(
                    //                       " Add +",
                    //                       style: TextStyle(
                    //                         fontFamily: 'MuseoSans',
                    //                         color: AppConst.darkGreen,
                    //                         fontSize:
                    //                             SizeUtils.horizontalBlockSize *
                    //                                 3.5,
                    //                         fontWeight: FontWeight.w500,
                    //                         fontStyle: FontStyle.normal,
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 )),
                    // ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  // List<String> quntityList = [
  //   '1',
  //   '2',
  //   '3',
  //   '4',
  //   '5',
  //   '6',
  //   '7',
  //   '8',
  //   '9',
  //   '10'
  // ];

  // Widget _dropDown(product, String sId) {
  //   return Obx(
  //     () => CustomPopMenu(
  //       title: 'Quantity',
  //       child: DisplayProductCount(
  //         count: product.quntity!.value,
  //       ),
  //       list: quntityList,
  //       onSelected: (value) async {
  //         product.quntity!.value = value;
  //         if (product.quntity!.value == 0) {
  //           product.isQunitityAdd?.value = false;
  //         }

  //         _moreStoreController.addToCart(
  //             cart_id: _moreStoreController.getCartIDModel.value?.sId ?? '',
  //             store_id: sId,
  //             index: 0,
  //             increment: true,
  //             product: product);
  //       },
  //     ),
  //   );
  // }

  // Widget _shoppingItem(product) {
  //   return Obx(
  //     () => DisplayProductCount(
  //       count: product.quntity!.value,
  //     ),
  //   );
  // }
}

class StoreListViewChild extends StatelessWidget {
  final Store? Stores;
  final MoreStoreController _moreStoreController = Get.find();
  final ExploreController _exploreController = Get.find();
  StoreListViewChild({Key? key, required this.Stores}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() async {
        // store search results of stores  in Hive
        RecentProductsData recentProductsData = RecentProductsData(
          name: Stores?.name.toString(),
          logo: "",
          sId: "",
          isStore: true,
        );
        var contain = _exploreController.recentProductList
            .where((element) => element.name == Stores?.name);
        if (contain.isEmpty) {
          _exploreController.setNearDataProduct(recentProductsData);
        }
        // navigate to store 2nd part
        _moreStoreController.storeId.value = Stores!.sId.toString();

        await _moreStoreController.getStoreData(
          id: Stores!.sId.toString(),
        );
      }),
      child: Row(
        children: [
          DispalyStoreLogo(
            logo: Stores?.logo,
            bottomPadding: 0,
            height: 5,
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
                        child: Text("${Stores?.name ?? ""}",
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
                        height: 0.5.h,
                      ),
                      Row(
                        children: [
                          (Stores?.calculatedDistance != null)
                              ? DisplayDistance(
                                  distance: Stores?.calculatedDistance,
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
                          if (Stores?.storeType != null &&
                              Stores!.storeType!.isNotEmpty)
                            if ((Stores?.storeType) == 'online')
                              DsplayPickupDelivery()
                            else
                              Text("Only Pickup",
                                  style: TextStyle(
                                    fontFamily: 'MuseoSans',
                                    color: AppConst.grey,
                                    fontSize:
                                        SizeUtils.horizontalBlockSize * 3.7,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                  )),
                        ],
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
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
    );
  }
}
