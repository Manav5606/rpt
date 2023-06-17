import 'dart:developer';

import 'package:bubble/bubble.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:customer_app/app/controller/add_location_controller.dart';
import 'package:customer_app/app/data/provider/hive/hive.dart';
import 'package:customer_app/app/data/provider/hive/hive_constants.dart';
import 'package:customer_app/app/ui/common/shimmer_widget.dart';
import 'package:customer_app/app/ui/pages/my_wallet/wallet_details_screen.dart';
import 'package:customer_app/app/ui/pages/signIn/phone_authentication_screen.dart';
import 'package:customer_app/app/ui/pages/stores/chatOrder/chatOrder.dart';
import 'package:customer_app/screens/history/history_screen.dart';
import 'package:customer_app/widgets/copied/confirm_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:customer_app/app/ui/pages/search/controller/exploreContoller.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/screens/addcart/services/cart_review_screen_shimmer.dart';
import 'package:customer_app/screens/more_stores/morestore_controller.dart';
import 'package:customer_app/widgets/custom_popupmenu.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../app/constants/responsive.dart';
import '../../app/ui/pages/location_picker/address_model.dart';
import '../../theme/styles.dart';
import '../../widgets/cartWidget.dart';
import '../home/models/GetAllCartsModel.dart';
import 'controller/addcart_controller.dart';
import 'models/review_cart_model.dart';

class CartReviewScreen extends StatefulWidget {
  CartReviewScreen({Key? key}) : super(key: key);

  @override
  State<CartReviewScreen> createState() => _CartReviewScreenState();
}

class _CartReviewScreenState extends State<CartReviewScreen> {
  final AddCartController _addCartController = Get.find();
  final ExploreController _exploreController = Get.find();
  final MoreStoreController _moreStoreController = Get.find();
  final AddLocationController _addLocationController = Get.find();
  String logo = '';
  String storeName = '';
  String storeID = "";
  String businessID = "";
  bool addressAdd = false;
  String navBackTo = "";

  // String totalCount = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Map arg = Get.arguments ?? {};
    logo = arg['logo'] ?? '';
    businessID = arg['businessID'] ?? "";
    storeID = arg['id'] ?? "";
    storeName = arg['storeName'] ?? "";
    addressAdd = arg['addressAdd'] ?? false;
    navBackTo = arg['navBackTo'] ?? '';
    _addCartController.totalCount.value = arg['totalCount'].toString();
  }

  Future<bool> handleBackPressed() async {
    SeeyaConfirmDialog(
        title: "Are you sure?",
        subTitle: "You Want to go back.",
        onCancel: () => Get.back(),
        onConfirm: () async {
          // _moreStoreController.storeId.value = storeID;
          // await _moreStoreController.getStoreData(
          //     id: _addCartController.reviewCart.value?.data?.storeDoc?.id ??
          //         storeID,
          //     businessId: businessID);
          //exit the dialog;
          Get.back();
          //exit this screen

          if (navBackTo == "newbasescreen") {
            Get.offAllNamed(AppRoutes.NewBaseScreen);
          } else {
            Get.offAllNamed(AppRoutes.BaseScreen);
            // Get.back();
          }
        }).show(context);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    (addressAdd) ? _addCartController.SelectedAddressForCart() : null;

    return WillPopScope(
      onWillPop: handleBackPressed,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: AppConst.white,
              statusBarIconBrightness: Brightness.dark),
          elevation: 1,
          // automaticallyImplyLeading: false,
          // leading: Padding(
          //   padding: EdgeInsets.only(left: SizeUtils.horizontalBlockSize * 1.8),
          //   child: InkWell(
          //     onTap: () async {
          //       _addCartController.refresh();
          //       Get.back();
          //       // handleBackPressed();
          //       // await _exploreController.getStoreData(id: _addCartController.store.value?.sId ?? '');
          //     },
          //     child: Icon(
          //       Icons.arrow_back,
          //       color: AppConst.black,
          //       size: 3.5.h,
          //     ),
          //   ),
          // ),
          // actions: [
          //   Obx(
          //     () => CartWidget(
          //       onTap: () async {},
          //       count: _addCartController.totalCount.value,
          //     ),
          //   ),
          // ],
          title: Column(
            children: [
              // (logo.isEmpty)
              //     ? Container(
              //         decoration: BoxDecoration(
              //             shape: BoxShape.circle,
              //             border: Border.all(color: AppConst.grey)),
              //         child: ClipOval(
              //           child: ClipRRect(
              //             child: CircleAvatar(
              //               child: Text(storeName.substring(0, 1),
              //                   style: TextStyle(
              //                       fontSize: SizeUtils.horizontalBlockSize * 2)),
              //               backgroundColor: AppConst.kPrimaryColor,
              //               radius: SizeUtils.horizontalBlockSize * 2.5,
              //             ),
              //           ),
              //         ),
              //       )
              //     : CircleAvatar(
              //         backgroundImage: NetworkImage(logo),
              //         backgroundColor: AppConst.white,
              //         radius: SizeUtils.horizontalBlockSize * 2.5,
              //       ),
              Text("Review Cart",
                  style: TextStyle(
                    fontFamily: 'MuseoSans',
                    color: Color(0xff000000),
                    fontSize: SizeUtils.horizontalBlockSize * 4.5,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  )),
              Obx(
                () => _addCartController.isLoading.value
                    ? ShimmerEffect(
                        child: Text(
                            "${_addCartController.reviewCart.value?.data?.storeDoc?.name ?? storeName}",
                            style: TextStyle(
                              fontFamily: 'MuseoSans',
                              color: Color(0xff9e9e9e),
                              fontSize: SizeUtils.horizontalBlockSize * 3.8,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                            )),
                      )
                    : Text(
                        "${_addCartController.reviewCart.value?.data?.storeDoc?.name ?? storeName}",
                        style: TextStyle(
                          fontFamily: 'MuseoSans',
                          color: Color(0xff9e9e9e),
                          fontSize: SizeUtils.horizontalBlockSize * 3.8,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                        )),
              ),
            ],
          ),
        ),
        bottomSheet: Obx(
          () {
            // final box = Boxes.getCommonBox();
            // final currentlat =
            //     _addLocationController.latitude.value;

            // final currentlng =
            //     _addLocationController.longitude.value;
            // // 14 & 7 lat unit digits
            final storetype =
                _addCartController.reviewCart.value?.data?.storeDoc?.store_type;

            // //Select the lat lng from user location
            // final userlocation = _addCartController
            //     .cartLocationModel.value?.addresses;

            // var Latpresent = false;
            // var Lngpresent = false;
            // var deliveryAddLat;
            // var deliveryAddLng;
            // // var DeliveryAddress;
            // if (userlocation != null && (userlocation.length) > 0) {
            //   // var Latpresent = false;
            //   for (var i = 0; i < userlocation.length; i++) {
            //     if (currentlat == userlocation[i].location?.lat) {
            //       Latpresent = true;
            //       deliveryAddLat = userlocation[i].address;
            //       print(Latpresent);
            //       break;
            //     }
            //   }
            //   // var Lngpresent = false;
            //   for (var i = 0; i < userlocation.length; i++) {
            //     if (currentlng == userlocation[i].location?.lng) {
            //       Lngpresent = true;
            //       deliveryAddLng = userlocation[i].address;
            //       print(Lngpresent);
            //       break;
            //     }
            //   }
            // }
            // // if (Lngpresent == true && Latpresent == true) {}
            // if ((deliveryAddLat != null &&
            //         deliveryAddLng != null) &&
            //     (deliveryAddLat == deliveryAddLng)) {
            // _addCartController.selectAddress.value =
            //       deliveryAddLng;
            // }
            var temp = _addCartController.reviewCart.value?.data?.products
                ?.indexWhere((Products element) => element.status == false);
            var tempInventory = _addCartController
                .reviewCart.value?.data?.inventories
                ?.indexWhere((Products element) => element.status == false);
            int totalProductCount = ((_addCartController
                        .reviewCart.value?.data?.products?.length ??
                    0) +
                (_addCartController.reviewCart.value?.data?.rawItems?.length ??
                    0) +
                (_addCartController
                        .reviewCart.value?.data?.inventories?.length ??
                    0));

            return
                // (_addCartController.reviewCart.value?.data
                //             ?.products?.isEmpty  ?? false&& _addCartController.reviewCart.value?.data
                //             ?.products?.isEmpty &&_addCartController.reviewCart.value?.data
                //             ?.products?.isEmpty )
                _addCartController.isLoading.value
                    ? SizedBox()
                    : (totalProductCount == 0)
                        ? SizedBox()
                        : ((temp != -1) || (tempInventory != -1))
                            ? GestureDetector(
                                onTap: () async {
                                  _addCartController
                                      .reviewCart.value?.data?.products
                                      ?.removeWhere(
                                          (element) => element.status == false);
                                  _addCartController
                                      .reviewCart.value?.data?.inventories
                                      ?.removeWhere(
                                          (element) => element.status == false);
                                  _addCartController.reviewCart.refresh();
                                  // total();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppConst.orange,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  height: SizeUtils.verticalBlockSize * 6,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal:
                                          SizeUtils.horizontalBlockSize * 2,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Center(
                                            child: Text(
                                              "Remove Unavailable Items",
                                              style: TextStyle(
                                                color: AppConst.white,
                                                fontSize: SizeUtils
                                                        .horizontalBlockSize *
                                                    4,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                padding: EdgeInsets.only(
                                    left: 2.w,
                                    bottom: 1.h,
                                    right: 2.w,
                                    top: 1.h),
                                height: (
                                        // (_addCartController
                                        //                   .cartLocationModel
                                        //                   .value
                                        //                   ?.addresses
                                        //                   ?.length ??
                                        //               0) >
                                        //           0 ||
                                        _addCartController
                                                .selectAddress.value !=
                                            ""

                                    // ||
                                    // ((_addCartController
                                    //             .cartLocationModel
                                    //             .value
                                    //             ?.storeAddress
                                    //             ?.address ==
                                    //         _addCartController
                                    //             .selectAddress
                                    //             .value) &&
                                    //     (storetype == "online")
                                    // )
                                    )
                                    ? 16.h
                                    : 12.h,
                                decoration: BoxDecoration(
                                  color: AppConst.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppConst.grey,
                                      blurRadius: 8,
                                      offset: Offset(1, 1),
                                    ),
                                  ],
                                ),
                                child: (
                                        // (
                                        // _addCartController
                                        //                   .cartLocationModel
                                        //                   .value
                                        //                   ?.addresses
                                        //                   ?.length ??
                                        //               0) >
                                        //           0 &&
                                        _addCartController
                                                .selectAddress.value !=
                                            ""

                                    // ||

                                    // ((_addCartController
                                    //             .cartLocationModel
                                    //             .value
                                    //             ?.storeAddress
                                    //             ?.address ==
                                    //         _addCartController
                                    //             .selectAddress
                                    //             .value) &&
                                    //     (storetype == "online")
                                    // )
                                    )
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: 1.5.h),
                                              child: Icon(
                                                (storetype == "instore")
                                                    ? Icons.store
                                                    : Icons.home,
                                                size: 3.5.h,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  (storetype == "instore" ||
                                                          (_addCartController
                                                                  .cartLocationModel
                                                                  .value
                                                                  ?.storeAddress
                                                                  ?.address ==
                                                              _addCartController
                                                                  .selectAddress
                                                                  .value))
                                                      ? "Pick up from the store"
                                                      : "Delivered to ",
                                                  style: TextStyle(
                                                      color: AppConst.black,
                                                      fontFamily: 'MuseoSans',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: SizeUtils
                                                              .horizontalBlockSize *
                                                          4),
                                                ),
                                                SizedBox(
                                                  height: 0.5.h,
                                                ),
                                                Container(
                                                  width:
                                                      (storetype == "instore")
                                                          ? 80.w
                                                          : 65.w,
                                                  child: Text(
                                                    (storetype == "instore")
                                                        ? "${_addCartController.cartLocationModel.value?.storeAddress?.address ?? ""}"
                                                        : "${"${_addCartController.selectAddressHouse.value} ${_addCartController.selectAddress.value}"}",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: AppConst.grey,
                                                        fontFamily: 'MuseoSans',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: SizeUtils
                                                                .horizontalBlockSize *
                                                            3.7),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                            (storetype == "instore")
                                                ? SizedBox()
                                                : InkWell(
                                                    onTap: () {
                                                      showModalBottomSheet(
                                                          isScrollControlled:
                                                              true,
                                                          context: context,
                                                          useRootNavigator:
                                                              true,
                                                          builder: (context) {
                                                            return SelectDeliveryAddress();
                                                          });
                                                    },
                                                    child:
                                                        DisplaychangeButton())
                                          ]),
                                          Spacer(),
                                          GestureDetector(
                                            onTap: () async {
                                              Get.toNamed(
                                                AppRoutes.orderCheckOutScreen,
                                                arguments: {
                                                  'storeName':
                                                      _addCartController
                                                              .reviewCart
                                                              .value
                                                              ?.data
                                                              ?.storeDoc
                                                              ?.name ??
                                                          storeName,
                                                  'id': _addCartController
                                                          .reviewCart
                                                          .value
                                                          ?.data
                                                          ?.storeDoc
                                                          ?.id ??
                                                      storeID,
                                                  "navBackTo": navBackTo
                                                },
                                              );
                                              // );

                                              if (_addCartController
                                                      .cartLocationModel
                                                      .value
                                                      ?.storeAddress
                                                      ?.address ==
                                                  _addCartController
                                                      .selectAddress.value) {
                                                _addCartController
                                                    .pickedup.value = true;
                                              }
                                              await _addCartController
                                                  .getOrderConfirmPageData(
                                                      storeId: _addCartController
                                                              .reviewCart
                                                              .value
                                                              ?.data
                                                              ?.storeDoc
                                                              ?.id ??
                                                          storeID,
                                                      pickedup: _addCartController
                                                          .pickedup.value,
                                                      distance: 0,
                                                      products: _addCartController
                                                          .reviewCart
                                                          .value
                                                          ?.data
                                                          ?.products,
                                                      inventories:
                                                          _addCartController
                                                              .reviewCart
                                                              .value
                                                              ?.data
                                                              ?.inventories,
                                                      walletAmount: 0);
                                              _addCartController.formatDate();
                                            },
                                            child: CheckOutButton(),
                                          ),
                                        ],
                                      )
                                    : Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 1.5.h),
                                        child: InkWell(
                                          onTap: (() {
                                            showModalBottomSheet(
                                                isScrollControlled: true,
                                                context: context,
                                                useRootNavigator: true,
                                                builder: (context) {
                                                  return SelectDeliveryAddress();
                                                });
                                          }),
                                          child: CheckOutButton(
                                            text: "Choose Delivery Address",
                                          ),
                                        ),
                                      ),
                              );
          },
        ),
        body: SafeArea(
          child: Obx(() => _addCartController.isLoading.value
              ? CartReviewScreenShimmer()
              : SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 2.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() {
                          int totalProductCount = ((_addCartController
                                      .reviewCart
                                      .value
                                      ?.data
                                      ?.products
                                      ?.length ??
                                  0) +
                              (_addCartController.reviewCart.value?.data
                                      ?.rawItems?.length ??
                                  0) +
                              (_addCartController.reviewCart.value?.data
                                      ?.inventories?.length ??
                                  0));
                          return (totalProductCount != 0)
                              ? Padding(
                                  padding: EdgeInsets.symmetric(vertical: 1.h),
                                  child: Container(
                                    width: double.infinity,
                                    height: 10.h,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(3.w),
                                        color: Color(0xfffe6faf1)),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 3.w, right: 3.w, top: 1.h),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Grow Your Savings",
                                              style: TextStyle(
                                                fontFamily: 'MuseoSans',
                                                color: Color(0xff005b41),
                                                fontSize: SizeUtils
                                                        .horizontalBlockSize *
                                                    5,
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                                letterSpacing: -0.36,
                                              )),
                                          SizedBox(height: 1.h),
                                          // SizedBox(height: 1.h)

                                          Row(
                                            children: [
                                              Icon(Icons.local_offer,
                                                  size: 2.h,
                                                  color: Color(0xffa12aff)),
                                              RichText(
                                                  text: new TextSpan(children: [
                                                new TextSpan(
                                                    text: " Get ",
                                                    style: TextStyle(
                                                      fontFamily: 'MuseoSans',
                                                      color: Color(0xff005b41),
                                                      fontSize: SizeUtils
                                                              .horizontalBlockSize *
                                                          4,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                    )),
                                                new TextSpan(
                                                    text: (_addCartController
                                                                    .reviewCart
                                                                    .value
                                                                    ?.data
                                                                    ?.storeDoc
                                                                    ?.billDiscountOfferStatus ??
                                                                false) ==
                                                            true
                                                        ? "₹${_addCartController.reviewCart.value?.data?.storeDoc?.billDiscountOfferAmount ?? 0} off"
                                                        : "${_addCartController.reviewCart.value?.data?.storeDoc?.actualCashback ?? 0}% CashBack",

                                                    // text: "₹10 Cashback",
                                                    style: TextStyle(
                                                      fontFamily: 'MuseoSans',
                                                      color: Color(0xff005b41),
                                                      fontSize: SizeUtils
                                                              .horizontalBlockSize *
                                                          4,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                    )),
                                                new TextSpan(
                                                    text: (_addCartController
                                                                    .reviewCart
                                                                    .value
                                                                    ?.data
                                                                    ?.storeDoc
                                                                    ?.billDiscountOfferStatus ??
                                                                false) ==
                                                            true
                                                        ? " On orders above ${_addCartController.reviewCart.value?.data?.storeDoc?.billDiscountTargetAmount}"
                                                        : " On your Orders",
                                                    style: TextStyle(
                                                      fontFamily: 'MuseoSans',
                                                      color: Color(0xff005b41),
                                                      fontSize: SizeUtils
                                                              .horizontalBlockSize *
                                                          4,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                    )),
                                              ])),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox();
                        }),
                        Obx(() {
                          int totalProductCount = ((_addCartController
                                      .reviewCart
                                      .value
                                      ?.data
                                      ?.products
                                      ?.length ??
                                  0) +
                              (_addCartController.reviewCart.value?.data
                                      ?.rawItems?.length ??
                                  0) +
                              (_addCartController.reviewCart.value?.data
                                      ?.inventories?.length ??
                                  0));
                          return (totalProductCount == 0)
                              ? Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.shopping_cart_outlined,
                                            size: 20.h,
                                            color: AppConst.lightSkyBlue,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "  Cart is Empty ",
                                            style: TextStyle(
                                              fontFamily: 'MuseoSans',
                                              color: AppConst.darkGrey,
                                              fontSize: (SizerUtil.deviceType ==
                                                      DeviceType.tablet)
                                                  ? 11.sp
                                                  : 14.sp,
                                              fontWeight: FontWeight.w500,
                                              fontStyle: FontStyle.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // Icon(
                                          //   Icons.arrow_back,
                                          //   size: 3.h,
                                          //   color: AppConst.black,
                                          // ),
                                          // SizedBox(
                                          //   width: 2.w,
                                          // ),
                                          Text(
                                            "Search your product in differents Stores ",
                                            style: TextStyle(
                                              fontFamily: 'MuseoSans',
                                              color: AppConst.grey,
                                              fontSize: (SizerUtil.deviceType ==
                                                      DeviceType.tablet)
                                                  ? 10.sp
                                                  : 12.sp,
                                              fontWeight: FontWeight.w600,
                                              fontStyle: FontStyle.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (navBackTo == "newbasescreen") {
                                            Get.offAllNamed(
                                                AppRoutes.NewBaseScreen);
                                          } else {
                                            Get.offAllNamed(
                                                AppRoutes.BaseScreen);
                                            // Get.back();
                                          }
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.w),
                                          child: BottomWideButton(
                                            text: "Back to home",
                                            color: AppConst.grey,
                                            borderColor: AppConst.transparent,
                                          ),
                                        ),
                                      )
                                      // InkWell(
                                      //   onTap: (() {
                                      //     Get.to(ChatOrderScreen(
                                      //         isNewStore: true,
                                      //         businessID: businessID));
                                      //   }),
                                      //   child: Padding(
                                      //     padding: EdgeInsets.symmetric(
                                      //         horizontal: 3.w),
                                      //     child: Bubble(
                                      //       color: AppConst.lightGreen
                                      //           .withOpacity(0.9),
                                      //       margin: BubbleEdges.only(top: 0.h),
                                      //       stick: true,
                                      //       nip: BubbleNip.leftTop,
                                      //       child: Container(
                                      //         padding: EdgeInsets.symmetric(
                                      //             vertical: 1.h,
                                      //             horizontal: 2.w),
                                      //         child: Row(
                                      //           mainAxisAlignment:
                                      //               MainAxisAlignment
                                      //                   .spaceBetween,
                                      //           crossAxisAlignment:
                                      //               CrossAxisAlignment.start,
                                      //           children: [
                                      //             Container(
                                      //               width: 54.w,
                                      //               child: Text(
                                      //                 "Struggling to find items? \nChat with store & place orders.",
                                      //                 style: TextStyle(
                                      //                     color: AppConst.black,
                                      //                     fontWeight:
                                      //                         FontWeight.w400,
                                      //                     // Color(0xff003d29),
                                      //                     fontSize: 10.sp),
                                      //               ),
                                      //             ),
                                      //             Container(
                                      //               width: 20.w,
                                      //               height: 4.h,
                                      //               decoration: BoxDecoration(
                                      //                 color: AppConst
                                      //                     .veryLightGrey
                                      //                     .withOpacity(0.9),
                                      //                 borderRadius:
                                      //                     BorderRadius.circular(
                                      //                         8),
                                      //                 boxShadow: [
                                      //                   BoxShadow(
                                      //                     color: AppConst
                                      //                         .veryLightGrey,
                                      //                     blurRadius: 1,
                                      //                     // offset: Offset(1, 1),
                                      //                   ),
                                      //                 ],
                                      //               ),
                                      //               child: Row(
                                      //                 mainAxisAlignment:
                                      //                     MainAxisAlignment
                                      //                         .center,
                                      //                 children: [
                                      //                   Text(
                                      //                     "Chat ",
                                      //                     style: TextStyle(
                                      //                         color: AppConst
                                      //                             .black,
                                      //                         fontSize: 12.sp,
                                      //                         fontWeight:
                                      //                             FontWeight
                                      //                                 .w500),
                                      //                   ),
                                      //                   Icon(
                                      //                     Icons.send_rounded,
                                      //                     color: AppConst.black,
                                      //                     size: 2.h,
                                      //                   )
                                      //                 ],
                                      //               ),
                                      //             ),
                                      //           ],
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                )
                              : SizedBox();
                        }),
                        Obx(
                          () => ListView.builder(
                            itemCount: _addCartController
                                    .reviewCart.value?.data?.products?.length ??
                                0,
                            shrinkWrap: true,
                            primary: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, i) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 2.w, vertical: 1.h),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        DisplayProductImage(
                                          logo: _addCartController.reviewCart
                                              .value?.data?.products?[i].logo,
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            DisplayProductName(
                                              name: _addCartController
                                                  .reviewCart
                                                  .value
                                                  ?.data
                                                  ?.products?[i]
                                                  .name,
                                            ),
                                            RichText(
                                                text: TextSpan(children: [
                                              TextSpan(
                                                  text:
                                                      "\u20b9${_addCartController.reviewCart.value?.data?.products?[i].mrp ?? ""}",
                                                  style: TextStyle(
                                                      fontFamily: 'MuseoSans',
                                                      color: AppConst.grey,
                                                      fontSize: SizeUtils
                                                              .horizontalBlockSize *
                                                          3.3,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      decoration: TextDecoration
                                                          .lineThrough)),
                                              TextSpan(
                                                  text:
                                                      " \u20b9${_addCartController.reviewCart.value?.data?.products?[i].sellingPrice ?? ""}",
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
                                                  text:
                                                      "/ ${_addCartController.reviewCart.value?.data?.products?[i].unit ?? ""}",
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
                                          ],
                                        ),
                                        _addCartController
                                                    .reviewCart
                                                    .value
                                                    ?.data
                                                    ?.products?[i]
                                                    .status ==
                                                false
                                            ? Container(
                                                width: 15.w,
                                                child: Text("Not Available",
                                                    maxLines: 2,
                                                    textAlign: TextAlign.center,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: SizeUtils
                                                              .horizontalBlockSize *
                                                          3,
                                                    )),
                                              )
                                            : Obx(
                                                () => CustomPopMenu(
                                                  title: 'Quantity',
                                                  child: DisplayProductCount(
                                                    count: _addCartController
                                                        .reviewCart
                                                        .value
                                                        ?.data
                                                        ?.products?[i]
                                                        .quantity
                                                        ?.value,
                                                  ),
                                                  onSelected: (value) async {
                                                    _addCartController
                                                        .reviewCart
                                                        .value
                                                        ?.data
                                                        ?.products?[i]
                                                        .quantity
                                                        ?.value = value;
                                                    // await _addCartController.addToCart(
                                                    //     newValueItem:
                                                    //         _addCartController.reviewCart.value?.data?.products?[i].name ?? '',
                                                    //     cartId: _addCartController.cartId.value,
                                                    //     rawItem: rawItems,
                                                    //     isEdit: true);
                                                    await _addCartController.addToReviewCartProduct(
                                                        cart_id: _addCartController
                                                            .cartId.value,
                                                        store_id:
                                                            _addCartController
                                                                    .store
                                                                    .value
                                                                    ?.sId ??
                                                                '',
                                                        index: 0,
                                                        increment: true,
                                                        sId: _addCartController
                                                                .reviewCart
                                                                .value
                                                                ?.data
                                                                ?.products?[i]
                                                                .sId ??
                                                            "",
                                                        name: _addCartController
                                                                .reviewCart
                                                                .value
                                                                ?.data
                                                                ?.products?[i]
                                                                .name ??
                                                            "",
                                                        quntity: _addCartController
                                                                .reviewCart
                                                                .value
                                                                ?.data
                                                                ?.products?[i]
                                                                .quantity
                                                                ?.value ??
                                                            0);
                                                    // await _addCartController.getCartLocation(
                                                    //     storeId:
                                                    //         _addCartController
                                                    //             .cartId
                                                    //             .value,
                                                    //     cartId: _addCartController
                                                    //             .store
                                                    //             .value
                                                    //             ?.sId ??
                                                    //         '');
                                                    _addCartController
                                                            .totalCount.value =
                                                        _exploreController
                                                                .addToCartModel
                                                                .value
                                                                ?.totalItemsCount
                                                                .toString() ??
                                                            '';
                                                    _moreStoreController
                                                            .getCartIDModel
                                                            .value
                                                            ?.totalItemsCount =
                                                        _exploreController
                                                                .addToCartModel
                                                                .value
                                                                ?.totalItemsCount ??
                                                            0;
                                                  },
                                                  list: _addCartController
                                                      .quntityList,
                                                ),
                                              ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        if (_addCartController
                                .reviewCart.value?.data?.rawItems?.isNotEmpty ??
                            false)
                          Column(
                            children: [
                              Obx(
                                () {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    primary: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: _addCartController.reviewCart
                                            .value?.data?.rawItems?.length ??
                                        0,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 2.w, vertical: 1.h),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                DisplayProductImage(
                                                  logo: _addCartController
                                                      .reviewCart
                                                      .value
                                                      ?.data
                                                      ?.rawItems?[index]
                                                      .logo,
                                                ),
                                                SizedBox(
                                                  width: 2.w,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    DisplayProductName(
                                                      name: _addCartController
                                                          .reviewCart
                                                          .value
                                                          ?.data
                                                          ?.rawItems?[index]
                                                          .item,
                                                    ),
                                                    SizedBox(
                                                      height: 1.h,
                                                    ),
                                                    DisplayChatOrderTag()
                                                  ],
                                                ),
                                                Obx(
                                                  () => CustomPopMenu(
                                                    title: 'Quantity',
                                                    child: DisplayProductCount(
                                                      count: _addCartController
                                                          .reviewCart
                                                          .value
                                                          ?.data
                                                          ?.rawItems?[index]
                                                          .quantity
                                                          ?.value,
                                                    ),
                                                    onSelected: (value) async {
                                                      _addCartController
                                                          .reviewCart
                                                          .value
                                                          ?.data
                                                          ?.rawItems?[index]
                                                          .quantity
                                                          ?.value = value;

                                                      RawItems rawItems = RawItems(
                                                          sId: _addCartController
                                                                  .reviewCart
                                                                  .value
                                                                  ?.data
                                                                  ?.rawItems?[
                                                                      index]
                                                                  .sId ??
                                                              "",
                                                          item: _addCartController
                                                                  .reviewCart
                                                                  .value
                                                                  ?.data
                                                                  ?.rawItems?[
                                                                      index]
                                                                  .item ??
                                                              '',
                                                          quantity:
                                                              _addCartController
                                                                  .reviewCart
                                                                  .value
                                                                  ?.data
                                                                  ?.rawItems?[
                                                                      index]
                                                                  .quantity,
                                                          unit: _addCartController
                                                                  .reviewCart
                                                                  .value
                                                                  ?.data
                                                                  ?.rawItems?[
                                                                      index]
                                                                  .unit ??
                                                              '',
                                                          logo: _addCartController
                                                                  .reviewCart
                                                                  .value
                                                                  ?.data
                                                                  ?.rawItems?[
                                                                      index]
                                                                  .logo ??
                                                              '');

                                                      // var isId = _addCartController
                                                      //     .reviewCart
                                                      //     .value
                                                      //     ?.data
                                                      //     ?.rawItems?[
                                                      //         index]
                                                      //     .sId;
                                                      await _addCartController.addToCart(
                                                          newValueItem:
                                                              _addCartController
                                                                      .reviewCart
                                                                      .value
                                                                      ?.data
                                                                      ?.rawItems?[
                                                                          index]
                                                                      .item ??
                                                                  '',
                                                          cartId:
                                                              _addCartController
                                                                  .cartId.value,
                                                          store_id:
                                                              _addCartController
                                                                      .reviewCart
                                                                      .value
                                                                      ?.data
                                                                      ?.storeDoc
                                                                      ?.id ??
                                                                  "",
                                                          rawItem: rawItems,
                                                          isEdit: true
                                                          //  isId != null &&
                                                          //         isId != ""
                                                          //     ? true
                                                          //     : false
                                                          );
                                                      _moreStoreController
                                                              .getCartIDModel
                                                              .value
                                                              ?.rawitems =
                                                          _addCartController
                                                                  .cart
                                                                  .value
                                                                  ?.rawItems ??
                                                              [];
                                                      _moreStoreController
                                                              .getCartIDModel
                                                              .value
                                                              ?.totalItemsCount =
                                                          _addCartController
                                                                  .cart
                                                                  .value
                                                                  ?.totalItemsCount
                                                                  ?.value ??
                                                              0;
                                                    },
                                                    list: _addCartController
                                                        .quntityList,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        if (_addCartController.reviewCart.value?.data
                                ?.inventories?.isNotEmpty ??
                            false)
                          Column(
                            children: [
                              Obx(
                                () {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    primary: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: _addCartController.reviewCart
                                            .value?.data?.inventories?.length ??
                                        0,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 1.h, horizontal: 2.w),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                DisplayProductImage(
                                                  logo: _addCartController
                                                      .reviewCart
                                                      .value
                                                      ?.data
                                                      ?.inventories?[index]
                                                      .img,
                                                ),
                                                SizedBox(
                                                  width: 2.w,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    DisplayProductName(
                                                      name: _addCartController
                                                          .reviewCart
                                                          .value
                                                          ?.data
                                                          ?.inventories?[index]
                                                          .name,
                                                    ),
                                                    RichText(
                                                        text:
                                                            TextSpan(children: [
                                                      TextSpan(
                                                          text:
                                                              " \u20b9${_addCartController.reviewCart.value?.data?.inventories?[index].mrp ?? ""}",
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'MuseoSans',
                                                            color:
                                                                AppConst.black,
                                                            fontSize: SizeUtils
                                                                    .horizontalBlockSize *
                                                                3.5,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle: FontStyle
                                                                .normal,
                                                          )),
                                                      TextSpan(
                                                          text:
                                                              "/ ${_addCartController.reviewCart.value?.data?.inventories?[index].unit ?? ""}",
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'MuseoSans',
                                                            color:
                                                                AppConst.black,
                                                            fontSize: SizeUtils
                                                                    .horizontalBlockSize *
                                                                3.3,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle: FontStyle
                                                                .normal,
                                                          ))
                                                    ])),
                                                  ],
                                                ),
                                                _addCartController
                                                            .reviewCart
                                                            .value
                                                            ?.data
                                                            ?.inventories?[
                                                                index]
                                                            .status ==
                                                        false
                                                    ? Container(
                                                        width: 15.w,
                                                        child: Text(
                                                            "Not Available",
                                                            maxLines: 2,
                                                            textAlign: TextAlign
                                                                .center,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              fontSize: SizeUtils
                                                                      .horizontalBlockSize *
                                                                  3,
                                                            )),
                                                      )
                                                    : Obx(
                                                        () => CustomPopMenu(
                                                          title: 'Quantity',
                                                          child:
                                                              DisplayProductCount(
                                                            count: _addCartController
                                                                .reviewCart
                                                                .value
                                                                ?.data
                                                                ?.inventories?[
                                                                    index]
                                                                .quantity
                                                                ?.value,
                                                          ),
                                                          onSelected:
                                                              (value) async {
                                                            _addCartController
                                                                .reviewCart
                                                                .value
                                                                ?.data
                                                                ?.inventories?[
                                                                    index]
                                                                .quantity
                                                                ?.value = value;

                                                            await _addCartController
                                                                .addToReviewCartInventory(
                                                              name: _addCartController
                                                                      .reviewCart
                                                                      .value
                                                                      ?.data
                                                                      ?.inventories?[
                                                                          index]
                                                                      .name ??
                                                                  '',
                                                              quntity: _addCartController
                                                                      .reviewCart
                                                                      .value
                                                                      ?.data
                                                                      ?.inventories?[
                                                                          index]
                                                                      .quantity
                                                                      ?.value ??
                                                                  0,
                                                              sId: _addCartController
                                                                      .reviewCart
                                                                      .value
                                                                      ?.data
                                                                      ?.inventories?[
                                                                          index]
                                                                      .sId ??
                                                                  '',
                                                              cart_id:
                                                                  _addCartController
                                                                      .cartId
                                                                      .value,
                                                              store_id:
                                                                  _addCartController
                                                                          .store
                                                                          .value
                                                                          ?.sId ??
                                                                      '',
                                                            );
                                                            // await _addCartController.getCartLocation(
                                                            //     storeId: _addCartController
                                                            //         .cartId
                                                            //         .value,
                                                            //     cartId:
                                                            //         _addCartController.store.value?.sId ?? '');
                                                            // _moreStoreController
                                                            //     .totalItemsCount
                                                            //     .value = _moreStoreController
                                                            //         .addToCartModel
                                                            //         .value
                                                            //         ?.totalItemsCount ??
                                                            //     0;
                                                            _moreStoreController
                                                              ..getCartIDModel
                                                                      .value
                                                                      ?.totalItemsCount =
                                                                  _addCartController
                                                                          .cart
                                                                          .value
                                                                          ?.totalItemsCount
                                                                          ?.value ??
                                                                      0;

                                                            _addCartController
                                                                .totalCount
                                                                .value = _moreStoreController
                                                                    .getCartIDModel
                                                                    .value
                                                                    ?.totalItemsCount
                                                                    .toString() ??
                                                                '';
                                                            _addCartController
                                                                .reviewCart
                                                                .refresh();
                                                          },
                                                          list:
                                                              _addCartController
                                                                  .quntityList,
                                                        ),
                                                      ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        SizedBox(
                          height: SizeUtils.verticalBlockSize * 12,
                        ),
                      ],
                    ),
                  ),
                )),
        ),
      ),
    );
  }

  Container SelectDeliveryAddress() {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        color: AppConst.white,
      ),
      child: Column(
        children: [
          Container(
            height: 7.h,
            color: AppConst.lightGrey,
            child: Center(
              child: Text("Choose another Address",
                  style: TextStyle(
                    fontFamily: 'MuseoSans',
                    color: AppConst.black,
                    fontSize: SizeUtils.horizontalBlockSize * 4.5,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  )),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Your Address",
                    style: TextStyle(
                      fontFamily: 'MuseoSans',
                      color: AppConst.black,
                      fontSize: SizeUtils.horizontalBlockSize * 4.2,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                    )),
                InkWell(
                  onTap: () async {
                    dynamic value = await Get.to(AddressModel(
                      isHomeScreen: false,
                      isSavedAddress: false,
                      page: "review",
                    ));
                    // Get.toNamed(AppRoutes.AddressModel);
                    // Get.toNamed(AppRoutes.orderCheckOutScreen);
                  },
                  child: Text("+ Add New",
                      style: TextStyle(
                        fontFamily: 'MuseoSans',
                        color: AppConst.green,
                        fontSize: SizeUtils.horizontalBlockSize * 4.2,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      )),
                ),
              ],
            ),
          ),
          Container(
            height: 37.h,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 3.w,
                      right: 3.w,
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.separated(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _addCartController.cartLocationModel
                                    .value?.addresses?.length ??
                                0,
                            itemBuilder: (context, index) {
                              return Obx(
                                () => InkWell(
                                  highlightColor: AppConst.highLightColor,
                                  onTap: () async {
                                    _addCartController
                                        .currentSelectValue.value = index;
                                    _addCartController
                                        .isSelectFirstAddress.value = true;
                                    selectAddress(_addCartController
                                        .cartLocationModel
                                        .value
                                        ?.addresses?[index]);
                                    _addCartController.pickedup.value = false;
                                    Get.back();
                                  },
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 1.5.h),
                                    child: Container(
                                      // color: AppConst.yellow,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 1.5.h),
                                                child: Icon(
                                                  (_addCartController
                                                              .cartLocationModel
                                                              .value
                                                              ?.addresses?[
                                                                  index]
                                                              .title ==
                                                          "Home")
                                                      ? Icons.home_filled
                                                      : (_addCartController
                                                                  .cartLocationModel
                                                                  .value
                                                                  ?.addresses?[
                                                                      index]
                                                                  .title ==
                                                              "Work")
                                                          ? Icons.work
                                                          : Icons.home,
                                                  size: 3.5.h,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 2.w,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${_addCartController.cartLocationModel.value?.addresses?[index].title ?? ""}",
                                                    style: TextStyle(
                                                        color: AppConst.black,
                                                        fontFamily: 'MuseoSans',
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: SizeUtils
                                                                .horizontalBlockSize *
                                                            4),
                                                  ),
                                                  Container(
                                                    width: 80.w,
                                                    // height: 5.h,
                                                    // color: AppConst.yellow,
                                                    child: Text(
                                                      "${_addCartController.cartLocationModel.value?.addresses?[index].house ?? ''} ${_addCartController.cartLocationModel.value?.addresses?[index].address ?? ''}",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: AppConst.grey,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: SizeUtils
                                                                  .horizontalBlockSize *
                                                              4),
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
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox();
                            },
                          ),
                        ]),
                  ),
                  Obx(() => _addCartController
                              .cartLocationModel.value?.storeAddress !=
                          null
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 1.h),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("Pickup from",
                                        style: TextStyle(
                                          fontFamily: 'MuseoSans',
                                          color: AppConst.black,
                                          fontSize:
                                              SizeUtils.horizontalBlockSize *
                                                  4.2,
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.normal,
                                        )),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: (() {
                                  // if ((_addCartController.reviewCart.value?.data
                                  //         ?.storeDoc?.store_type ==
                                  //     "instore")) {
                                  selectAddress(_addCartController
                                      .cartLocationModel.value?.storeAddress);
                                  _addCartController.pickedup.value = true;
                                  // }
                                  Get.back();
                                }),
                                highlightColor: AppConst.highLightColor,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 1.h),
                                  child: Container(
                                    color: AppConst.transparent,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: 1.5.h),
                                              child: Icon(
                                                Icons.store,
                                                size: 3.5.h,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${storeName}",
                                                  style: TextStyle(
                                                      color: AppConst.black,
                                                      fontFamily: 'MuseoSans',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: SizeUtils
                                                              .horizontalBlockSize *
                                                          4),
                                                ),
                                                Container(
                                                  width: 80.w,
                                                  // height: 5.h,
                                                  // color: AppConst.yellow,
                                                  child: Text(
                                                    "${_addCartController.cartLocationModel.value?.storeAddress?.address ?? ""}",
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: AppConst.grey,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: SizeUtils
                                                                .horizontalBlockSize *
                                                            4),
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
                              ),
                            ],
                          ),
                        )
                      : SizedBox()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void selectAddress(Addresses? addresses) async {
    try {
      _addCartController.selectAddress.value = addresses?.address ?? '';
      _addCartController.selectAddressHouse.value = addresses?.house ?? '';
      _addCartController.selectAddressIndex.value = addresses;
      // await _addCartController.selectCartLocation(
      //     addresses: addresses, cardId: _addCartController.cartId.value);
      // await _addCartController.getCartPageInformation(
      //   storeId: _addCartController.store.value?.sId ?? '',
      // );

      _addCartController.selectExpendTile.value = 1;
    } catch (e) {
      _addCartController.selectExpendTile.value = 0;
      print(e);
    }
  }
}

class CheckOutButton extends StatelessWidget {
  CheckOutButton({Key? key, this.text}) : super(key: key);
  String? text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.w),
      child: Container(
        height: 6.5.h,
        decoration: BoxDecoration(
          color: AppConst.green,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Spacer(),
            Text(
              text ?? "Continue to Checkout",
              style: TextStyle(
                  color: AppConst.white,
                  fontWeight: FontWeight.w700,
                  fontSize: SizeUtils.horizontalBlockSize * 4),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 2.2.h,
              color: AppConst.white,
            ),
            SizedBox(
              width: 5.w,
            ),
          ],
        ),
      ),
    );
  }
}

class DisplaychangeButton extends StatelessWidget {
  const DisplaychangeButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
      child: Center(
        child: Text(
          "Change",
          style: TextStyle(
              color: AppConst.darkGreen,
              fontSize: SizeUtils.horizontalBlockSize * 3.7,
              fontWeight: FontWeight.w500),
        ),
      ),
      decoration: BoxDecoration(
        color: Color(0xffe6faf1),
        border: Border.all(width: 1, color: AppConst.darkGreen),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class DisplayChatOrderTag extends StatelessWidget {
  const DisplayChatOrderTag({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Color(0xffe8ddff)),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(2),
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Color(0xff8a52ff)),
            child: Icon(
              FontAwesomeIcons.whatsapp,
              size: 1.6.h,
              color: Color(0xffe8ddff),
            ),
          ),
          SizedBox(
            width: 2.w,
          ),
          Text("Chat Order",
              style: TextStyle(
                fontFamily: 'MuseoSans',
                color: Color(0xff1e0044),
                fontSize: SizeUtils.horizontalBlockSize * 3.5,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
              ))
        ],
      ),
    );
  }
}
