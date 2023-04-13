import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:customer_app/app/controller/add_location_controller.dart';
import 'package:customer_app/app/ui/pages/chat/freshchat_controller.dart';
import 'package:customer_app/app/ui/pages/signIn/signup_screen.dart';
import 'package:customer_app/screens/addcart/Widgets/store_name_call_logo.dart';
import 'package:customer_app/screens/addcart/active_order_tracking_screen.dart';
import 'package:customer_app/screens/more_stores/morestore_controller.dart';
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
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:upgrader/upgrader.dart';

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
  late ScrollController _recentCartController;

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
  final MoreStoreController _moreStoreController =
      Get.put(MoreStoreController());

  final AddLocationController _addLocationController = Get.find();

  @override
  void initState() {
    super.initState();
    percent = .50;
    _scrollController = ScrollController();
    _categoryController = ScrollController();
    _recentController = ScrollController();
    _recentCartController = ScrollController();
    _hideFabAnimController = AnimationController(
      vsync: this,
      duration: kThemeAnimationDuration,
      value: 1,
    );

    _addLocationController.checkPermission.listen((p0) async {
      // bool isEnable = await _homeController.getCurrentLocation();
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
    Get.find<HomeController>()..getAllCartsData();

    _categoryController.addListener(_scrollListener);
    _recentController.addListener(_recentScrollListener);
    _recentCartController.addListener(_recentCartScrollListener);

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

  _recentCartScrollListener() {
    setState(() {
      if (_recentCartController.position.pixels > 200) {
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
    _recentCartController.dispose();
    FireBaseNotification().localNotificationDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String UserSlecetedAddress =
        ("${_addLocationController.userAddressTitle.value}") +
            ((_addLocationController.userAddressTitle.value != "") ? "," : "") +
            (" ${_addLocationController.userHouse.value}") +
            ((_addLocationController.userHouse.value != "") ? "," : "") +
            (" ${_addLocationController.userAppartment.value}") +
            ((_addLocationController.userAppartment.value != "") ? "," : "") +
            (" ${_addLocationController.userAddress.value}");
    SizeUtils().init(context);
    Data tempModel = Data.fromJson(
        jsonDecode(FirebaseRemoteConfigUtils.homeScreenTempString));
    // _homeController.checkLocationPermission();

    RxInt recentCount = ((_myAccountController.activeOrderCount.value) +
            (_homeController.cartsCount.value))
        .obs;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: AppConst.darkGreen,
          statusBarIconBrightness: Brightness.light),
      child: Scaffold(
        body: UpgradeAlert(
          upgrader: Upgrader(
              durationUntilAlertAgain: Duration(days: 1),
              canDismissDialog: true,
              showIgnore: false,
              platform:
                  Platform.isIOS ? TargetPlatform.iOS : TargetPlatform.android,
              // shouldPopScope: () => true,
              dialogStyle: Platform.isIOS
                  ? UpgradeDialogStyle.cupertino
                  : UpgradeDialogStyle.material,
              minAppVersion: "1.0.7",
              countryCode: "IN"),
          child: SafeArea(
            child: Obx(
              () => Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  if (_homeController.isLoading.value)
                    HomeScreenShimmer()
                  else
                    Flex(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      direction: Axis.vertical,
                      children: [
                        Obx(
                          () => HomeAppBar(
                            onTap: () async {
                              dynamic value = Get.to(AddressModel(
                                isHomeScreen: true,
                                page: "home",
                              ));
                              // if (Constants.isAbleToCallApi)
                              //   await _homeController.getAllCartsData();
                            },
                            isRedDot: _homeController.getAllCartsModel.value
                                        ?.cartItemsTotal !=
                                    0
                                ? true
                                : false,
                            address: UserSlecetedAddress,
                            // "${_addLocationController.userAddressTitle.value}, ${_addLocationController.userHouse.value}, ${_addLocationController.userAppartment.value}, ${_addLocationController.userAddress.value}",
                            balance: _addLocationController.convertor(
                                _myAccountController.user.balance ?? 0),
                            onTapWallet: () {
                              Get.toNamed(AppRoutes.Wallet,
                                  arguments: {"navWithOutTranscation": true});
                            },
                            isHomeScreen: true,
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        // _homeController.checkPermission.value
                        //     ? SizedBox()
                        //     : PermissionRaw(
                        //         onTap: () async {
                        //           bool isEnable =
                        //               await _homeController.getCurrentLocation();
                        //           if (isEnable) {
                        //             _homeController.isPageAvailable = true;
                        //             _homeController.homePageFavoriteShopsList
                        //                 .clear();
                        //             await _homeController.apiCall();
                        //           }
                        //         },
                        //       ),
                        Obx(
                          () => Flexible(
                            child: ListView(
                              controller: _homeController
                                  .homePageFavoriteShopsScrollController,
                              children: [
                                ((_myAccountController.activeOrdersModel.value
                                                    ?.data?.length ??
                                                1) >
                                            0 ||
                                        ((_homeController.getAllCartsModel.value
                                                    ?.carts?.length) ??
                                                0) >
                                            0)
                                    ? Container(
                                        height: 18.h,
                                        width: double.infinity,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              ListView.builder(
                                                controller: _categoryController,
                                                itemCount: _homeController
                                                    .category.length,
                                                //  _homeController
                                                //         .getHomePageFavoriteShopsModel
                                                //         .value
                                                //         ?.keywords
                                                //         ?.length ??
                                                physics: PageScrollPhysics(),
                                                scrollDirection:
                                                    Axis.horizontal,
                                                shrinkWrap: true,
                                                itemExtent: SizeUtils
                                                        .horizontalBlockSize *
                                                    30,
                                                itemBuilder: (context, index) {
                                                  //currentItems = index;
                                                  return GestureDetector(
                                                      onTap: () async {
                                                        _homeController
                                                            .storeDataList
                                                            .clear();
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
                                                        _homeController
                                                                .keywordValue =
                                                            CategoryModel(
                                                          isProductAvailable:
                                                              _homeController
                                                                  .category[
                                                                      index]
                                                                  .isProductAvailable,
                                                          id: _homeController
                                                              .category[index]
                                                              .id,
                                                          keywordHelper:
                                                              _homeController
                                                                  .category[
                                                                      index]
                                                                  .keywordHelper,
                                                          name: _homeController
                                                              .category[index]
                                                              .name,
                                                          subtitle:
                                                              _homeController
                                                                  .category[
                                                                      index]
                                                                  .subtitle,
                                                          image: _homeController
                                                              .category[index]
                                                              .image,
                                                          title: _homeController
                                                              .category[index]
                                                              .title,
                                                        );
                                                        _homeController
                                                            .isRemoteConfigPageLoading1
                                                            .value = true;
                                                        if (!(_homeController
                                                            .category[index]
                                                            .isProductAvailable)) {
                                                          Get.to(() => InStoreScreen(
                                                              category:
                                                                  _homeController
                                                                          .category[
                                                                      index]));
                                                        } else {
                                                          Get.to(() => StoreListScreen(
                                                              category:
                                                                  _homeController
                                                                          .category[
                                                                      index]));
                                                        }

                                                        await _homeController
                                                            .homePageRemoteConfigData(
                                                          productFetch:
                                                              _homeController
                                                                  .category[
                                                                      index]
                                                                  .isProductAvailable,
                                                          keyword:
                                                              _homeController
                                                                  .category[
                                                                      index]
                                                                  .name,
                                                          keywordHelper:
                                                              _homeController
                                                                  .category[
                                                                      index]
                                                                  .keywordHelper,
                                                          id: _homeController
                                                              .category[index]
                                                              .id,
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
                                                        if (Constants
                                                            .isAbleToCallApi)
                                                          await _homeController
                                                              .getAllCartsData();
                                                      },
                                                      child: CategoryCard(
                                                          index: index,
                                                          category:
                                                              _homeController
                                                                      .category[
                                                                  index]));
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : GridView(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        physics: NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                crossAxisSpacing: 2.w,
                                                mainAxisSpacing: 2.h),
                                        children: List.generate(
                                            (_homeController.category.length),
                                            (index) {
                                          return GestureDetector(
                                              onTap: () async {
                                                _homeController.storeDataList
                                                    .clear();
                                                _homeController
                                                    .remoteConfigPageNumber = 1;
                                                _homeController
                                                        .isRemoteConfigPageAvailable =
                                                    true;

                                                _homeController.keywordValue =
                                                    CategoryModel(
                                                  isProductAvailable:
                                                      _homeController
                                                          .category[index]
                                                          .isProductAvailable,
                                                  id: _homeController
                                                      .category[index].id,
                                                  keywordHelper: _homeController
                                                      .category[index]
                                                      .keywordHelper,
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
                                                      .category[index]
                                                      .keywordHelper,
                                                  id: _homeController
                                                      .category[index].id,
                                                );
                                                (!(_homeController
                                                        .category[index]
                                                        .isProductAvailable))
                                                    ? await Get.to(() =>
                                                        InStoreScreen(
                                                            category:
                                                                _homeController
                                                                        .category[
                                                                    index]))
                                                    : await Get.to(() =>
                                                        StoreListScreen(
                                                            category:
                                                                _homeController
                                                                        .category[
                                                                    index]));

                                                if (Constants.isAbleToCallApi)
                                                  await _homeController
                                                      .getAllCartsData();
                                              },
                                              child: CategoryCard(
                                                  index: index,
                                                  category: _homeController
                                                      .category[index]));
                                        }),
                                      ),
                                // SizedBox(
                                //   height: 2.h,
                                // ),
                                // (_homeController.getAllCartsModel.value?.carts
                                //             ?.isNotEmpty ??
                                //         false)
                                //     ? _homeController.isAllCartLoading.value
                                //         ? ShimmerEffect(
                                //             child: YourStores(),
                                //           )
                                //         : YourStores()
                                //     : SizedBox(),
                                SizedBox(
                                  height: 1.h,
                                ),
                                ((_myAccountController.activeOrdersModel.value
                                                    ?.data?.length ??
                                                0) >
                                            0) ||
                                        ((_homeController.getAllCartsModel.value
                                                    ?.carts?.length) ??
                                                0) >
                                            0
                                    ? Container(
                                        height: 18.h,
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
                                                  // Text("Recent Transactions",
                                                  //     style: TextStyle(
                                                  //       fontFamily: 'MuseoSans',
                                                  //       color: AppConst.black,
                                                  //       fontSize: SizeUtils
                                                  //               .horizontalBlockSize *
                                                  //           4.5,
                                                  //       fontWeight:
                                                  //           FontWeight.w700,
                                                  //       fontStyle:
                                                  //           FontStyle.normal,
                                                  //     )),
                                                  // InkWell(
                                                  //   onTap: (() {
                                                  //     Get.toNamed(
                                                  //         AppRoutes.ActiveOrders);
                                                  //   }),
                                                  //   child: Padding(
                                                  //     padding: EdgeInsets.only(
                                                  //         bottom: 0.5.h),
                                                  //     child: Row(
                                                  //       mainAxisAlignment:
                                                  //           MainAxisAlignment.end,
                                                  //       children: [
                                                  //         Text(
                                                  //           "View All",
                                                  //           style: TextStyle(
                                                  //             color:
                                                  //                 AppConst.black,
                                                  //             fontSize: SizeUtils
                                                  //                     .horizontalBlockSize *
                                                  //                 3.4,
                                                  //             fontWeight:
                                                  //                 FontWeight.bold,
                                                  //           ),
                                                  //         ),
                                                  //         Icon(
                                                  //           Icons
                                                  //               .arrow_forward_ios_rounded,
                                                  //           color: AppConst.black,
                                                  //           size: 1.8.h,
                                                  //         )
                                                  //       ],
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              Container(
                                                height: 14.h,
                                                // color: AppConst.yellow,
                                                width: double.infinity,
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    children: [
                                                      Obx(() =>
                                                          ((_myAccountController
                                                                      .activeOrderCount
                                                                      .value) >
                                                                  0)
                                                              ? ListView
                                                                  .builder(
                                                                  controller:
                                                                      _recentController,
                                                                  itemCount: ((_myAccountController
                                                                              .activeOrdersModel
                                                                              .value
                                                                              ?.data)
                                                                          ?.length) ??
                                                                      0,
                                                                  physics:
                                                                      NeverScrollableScrollPhysics(),
                                                                  scrollDirection:
                                                                      Axis.horizontal,
                                                                  shrinkWrap:
                                                                      true,
                                                                  itemExtent: (recentCount
                                                                              .value ==
                                                                          1)
                                                                      ? SizeUtils
                                                                              .horizontalBlockSize *
                                                                          95
                                                                      : (recentCount.value ==
                                                                              2)
                                                                          ? SizeUtils.horizontalBlockSize *
                                                                              80
                                                                          : SizeUtils.horizontalBlockSize *
                                                                              30,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    //currentItems = index;
                                                                    return RecentActiveOrders1(
                                                                      recentCount:
                                                                          recentCount,
                                                                      myAccountController:
                                                                          _myAccountController,
                                                                      itemIndex: (_myAccountController.activeOrdersModel.value?.data!.length ??
                                                                              0) -
                                                                          1 -
                                                                          index,
                                                                    );
                                                                    // : RecentActiveOrders(
                                                                    //     myAccountController:
                                                                    //         _myAccountController,
                                                                    //     itemIndex: (_myAccountController
                                                                    //             .activeOrdersModel
                                                                    //             .value
                                                                    //             ?.data!
                                                                    //             .length)! -
                                                                    //         1 -
                                                                    //         index,
                                                                    //   );
                                                                  },
                                                                )
                                                              : SizedBox()),
                                                      Obx(() => ((_homeController
                                                                  .cartsCount
                                                                  .value) >
                                                              0)
                                                          ? ListView.builder(
                                                              controller:
                                                                  _recentCartController,
                                                              itemCount:
                                                                  // 1,
                                                                  ((_homeController
                                                                          .getAllCartsModel
                                                                          .value
                                                                          ?.carts
                                                                          ?.length) ??
                                                                      0),
                                                              physics:
                                                                  PageScrollPhysics(),
                                                              scrollDirection:
                                                                  Axis.horizontal,
                                                              shrinkWrap: true,
                                                              itemExtent: (recentCount
                                                                          .value ==
                                                                      1)
                                                                  ? SizeUtils
                                                                          .horizontalBlockSize *
                                                                      95
                                                                  : (recentCount
                                                                              .value ==
                                                                          2)
                                                                      ? SizeUtils
                                                                              .horizontalBlockSize *
                                                                          80
                                                                      : SizeUtils
                                                                              .horizontalBlockSize *
                                                                          30,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                // currentItems = index;
                                                                return RecentCarts12(
                                                                  recentCount:
                                                                      recentCount
                                                                          .value,
                                                                  moreStoreController:
                                                                      _moreStoreController,
                                                                  homeController:
                                                                      _homeController,
                                                                  itemIndex: (_homeController
                                                                          .getAllCartsModel
                                                                          .value
                                                                          ?.carts
                                                                          ?.length)! -
                                                                      1 -
                                                                      index,
                                                                );
                                                                // : RecentCarts(
                                                                //     moreStoreController:
                                                                //         _moreStoreController,
                                                                //     homeController:
                                                                //         _homeController,
                                                                //     itemIndex: (_homeController
                                                                //             .getAllCartsModel
                                                                //             .value
                                                                //             ?.carts
                                                                //             ?.length)! -
                                                                //         1 -
                                                                //         index,
                                                                //   );
                                                              },
                                                            )
                                                          : SizedBox()),
                                                      // ((_myAccountController
                                                      //                     .activeOrdersModel
                                                      //                     .value
                                                      //                     ?.data)
                                                      //                 ?.length ??
                                                      //             0) >
                                                      //         0
                                                      //     ? InkWell(
                                                      //         onTap: (() {
                                                      //           Get.toNamed(AppRoutes
                                                      //               .ActiveOrders);
                                                      //         }),
                                                      //         child: Padding(
                                                      //           padding: EdgeInsets
                                                      //               .only(
                                                      //                   bottom:
                                                      //                       2.h,
                                                      //                   left: 4.w,
                                                      //                   right:
                                                      //                       4.w),
                                                      //           child: Row(
                                                      //             mainAxisAlignment:
                                                      //                 MainAxisAlignment
                                                      //                     .end,
                                                      //             children: [
                                                      //               Text(
                                                      //                 "View All",
                                                      //                 style:
                                                      //                     TextStyle(
                                                      //                   color: AppConst
                                                      //                       .green,
                                                      //                   fontSize:
                                                      //                       SizeUtils.horizontalBlockSize *
                                                      //                           3.4,
                                                      //                   fontWeight:
                                                      //                       FontWeight
                                                      //                           .bold,
                                                      //                 ),
                                                      //               ),
                                                      //               Icon(
                                                      //                 Icons
                                                      //                     .arrow_forward_ios_rounded,
                                                      //                 color: AppConst
                                                      //                     .green,
                                                      //                 size: 1.8.h,
                                                      //               )
                                                      //             ],
                                                      //           ),
                                                      //         ),
                                                      //       )
                                                      //     : SizedBox(),
                                                    ],
                                                  ),
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

                                    //  Row(
                                    //     children: [
                                    //       InkWell(
                                    //           onTap: (() {
                                    //             Get.offAllNamed(
                                    //                 AppRoutes
                                    //                     .SelectLocationAddress,
                                    //                 arguments: {
                                    //                   "locationListAvilable": true
                                    //                 });
                                    //           }),
                                    //           child: AllOffers()),
                                    //       Spacer(),
                                    //       InkWell(
                                    //           onTap: (() {
                                    //             Get.offAllNamed(
                                    //                 AppRoutes
                                    //                     .SelectLocationAddress,
                                    //                 arguments: {
                                    //                   "locationListAvilable":
                                    //                       false
                                    //                 });
                                    //           }),
                                    //           child: AllOffers()),
                                    //     ],
                                    //   )
                                    : SizedBox(
                                        // height: 5.h,
                                        ),
                                AllOffersListView(
                                  controller: _scrollController,
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                // Divider(
                                //   thickness: 2.w,
                                //   color: AppConst.veryLightGrey,
                                // ),

                                Container(
                                  color: AppConst.veryLightGrey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 3.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 2.w, vertical: 1.h),
                                            child: Container(
                                                height: 5.5.h,
                                                width: 30.w,
                                                child: FittedBox(
                                                  child: SvgPicture.asset(
                                                    "assets/icons/logoname1.svg",
                                                    fit: BoxFit.fill,
                                                    color: AppConst.grey,
                                                  ),
                                                )),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 2.w, vertical: 1.h),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Can't find your store ?",
                                              style: TextStyle(
                                                fontFamily: 'MuseoSans',
                                                color: AppConst.grey,
                                                fontSize: SizeUtils
                                                        .horizontalBlockSize *
                                                    3.5,
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 0.5.h,
                                            ),
                                            // Text(
                                            //   "currently showing the stores in ${_addLocationController.userAddress.value}. Please change the location to see local store.",
                                            //   maxLines: 2,
                                            //   style: TextStyle(
                                            //     fontFamily: 'MuseoSans',
                                            //     color: AppConst.grey,
                                            //     fontSize:
                                            //         SizeUtils.horizontalBlockSize * 3.5,
                                            //     fontWeight: FontWeight.w500,
                                            //     fontStyle: FontStyle.normal,
                                            //   ),
                                            // ),
                                            // RichText(
                                            //     text: TextSpan(children: [
                                            //   TextSpan(
                                            //     text:
                                            //         "currently showing the stores in ",
                                            //     style: TextStyle(
                                            //       fontFamily: 'MuseoSans',
                                            //       color: AppConst.grey,
                                            //       fontSize:
                                            //           SizeUtils.horizontalBlockSize *
                                            //               3.5,
                                            //       fontWeight: FontWeight.w500,
                                            //       fontStyle: FontStyle.normal,
                                            //     ),
                                            //   ),
                                            //   TextSpan(
                                            //     text:
                                            //         "${_addLocationController.userAddress.value}. ",
                                            //     style: TextStyle(
                                            //       fontFamily: 'MuseoSans',
                                            //       color: AppConst.darkGrey,
                                            //       fontSize:
                                            //           SizeUtils.horizontalBlockSize *
                                            //               3.5,
                                            //       fontWeight: FontWeight.w500,
                                            //       fontStyle: FontStyle.normal,
                                            //     ),
                                            //   ),
                                            //   TextSpan(
                                            //     text:
                                            //         "Please change the location to see local store.",
                                            //     style: TextStyle(
                                            //       fontFamily: 'MuseoSans',
                                            //       color: AppConst.grey,
                                            //       fontSize:
                                            //           SizeUtils.horizontalBlockSize *
                                            //               3.5,
                                            //       fontWeight: FontWeight.w500,
                                            //       fontStyle: FontStyle.normal,
                                            //     ),
                                            //   ),
                                            // ])),
                                            GestureDetector(
                                              onTap: () async {
                                                dynamic value =
                                                    Get.to(AddressModel(
                                                  // isSavedAddress: false,
                                                  isHomeScreen: true,
                                                  page: "home",
                                                ));
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Click here to change the location",
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        fontFamily: 'MuseoSans',
                                                        fontSize: SizeUtils
                                                                .horizontalBlockSize *
                                                            3.5,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        color:
                                                            AppConst.darkGreen,
                                                      ),
                                                    ),
                                                    Icon(
                                                      Icons.location_on_sharp,
                                                      color: AppConst.darkGreen,
                                                      size: 2.h,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 7.h,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                                : Get.toNamed(AppRoutes
                                                    .ScanRecipetSearch);
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
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                      fontFamily: 'MuseoSans',
                                                      color: AppConst.black,
                                                      fontSize: SizeUtils
                                                              .horizontalBlockSize *
                                                          3.8,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontStyle:
                                                          FontStyle.normal,
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
                                                : Get.toNamed(AppRoutes
                                                    .LoyaltyCardScreen);
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
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                      fontFamily: 'MuseoSans',
                                                      color: AppConst.black,
                                                      fontSize: SizeUtils
                                                              .horizontalBlockSize *
                                                          3.8,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontStyle:
                                                          FontStyle.normal,
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
        ),
        // floatingActionButton:
      ),
    );
  }
}

class RecentCarts12 extends StatelessWidget {
  RecentCarts12(
      {Key? key,
      required MoreStoreController moreStoreController,
      required HomeController homeController,
      required this.recentCount,
      required this.itemIndex})
      : _moreStoreController = moreStoreController,
        _homeController = homeController,
        super(key: key);

  final MoreStoreController _moreStoreController;
  final HomeController _homeController;
  int itemIndex;
  int recentCount;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        _moreStoreController.storeId.value = _homeController
                .getAllCartsModel.value?.carts?[itemIndex].store?.sId ??
            '';
        await _moreStoreController.getStoreData(
          id: _homeController
                  .getAllCartsModel.value?.carts?[itemIndex].store?.sId ??
              '',
        );
      },
      child: (recentCount == 1 || recentCount == 2)
          ? Padding(
              padding: EdgeInsets.only(right: 1.w),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 1.w),
                decoration: BoxDecoration(
                  color: AppConst.white,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  boxShadow: [
                    BoxShadow(
                        color: AppConst.lightGrey, //New
                        blurRadius: 2,
                        spreadRadius: 2,
                        offset: Offset(1, 1))
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 5.5.h,
                            child: Image(
                              image: AssetImage(
                                'assets/images/eCART.png',
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: (recentCount == 1)
                                    ? 55.w
                                    : (recentCount == 2)
                                        ? 38.w
                                        : 15.w,
                                // color: AppConst.yellow,
                                child: Text(
                                  "${_homeController.getAllCartsModel.value?.carts?[itemIndex].store?.name ?? ""}",
                                  // "${_myAccountController.activeOrdersModel.value?.data![index].store?.name ?? "Go to Order"}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: 'MuseoSans',
                                    color: AppConst.black,
                                    fontSize:
                                        SizeUtils.horizontalBlockSize * 3.8,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 0.5.h,
                              ),
                              Text(
                                  "${_homeController.getAllCartsModel.value?.carts?[itemIndex].totalItemsCount} items",
                                  style: TextStyle(
                                    fontFamily: 'MuseoSans',
                                    color: Color(0xff0082ab),
                                    fontSize:
                                        SizeUtils.horizontalBlockSize * 3.5,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                  )),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.5.w, vertical: 1.2.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppConst.green,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Cart ",
                                style: TextStyle(
                                  fontFamily: 'MuseoSans',
                                  color: AppConst.white,
                                  fontSize: SizeUtils.horizontalBlockSize * 3.5,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                )),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: SizeUtils.horizontalBlockSize * 3.5,
                              color: AppConst.white,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          : Padding(
              padding: EdgeInsets.only(right: 1.w),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 1.w),
                decoration: BoxDecoration(
                  color: AppConst.white,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  boxShadow: [
                    BoxShadow(
                        color: AppConst.lightGrey, //New
                        blurRadius: 2,
                        spreadRadius: 2,
                        offset: Offset(1, 1))
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        left: 1.w,
                      ),
                      width: 26.w,
                      height: 10.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppConst.white),
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: 0.5.h, top: 1.h, right: 1.w, left: 1.w),
                        child: Column(
                          children: [
                            Container(
                              height: 3.5.h,
                              child: Image(
                                image: AssetImage(
                                  'assets/images/eCART.png',
                                ),
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${_homeController.getAllCartsModel.value?.carts?[itemIndex].store?.name ?? "Go to Order"}",
                              // "${_myAccountController.activeOrdersModel.value?.data![index].store?.name ?? "Go to Order"}",
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
                    Text(
                        "${_homeController.getAllCartsModel.value?.carts?[itemIndex].totalItemsCount} items",
                        style: TextStyle(
                          fontFamily: 'MuseoSans',
                          color: Color(0xff0082ab),
                          fontSize: SizeUtils.horizontalBlockSize * 3.5,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                        )),
                    SizedBox(
                      height: 0.5.h,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class RecentCarts extends StatelessWidget {
  RecentCarts(
      {Key? key,
      required MoreStoreController moreStoreController,
      required HomeController homeController,
      required this.itemIndex})
      : _moreStoreController = moreStoreController,
        _homeController = homeController,
        super(key: key);

  final MoreStoreController _moreStoreController;
  final HomeController _homeController;
  int itemIndex;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        _moreStoreController.storeId.value = _homeController
                .getAllCartsModel.value?.carts?[itemIndex].store?.sId ??
            '';
        await _moreStoreController.getStoreData(
          id: _homeController
                  .getAllCartsModel.value?.carts?[itemIndex].store?.sId ??
              '',
        );
      },
      child: Padding(
        padding: EdgeInsets.only(right: 1.w),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 1.w),
          decoration: BoxDecoration(
            color: AppConst.white,
            borderRadius: BorderRadius.all(Radius.circular(12)),
            boxShadow: [
              BoxShadow(
                  color: AppConst.lightGrey, //New
                  blurRadius: 2,
                  spreadRadius: 2,
                  offset: Offset(1, 1))
            ],
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  left: 1.w,
                ),
                width: 26.w,
                height: 10.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppConst.white),
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: 0.5.h, top: 1.h, right: 1.w, left: 1.w),
                  child: Column(
                    children: [
                      Container(
                        height: 3.5.h,
                        child: Image(
                          image: AssetImage(
                            'assets/images/eCART.png',
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${_homeController.getAllCartsModel.value?.carts?[itemIndex].store?.name ?? "Go to Order"}",
                        // "${_myAccountController.activeOrdersModel.value?.data![index].store?.name ?? "Go to Order"}",
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
              Text(
                  "${_homeController.getAllCartsModel.value?.carts?[itemIndex].totalItemsCount} items",
                  style: TextStyle(
                    fontFamily: 'MuseoSans',
                    color: Color(0xff0082ab),
                    fontSize: SizeUtils.horizontalBlockSize * 3.5,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                  )),
              SizedBox(
                height: 0.5.h,
              ),
            ],
          ),
        ),
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
  final HomeController _homeController = Get.find();

  int itemIndex;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Get.to(
          ActiveOrderTrackingScreen(
            activeOrder: (_myAccountController
                .activeOrdersModel.value?.data![itemIndex]),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
        decoration: BoxDecoration(
          color: AppConst.white,
          // border: Border.all(width: 0.5, color: AppConst.lightGrey),
          borderRadius: BorderRadius.all(Radius.circular(12)),
          boxShadow: [
            BoxShadow(
                color: AppConst.veryLightGrey, //New
                blurRadius: 2,
                spreadRadius: 3,
                offset: Offset(0, 2)),
            // BoxShadow(
            //     color: AppConst.white, //New
            //     blurRadius: 2,
            //     spreadRadius: 3,
            //     offset: Offset(-2, -2)),
            // BoxShadow(
            //     color: AppConst.lightGrey, //New
            //     blurRadius: 2,
            //     spreadRadius: 3,
            //     offset: Offset(2, 0)),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                left: 1.w,
              ),
              width: 26.w,
              // height: 9.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppConst.white),
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: 0.h, top: 0.5.h, right: 1.w, left: 1.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 4.h,
                      width: 8.w,
                      child: Image(
                        image: AssetImage(
                          'assets/images/CART.png',
                        ),
                      ),
                    ),
                    Text(
                      "${_myAccountController.activeOrdersModel.value?.data![itemIndex].store?.name ?? "Go to Order"}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'MuseoSans',
                        color: AppConst.black,
                        fontSize: SizeUtils.horizontalBlockSize * 3,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 0.5.h,
            ),
            (_myAccountController
                            .activeOrdersModel.value?.data![itemIndex].status ==
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
                : (((_myAccountController.activeOrdersModel.value
                                    ?.data![itemIndex].status ==
                                "picked_up") ||
                            (_myAccountController.activeOrdersModel.value
                                    ?.data![itemIndex].status ==
                                "accepted") ||
                            (_myAccountController.activeOrdersModel.value
                                    ?.data![itemIndex].status ==
                                "ready")) &&
                        ((_myAccountController.activeOrdersModel.value
                                    ?.data![itemIndex].final_payable_amount ??
                                0) >
                            0) &&
                        (_myAccountController.activeOrdersModel.value
                                ?.data![itemIndex].orderType !=
                            "receipt")
                    ? Container(
                        width: 12.w,
                        padding: EdgeInsets.symmetric(vertical: 0.5.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: AppConst.green),
                        child: Center(
                          child: Text("Pay",
                              style: TextStyle(
                                fontFamily: 'MuseoSans',
                                color: AppConst.white,
                                fontSize: SizeUtils.horizontalBlockSize * 3,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                              )),
                        ),
                      )
                    : Container(
                        width: 12.w,
                        padding: EdgeInsets.symmetric(vertical: 0.5.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: AppConst.grey),
                        child: Center(
                          child: Text("Paid",
                              style: TextStyle(
                                fontFamily: 'MuseoSans',
                                color: AppConst.white,
                                fontSize: SizeUtils.horizontalBlockSize * 3.2,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                              )),
                        ),
                      )),
          ],
        ),
      ),
    );
  }
}

class RecentActiveOrders1 extends StatelessWidget {
  RecentActiveOrders1(
      {Key? key,
      required MyAccountController myAccountController,
      required this.itemIndex,
      required this.recentCount})
      : _myAccountController = myAccountController,
        super(key: key);

  final MyAccountController _myAccountController;
  final HomeController _homeController = Get.find();

  int itemIndex;
  RxInt recentCount;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          Get.to(
            ActiveOrderTrackingScreen(
              activeOrder: (_myAccountController
                  .activeOrdersModel.value?.data![itemIndex]),
            ),
          );
        },
        child: Obx(
          () => (recentCount.value == 1 || recentCount.value == 2)
              ? Padding(
                  padding: EdgeInsets.only(right: 1.w),
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 1.w),
                    decoration: BoxDecoration(
                      color: AppConst.white,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      boxShadow: [
                        BoxShadow(
                            color: AppConst.lightGrey, //New
                            blurRadius: 2,
                            spreadRadius: 2,
                            offset: Offset(1, 1))
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            Container(
                              height: 5.5.h,
                              child: Image(
                                image: AssetImage(
                                  'assets/images/CART.png',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: (recentCount.value == 1)
                                      ? 55.w
                                      : (recentCount.value == 2)
                                          ? 38.w
                                          : 15.w,
                                  child: Text(
                                      "${_myAccountController.activeOrdersModel.value?.data![itemIndex].store?.name ?? ""} ",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: 'MuseoSans',
                                        color: AppConst.black,
                                        fontSize:
                                            SizeUtils.horizontalBlockSize * 3.8,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                      )),
                                ),
                                SizedBox(
                                  height: 0.5.h,
                                ),
                                Container(
                                  width: (recentCount.value == 1)
                                      ? 55.w
                                      : (recentCount.value == 2)
                                          ? 38.w
                                          : 15.w,
                                  child: Text(
                                      "\u{20b9} ${_myAccountController.activeOrdersModel.value?.data![itemIndex].final_payable_amount ?? ""}",
                                      style: TextStyle(
                                        fontFamily: 'MuseoSans',
                                        color: AppConst.black,
                                        fontSize:
                                            SizeUtils.horizontalBlockSize * 4,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                      )),
                                ),
                                SizedBox(
                                  height: 0.5.h,
                                ),
                                Text(
                                    "${_myAccountController.activeOrdersModel.value?.data![itemIndex].status![0].toUpperCase() ?? ""}${_myAccountController.activeOrdersModel.value?.data![itemIndex].status?.substring(1) ?? ""}",
                                    style: TextStyle(
                                      fontFamily: 'MuseoSans',
                                      color: Color(0xff0082ab),
                                      fontSize:
                                          SizeUtils.horizontalBlockSize * 3.5,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                    )),
                                // Row(
                                //   children: [
                                //     (_myAccountController.activeOrdersModel.value
                                //                     ?.data![itemIndex].status ==
                                //                 "pending" ||
                                //             (_myAccountController.activeOrdersModel.value
                                //                     ?.data![itemIndex].orderType ==
                                //                 "receipt"))
                                //         ? Text(
                                //             "${_myAccountController.activeOrdersModel.value?.data![itemIndex].status![0].toUpperCase() ?? ""}${_myAccountController.activeOrdersModel.value?.data![itemIndex].status?.substring(1) ?? ""}",
                                //             style: TextStyle(
                                //               fontFamily: 'MuseoSans',
                                //               color: Color(0xff0082ab),
                                //               fontSize: SizeUtils.horizontalBlockSize * 3.5,
                                //               fontWeight: FontWeight.w600,
                                //               letterSpacing: 0.4,
                                //               fontStyle: FontStyle.normal,
                                //             ))
                                //         : (((_myAccountController.activeOrdersModel.value
                                //                             ?.data![itemIndex].status ==
                                //                         "picked_up") ||
                                //                     (_myAccountController
                                //                             .activeOrdersModel
                                //                             .value
                                //                             ?.data![itemIndex]
                                //                             .status ==
                                //                         "accepted") ||
                                //                     (_myAccountController
                                //                             .activeOrdersModel
                                //                             .value
                                //                             ?.data![itemIndex]
                                //                             .status ==
                                //                         "ready")) &&
                                //                 ((_myAccountController
                                //                             .activeOrdersModel
                                //                             .value
                                //                             ?.data![itemIndex]
                                //                             .final_payable_amount ??
                                //                         0) >
                                //                     0) &&
                                //                 (_myAccountController
                                //                         .activeOrdersModel
                                //                         .value
                                //                         ?.data![itemIndex]
                                //                         .orderType !=
                                //                     "receipt")
                                // ? Container(
                                //     width: 14.w,
                                //     padding:
                                //         EdgeInsets.symmetric(vertical: 0.5.h),
                                //     decoration: BoxDecoration(
                                //         borderRadius: BorderRadius.circular(4),
                                //         color: AppConst.green),
                                //     child: Center(
                                //       child: Text("Pay",
                                //           style: TextStyle(
                                //             fontFamily: 'MuseoSans',
                                //             color: AppConst.white,
                                //             fontSize:
                                //                 SizeUtils.horizontalBlockSize *
                                //                     3.5,
                                //             fontWeight: FontWeight.w500,
                                //             fontStyle: FontStyle.normal,
                                //           )),
                                //     ),
                                //   )
                                //             : Container(
                                //                 width: 14.w,
                                //                 padding:
                                //                     EdgeInsets.symmetric(vertical: 0.5.h),
                                //                 decoration: BoxDecoration(
                                //                     borderRadius: BorderRadius.circular(4),
                                //                     color: AppConst.grey),
                                //                 child: Center(
                                //                   child: Text("Paid",
                                //                       style: TextStyle(
                                //                         fontFamily: 'MuseoSans',
                                //                         color: AppConst.white,
                                //                         fontSize:
                                //                             SizeUtils.horizontalBlockSize *
                                //                                 3.5,
                                //                         fontWeight: FontWeight.w500,
                                //                         fontStyle: FontStyle.normal,
                                //                       )),
                                //                 ),
                                //               )),
                                //   ],
                                // ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2.5.w, vertical: 1.2.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppConst.green,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("Pay ",
                                      style: TextStyle(
                                        fontFamily: 'MuseoSans',
                                        color: AppConst.white,
                                        fontSize:
                                            SizeUtils.horizontalBlockSize * 3.5,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                      )),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: SizeUtils.horizontalBlockSize * 3.5,
                                    color: AppConst.white,
                                  )
                                ],
                              ),
                            )
                          ]),
                        ],
                      ),
                    ),
                  ),
                )
              : Container(
                  margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
                  decoration: BoxDecoration(
                    color: AppConst.white,
                    // border: Border.all(width: 0.5, color: AppConst.lightGrey),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    boxShadow: [
                      BoxShadow(
                          color: AppConst.veryLightGrey, //New
                          blurRadius: 2,
                          spreadRadius: 3,
                          offset: Offset(0, 2)),
                      // BoxShadow(
                      //     color: AppConst.white, //New
                      //     blurRadius: 2,
                      //     spreadRadius: 3,
                      //     offset: Offset(-2, -2)),
                      // BoxShadow(
                      //     color: AppConst.lightGrey, //New
                      //     blurRadius: 2,
                      //     spreadRadius: 3,
                      //     offset: Offset(2, 0)),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: 1.w,
                        ),
                        width: 26.w,
                        // height: 9.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppConst.white),
                        child: Padding(
                          padding: EdgeInsets.only(
                              bottom: 0.h, top: 0.5.h, right: 1.w, left: 1.w),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 4.h,
                                width: 8.w,
                                child: Image(
                                  image: AssetImage(
                                    'assets/images/CART.png',
                                  ),
                                ),
                              ),
                              Text(
                                "${_myAccountController.activeOrdersModel.value?.data![itemIndex].store?.name ?? "Go to Order"}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: 'MuseoSans',
                                  color: AppConst.black,
                                  fontSize: SizeUtils.horizontalBlockSize * 3,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      (_myAccountController.activeOrdersModel.value
                                      ?.data![itemIndex].status ==
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
                          : (((_myAccountController.activeOrdersModel.value
                                              ?.data![itemIndex].status ==
                                          "picked_up") ||
                                      (_myAccountController.activeOrdersModel
                                              .value?.data![itemIndex].status ==
                                          "accepted") ||
                                      (_myAccountController.activeOrdersModel
                                              .value?.data![itemIndex].status ==
                                          "ready")) &&
                                  ((_myAccountController
                                              .activeOrdersModel
                                              .value
                                              ?.data![itemIndex]
                                              .final_payable_amount ??
                                          0) >
                                      0) &&
                                  (_myAccountController.activeOrdersModel.value
                                          ?.data![itemIndex].orderType !=
                                      "receipt")
                              ? Container(
                                  width: 12.w,
                                  padding:
                                      EdgeInsets.symmetric(vertical: 0.5.h),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: AppConst.green),
                                  child: Center(
                                    child: Text("Pay",
                                        style: TextStyle(
                                          fontFamily: 'MuseoSans',
                                          color: AppConst.white,
                                          fontSize:
                                              SizeUtils.horizontalBlockSize * 3,
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.normal,
                                        )),
                                  ),
                                )
                              : Container(
                                  width: 12.w,
                                  padding:
                                      EdgeInsets.symmetric(vertical: 0.5.h),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: AppConst.grey),
                                  child: Center(
                                    child: Text("Paid",
                                        style: TextStyle(
                                          fontFamily: 'MuseoSans',
                                          color: AppConst.white,
                                          fontSize:
                                              SizeUtils.horizontalBlockSize *
                                                  3.2,
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.normal,
                                        )),
                                  ),
                                )),
                    ],
                  ),
                ),
        ));
  }
}
