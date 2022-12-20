import 'dart:convert';
import 'dart:developer';

import 'package:customer_app/app/ui/pages/chat/freshchat_controller.dart';
import 'package:customer_app/screens/addcart/active_order_tracking_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:customer_app/app/constants/app_constants.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/controller/account_controller.dart';
import 'package:customer_app/app/data/provider/firebase/firebase_notification.dart';
import 'package:customer_app/app/data/repository/hive_repository.dart';
import 'package:customer_app/app/data/repository/my_account_repository.dart';
import 'package:customer_app/app/ui/common/shimmer_widget.dart';
import 'package:customer_app/app/ui/pages/location_picker/address_model.dart';
import 'package:customer_app/app/ui/pages/search/models/GetStoreDataModel.dart';
import 'package:customer_app/app/ui/pages/stores/InStoreScreen.dart';
import 'package:customer_app/app/ui/pages/stores/storedetailscreen.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/constants/string_constants.dart';
import 'package:customer_app/data/models/category_model.dart';
import 'package:customer_app/screens/addcart/controller/addcart_controller.dart';
import 'package:customer_app/screens/home/controller/home_controller.dart';
import 'package:customer_app/screens/home/home_screen_shimmer.dart';
import 'package:customer_app/screens/more_stores/all_offers.dart';
import 'package:customer_app/screens/more_stores/all_offers_listview.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:customer_app/utils/firebase_remote_config.dart';
import 'package:customer_app/widgets/cartWidget.dart';
import 'package:customer_app/widgets/category_card.dart';
import 'package:customer_app/widgets/homescreen_appbar.dart';
import 'package:customer_app/widgets/permission_raw.dart';
import 'package:customer_app/widgets/yourStores.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/userViewModel.dart';
import '../../routes/app_list.dart';
import '../wallet/controller/paymentController.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late ScrollController _categoryController;
  late ScrollController _recentController;

  late AnimationController _hideFabAnimController;

  late double percent;
  int currentItems = 4;
  RxInt temp = 4.obs;
  bool last = false;
  final HomeController _homeController = Get.put(HomeController());
  final PaymentController _paymentController = Get.put(PaymentController());
  final AddCartController _addCartController = Get.put(AddCartController());
  final MyAccountController _myAccountController =
      Get.put(MyAccountController(MyAccountRepository(), HiveRepository()));
  final freshChatController _freshChat = Get.put(freshChatController());
  final UserViewModel userViewModel = Get.put(UserViewModel());

  @override
  void initState() {
    super.initState();
    percent = .50;
    _scrollController = ScrollController();
    _categoryController = ScrollController();
    _recentController = ScrollController();
    _hideFabAnimController = AnimationController(
      vsync: this,
      duration: kThemeAnimationDuration,
      value: 1,
    );

    _homeController.checkPermission.listen((p0) async {
      bool isEnable = await _homeController.getCurrentLocation();
      _homeController.isPageAvailable = true;
      _homeController.homePageFavoriteShopsList.clear();
      await _homeController.apiCall();
    });

    _scrollController.addListener(() {
      switch (_scrollController.position.userScrollDirection) {
        case ScrollDirection.forward:
          _hideFabAnimController.forward();
          break;
        case ScrollDirection.reverse:
          _hideFabAnimController.reverse();
          break;
        case ScrollDirection.idle:
          break;
      }
    });

    Get.find<MyAccountController>()
      ..getActiveOrders()
      ..getUserData();
    Get.find<UserViewModel>();

    _categoryController.addListener(_scrollListener);
    _recentController.addListener(_recentScrollListener);

    // Notification
    FireBaseNotification().localNotificationRequestPermissions();
    FireBaseNotification().configureDidReceiveLocalNotificationSubject();
    FireBaseNotification().configureSelectNotificationSubject();
  }

  _scrollListener() {
    setState(() {
      if (_categoryController.position.pixels > 200) {
        setState(() {
          last = true;
        });
      } else {
        setState(() {
          last = false;
        });
      }
    });
  }

  _recentScrollListener() {
    setState(() {
      if (_recentController.position.pixels > 200) {
        setState(() {
          last = true;
        });
      } else {
        setState(() {
          last = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _hideFabAnimController.dispose();
    _recentController.dispose();
    FireBaseNotification().localNotificationDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
    Data tempModel = Data.fromJson(
        jsonDecode(FirebaseRemoteConfigUtils.homeScreenTempString));
    // _homeController.checkLocationPermission();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: Color(0xff005b41),
          statusBarIconBrightness: Brightness.light),
      child: Scaffold(
        body: SafeArea(
          child: Obx(
            () => Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                if (_homeController.isLoading.value)
                  HomeScreenShimmer()
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => HomeAppBar(
                          onTap: () async {
                            dynamic value = Get.to(AddressModel(
                              isHomeScreen: true,
                            ));
                            // if (Constants.isAbleToCallApi)
                            //   await _homeController.getAllCartsData();
                          },
                          isRedDot: _homeController
                                      .getAllCartsModel.value?.cartItemsTotal !=
                                  0
                              ? true
                              : false,
                          address: _homeController.userAddress.value,
                          balance: (_myAccountController.user.balance ?? 0),
                          onTapWallet: () {
                            Get.toNamed(AppRoutes.Wallet);
                          },
                          isHomeScreen: true,
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      _homeController.checkPermission.value
                          ? SizedBox()
                          : PermissionRaw(
                              onTap: () async {
                                bool isEnable =
                                    await _homeController.getCurrentLocation();
                                if (isEnable) {
                                  _homeController.isPageAvailable = true;
                                  _homeController.homePageFavoriteShopsList
                                      .clear();
                                  await _homeController.apiCall();
                                }
                              },
                            ),
                      Obx(
                        () => Expanded(
                          child: ListView(
                            controller: _homeController
                                .homePageFavoriteShopsScrollController,
                            children: [
                              Container(
                                height: 16.h,
                                width: double.infinity,
                                child: ListView.builder(
                                  controller: _categoryController,
                                  itemCount: _homeController.category.length,
                                  //  _homeController
                                  //         .getHomePageFavoriteShopsModel
                                  //         .value
                                  //         ?.keywords
                                  //         ?.length ??

                                  physics: PageScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemExtent:
                                      SizeUtils.horizontalBlockSize * 30,
                                  itemBuilder: (context, index) {
                                    //currentItems = index;
                                    return GestureDetector(
                                        onTap: () async {
                                          _homeController.storeDataList.clear();
                                          _homeController
                                              .remoteConfigPageNumber = 1;
                                          _homeController
                                                  .isRemoteConfigPageAvailable =
                                              true;
                                          // _homeController.keywordValue =
                                          //     CategoryModel(
                                          //   isProductAvailable: _homeController
                                          //           .getHomePageFavoriteShopsModel
                                          //           .value
                                          //           ?.keywords?[index]
                                          //           .isProductAvailable ??
                                          //       false,
                                          //   id: _homeController
                                          //       .getHomePageFavoriteShopsModel
                                          //       .value!
                                          //       .keywords![index]
                                          //       .id,
                                          //   keywordHelper: _homeController
                                          //       .getHomePageFavoriteShopsModel
                                          //       .value!
                                          //       .keywords![index]
                                          //       .keywordHelper,
                                          //   name: _homeController
                                          //       .getHomePageFavoriteShopsModel
                                          //       .value!
                                          //       .keywords![index]
                                          //       .name,
                                          //   subtitle: '',
                                          //   image: '',
                                          // );
                                          _homeController.keywordValue =
                                              CategoryModel(
                                            isProductAvailable: _homeController
                                                .category[index]
                                                .isProductAvailable,
                                            id: _homeController
                                                .category[index].id,
                                            keywordHelper: _homeController
                                                .category[index].keywordHelper,
                                            name: _homeController
                                                .category[index].name,
                                            subtitle: _homeController
                                                .category[index].subtitle,
                                            image: _homeController
                                                .category[index].image,
                                            title: _homeController
                                                .category[index].title,
                                          );
                                          await _homeController
                                              .homePageRemoteConfigData(
                                            productFetch: _homeController
                                                .category[index]
                                                .isProductAvailable,
                                            keyword: _homeController
                                                .category[index].name,
                                            keywordHelper: _homeController
                                                .category[index].keywordHelper,
                                            id: _homeController
                                                .category[index].id,
                                            // productFetch:
                                            //  _homeController
                                            //         .getHomePageFavoriteShopsModel
                                            //         .value
                                            //         ?.keywords?[index]
                                            //         .isProductAvailable ??
                                            //     false,
                                            // keyword: _homeController
                                            //     .getHomePageFavoriteShopsModel
                                            //     .value!
                                            //     .keywords![index]
                                            //     .name,
                                            // keywordHelper: _homeController
                                            //     .getHomePageFavoriteShopsModel
                                            //     .value!
                                            //     .keywords![index]
                                            //     .keywordHelper,
                                            // id: _homeController
                                            //     .getHomePageFavoriteShopsModel
                                            //     .value!
                                            //     .keywords![index]
                                            //     .id,
                                          );
                                          (!(_homeController.category[index]
                                                  .isProductAvailable))
                                              ? await Get.to(() =>
                                                  InStoreScreen(
                                                      category: _homeController
                                                          .category[index]))
                                              : await Get.to(() =>
                                                  StoreListScreen(
                                                      category: _homeController
                                                          .category[index]));
                                          //      (!(_homeController
                                          //         .getHomePageFavoriteShopsModel
                                          //         .value
                                          //         ?.keywords?[index]
                                          //         .isProductAvailable ??
                                          //     false))
                                          // ? await Get.to(() => InStoreScreen(
                                          //     category: _homeController
                                          //         .getHomePageFavoriteShopsModel
                                          //         .value!
                                          //         .keywords![index]))
                                          // : await Get.to(
                                          //     () => StoreListScreen());
                                          if (Constants.isAbleToCallApi)
                                            await _homeController
                                                .getAllCartsData();
                                        },
                                        child: CategoryCard(
                                            index: index,
                                            category: _homeController
                                                .category[index]));
                                  },
                                ),
                              ),
                              // Container(
                              //   height: 24.h,
                              //   child: GridView(
                              //     gridDelegate:
                              //         SliverGridDelegateWithFixedCrossAxisCount(
                              //             crossAxisCount: 4,
                              //             crossAxisSpacing: 2.w,
                              //             mainAxisSpacing: 1.h),
                              //     children: List.generate(
                              //         (_homeController
                              //                 .getHomePageFavoriteShopsModel
                              //                 .value
                              //                 ?.keywords
                              //                 ?.length ??
                              //             0), (index) {
                              //       return GestureDetector(
                              //           onTap: () async {
                              //             _homeController.storeDataList.clear();
                              //             _homeController
                              //                 .remoteConfigPageNumber = 1;
                              //             _homeController
                              //                     .isRemoteConfigPageAvailable =
                              //                 true;
                              //             _homeController.keywordValue =
                              //                 CategoryModel(
                              //               isProductAvailable: _homeController
                              //                       .getHomePageFavoriteShopsModel
                              //                       .value
                              //                       ?.keywords?[index]
                              //                       .isProductAvailable ??
                              //                   false,
                              //               id: _homeController
                              //                   .getHomePageFavoriteShopsModel
                              //                   .value!
                              //                   .keywords![index]
                              //                   .id,
                              //               keywordHelper: _homeController
                              //                   .getHomePageFavoriteShopsModel
                              //                   .value!
                              //                   .keywords![index]
                              //                   .keywordHelper,
                              //               name: _homeController
                              //                   .getHomePageFavoriteShopsModel
                              //                   .value!
                              //                   .keywords![index]
                              //                   .name,
                              //               subtitle: '',
                              //               image: '',
                              //             );
                              //             await _homeController
                              //                 .homePageRemoteConfigData(
                              //               productFetch: _homeController
                              //                       .getHomePageFavoriteShopsModel
                              //                       .value
                              //                       ?.keywords?[index]
                              //                       .isProductAvailable ??
                              //                   false,
                              //               keyword: _homeController
                              //                   .getHomePageFavoriteShopsModel
                              //                   .value!
                              //                   .keywords![index]
                              //                   .name,
                              //               keywordHelper: _homeController
                              //                   .getHomePageFavoriteShopsModel
                              //                   .value!
                              //                   .keywords![index]
                              //                   .keywordHelper,
                              //               id: _homeController
                              //                   .getHomePageFavoriteShopsModel
                              //                   .value!
                              //                   .keywords![index]
                              //                   .id,
                              //             );
                              //             (!(_homeController
                              //                         .getHomePageFavoriteShopsModel
                              //                         .value
                              //                         ?.keywords?[index]
                              //                         .isProductAvailable ??
                              //                     false))
                              //                 ? await Get.to(
                              //                     () => InStoreScreen())
                              //                 : await Get.to(
                              //                     () => StoreListScreen());
                              //             if (Constants.isAbleToCallApi)
                              //               await _homeController
                              //                   .getAllCartsData();
                              //           },
                              //           child: CategoryCard(
                              //               category: _homeController
                              //                   .getHomePageFavoriteShopsModel
                              //                   .value!
                              //                   .keywords![index]));
                              //     }),
                              //   ),
                              // ),
                              SizedBox(
                                height: 2.h,
                              ),
                              // (_homeController.getAllCartsModel.value?.carts
                              //             ?.isNotEmpty ??
                              //         false)
                              //     ? _homeController.isAllCartLoading.value
                              //         ? ShimmerEffect(
                              //             child: YourStores(),
                              //           )
                              //         : YourStores()
                              //     : SizedBox(),
                              // SizedBox(
                              //   height: 1.h,
                              // ),
                              ((_myAccountController.activeOrdersModel.value
                                              ?.data?.length ??
                                          0) >
                                      0)
                                  ? Container(
                                      height: 21.h,
                                      decoration: BoxDecoration(
                                          color: Color(0xfff2f3f7)),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 2.w, top: 1.h, right: 1.w),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("Recent Transactions",
                                                    style: TextStyle(
                                                      fontFamily: 'MuseoSans',
                                                      color: AppConst.black,
                                                      fontSize: SizeUtils
                                                              .horizontalBlockSize *
                                                          4.7,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                    )),
                                                InkWell(
                                                  onTap: (() {
                                                    Get.toNamed(
                                                        AppRoutes.ActiveOrders);
                                                  }),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 0.5.h),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          "View All",
                                                          style: TextStyle(
                                                            color:
                                                                AppConst.black,
                                                            fontSize: SizeUtils
                                                                    .horizontalBlockSize *
                                                                3.4,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Icon(
                                                          Icons
                                                              .arrow_forward_ios_rounded,
                                                          color: AppConst.black,
                                                          size: 1.8.h,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 1.5.h,
                                            ),
                                            Container(
                                              height: 15.h,
                                              // color: AppConst.yellow,
                                              width: double.infinity,
                                              child: ListView.builder(
                                                controller: _recentController,
                                                itemCount: ((_myAccountController
                                                            .activeOrdersModel
                                                            .value
                                                            ?.data)
                                                        ?.length) ??
                                                    0,
                                                physics: PageScrollPhysics(),
                                                scrollDirection:
                                                    Axis.horizontal,
                                                shrinkWrap: true,
                                                itemExtent: SizeUtils
                                                        .horizontalBlockSize *
                                                    28,
                                                itemBuilder: (context, index) {
                                                  //currentItems = index;
                                                  return RecentActiveOrders(
                                                    myAccountController:
                                                        _myAccountController,
                                                    itemIndex:
                                                        (_myAccountController
                                                                .activeOrdersModel
                                                                .value
                                                                ?.data!
                                                                .length)! -
                                                            1 -
                                                            index,
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : SizedBox(),
                              // Divider(
                              //   thickness: 2.w,
                              //   color: AppConst.veryLightGrey,
                              // ),
                              ((_homeController
                                          .homePageFavoriteShopsList.length) >
                                      0)
                                  ? AllOffers()
                                  : SizedBox(
                                      // height: 5.h,
                                      ),
                              AllOffersListView(
                                controller: _scrollController,
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Divider(
                                thickness: 2.w,
                                color: AppConst.veryLightGrey,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 2.h, horizontal: 2.w),
                                child: Container(
                                  width: double.infinity,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      StringContants.receipto,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 25.sp,
                                        letterSpacing: 1,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 2.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Can't find your store ?",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13.sp,
                                        // letterSpacing: 1,
                                        color: AppConst.black,
                                      ),
                                    ),
                                    Text(
                                      "Currently showing the stores in ${_homeController.userAddress.value}. Please change the location to see local store.",
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize:
                                            SizeUtils.horizontalBlockSize * 3.8,
                                        overflow: TextOverflow.visible,
                                        fontFamily: 'MuseoSans',
                                        // letterSpacing: 0.4,
                                        color: AppConst.grey,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        dynamic value = Get.to(AddressModel(
                                          // isSavedAddress: false,
                                          isHomeScreen: true,
                                        ));
                                      },
                                      child: Text(
                                        "Click here to change the location.",
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize:
                                              SizeUtils.horizontalBlockSize *
                                                  3.8,
                                          overflow: TextOverflow.visible,
                                          fontFamily: 'MuseoSans',
                                          // letterSpacing: 0.4,
                                          color: AppConst.green,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                // _homeController.isLoading.value
                //     ? SizedBox()
                //     : FadeTransition(
                //         opacity: _hideFabAnimController,
                //         child: Column(
                //           mainAxisSize: MainAxisSize.min,
                //           // crossAxisAlignment: CrossAxisAlignment.end,
                //           children: [
                //             Container(
                //               height: 13.h,
                //               decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.only(
                //                   topLeft: Radius.circular(10),
                //                   topRight: Radius.circular(10),
                //                 ),
                //                 // boxShadow: [
                //                 //   BoxShadow(
                //                 //     color: (_myAccountController
                //                 //                 .activeOrdersModel
                //                 //                 .value
                //                 //                 ?.data
                //                 //                 ?.isNotEmpty ??
                //                 //             false)
                //                 //         ? AppConst.grey
                //                 //         : AppConst.transparent,
                //                 //     blurRadius: 5.0,
                //                 //   ),
                //                 // ],
                //                 color: (_myAccountController.activeOrdersModel
                //                             .value?.data?.isNotEmpty ??
                //                         false)
                //                     ? AppConst.transparent
                //                     : AppConst.transparent,
                //               ),
                //               child: Padding(
                //                 padding: EdgeInsets.symmetric(horizontal: 2.w),
                //                 child: Row(
                //                   mainAxisAlignment:
                //                       MainAxisAlignment.spaceBetween,
                //                   children: [
                //                     Obx(
                //                       () => (_myAccountController
                //                                   .activeOrdersModel
                //                                   .value
                //                                   ?.data
                //                                   ?.isNotEmpty ??
                //                               false)
                //                           ? GestureDetector(
                //                               onTap: () {
                //                                 Get.toNamed(
                //                                     AppRoutes.ActiveOrders);
                //                               },
                //                               child: Container(
                //                                 // width: 73.w,
                //                                 // height: 10.h,
                //                                 decoration: BoxDecoration(
                //                                   borderRadius:
                //                                       BorderRadius.only(
                //                                     topLeft:
                //                                         Radius.circular(10),
                //                                     topRight:
                //                                         Radius.circular(10),
                //                                     bottomLeft:
                //                                         Radius.circular(10),
                //                                     bottomRight:
                //                                         Radius.circular(10),
                //                                   ),
                //                                   // boxShadow: [
                //                                   //   BoxShadow(
                //                                   //     color: AppConst.grey,
                //                                   //     blurRadius: 5.0,
                //                                   //   ),
                //                                   // ],
                //                                   color: AppConst.transparent,
                //                                 ),
                //                                 child: Padding(
                //                                   padding: EdgeInsets.only(
                //                                       left: 2.w,
                //                                       top: 1.h,
                //                                       bottom: 1.h),
                //                                   child: Column(
                //                                     crossAxisAlignment:
                //                                         CrossAxisAlignment
                //                                             .start,
                //                                     mainAxisAlignment:
                //                                         MainAxisAlignment
                //                                             .spaceEvenly,
                //                                     children: [
                //                                       Text(
                //                                         "Your Active orders   ",
                //                                         style: TextStyle(
                //                                             fontSize: SizeUtils
                //                                                     .horizontalBlockSize *
                //                                                 5,
                //                                             fontWeight:
                //                                                 FontWeight
                //                                                     .bold),
                //                                       ),
                //                                       Text(
                //                                         "See all your active orders ! ",
                //                                         style: TextStyle(
                //                                             fontSize: SizeUtils
                //                                                     .horizontalBlockSize *
                //                                                 3.5,
                //                                             fontWeight:
                //                                                 FontWeight
                //                                                     .w300),
                //                                       ),
                //                                       SizedBox(
                //                                         height: 0.5.h,
                //                                       ),
                //                                       FittedBox(
                //                                         child: SizedBox(
                //                                           height: 3.5.h,
                //                                           child: ElevatedButton(
                //                                             child: Text(
                //                                               'All active orders',
                //                                               style: TextStyle(
                //                                                   fontSize:
                //                                                       SizeUtils
                //                                                               .horizontalBlockSize *
                //                                                           3.2,
                //                                                   color: AppConst
                //                                                       .black),
                //                                             ),
                //                                             onPressed: () {
                // Get.toNamed(AppRoutes
                //     .ActiveOrders);
                //                                             },
                //                                             style: ElevatedButton.styleFrom(
                //                                                 primary:
                //                                                     AppConst
                //                                                         .orange,
                //                                                 shape: RoundedRectangleBorder(
                //                                                     borderRadius:
                //                                                         BorderRadius.circular(
                //                                                             15))),
                //                                           ),
                //                                         ),
                //                                       ),
                //                                     ],
                //                                   ),
                //                                 ),
                //                                 // Row(
                //                                 //   children: [
                //                                 //     SizedBox(
                //                                 //       width: 2.w,
                //                                 //     ),
                //                                 //     Expanded(
                //                                 //       child: Padding(
                //                                 //         padding:
                //                                 //             EdgeInsets.all(1.h),
                //                                 //         child: Row(
                //                                 //           children: [
                //                                 //             Column(
                //                                 //               crossAxisAlignment:
                //                                 //                   CrossAxisAlignment
                //                                 //                       .start,
                //                                 //               children: [
                //                                 //                 Row(
                //                                 //                   mainAxisAlignment:
                //                                 //                       MainAxisAlignment
                //                                 //                           .spaceBetween,
                //                                 //                   children: [
                //                                 //                     Text(
                //                                 //                       "${_myAccountController.activeOrders.data?.first.store?.name ?? "Storename"} ",
                //                                 //                       style:
                //                                 //                           TextStyle(
                //                                 //                         fontWeight:
                //                                 //                             FontWeight
                //                                 //                                 .w700,
                //                                 //                         color: Colors
                //                                 //                             .black,
                //                                 //                         fontSize:
                //                                 //                             SizeUtils.horizontalBlockSize *
                //                                 //                                 4.5,
                //                                 //                       ),
                //                                 //                     ),
                //                                 //                     // Text(
                //                                 //                     // 'Active Order (${_myAccountController.activeOrders.data?.length ?? 0})',
                //                                 //                     //   style: TextStyle(
                //                                 //                     //     fontWeight:
                //                                 //                     //         FontWeight.w500,
                //                                 //                     //     color: Colors.black,
                //                                 //                     //     fontSize: SizeUtils
                //                                 //                     //             .horizontalBlockSize *
                //                                 //                     //         3.5,
                //                                 //                     //   ),
                //                                 //                     // ),
                //                                 //                   ],
                //                                 //                 ),
                //                                 //                 Text(
                //                                 //                   "Total :- ${_myAccountController.activeOrders.data?.first.total ?? ""} ",
                //                                 //                   style:
                //                                 //                       TextStyle(
                //                                 //                     fontWeight:
                //                                 //                         FontWeight
                //                                 //                             .w400,
                //                                 //                     color: Colors
                //                                 //                         .black,
                //                                 //                     fontSize:
                //                                 //                         SizeUtils
                //                                 //                                 .horizontalBlockSize *
                //                                 //                             4,
                //                                 //                   ),
                //                                 //                 ),
                //                                 //                 RichText(
                //                                 //                   overflow:
                //                                 //                       TextOverflow
                //                                 //                           .ellipsis,
                //                                 //                   text: TextSpan(
                //                                 //                     style: TextStyle(
                //                                 //                         color: AppConst
                //                                 //                             .kIconColor),
                //                                 //                     children: _myAccountController
                //                                 //                         .activeOrders
                //                                 //                         .data
                //                                 //                         ?.first
                //                                 //                         .products
                //                                 //                         ?.map(
                //                                 //                             (e) {
                //                                 //                       return TextSpan(
                //                                 //                           text:
                //                                 //                               "${e.name} (${e.quantity}), ",
                //                                 //                           style:
                //                                 //                               TextStyle(
                //                                 //                             color:
                //                                 //                                 Colors.black,
                //                                 //                           ));
                //                                 //                     }).toList(),
                //                                 //                   ),
                //                                 //                 ),
                //                                 //               ],
                //                                 //             ),
                //                                 //             Spacer(),
                //                                 //             Icon(
                //                                 //               Icons
                //                                 //                   .arrow_forward_ios_rounded,
                //                                 //               size: 4.h,
                //                                 //               color:
                //                                 //                   AppConst.grey,
                //                                 //             ),
                //                                 //             // goToStore(),
                //                                 //             SizedBox(
                //                                 //               width: 2.w,
                //                                 //             ),
                //                                 //           ],
                //                                 //         ),
                //                                 //       ),
                //                                 //     ),
                //                                 //   ],
                //                                 // ),
                //                               ),
                //                             )
                //                           : SizedBox(),
                //                     ),
                //                     FloatingActionButton(
                //                       heroTag: '2',
                //                       elevation: 1,
                //                       backgroundColor: Color(0xffffa300),
                //                       // AppConst.kPrimaryColor,
                //                       onPressed: () {
                //                         Get.defaultDialog(
                //                             title: "Pick any one",
                //                             titleStyle:
                //                                 AppStyles.STORE_NAME_STYLE,
                //                             content: Center(
                //                               child: Row(
                //                                 mainAxisAlignment:
                //                                     MainAxisAlignment
                //                                         .spaceAround,
                //                                 children: [
                //                                   Column(
                //                                     children: [
                //                                       InkWell(
                //                                         onTap: () async {
                //                                           // await _homeController.checkLocationPermission();
                //                                           // if (_homeController.checkPermission.value) {
                //                                           //   Position position = await Geolocator.getCurrentPosition();
                //                                           //   _paymentController.latLng = LatLng(position.latitude, position.longitude);
                //                                           //   await _paymentController.getScanReceiptPageNearMeStoresData();
                //                                           //   Get.back();
                //                                           //   (_paymentController.getRedeemCashInStorePageData.value?.error ?? false)
                //                                           //       ? null
                //                                           //       : Get.toNamed(AppRoutes.ScanRecipetSearch);
                //                                           // } else {
                //                                           _paymentController
                //                                                   .latLng =
                //                                               LatLng(
                //                                                   UserViewModel
                //                                                       .currentLocation
                //                                                       .value
                //                                                       .latitude,
                //                                                   UserViewModel
                //                                                       .currentLocation
                //                                                       .value
                //                                                       .longitude);
                //                                           await _paymentController
                //                                               .getScanReceiptPageNearMeStoresData();
                //                                           Get.back();
                //                                           (_paymentController
                //                                                       .getRedeemCashInStorePageData
                //                                                       .value
                //                                                       ?.error ??
                //                                                   false)
                //                                               ? null
                //                                               : Get.toNamed(
                //                                                   AppRoutes
                //                                                       .ScanRecipetSearch);
                //                                           // }
                //                                         },
                //                                         child: CircleAvatar(
                //                                           radius: 10.w,
                //                                           foregroundImage:
                //                                               NetworkImage(
                //                                                   "https://img.freepik.com/free-vector/tiny-people-using-qr-code-online-payment-isolated-flat-illustration_74855-11136.jpg?t=st=1649328483~exp=1649329083~hmac=5171d5a26cfeb0c063c6afc1f8af8cb4460c207134f830b2ff0d833279d8bf7e&w=1380"),
                //                                         ),
                //                                       ),
                //                                       Text(
                //                                         "Scan",
                //                                         style: AppStyles
                //                                             .BOLD_STYLE,
                //                                       )
                //                                     ],
                //                                   ),
                //                                   Column(
                //                                     children: [
                //                                       InkWell(
                //                                         onTap: () async {
                //                                           _paymentController
                //                                               .isLoading
                //                                               .value = true;
                //                                           // await _homeController.checkLocationPermission();
                //                                           // if (_homeController.checkPermission.value) {
                //                                           //   Position position = await Geolocator.getCurrentPosition();
                //                                           //   _paymentController.latLng = LatLng(position.latitude, position.longitude);
                //                                           //   await _paymentController.getRedeemCashInStorePage();
                //                                           //   Get.back();
                //                                           //   (_paymentController.getRedeemCashInStorePageData.value?.error ?? false)
                //                                           //       ? null
                //                                           //       : Get.toNamed(AppRoutes.LoyaltyCardScreen);
                //                                           // } else {
                //                                           _paymentController
                //                                                   .latLng =
                //                                               LatLng(
                //                                                   UserViewModel
                //                                                       .currentLocation
                //                                                       .value
                //                                                       .latitude,
                //                                                   UserViewModel
                //                                                       .currentLocation
                //                                                       .value
                //                                                       .longitude);
                //                                           await _paymentController
                //                                               .getRedeemCashInStorePage();
                //                                           Get.back();
                //                                           (_paymentController
                //                                                       .getRedeemCashInStorePageData
                //                                                       .value
                //                                                       ?.error ??
                //                                                   false)
                //                                               ? null
                //                                               : Get.toNamed(
                //                                                   AppRoutes
                //                                                       .LoyaltyCardScreen);
                //                                           // }
                //                                         },
                //                                         child: CircleAvatar(
                //                                           radius: 10.w,
                //                                           backgroundColor:
                //                                               Colors.white,
                //                                           foregroundImage:
                //                                               NetworkImage(
                //                                                   "https://img.freepik.com/free-vector/successful-financial-operation-business-accounting-invoice-report-happy-people-with-tax-receipt-duty-paying-money-savings-cash-income-vector-isolated-concept-metaphor-illustration_335657-2188.jpg?t=st=1649328544~exp=1649329144~hmac=635d4a3527c71f715e710f64fa046e8faf59de565b6be17f34a03ef3d5d8fa4d&w=826"),
                //                                         ),
                //                                       ),
                //                                       Text(
                //                                         "Refund",
                //                                         style: AppStyles
                //                                             .BOLD_STYLE,
                //                                       )
                //                                     ],
                //                                   )
                //                                 ],
                //                               ),
                //                             ));
                //                       },
                //                       child: Icon(Icons.camera_alt_outlined),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                Positioned(
                  right: 2.w,
                  bottom: 2.h,
                  child: FloatingActionButton(
                    heroTag: '2',
                    elevation: 1,
                    backgroundColor: Color(0xffffa300),
                    // AppConst.kPrimaryColor,
                    onPressed: () {
                      Get.defaultDialog(
                          titlePadding: EdgeInsets.symmetric(
                              vertical: 1.h, horizontal: 2.w),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 1.h, horizontal: 2.w),
                          title: "Choose any one",
                          titleStyle: TextStyle(
                            fontFamily: 'MuseoSans',
                            color: AppConst.black,
                            fontSize: SizeUtils.horizontalBlockSize * 4,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                          ),
                          content: Container(
                            width: 90.w,
                            height: 18.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    InkWell(
                                        onTap: () async {
                                          // await _homeController.checkLocationPermission();
                                          // if (_homeController.checkPermission.value) {
                                          //   Position position = await Geolocator.getCurrentPosition();
                                          //   _paymentController.latLng = LatLng(position.latitude, position.longitude);
                                          //   await _paymentController.getScanReceiptPageNearMeStoresData();
                                          //   Get.back();
                                          //   (_paymentController.getRedeemCashInStorePageData.value?.error ?? false)
                                          //       ? null
                                          //       : Get.toNamed(AppRoutes.ScanRecipetSearch);
                                          // } else {
                                          _paymentController.latLng = LatLng(
                                              UserViewModel.currentLocation
                                                  .value.latitude,
                                              UserViewModel.currentLocation
                                                  .value.longitude);
                                          await _paymentController
                                              .getScanReceiptPageNearMeStoresData();
                                          Get.back();
                                          (_paymentController
                                                      .getRedeemCashInStorePageData
                                                      .value
                                                      ?.error ??
                                                  false)
                                              ? null
                                              : Get.toNamed(
                                                  AppRoutes.ScanRecipetSearch);
                                          // }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 1.h, horizontal: 2.w),
                                          width: 30.w,
                                          height: 18.h,
                                          decoration: new BoxDecoration(
                                              color: AppConst.veryLightGrey,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              SizedBox(
                                                height: 8.h,
                                                child: Image(
                                                  image: AssetImage(
                                                    'assets/images/Scan.png',
                                                  ),
                                                ),
                                              ),
                                              Text("Scan Receipt",
                                                  style: TextStyle(
                                                    fontFamily: 'MuseoSans',
                                                    color: AppConst.black,
                                                    fontSize: SizeUtils
                                                            .horizontalBlockSize *
                                                        4,
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle: FontStyle.normal,
                                                  ))
                                            ],
                                          ),
                                        )

                                        // CircleAvatar(
                                        //   radius: 10.w,
                                        //   foregroundImage: NetworkImage(
                                        //       "https://img.freepik.com/free-vector/tiny-people-using-qr-code-online-payment-isolated-flat-illustration_74855-11136.jpg?t=st=1649328483~exp=1649329083~hmac=5171d5a26cfeb0c063c6afc1f8af8cb4460c207134f830b2ff0d833279d8bf7e&w=1380"),
                                        // ),
                                        ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    InkWell(
                                        onTap: () async {
                                          _paymentController.isLoading.value =
                                              true;
                                          // await _homeController.checkLocationPermission();
                                          // if (_homeController.checkPermission.value) {
                                          //   Position position = await Geolocator.getCurrentPosition();
                                          //   _paymentController.latLng = LatLng(position.latitude, position.longitude);
                                          //   await _paymentController.getRedeemCashInStorePage();
                                          //   Get.back();
                                          //   (_paymentController.getRedeemCashInStorePageData.value?.error ?? false)
                                          //       ? null
                                          //       : Get.toNamed(AppRoutes.LoyaltyCardScreen);
                                          // } else {
                                          _paymentController.latLng = LatLng(
                                              UserViewModel.currentLocation
                                                  .value.latitude,
                                              UserViewModel.currentLocation
                                                  .value.longitude);
                                          await _paymentController
                                              .getRedeemCashInStorePage();
                                          Get.back();
                                          (_paymentController
                                                      .getRedeemCashInStorePageData
                                                      .value
                                                      ?.error ??
                                                  false)
                                              ? null
                                              : Get.toNamed(
                                                  AppRoutes.LoyaltyCardScreen);
                                          // }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 1.h, horizontal: 2.w),
                                          width: 30.w,
                                          height: 18.h,
                                          decoration: new BoxDecoration(
                                              color: AppConst.veryLightGrey,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              SizedBox(
                                                height: 8.h,
                                                child: Image(
                                                  image: AssetImage(
                                                    'assets/images/Redeem.png',
                                                  ),
                                                ),
                                              ),
                                              Text("Redeem Cash",
                                                  style: TextStyle(
                                                    fontFamily: 'MuseoSans',
                                                    color: AppConst.black,
                                                    fontSize: SizeUtils
                                                            .horizontalBlockSize *
                                                        4,
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle: FontStyle.normal,
                                                  ))
                                            ],
                                          ),
                                        )
                                        // CircleAvatar(
                                        //   radius: 10.w,
                                        //   backgroundColor: Colors.white,
                                        //   foregroundImage: NetworkImage(
                                        //       "https://img.freepik.com/free-vector/successful-financial-operation-business-accounting-invoice-report-happy-people-with-tax-receipt-duty-paying-money-savings-cash-income-vector-isolated-concept-metaphor-illustration_335657-2188.jpg?t=st=1649328544~exp=1649329144~hmac=635d4a3527c71f715e710f64fa046e8faf59de565b6be17f34a03ef3d5d8fa4d&w=826"),
                                        // ),
                                        ),
                                  ],
                                )
                              ],
                            ),
                          ));
                    },
                    child: Icon(
                      CupertinoIcons.camera,
                      size: 3.8.h,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // floatingActionButton:
      ),
    );
  }
}

class RecentActiveOrders extends StatelessWidget {
  RecentActiveOrders(
      {Key? key,
      required MyAccountController myAccountController,
      required this.itemIndex})
      : _myAccountController = myAccountController,
        super(key: key);

  final MyAccountController _myAccountController;
  int itemIndex;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ActiveOrderTrackingScreen(
              activeOrder: (_myAccountController
                  .activeOrdersModel.value?.data![itemIndex]),
            ),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(right: 1.w),
        child: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  left: 1.w,
                ),
                width: 26.w,
                height: 10.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: AppConst.white),
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: 1.h, top: 1.h, right: 1.w, left: 1.w),
                  child: Column(
                    children: [
                      Container(
                        height: 3.5.h,
                        child: Image(
                          image: AssetImage(
                            'assets/images/CART.png',
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${_myAccountController.activeOrdersModel.value?.data![itemIndex].store?.name ?? "Go to Order"}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'MuseoSans',
                          color: AppConst.black,
                          fontSize: SizeUtils.horizontalBlockSize * 3.2,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              (_myAccountController.activeOrdersModel.value?.data![itemIndex]
                              .status ==
                          "pending" ||
                      (_myAccountController.activeOrdersModel.value
                              ?.data![itemIndex].orderType ==
                          "receipt"))
                  ? Text(
                      "${_myAccountController.activeOrdersModel.value?.data![itemIndex].status ?? "Pending"}",
                      style: TextStyle(
                        fontFamily: 'MuseoSans',
                        color: Color(0xff0082ab),
                        fontSize: SizeUtils.horizontalBlockSize * 3.5,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                      ))
                  : Container(
                      width: 12.w,
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: AppConst.green),
                      child: Center(
                        child: Text("Pay",
                            style: TextStyle(
                              fontFamily: 'MuseoSans',
                              color: AppConst.white,
                              fontSize: SizeUtils.horizontalBlockSize * 3.2,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                            )),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
