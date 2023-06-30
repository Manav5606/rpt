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

class _SearchListState extends State<SearchList> with SingleTickerProviderStateMixin {
  final ExploreController _exploreController = Get.find();

  final MoreStoreController _moreStoreController = Get.find();

  late TabController _tabController;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    setState(() {
      _selectedTabIndex = _tabController.index;
    });
  }

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
            ? Container(
                height: 70.h,
                // color: AppConst.yellow,
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 170,
                        height: 50,
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            tabBarTheme: TabBarTheme(
                              indicator: UnderlineTabIndicator(
                                borderSide:
                                    BorderSide(color: Colors.green, width: 2.0),
                              ),
                            ),
                          ),
                          child: TabBar(
                             controller: _tabController,
                            labelPadding: EdgeInsets.symmetric(horizontal: 0.0),
                            indicatorSize: TabBarIndicatorSize.label,
                        
                            tabs: [
                              
                              Text('Stores ${data?.stores?.length ?? 0}',
                                  style: TextStyle(
                                    fontFamily: 'MuseoSans',
                                    color: _selectedTabIndex == 0 ? AppConst.green : AppConst.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                  )),
                              Text('Products  ${totalProducts}',
                                  style: TextStyle(
                                    fontFamily: 'MuseoSans',
                                    color: _selectedTabIndex == 1 ? AppConst.green : AppConst.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                  )),
                             
                            ],
                          ),
                        ),
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
                                    SizedBox(
                                      height: 500,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Padding(
                                padding: EdgeInsets.only(left: 2.w, top: 1.h),
                                child: Column(
                                  // controller: this.widget.controller,
                                  // scrollDirection: Axis.vertical,
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
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                controller:
                                                    this.widget.controller,
                                                shrinkWrap: true,
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
                                    SizedBox(
                                      height: 300,
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
              )
            : Container(
                height: 70.h,
                // color: AppConst.yellow,
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 170,
                        height: 50,
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            tabBarTheme: TabBarTheme(
                              indicator: UnderlineTabIndicator(
                                borderSide:
                                    BorderSide(color: Colors.green, width: 2.0),
                              ),
                            ),
                          ),
                          child: TabBar(
                            controller: _tabController,
                            labelPadding: EdgeInsets.symmetric(horizontal: 0.0),
                            indicatorSize: TabBarIndicatorSize.label,
                            tabs: [
                              
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                    Text('Stores ${data?.stores?.length ?? 0}',
                                        style: TextStyle(
                                          fontFamily: 'MuseoSans',
                                          color: _selectedTabIndex==0 ? AppConst.green : AppConst.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.normal,
                                        )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Products ${totalProducts}',
                                    style: TextStyle(
                                      fontFamily: 'MuseoSans',
                                      color: _selectedTabIndex==1 ? AppConst.green : AppConst.black,
                                      fontSize: 12,
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
                        ),
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
                                    SizedBox(
                                      height: 500,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Padding(
                                padding: EdgeInsets.only(left: 2.w, top: 1.h),
                                child: Column(
                                  // controller: this.widget.controller,
                                  // scrollDirection: Axis.vertical,
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
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                controller:
                                                    this.widget.controller,
                                                shrinkWrap: true,
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
                                    SizedBox(
                                      height: 300,
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (product.store?.name != null &&
                  product.store?.name != "" &&
                  (product.store?.name!.length ?? 0) > 17)
              ? Padding(
                  padding: EdgeInsets.only(left: 1.w),
                  child: DisplayStoreNameOrHotProduct(
                    name: product.store!.name ?? "",
                    subStringLength: 40,
                  ),
                )
              : SizedBox(),
          SizedBox(
            height: 1.h,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  (product.store?.name != null &&
                          product.store?.name != "" &&
                          (product.store?.name!.length ?? 0) < 18)
                      ? DisplayStoreNameOrHotProduct(
                          name: product.store!.name ?? "",
                          subStringLength: 18,
                        )
                      : SizedBox(),
                  SizedBox(
                    height: 1.h,
                  ),
                  Container(
                    height: 10.h,
                    width: 30.w,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8)),
                    child: (product.logo == null || product.logo == "")
                        ? Image.asset("assets/images/noproducts.png")
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              product.logo
                                  // chatOrderController.cartIndex.value?.rawItems?[index].logo
                                  ??
                                  '',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return SizedBox(
                                    height: 10.h,
                                    width: 30.w,
                                    child: Image.asset(
                                        "assets/images/noproducts.png"));
                              },
                            ),
                          ),
                  ),
                ],
              ),
              SizedBox(
                width: 3.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // (product.store?.name != null && product.store?.name != "")
                  //     ? DisplayStoreNameOrHotProduct(
                  //         name: product.store!.name ?? "")
                  //     : SizedBox(),
                  // SizedBox(
                  //   height: 0.4.h,
                  // ),
                  Container(
                    width: 60.w,
                    // height: 4.5.h,
                    // color: AppConst.yellow,
                    child: Text(
                        "${product.name ?? ''} - ${product.unit ?? "1 unit"}",
                        maxLines: 2,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'MuseoSans',
                          color: Colors.black87,
                          fontSize: (SizerUtil.deviceType == DeviceType.tablet)
                              ? 8.sp
                              : 9.5.sp,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                        )),
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  Container(
                    width: 60.w,
                    child: Row(
                      children: [
                        Text(
                            "\u{20b9}${product.selling_price?.toStringAsFixed(2) ?? 00}  ",
                            style: TextStyle(
                              fontFamily: 'MuseoSans',
                              color: Colors.black,
                              fontSize:
                                  (SizerUtil.deviceType == DeviceType.tablet)
                                      ? 10.sp
                                      : 11.5.sp,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                            )),
                        Text(
                            "\u{20b9}${product.mrp?.toStringAsFixed(2) ?? 00} ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'MuseoSans',
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                              fontSize:
                                  (SizerUtil.deviceType == DeviceType.tablet)
                                      ? 7.5.sp
                                      : 9.5.sp,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                            )),
                        SizedBox(
                          width: 1.w,
                        ),
                        (product.cashback != null &&
                                (product.cashback ?? 0) > 0)
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Color(0xffe6faf1),
                                ),
                                child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                          text:
                                              "\u{20b9}${product.cashback ?? 00} ",
                                          style: TextStyle(
                                            fontFamily: 'MuseoSans',
                                            color: Colors.green.shade600,
                                            fontSize: (SizerUtil.deviceType ==
                                                    DeviceType.tablet)
                                                ? 8.sp
                                                : 9.5.sp,
                                            fontWeight: FontWeight.w600,
                                            fontStyle: FontStyle.normal,
                                          )),
                                      TextSpan(
                                          text: "OFF",
                                          style: TextStyle(
                                            fontFamily: 'MuseoSans',
                                            color: Colors.green.shade700,
                                            fontSize: (SizerUtil.deviceType ==
                                                    DeviceType.tablet)
                                                ? 8.sp
                                                : 9.5.sp,
                                            fontWeight: FontWeight.w600,
                                            fontStyle: FontStyle.normal,
                                          ))
                                    ]))),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                  // (product.cashback == null || product.cashback == "")
                  //     ? SizedBox()
                  //     : Text("Cashback \u20b9${product.cashback.toString()}",
                  //         style: TextStyle(
                  //           fontFamily: 'MuseoSans',
                  //           color: AppConst.black,
                  //           fontSize: SizeUtils.horizontalBlockSize * 3.5,
                  //           fontWeight: FontWeight.w700,
                  //           fontStyle: FontStyle.normal,
                  //         )),
                  // SizedBox(
                  //   height: 0.5.h,
                  // ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Container(
                    width: 60.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [
                        //     Container(
                        //       padding: const EdgeInsets.all(4.0),
                        //       height: 2.5.h,
                        //       decoration: BoxDecoration(
                        //           shape: BoxShape.circle,
                        //           color: AppConst.lightGrey,
                        //           border: Border.all(
                        //             width: 0.1,
                        //             color: AppConst.lightGrey,
                        //           )),
                        //       child: Image(
                        //         image: AssetImage(
                        //           'assets/images/Store.png',
                        //         ),
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       width: 1.w,
                        //     ),
                        // Container(
                        //   width: 52.w,
                        //   child: Text(product.store?.name ?? "",
                        //       maxLines: 1,
                        //       overflow: TextOverflow.ellipsis,
                        //       style: TextStyle(
                        //         fontFamily: 'MuseoSans',
                        //         color: AppConst.black,
                        //         fontSize:
                        //             SizeUtils.horizontalBlockSize * 3.5,
                        //         fontWeight: FontWeight.w700,
                        //         fontStyle: FontStyle.normal,
                        //       )),
                        // ),
                        //   ],
                        // ),
                        // SizedBox(
                        //   width: 1.w,
                        // ),
                        InkWell(
                          onTap: (() async {
                            _moreStoreController.storeId.value =
                                product.store?.sId ?? '';

                            await _moreStoreController.getStoreData(
                              id: product.store?.sId ?? '',
                            );
                          }),
                          child: Container(
                            // width: 17.w,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: AppConst.grey, width: 0.5),
                              borderRadius: BorderRadius.circular(18),
                              // color: Color(0xffe6faf1),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 3.w, vertical: 0.5.h),
                              child: Text(
                                " Add +",
                                style: TextStyle(
                                  fontFamily: 'MuseoSans',
                                  color: AppConst.darkGreen,
                                  fontSize: (SizerUtil.deviceType ==
                                          DeviceType.tablet)
                                      ? 9.sp
                                      : 11.5.sp,
                                  fontWeight: FontWeight.w700,
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
          Padding(
            padding:
                EdgeInsets.only(left: 2.w, right: 2.w, top: 2.h, bottom: 0.5.h),
            child: Container(
              height: 1,
              width: double.infinity,
              color: AppConst.lightGrey,
            ),
          )
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

class DisplayStoreNameOrHotProduct extends StatelessWidget {
  DisplayStoreNameOrHotProduct(
      {Key? key, required this.name, this.subStringLength = 12})
      : super(key: key);

  final String name;
  int subStringLength;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(
              0xfffef0d3), // Color(0xffFED3D3), //AppConst.lightSkyBlue, //Color(0xfffce6e7),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(100),
              topRight: Radius.circular(8))),
      child: Padding(
        padding: EdgeInsets.only(left: 1.w, top: 4, bottom: 4, right: 4.w),
        child: Text(
            ((name.length) > subStringLength)
                ? (name.substring(0, subStringLength - 1) + ".")
                : (name + "."),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'MuseoSans',
              color: Color(
                  0xff442e00), //   Color(0xff450000), //AppConst.darkBlue, //Color(0xffE96971),
              fontSize:
                  (SizerUtil.deviceType == DeviceType.tablet) ? 8.sp : 9.sp,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
            )),
      ),
    );
  }
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
      child: Padding(
        padding: EdgeInsets.only(left: 2.w, top: 1.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DispalyStoreLogo(
              logo: Stores?.logo,
              bottomPadding: 0,
              height: 10,
              logoPadding: 6,
            ),
            SizedBox(
              width: 2.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DisplayStoreName(name: Stores?.name),
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
                      padding: EdgeInsets.only(left: 1.w, right: 2.w, top: 0.h),
                      child: Icon(
                        Icons.circle,
                        color: AppConst.lightGrey,
                        size: 0.7.h,
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
                              color: AppConst.greySecondaryText,
                              fontSize:
                                  (SizerUtil.deviceType == DeviceType.tablet)
                                      ? 8.sp
                                      : 9.sp,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                            )),
                  ],
                ),
                SizedBox(
                  height: 0.5.h,
                ),
                Row(
                  children: [
                    ((Stores?.premium ?? false) == true)
                        ? DisplayPreminumStore()
                        : SizedBox(),
                    DisplayCashback(
                      cashback: Stores?.defaultCashback,
                      iscashbackPercentage: true,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
