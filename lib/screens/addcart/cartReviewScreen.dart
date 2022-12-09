import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  String logo = '';
  String storeName = '';

  // String totalCount = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Map arg = Get.arguments ?? {};
    logo = arg['logo'] ?? '';
    storeName = arg['storeName'] ?? '';
    _addCartController.totalCount.value = arg['totalCount'].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        // automaticallyImplyLeading: false,
        // leading: Padding(
        //   padding: EdgeInsets.only(left: SizeUtils.horizontalBlockSize * 1.8),
        //   child: InkWell(
        //     onTap: () async {
        //       Get.back();
        //       // await _exploreController.getStoreData(id: _addCartController.store.value?.sId ?? '');
        //     },
        //     child: Icon(
        //       Icons.clear,
        //       color: AppConst.black,
        //       size: SizeUtils.horizontalBlockSize * 7.65,
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
            Text(storeName,
                style: TextStyle(
                  fontFamily: 'MuseoSans',
                  color: Color(0xff9e9e9e),
                  fontSize: SizeUtils.horizontalBlockSize * 3.8,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                )),
          ],
        ),
      ),
      body: SafeArea(
        child: Obx(
          () => _addCartController.isLoading.value
              ? CartReviewScreenShimmer()
              : Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeUtils.horizontalBlockSize * 2,
                      vertical: SizeUtils.verticalBlockSize * 1),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            SizeUtils.horizontalBlockSize * 3,
                                        vertical:
                                            SizeUtils.verticalBlockSize * 1),
                                    child: Container(
                                      width: double.infinity,
                                      height: 10.h,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3.w),
                                          color: Color(0xfffe6faf1)),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                SizeUtils.horizontalBlockSize *
                                                    3,
                                            vertical:
                                                SizeUtils.verticalBlockSize *
                                                    1),
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
                                                      6,
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
                                                    text:
                                                        new TextSpan(children: [
                                                  new TextSpan(
                                                      text: " Get ",
                                                      style: TextStyle(
                                                        fontFamily: 'MuseoSans',
                                                        color:
                                                            Color(0xff005b41),
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
                                                          ? "₹${_addCartController.reviewCart.value?.data?.storeDoc?.billDiscountOfferAmount} off"
                                                          : "${_addCartController.reviewCart.value?.data?.storeDoc?.actualCashback}% CashBack",

                                                      // text: "₹10 Cashback",
                                                      style: TextStyle(
                                                        fontFamily: 'MuseoSans',
                                                        color:
                                                            Color(0xff005b41),
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
                                                        color:
                                                            Color(0xff005b41),
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

                                            // Text(
                                            //   "You could save \₹${(_addCartController.getCartPageInformationModel.value?.data?.walletAmount ?? 0) + (_addCartController.getCartPageInformationModel.value?.data?.billDiscountOfferTarget ?? 0)} a month",
                                            //   style: TextStyle(
                                            //     color: AppConst.black,
                                            //     fontWeight: FontWeight.w600,
                                            //     fontSize: SizeUtils.horizontalBlockSize * 4.5,
                                            //   ),
                                            // ),

                                            // Padding(
                                            //   padding: EdgeInsets.symmetric(
                                            //       vertical: SizeUtils
                                            //               .verticalBlockSize *
                                            //           1),
                                            //   child: Container(
                                            //     decoration: BoxDecoration(
                                            //         borderRadius:
                                            //             BorderRadius.circular(
                                            //                 5.w),
                                            //         color: AppConst.orange),
                                            //     child: Padding(
                                            //       padding: EdgeInsets.all(SizeUtils
                                            //               .horizontalBlockSize *
                                            //           2),
                                            //       child: Text(
                                            //         "Here's how",
                                            //         style: TextStyle(
                                            //           color: AppConst.black,
                                            //           fontSize: SizeUtils
                                            //                   .horizontalBlockSize *
                                            //               4,
                                            //         ),
                                            //       ),
                                            //     ),
                                            //   ),
                                            // )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Obx(
                                    () => ListView.separated(
                                      itemCount: _addCartController.reviewCart
                                              .value?.data?.products?.length ??
                                          0,
                                      separatorBuilder: (context, index) {
                                        return SizedBox(
                                          height:
                                              SizeUtils.verticalBlockSize * 1,
                                        );
                                      },
                                      shrinkWrap: true,
                                      primary: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, i) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 3.w, vertical: 2.h),
                                          child: Column(
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  // ClipRRect(
                                                  //   borderRadius:
                                                  //       BorderRadius.circular(
                                                  //           100),
                                                  //   child: CachedNetworkImage(
                                                  //     width: SizeUtils
                                                  //             .horizontalBlockSize *
                                                  //         12,
                                                  //     height: 6.h,
                                                  //     fit: BoxFit.contain,
                                                  //     imageUrl:
                                                  //         'https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg',
                                                  //     progressIndicatorBuilder: (context,
                                                  //             url,
                                                  //             downloadProgress) =>
                                                  //         Center(
                                                  //             child: CircularProgressIndicator(
                                                  //                 value: downloadProgress
                                                  //                     .progress)),
                                                  //     errorWidget: (context,
                                                  //             url, error) =>
                                                  //         Image.network(
                                                  //             'https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg'),
                                                  //   ),
                                                  // ),
                                                  Container(
                                                      width: 20.w,
                                                      height: 8.h,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8)),
                                                      child: (_addCartController
                                                                  .reviewCart
                                                                  .value
                                                                  ?.data
                                                                  ?.products?[i]
                                                                  .gstAmount !=
                                                              null)
                                                          ? Image(
                                                              image: NetworkImage(
                                                                  "${_addCartController.reviewCart.value?.data?.products?[i].gstAmount}"),
                                                            )
                                                          : Image.asset(
                                                              "assets/images/noimage.png")),
                                                  SizedBox(
                                                    width: 2.w,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          child: Text(
                                                              _addCartController
                                                                      .reviewCart
                                                                      .value
                                                                      ?.data
                                                                      ?.products?[
                                                                          i]
                                                                      .name ??
                                                                  "",
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'MuseoSans',
                                                                color: Color(
                                                                    0xff000000),
                                                                fontSize: SizeUtils
                                                                        .horizontalBlockSize *
                                                                    4,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .normal,
                                                              )),
                                                        ),
                                                        Text("₹95 / 60g",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'MuseoSans',
                                                              color: Color(
                                                                  0xff9e9e9e),
                                                              fontSize: SizeUtils
                                                                      .horizontalBlockSize *
                                                                  3.7,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: _addCartController
                                                                .reviewCart
                                                                .value
                                                                ?.data
                                                                ?.products?[i]
                                                                .status ==
                                                            false
                                                        ? 18.w
                                                        : 12.w,
                                                    height: 5.h,
                                                    child: Center(
                                                      child: _addCartController
                                                                  .reviewCart
                                                                  .value
                                                                  ?.data
                                                                  ?.products?[i]
                                                                  .status ==
                                                              false
                                                          ? Text(
                                                              "Item Not Available",
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                fontSize: SizeUtils
                                                                        .horizontalBlockSize *
                                                                    3,
                                                              ))
                                                          : Obx(
                                                              () =>
                                                                  CustomPopMenu(
                                                                title:
                                                                    'Quantity',
                                                                child:
                                                                    Container(
                                                                  // decoration: BoxDecoration(
                                                                  //     shape: BoxShape
                                                                  //         .circle,
                                                                  //     border: Border.all(
                                                                  //         color:
                                                                  //             AppConst.grey)
                                                                  // ),
                                                                  child: Center(
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Text(
                                                                        "${_addCartController.reviewCart.value?.data?.products?[i].quantity?.value.toString() ?? ''}",
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: AppStyles
                                                                            .BOLD_STYLE,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                onSelected:
                                                                    (value) async {
                                                                  _addCartController
                                                                      .reviewCart
                                                                      .value
                                                                      ?.data
                                                                      ?.products?[
                                                                          i]
                                                                      .quantity
                                                                      ?.value = value;
                                                                  // await _addCartController.addToCart(
                                                                  //     newValueItem:
                                                                  //         _addCartController.reviewCart.value?.data?.products?[i].name ?? '',
                                                                  //     cartId: _addCartController.cartId.value,
                                                                  //     rawItem: rawItems,
                                                                  //     isEdit: true);
                                                                  await _exploreController.addToCart(
                                                                      cart_id: _addCartController
                                                                          .cartId
                                                                          .value,
                                                                      store_id:
                                                                          _addCartController.store.value?.sId ??
                                                                              '',
                                                                      index: 0,
                                                                      increment:
                                                                          true,
                                                                      product: _addCartController
                                                                          .reviewCart
                                                                          .value
                                                                          ?.data
                                                                          ?.products?[i]);
                                                                  _addCartController
                                                                      .totalCount
                                                                      .value = _exploreController
                                                                          .addToCartModel
                                                                          .value
                                                                          ?.totalItemsCount
                                                                          .toString() ??
                                                                      '';
                                                                  _moreStoreController
                                                                      .totalItemsCount
                                                                      .value = _exploreController
                                                                          .addToCartModel
                                                                          .value
                                                                          ?.totalItemsCount ??
                                                                      0;
                                                                  _moreStoreController
                                                                      .addToCartModel
                                                                      .value
                                                                      ?.totalItemsCount = _exploreController
                                                                          .addToCartModel
                                                                          .value
                                                                          ?.totalItemsCount ??
                                                                      0;
                                                                },
                                                                list: _addCartController
                                                                    .quntityList,
                                                              ),
                                                            ),

                                                      /*Text(
                                                              _addCartController.reviewCart.value?.data?.products?[i].quantity.toString() ?? "",
                                                              maxLines: 1,
                                                              overflow: TextOverflow.ellipsis,
                                                              style: AppStyles.BOLD_STYLE,
                                                            ),*/
                                                    ),
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            color:
                                                                AppConst.grey)),
                                                  ),

                                                  // _addCartController
                                                  //             .reviewCart
                                                  //             .value
                                                  //             ?.data
                                                  //             ?.products?[i]
                                                  //             .status ==
                                                  //         false
                                                  //     ? GestureDetector(
                                                  //         onTap: () {
                                                  //           _addCartController
                                                  //               .reviewCart
                                                  //               .value
                                                  //               ?.data
                                                  //               ?.products
                                                  //               ?.removeAt(i);
                                                  //           _addCartController
                                                  //               .reviewCart
                                                  //               .refresh();
                                                  //         },
                                                  //         child: Icon(
                                                  //           Icons.clear,
                                                  //           size: SizeUtils
                                                  //                   .horizontalBlockSize *
                                                  //               5,
                                                  //         ),
                                                  //       )
                                                  //     : Text(
                                                  //         _addCartController
                                                  //                 .reviewCart
                                                  //                 .value
                                                  //                 ?.data
                                                  //                 ?.products?[i]
                                                  //                 .sellingPrice
                                                  //                 .toString() ??
                                                  //             "",
                                                  //         style: TextStyle(
                                                  //             fontSize: SizeUtils
                                                  //                     .horizontalBlockSize *
                                                  //                 4,
                                                  //             fontWeight:
                                                  //                 FontWeight
                                                  //                     .w500),
                                                  //       ),
                                                  // Obx(
                                                  //       () => _exploreController.addCartProduct[i].quntity!.value > 0
                                                  //       ? Text(
                                                  //     " \u20b9 ${(_exploreController.addCartProduct[i].cashback! * _exploreController.addCartProduct[i].quntity!.value).toString()}",
                                                  //     style: AppStyles.STORE_NAME_STYLE,
                                                  //   )
                                                  //       : Text(
                                                  //     " \u20b9 ${_exploreController.addCartProduct[i].cashback.toString()}",
                                                  //     style: AppStyles.STORE_NAME_STYLE,
                                                  //   ),
                                                  // )
                                                ],
                                              ),
                                              GestureDetector(
                                                onTap: () {},
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    FaIcon(Icons.edit,
                                                        size: 3.h,
                                                        color:
                                                            Color(0xff000000)),
                                                    SizedBox(width: 2.w),
                                                    // Text(
                                                    //   "${_addCartController.reviewCart.value?.data?.products?[i].cashback.toString() ?? ""} CV",
                                                    //   style: TextStyle(
                                                    //       fontSize: SizeUtils
                                                    //               .horizontalBlockSize *
                                                    //           4,
                                                    //       fontWeight:
                                                    //           FontWeight.w500),
                                                    // ),
                                                    Text("Edit Item",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'MuseoSans',
                                                          color:
                                                              Color(0xff000000),
                                                          fontSize: SizeUtils
                                                                  .horizontalBlockSize *
                                                              4,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                        )),
                                                    SizedBox(
                                                      width: 4.w,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () async {
                                                        _addCartController
                                                            .reviewCart
                                                            .value
                                                            ?.data
                                                            ?.products?[i]
                                                            .quantity
                                                            ?.value = 0;
                                                        await _exploreController.addToCart(
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
                                                            index: 0,
                                                            increment: true,
                                                            product:
                                                                _addCartController
                                                                    .reviewCart
                                                                    .value
                                                                    ?.data
                                                                    ?.products?[i]);
                                                        _addCartController
                                                            .reviewCart
                                                            .value
                                                            ?.data
                                                            ?.products
                                                            ?.removeAt(i);
                                                        _addCartController
                                                            .reviewCart
                                                            .refresh();
                                                        _addCartController
                                                            .totalCount
                                                            .value = _exploreController
                                                                .addToCartModel
                                                                .value
                                                                ?.totalItemsCount
                                                                .toString() ??
                                                            '';
                                                        _moreStoreController
                                                            .totalItemsCount
                                                            .value = _exploreController
                                                                .addToCartModel
                                                                .value
                                                                ?.totalItemsCount ??
                                                            0;
                                                        _moreStoreController
                                                                .addToCartModel
                                                                .value
                                                                ?.totalItemsCount =
                                                            _exploreController
                                                                    .addToCartModel
                                                                    .value
                                                                    ?.totalItemsCount ??
                                                                0;
                                                        // total();
                                                      },
                                                      child: Row(
                                                        children: [
                                                          FaIcon(
                                                            FontAwesomeIcons
                                                                .trash,
                                                            size: SizeUtils
                                                                    .horizontalBlockSize *
                                                                5,
                                                            color: Color(
                                                                0xff000000),
                                                          ),
                                                          SizedBox(
                                                            width: 2.w,
                                                          ),
                                                          Text("Remove",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'MuseoSans',
                                                                color: Color(
                                                                    0xff000000),
                                                                fontSize: SizeUtils
                                                                        .horizontalBlockSize *
                                                                    4,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .normal,
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  if (_addCartController.reviewCart.value?.data
                                          ?.rawItems?.isNotEmpty ??
                                      false)
                                    Column(
                                      children: [
                                        // Text(
                                        //   "Raw Items",
                                        //   style: AppStyles.BOLD_STYLE,
                                        // ),
                                        Obx(
                                          () {
                                            return ListView.builder(
                                              shrinkWrap: true,
                                              primary: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: _addCartController
                                                      .reviewCart
                                                      .value
                                                      ?.data
                                                      ?.rawItems
                                                      ?.length ??
                                                  0,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: EdgeInsets.all(SizeUtils
                                                          .horizontalBlockSize *
                                                      5),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child: Text(
                                                            _addCartController
                                                                    .reviewCart
                                                                    .value
                                                                    ?.data
                                                                    ?.rawItems?[
                                                                        index]
                                                                    .item ??
                                                                '',
                                                            style: TextStyle(
                                                                fontSize: SizeUtils
                                                                        .horizontalBlockSize *
                                                                    4,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          )),
                                                          Obx(
                                                            () => CustomPopMenu(
                                                              title: 'Quantity',
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .rectangle,
                                                                    border: Border.all(
                                                                        color: AppConst
                                                                            .grey)),
                                                                child: Center(
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Text(
                                                                      "${_addCartController.reviewCart.value?.data?.rawItems?[index].quantity?.value ?? 0}",
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: AppStyles
                                                                          .BOLD_STYLE,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              onSelected:
                                                                  (value) async {
                                                                _addCartController
                                                                    .reviewCart
                                                                    .value
                                                                    ?.data
                                                                    ?.rawItems?[
                                                                        index]
                                                                    .quantity
                                                                    ?.value = value;

                                                                RawItems rawItems = RawItems(
                                                                    item: _addCartController
                                                                            .reviewCart
                                                                            .value
                                                                            ?.data
                                                                            ?.rawItems?[
                                                                                index]
                                                                            .item ??
                                                                        '',
                                                                    quantity: _addCartController
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
                                                                            ?.rawItems?[index]
                                                                            .unit ??
                                                                        '');
                                                                await _addCartController.addToCart(
                                                                    newValueItem: _addCartController
                                                                            .reviewCart
                                                                            .value
                                                                            ?.data
                                                                            ?.rawItems?[
                                                                                index]
                                                                            .item ??
                                                                        '',
                                                                    cartId: _addCartController
                                                                        .cartId
                                                                        .value,
                                                                    rawItem:
                                                                        rawItems,
                                                                    isEdit:
                                                                        true);
                                                                _moreStoreController
                                                                    .rawItemsList
                                                                    .value = _addCartController
                                                                        .cart
                                                                        .value
                                                                        ?.rawItems ??
                                                                    [];
                                                                _moreStoreController
                                                                    .totalItemsCount
                                                                    .value = _addCartController
                                                                        .cart
                                                                        .value
                                                                        ?.totalItemsCount
                                                                        ?.value ??
                                                                    0;
                                                                _moreStoreController
                                                                    .addToCartModel
                                                                    .value
                                                                    ?.totalItemsCount = _addCartController
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
                                                      Text(_addCartController
                                                              .reviewCart
                                                              .value
                                                              ?.data
                                                              ?.rawItems?[index]
                                                              .unit ??
                                                          ''),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          SizedBox(
                                                            width: 3.w,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () async {
                                                              RawItems rawItems = RawItems(
                                                                  item: _addCartController
                                                                          .reviewCart
                                                                          .value
                                                                          ?.data
                                                                          ?.rawItems?[
                                                                              index]
                                                                          .item ??
                                                                      '',
                                                                  quantity:
                                                                      0.obs,
                                                                  unit: _addCartController
                                                                          .reviewCart
                                                                          .value
                                                                          ?.data
                                                                          ?.rawItems?[
                                                                              index]
                                                                          .unit ??
                                                                      '');
                                                              await _addCartController.addToCart(
                                                                  cartId:
                                                                      _addCartController
                                                                          .cartId
                                                                          .value,
                                                                  rawItem:
                                                                      rawItems,
                                                                  isEdit: false,
                                                                  newValueItem:
                                                                      '');
                                                              _moreStoreController
                                                                      .rawItemsList
                                                                      .value =
                                                                  _addCartController
                                                                          .cart
                                                                          .value
                                                                          ?.rawItems ??
                                                                      [];
                                                              _moreStoreController
                                                                  .totalItemsCount
                                                                  .value = _addCartController
                                                                      .cart
                                                                      .value
                                                                      ?.totalItemsCount
                                                                      ?.value ??
                                                                  0;
                                                              _moreStoreController
                                                                  .addToCartModel
                                                                  .value
                                                                  ?.totalItemsCount = _addCartController
                                                                      .cart
                                                                      .value
                                                                      ?.totalItemsCount
                                                                      ?.value ??
                                                                  0;

                                                              _addCartController
                                                                  .reviewCart
                                                                  .refresh();
                                                            },
                                                            child: Row(
                                                              children: [
                                                                FaIcon(
                                                                  FontAwesomeIcons
                                                                      .trash,
                                                                  size: SizeUtils
                                                                          .horizontalBlockSize *
                                                                      4,
                                                                  color: AppConst
                                                                      .green,
                                                                ),
                                                                SizedBox(
                                                                  width: 3.w,
                                                                ),
                                                                Text(
                                                                  "Remove",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          SizeUtils.horizontalBlockSize *
                                                                              4,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                              ],
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
                                        Text(
                                          "Inventories",
                                          style: AppStyles.BOLD_STYLE,
                                        ),
                                        Obx(
                                          () {
                                            return ListView.builder(
                                              shrinkWrap: true,
                                              primary: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: _addCartController
                                                      .reviewCart
                                                      .value
                                                      ?.data
                                                      ?.inventories
                                                      ?.length ??
                                                  0,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: EdgeInsets.all(SizeUtils
                                                          .horizontalBlockSize *
                                                      5),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child: Text(
                                                            _addCartController
                                                                    .reviewCart
                                                                    .value
                                                                    ?.data
                                                                    ?.inventories?[
                                                                        index]
                                                                    .name ??
                                                                '',
                                                            style: TextStyle(
                                                                fontSize: SizeUtils
                                                                        .horizontalBlockSize *
                                                                    4,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          )),
                                                          Obx(
                                                            () => CustomPopMenu(
                                                              title: 'Quantity',
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .rectangle,
                                                                    border: Border.all(
                                                                        color: AppConst
                                                                            .grey)),
                                                                child: Center(
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Text(
                                                                      "${_addCartController.reviewCart.value?.data?.inventories?[index].quantity?.value ?? 0}",
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: AppStyles
                                                                          .BOLD_STYLE,
                                                                    ),
                                                                  ),
                                                                ),
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

                                                                await _moreStoreController
                                                                    .addToCartInventory(
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
                                                                  store_id: _addCartController
                                                                          .store
                                                                          .value
                                                                          ?.sId ??
                                                                      '',
                                                                );
                                                                _moreStoreController
                                                                    .totalItemsCount
                                                                    .value = _moreStoreController
                                                                        .addToCartModel
                                                                        .value
                                                                        ?.totalItemsCount ??
                                                                    0;
                                                                _moreStoreController
                                                                    .addToCartModel
                                                                    .value
                                                                    ?.totalItemsCount = _addCartController
                                                                        .cart
                                                                        .value
                                                                        ?.totalItemsCount
                                                                        ?.value ??
                                                                    0;

                                                                _addCartController
                                                                    .totalCount
                                                                    .value = _moreStoreController
                                                                        .addToCartModel
                                                                        .value
                                                                        ?.totalItemsCount
                                                                        .toString() ??
                                                                    '';
                                                                _addCartController
                                                                    .reviewCart
                                                                    .refresh();
                                                              },
                                                              list: _addCartController
                                                                  .quntityList,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          SizedBox(
                                                            width: 3.w,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () async {
                                                              await _moreStoreController
                                                                  .addToCartInventory(
                                                                name: _addCartController
                                                                        .reviewCart
                                                                        .value
                                                                        ?.data
                                                                        ?.inventories?[
                                                                            index]
                                                                        .name ??
                                                                    '',
                                                                quntity: 0,
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
                                                                store_id: _addCartController
                                                                        .store
                                                                        .value
                                                                        ?.sId ??
                                                                    '',
                                                              );
                                                              _addCartController
                                                                  .reviewCart
                                                                  .value
                                                                  ?.data
                                                                  ?.inventories
                                                                  ?.removeAt(
                                                                      index);
                                                              _addCartController
                                                                  .reviewCart
                                                                  .refresh();
                                                              _moreStoreController
                                                                  .totalItemsCount
                                                                  .value = _moreStoreController
                                                                      .addToCartModel
                                                                      .value
                                                                      ?.totalItemsCount ??
                                                                  0;
                                                              _moreStoreController
                                                                  .addToCartModel
                                                                  .value
                                                                  ?.totalItemsCount = _addCartController
                                                                      .cart
                                                                      .value
                                                                      ?.totalItemsCount
                                                                      ?.value ??
                                                                  0;
                                                              _moreStoreController
                                                                      .rawItemsList
                                                                      .value =
                                                                  _addCartController
                                                                          .cart
                                                                          .value
                                                                          ?.rawItems ??
                                                                      [];
                                                              _addCartController
                                                                  .totalCount
                                                                  .value = _moreStoreController
                                                                      .addToCartModel
                                                                      .value
                                                                      ?.totalItemsCount
                                                                      .toString() ??
                                                                  '';
                                                            },
                                                            child: Row(
                                                              children: [
                                                                FaIcon(
                                                                  FontAwesomeIcons
                                                                      .trash,
                                                                  size: SizeUtils
                                                                          .horizontalBlockSize *
                                                                      4,
                                                                  color: AppConst
                                                                      .green,
                                                                ),
                                                                SizedBox(
                                                                  width: 3.w,
                                                                ),
                                                                Text(
                                                                  "Remove",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          SizeUtils.horizontalBlockSize *
                                                                              4,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                              ],
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
                          ),
                        ],
                      ),
                      Obx(
                        () {
                          var temp = _addCartController
                              .reviewCart.value?.data?.products
                              ?.indexWhere((Products element) =>
                                  element.status == false);
                          return _addCartController.reviewCart.value?.data
                                      ?.products?.isEmpty ??
                                  true
                              ? SizedBox()
                              : temp != -1
                                  ? GestureDetector(
                                      onTap: () async {
                                        _addCartController
                                            .reviewCart.value?.data?.products
                                            ?.removeWhere((element) =>
                                                element.status == false);
                                        _addCartController.reviewCart.refresh();
                                        // total();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: AppConst.orange,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        height: SizeUtils.verticalBlockSize * 6,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal:
                                                SizeUtils.horizontalBlockSize *
                                                    2,
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Center(
                                                  child: Text(
                                                    "Remove Unavailable Items",
                                                    style: TextStyle(
                                                      color: Colors.white,
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
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () async {
                                          Get.toNamed(
                                              AppRoutes.orderCheckOutScreen);
                                        },
                                        child: Container(
                                          height:
                                              SizeUtils.horizontalBlockSize *
                                                  12,
                                          decoration: BoxDecoration(
                                            color: AppConst.kSecondaryColor,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Center(
                                              child: Text(
                                            "Go to CheckOut",
                                            style: TextStyle(
                                                color: AppConst.white,
                                                fontSize: SizeUtils
                                                        .horizontalBlockSize *
                                                    4),
                                          )),
                                        ),
                                      ),
                                    );

                          /*Container(
                                      color: AppConst.lightGrey,
                                      child: Padding(
                                        padding: EdgeInsets.all(2.h),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            _addCartController.selectAddressHouse.value.isNotEmpty ||
                                                    _addCartController.selectAddress.value.isNotEmpty
                                                ? Container(
                                                    color: AppConst.transparent,
                                                    child: Column(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () async {
                                                            await addAddressBottomSheet(context);
                                                          },
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Icon(
                                                                Icons.location_on_rounded,
                                                                color: AppConst.black,
                                                                size: SizeUtils.horizontalBlockSize * 6,
                                                              ),
                                                              SizedBox(
                                                                width: SizeUtils.horizontalBlockSize * 1,
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  "${_addCartController.selectAddressHouse.value} ${_addCartController.selectAddress.value}",
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: TextStyle(
                                                                      color: AppConst.black,
                                                                      fontWeight: FontWeight.w600,
                                                                      fontSize: SizeUtils.horizontalBlockSize * 4),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: SizeUtils.horizontalBlockSize * 2,
                                                              ),
                                                              Icon(
                                                                Icons.keyboard_arrow_down_rounded,
                                                                color: AppConst.grey,
                                                                size: SizeUtils.horizontalBlockSize * 7,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: SizeUtils.verticalBlockSize * 1,
                                                        ),
                                                        Divider(
                                                          height: 0,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : SizedBox(),
                                            SizedBox(
                                              height: 2.h,
                                            ),
                                            Obx(
                                              () => GestureDetector(
                                                onTap: () async {
                                                  */ /*   if (_addCartController.timeTitle.value.isNotEmpty || _addCartController.timeZone.value.isNotEmpty) {
                                                  } else*/ /*
                                                  if (_addCartController.selectAddressHouse.value.isEmpty &&
                                                      _addCartController.selectAddress.value.isEmpty) {
                                                    await addAddressBottomSheet(context);
                                                    // total();
                                                  } else if (_addCartController.selectAddressHouse.value.isNotEmpty ||
                                                      _addCartController.selectAddress.value.isNotEmpty) {
                                                    await _addCartController.getOrderConfirmPageData(
                                                        storeId: _addCartController.store.value?.sId ?? '',
                                                        distance: 0,
                                                        products: _addCartController.reviewCart.value?.data?.products,
                                                        walletAmount: _addCartController.reviewCart.value?.data?.walletAmount ?? 0.0);
                                                    _addCartController.formatDate();
                                                    await addTimeBottomSheet(
                                                      context,
                                                      () async {
                                                        if (_addCartController.selectTimeSheetIndex.value == 1) {
                                                          _addCartController.timeSlots.value = _addCartController.getCartPageInformationModel.value
                                                              ?.data?.deliverySlots?[int.parse(_addCartController.currentDay.value)].slots?.first;
                                                        } else {}
                                                        await _addCartController.createRazorPayOrder(
                                                            storeId: _addCartController.store.value?.sId ?? '',
                                                            amount:
                                                                _addCartController.getOrderConfirmPageDataModel.value?.data?.total?.toDouble() ?? 00);
                                                        if (_addCartController.createRazorpayResponseModel.value != null) {
                                                          launchPayment(
                                                              _addCartController.getOrderConfirmPageDataModel.value?.data?.total?.toInt() ?? 00,
                                                              _addCartController.createRazorpayResponseModel.value?.orderId ?? '');
                                                        } else {
                                                          Get.showSnackbar(GetBar(
                                                            message: "failed to create razor order",
                                                            duration: Duration(seconds: 2),
                                                          ));
                                                        }
                                                      },
                                                    );
                                                  }
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: AppConst.kSecondaryColor,
                                                    borderRadius: BorderRadius.circular(6),
                                                  ),
                                                  height: SizeUtils.verticalBlockSize * 6,
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(
                                                      horizontal: SizeUtils.horizontalBlockSize * 2,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Center(
                                                            child: Text(
                                                              */ /*_addCartController.timeTitle.value.isNotEmpty || _addCartController.timeZone.value.isNotEmpty
                                                                  ? "Go to CheckOut"
                                                                  : */ /*
                                                              _addCartController.selectAddressHouse.value.isEmpty &&
                                                                      _addCartController.selectAddress.value.isEmpty
                                                                  ? "Add Delivery Address"
                                                                  : _addCartController.selectAddressHouse.value.isNotEmpty ||
                                                                          _addCartController.selectAddress.value.isNotEmpty
                                                                      ? "Add Time"
                                                                      : "",
                                                              style: TextStyle(
                                                                color: AppConst.white,
                                                                fontSize: SizeUtils.horizontalBlockSize * 4,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        _addCartController.timeTitle.value.isNotEmpty || _addCartController.timeZone.value.isNotEmpty
                                                            ? Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Container(
                                                                  decoration: BoxDecoration(
                                                                    color: AppConst.grey,
                                                                    borderRadius: BorderRadius.circular(6),
                                                                  ),
                                                                  child: Center(
                                                                    child: Padding(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal: SizeUtils.horizontalBlockSize * 3,
                                                                          vertical: SizeUtils.verticalBlockSize * 1),
                                                                      child: Text(
                                                                        "\₹${_addCartController.totalValue.value}",
                                                                        style: TextStyle(
                                                                          color: AppConst.white,
                                                                          fontSize: SizeUtils.horizontalBlockSize * 3,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            : SizedBox(),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );*/
                        },
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
