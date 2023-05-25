import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:customer_app/app/data/model/order_model.dart';
import 'package:customer_app/app/ui/pages/stores/chatOrder/chatOrder.dart';
import 'package:customer_app/screens/addcart/Widgets/store_name_call_logo.dart';
import 'package:customer_app/screens/addcart/order_sucess_screen.dart';
import 'package:customer_app/screens/history/history_order_tracking_screen.dart';
import 'package:customer_app/screens/home/controller/home_controller.dart';
import 'package:customer_app/widgets/imagePicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:customer_app/app/ui/pages/search/controller/exploreContoller.dart';
import 'package:customer_app/app/ui/pages/stores/StoreViewProductList.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/scan_receipt/scan_recipet_service.dart';
import 'package:customer_app/screens/wallet/controller/paymentController.dart';
import 'package:customer_app/widgets/copied/confirm_dialog.dart';
import 'package:customer_app/widgets/screenLoader.dart';
import 'package:customer_app/widgets/snack.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sizer/sizer.dart';

import '../../app/constants/responsive.dart';
import '../../constants/app_const.dart';
import '../../theme/styles.dart';

class MyCartScreen extends StatefulWidget {
  MyCartScreen({Key? key}) : super(key: key);

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  final TextEditingController amountController = TextEditingController();

  final ExploreController _exploreController = Get.find();
  final HomeController _homeController = Get.find();
  final PaymentController _paymentController = Get.find();
  List<File>? images;

  @override
  void initState() {
    images = Get.arguments;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IsScreenLoading(
        screenLoading: _exploreController.isLoadingSubmit.value,
        child: Scaffold(
          bottomSheet: Container(
            width: double.infinity,
            height:
                (_exploreController.actual_cashback.value > 0.0) ? 18.h : 16.h,
            decoration: BoxDecoration(
              color: AppConst.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(width: 0.1, color: AppConst.grey),
              boxShadow: [
                BoxShadow(
                    color: _exploreController.addCartProduct.isEmpty
                        ? AppConst.transparent
                        : AppConst.veryLightGrey,
                    offset: Offset(0, -4),
                    blurRadius: 10,
                    spreadRadius: 1)
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(color: Color(0xfff0e6fa)),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 1.2.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: (_exploreController.totalValue.value !=
                                          0)
                                      ? "\u20b9${_exploreController.totalValue.value} "
                                      : "",
                                  style: TextStyle(
                                    fontFamily: 'MuseoSans',
                                    color: AppConst.black,
                                    fontSize: SizeUtils.horizontalBlockSize * 4,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                  )),
                              TextSpan(
                                  text:
                                      (_exploreController.totalValue.value != 0)
                                          ? "Extra Cashback earned"
                                          : "You haven't Select any Product",
                                  style: TextStyle(
                                    fontFamily: 'MuseoSans',
                                    color: AppConst.black,
                                    fontSize:
                                        SizeUtils.horizontalBlockSize * 3.7,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                  ))
                            ])),
                            Text("Enter the bill amount to get more Cashback",
                                style: TextStyle(
                                  fontFamily: 'MuseoSans',
                                  color: Color(0xff2b0064),
                                  fontSize: SizeUtils.horizontalBlockSize * 3.7,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                )),
                            SizedBox(
                              height: 0.5.h,
                            ),
                            (_exploreController.actual_cashback.value > 0.0)
                                ? Text(
                                    "CashBack : ${_exploreController.actual_cashback.value}%",
                                    style: TextStyle(
                                      fontFamily: 'MuseoSans',
                                      color: AppConst.black,
                                      fontSize:
                                          SizeUtils.horizontalBlockSize * 4,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                    ))
                                : SizedBox(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 1.2.h),
                        child: Text(
                          "\u{20B9}",
                          style: TextStyle(
                              fontSize: SizeUtils.horizontalBlockSize * 6,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 1.h),
                          child: TextFormField(
                            controller: amountController,
                            maxLines: 1,
                            maxLength: 4,

                            keyboardType: TextInputType.number,
                            style: TextStyle(
                                fontSize: SizeUtils.horizontalBlockSize * 4.5),
                            cursorColor: AppConst.black,
                            cursorHeight: 25,
                            // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            onChanged: (value) {
                              _exploreController.amountText.value = value;
                            },

                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              enabledBorder: InputBorder.none,
                              // UnderlineInputBorder(
                              //   borderSide:
                              //       BorderSide(color: AppConst.transparent),
                              // ),
                              hintText: ' Enter bill amount',
                              counterText: "",
                              hintStyle: TextStyle(
                                fontSize: SizeUtils.horizontalBlockSize * 3.7,
                                color: AppConst.grey,
                              ),
                              // labelStyle: AppConst.body,
                            ),
                          ),
                        ),
                      ),
                      Obx(
                        () => GestureDetector(
                          onTap: () async {
                            try {
                              if (_exploreController
                                      .amountText.value.isNotEmpty &&
                                  _exploreController.amountText.value.isNum) {
                                _exploreController.isLoadingSubmit.value = true;
                                OrderData? order =
                                    await ScanRecipetService.placeOrder(
                                  images: Get.arguments,
                                  total: double.parse(amountController.text),
                                  storeId: _exploreController.getStoreDataModel
                                      .value?.data?.store?.sId,
                                  //  _paymentController
                                  //     .redeemCashInStorePageDataIndex.value,
                                  cashback:
                                      _exploreController.actual_cashback.value,
                                  products: _exploreController.addCartProduct,
                                  latLng: _paymentController.latLng,
                                );
                                clearList();
                                _exploreController.addCartProduct.clear();
                                total();
                                if (order != null) {
                                  await Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            OrderSucessScreen(
                                          type: "scan",
                                          order: order,
                                        ),
                                      ),
                                      (Route<dynamic> route) => route.isFirst);
                                  _homeController.apiCall();
                                  _exploreController.isLoadingSubmit.value =
                                      false;
                                } else {
                                  Get.to(
                                      OrderFailScreen(
                                        type: "scan",
                                        order: order,
                                      ),
                                      transition: Transition.fadeIn);
                                  Timer(Duration(seconds: 2), () {
                                    Get.offAllNamed(AppRoutes.BaseScreen);
                                  });
                                  // Snack.bottom('Error', 'Failed to send receipt');
                                  _exploreController.isLoadingSubmit.value =
                                      false;
                                }
                              } else {
                                Get.showSnackbar(GetSnackBar(
                                  backgroundColor: AppConst.black,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 12),
                                  snackStyle: SnackStyle.FLOATING,
                                  borderRadius: 12,
                                  duration: Duration(seconds: 2),
                                  message: "Please Enter the vaild amount!",
                                  // title: "Amount must be at least \u{20b9}1"
                                ));
                              }
                            } catch (e) {
                              _exploreController.isLoadingSubmit.value = false;
                              print(e);
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.only(top: 1.h),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: _exploreController
                                        .amountText.value.isNotEmpty
                                    ? Color(0xff005b41)
                                    : Color(0xff005b41).withOpacity(0.5),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 3.w, vertical: 1.h),
                                child: Row(
                                  children: [
                                    Text(
                                      'Submit',
                                      style: TextStyle(
                                        fontSize:
                                            SizeUtils.horizontalBlockSize * 4,
                                        fontWeight: FontWeight.w500,
                                        color: AppConst.white,
                                        fontFamily: 'Stag',
                                      ),
                                    ),
                                    // SizedBox(
                                    //   width: 2.w,
                                    // ),
                                    Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      size: 2.h,
                                      color: AppConst.white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          appBar: AppBar(
            // automaticallyImplyLeading: false,
            // leading: GestureDetector(
            //   onTap: () {
            //     clearList();
            //     _exploreController.addCartProduct.clear();
            //     Get.toNamed(AppRoutes.ScanStoreViewScreen);
            //   },
            //   child: Icon(Icons.arrow_back),
            // ),
            centerTitle: true,
            elevation: 0,
            // actions: [
            //   Center(
            //     child: Padding(
            //       padding: EdgeInsets.only(right: 3.w),
            //       child: Text(
            //         "My Carts",
            //         style: TextStyle(
            //           color: AppConst.grey,
            //           fontSize: SizeUtils.horizontalBlockSize * 4,
            //         ),
            //       ),
            //     ),
            //   ),
            // ],
            title: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Scan Receipt",
                  style: TextStyle(
                    fontFamily: 'MuseoSans',
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    color: AppConst.black,
                    fontSize: SizeUtils.horizontalBlockSize * 4.5,
                  ),
                ),
                Text(
                  "${_exploreController.getStoreDataModel.value?.data?.store?.name ?? ""}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'MuseoSans',
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    color: AppConst.grey,
                    fontSize: SizeUtils.horizontalBlockSize * 3.7,
                  ),
                ),
              ],
            ),
          ),
          body: WillPopScope(
            onWillPop: handleBackPressed,
            child: SingleChildScrollView(
              child: Obx(
                () => _exploreController.addCartProduct.isEmpty
                    ? ListView.builder(
                        itemCount: images!.length,
                        physics: PageScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (_, index) => Padding(
                          padding: EdgeInsets.only(bottom: 1.h),
                          child: Image.file(images![index]),
                        ),
                      )
                    : Column(
                        children: [
                          // Container(
                          //   decoration: BoxDecoration(color: Color(0xfff0e6fa)),
                          //   child: Row(
                          //     children: [
                          //       Padding(
                          //         padding: EdgeInsets.symmetric(
                          //             horizontal: 4.w, vertical: 1.2.h),
                          //         child: Column(
                          //           crossAxisAlignment:
                          //               CrossAxisAlignment.start,
                          //           children: [
                          //             RichText(
                          //                 text: TextSpan(children: [
                          //               TextSpan(
                          //                   text: (_exploreController
                          //                               .totalValue.value !=
                          //                           0)
                          //                       ? "\u20b9${_exploreController.totalValue.value} "
                          //                       : "",
                          //                   style: TextStyle(
                          //                     fontFamily: 'MuseoSans',
                          //                     color: AppConst.black,
                          //                     fontSize: SizeUtils
                          //                             .horizontalBlockSize *
                          //                         4,
                          //                     fontWeight: FontWeight.w700,
                          //                     fontStyle: FontStyle.normal,
                          //                   )),
                          //               TextSpan(
                          //                   text: (_exploreController
                          //                               .totalValue.value !=
                          //                           0)
                          //                       ? "Extra Cashback earned"
                          //                       : "You haven't Select any Product",
                          //                   style: TextStyle(
                          //                     fontFamily: 'MuseoSans',
                          //                     color: AppConst.black,
                          //                     fontSize: SizeUtils
                          //                             .horizontalBlockSize *
                          //                         3.7,
                          //                     fontWeight: FontWeight.w700,
                          //                     fontStyle: FontStyle.normal,
                          //                   ))
                          //             ])),
                          //             Text(
                          //                 "Enter the bill amount to get more Cashback",
                          //                 style: TextStyle(
                          //                   fontFamily: 'MuseoSans',
                          //                   color: Color(0xff2b0064),
                          //                   fontSize:
                          //                       SizeUtils.horizontalBlockSize *
                          //                           3.7,
                          //                   fontWeight: FontWeight.w500,
                          //                   fontStyle: FontStyle.normal,
                          //                 )),
                          //             SizedBox(
                          //               height: 0.5.h,
                          //             ),
                          //             (_exploreController
                          //                         .actual_cashback.value >
                          //                     0.0)
                          //                 ? Text(
                          //                     "CashBack : ${_exploreController.actual_cashback.value}%",
                          //                     style: TextStyle(
                          //                       fontFamily: 'MuseoSans',
                          //                       color: AppConst.black,
                          //                       fontSize: SizeUtils
                          //                               .horizontalBlockSize *
                          //                           4,
                          //                       fontWeight: FontWeight.w700,
                          //                       fontStyle: FontStyle.normal,
                          //                     ))
                          //                 : SizedBox(),
                          //           ],
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),

                          Container(
                            height: 22.h,
                            width: 100.w,
                            decoration: BoxDecoration(color: Color(0xfff5f5f5)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4.w, vertical: 1.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Scanned Reciepts",
                                      style: TextStyle(
                                        fontFamily: 'MuseoSans',
                                        color: AppConst.black,
                                        fontSize:
                                            SizeUtils.horizontalBlockSize * 4.2,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                      )),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                        itemCount: images!.length,
                                        shrinkWrap: true,
                                        physics: PageScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemExtent:
                                            SizeUtils.horizontalBlockSize * 30,
                                        itemBuilder: (_, index) {
                                          return Container(
                                            // height: 16.h,
                                            // width: 28.w,
                                            child: Hero(
                                              tag: "View Image",
                                              child: GestureDetector(
                                                onTap: () {
                                                  Get.dialog(Dialog(
                                                    child: Stack(
                                                      children: [
                                                        // Image.file(
                                                        //   images![index],
                                                        //   fit: BoxFit.fill,
                                                        // ),
                                                        // SizedBox(
                                                        //   height: 1.h,
                                                        // ),
                                                        PhotoView(
                                                          heroAttributes:
                                                              PhotoViewHeroAttributes(
                                                            tag: "View Image",
                                                          ),
                                                          imageProvider:
                                                              FileImage(File(
                                                                  "${images![index].path}")),
                                                          tightMode: true,
                                                          // customSize:
                                                          //     Size(98.w, 100.h),
                                                          backgroundDecoration:
                                                              BoxDecoration(
                                                                  color: AppConst
                                                                      .black),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child:
                                                              CircularCloseButton(),
                                                        )
                                                      ],
                                                    ),
                                                  ));
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 2.w),
                                                  height: 16.h,
                                                  width: 33.w,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: Image.file(
                                                    images![index],
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Row(
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          //   children: [
                          //     ClipRRect(
                          //       borderRadius: BorderRadius.circular(100),
                          //       child: CachedNetworkImage(
                          //         width: 12.w,
                          //         height: 6.h,
                          //         fit: BoxFit.contain,
                          //         imageUrl:
                          //             'https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg',
                          //         progressIndicatorBuilder:
                          //             (context, url, downloadProgress) => Center(
                          //                 child: CircularProgressIndicator(
                          //                     value: downloadProgress.progress)),
                          //         errorWidget: (context, url, error) => Image.network(
                          //             'https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg'),
                          //       ),
                          //     ),
                          //     Container(
                          //       width: 65.w,
                          //       child: Padding(
                          //         padding: EdgeInsets.only(left: 2.w, right: 2.w),
                          //         child: Column(
                          //           mainAxisSize: MainAxisSize.min,
                          //           crossAxisAlignment: CrossAxisAlignment.start,
                          //           children: [
                          //             Text(
                          //               _exploreController.getStoreDataModel.value
                          //                       ?.data?.store?.name ??
                          //                   '',
                          //               overflow: TextOverflow.ellipsis,
                          //               style: AppStyles.BOLD_STYLE,
                          //             ),
                          //             Text(
                          //               "",
                          //               style: AppStyles.STORES_SUBTITLE_STYLE,
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //     ),
                          //     Spacer(),
                          //     Obx(
                          //       () => Text(
                          //         '\u20b9 ${_exploreController.totalValue.value} ',
                          //         style: AppStyles.BOLD_STYLE,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // Divider(
                          //   thickness: 2,
                          //   height: 1,
                          // ),

                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4.w, vertical: 1.2.h),
                            child: Row(
                              children: [
                                Text("Products you selected",
                                    style: TextStyle(
                                      fontFamily: 'MuseoSans',
                                      color: AppConst.black,
                                      fontSize:
                                          SizeUtils.horizontalBlockSize * 4.2,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                    )),
                              ],
                            ),
                          ),
                          Obx(
                            () => _exploreController.addCartProduct.isEmpty
                                ? SizedBox()
                                // Column(
                                //     crossAxisAlignment: CrossAxisAlignment.center,
                                //     children: [
                                //       SizedBox(
                                //         height: SizeUtils.verticalBlockSize * 25,
                                //       ),
                                //       Center(
                                //         child: Padding(
                                //           padding: EdgeInsets.all(2.h),
                                //           child: Text(
                                //             'Card is Empty',
                                //             style: TextStyle(
                                //               fontSize:
                                //                   SizeUtils.horizontalBlockSize * 4,
                                //               fontWeight: FontWeight.w500,
                                //             ),
                                //           ),
                                //         ),
                                //       ),
                                //       Container(
                                //         decoration: BoxDecoration(
                                //           color: AppConst.kSecondaryColor,
                                //         ),
                                //         child: GestureDetector(
                                //           onTap: () async {
                                //             clearList();
                                //             await addCartBottomSheet(context);
                                //           },
                                //           child: Padding(
                                //             padding: EdgeInsets.all(2.h),
                                //             child: Text(
                                //               'Add to Cart',
                                //               style: TextStyle(
                                //                 color: AppConst.white,
                                //                 fontWeight: FontWeight.w600,
                                //                 fontSize:
                                //                     SizeUtils.horizontalBlockSize * 4,
                                //               ),
                                //             ),
                                //           ),
                                //         ),
                                //       )
                                //     ],
                                //   )
                                : Obx(
                                    () => ListView.separated(
                                      itemCount: _exploreController
                                          .addCartProduct.length,
                                      separatorBuilder: (context, index) {
                                        return SizedBox();
                                      },
                                      shrinkWrap: true,
                                      primary: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, i) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 3.w, vertical: 1.h),
                                          child: Column(
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  DisplayProductImage(
                                                    logo: _exploreController
                                                        .addCartProduct[i].logo,
                                                    height: 7.h,
                                                    width: 14.w,
                                                  ),
                                                  // ClipRRect(
                                                  //   borderRadius:
                                                  //       BorderRadius.circular(100),
                                                  //   child: CachedNetworkImage(
                                                  //     width: 12.w,
                                                  //     height: 6.h,
                                                  //     fit: BoxFit.contain,
                                                  //     imageUrl: _exploreController
                                                  //             .addCartProduct[i]
                                                  //             .logo ??
                                                  //         'https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg',
                                                  //     progressIndicatorBuilder: (context,
                                                  //             url,
                                                  //             downloadProgress) =>
                                                  //         Center(
                                                  //             child: CircularProgressIndicator(
                                                  //                 value:
                                                  //                     downloadProgress
                                                  //                         .progress)),
                                                  //     errorWidget: (context, url,
                                                  //             error) =>
                                                  //         Image.network(
                                                  //             'https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg'),
                                                  //   ),
                                                  // ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 2.w),
                                                    child: Container(
                                                      width: 60.w,
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              _exploreController
                                                                      .addCartProduct[
                                                                          i]
                                                                      .name ??
                                                                  '',
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'MuseoSans',
                                                                color: AppConst
                                                                    .black,
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
                                                          SizedBox(
                                                            height: 0.5.h,
                                                          ),
                                                          RichText(
                                                              text: TextSpan(
                                                                  children: [
                                                                TextSpan(
                                                                    text:
                                                                        "\u20b9${_exploreController.addCartProduct[i].mrp ?? ""}",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'MuseoSans',
                                                                        color: AppConst
                                                                            .grey,
                                                                        fontSize:
                                                                            SizeUtils.horizontalBlockSize *
                                                                                3.3,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontStyle:
                                                                            FontStyle
                                                                                .normal,
                                                                        decoration:
                                                                            TextDecoration.lineThrough)),
                                                                TextSpan(
                                                                    text:
                                                                        " \u20b9${_exploreController.addCartProduct[i].selling_price ?? ""}",
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'MuseoSans',
                                                                      color: AppConst
                                                                          .black,
                                                                      fontSize:
                                                                          SizeUtils.horizontalBlockSize *
                                                                              3.5,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontStyle:
                                                                          FontStyle
                                                                              .normal,
                                                                    )),
                                                                TextSpan(
                                                                    text:
                                                                        "/ ${_exploreController.addCartProduct[i].unit ?? ""}",
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'MuseoSans',
                                                                      color: AppConst
                                                                          .black,
                                                                      fontSize:
                                                                          SizeUtils.horizontalBlockSize *
                                                                              3.3,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontStyle:
                                                                          FontStyle
                                                                              .normal,
                                                                    ))
                                                              ])),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Obx(
                                                    () => Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 2.h),
                                                      child: Container(
                                                        width: 10.w,
                                                        height: 5.h,
                                                        child: Center(
                                                          child: Text(
                                                            _exploreController
                                                                    .addCartProduct[
                                                                        i]
                                                                    .quntity
                                                                    ?.value
                                                                    .toString() ??
                                                                '',
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: AppStyles
                                                                .BOLD_STYLE,
                                                          ),
                                                        ),
                                                        decoration: BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            border: Border.all(
                                                                color: AppConst
                                                                    .grey)),
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      _exploreController
                                                          .addCartProduct
                                                          .removeAt(i);
                                                      _exploreController
                                                          .addCartProduct
                                                          .refresh();
                                                      total();
                                                    },
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 2.w,
                                                          bottom: 2.h),
                                                      child: FaIcon(
                                                        FontAwesomeIcons.trash,
                                                        size: SizeUtils
                                                                .horizontalBlockSize *
                                                            4.5,
                                                        color:
                                                            Color(0xff666666),
                                                      ),
                                                    ),
                                                  ),
                                                  // Spacer(),
                                                  // Obx(
                                                  //   () => _exploreController
                                                  //               .addCartProduct[i]
                                                  //               .quntity!
                                                  //               .value >
                                                  //           0
                                                  //       ? Text(
                                                  //           " \u20b9 ${(_exploreController.addCartProduct[i].cashback! * _exploreController.addCartProduct[i].quntity!.value).toString()}",
                                                  //           style: AppStyles
                                                  //               .STORE_NAME_STYLE,
                                                  //         )
                                                  //       : Text(
                                                  //           " \u20b9 ${_exploreController.addCartProduct[i].cashback.toString()}",
                                                  //           style: AppStyles
                                                  //               .STORE_NAME_STYLE,
                                                  //         ),
                                                  // )
                                                ],
                                              ),
                                              // GestureDetector(
                                              //   onTap: () {
                                              //     _exploreController.addCartProduct
                                              //         .removeAt(i);
                                              //     _exploreController.addCartProduct
                                              //         .refresh();
                                              //     total();
                                              //   },
                                              //   child: Row(
                                              //     mainAxisAlignment:
                                              //         MainAxisAlignment.center,
                                              //     children: [
                                              //       FaIcon(
                                              //         FontAwesomeIcons.trash,
                                              //         size: SizeUtils
                                              //                 .horizontalBlockSize *
                                              //             4,
                                              //         color: Color(0xff666666),
                                              //       ),
                                              //       // SizedBox(
                                              //       //   width: 3.w,
                                              //       // ),
                                              //       // Text(
                                              //       //   "Remove",
                                              //       //   style: TextStyle(
                                              //       //       fontSize: SizeUtils
                                              //       //               .horizontalBlockSize *
                                              //       //           4,
                                              //       //       fontWeight:
                                              //       //           FontWeight.w500),
                                              //       // ),
                                              //     ],
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> handleBackPressed() async {
    SeeyaConfirmDialog(
        title: "Are you sure?",
        subTitle: "You want to cancel",
        onCancel: () => Get.back(),
        onConfirm: () async {
          clearList();
          _exploreController.addCartProduct.clear();
          total();
          Get.back();
          Get.back();
          Get.back();
        }).show(Get.context!);
    return false;
  }

  void clearList() {
    _exploreController.getStoreDataModel.value?.data?.mainProducts!
        .forEach((mainProducts) {
      mainProducts.products!.forEach((product) {
        int isExists = _exploreController.addCartProduct.indexWhere((element) {
          return element.sId == product.sId;
        });
        if (isExists == -1) {
          for (var item in mainProducts.products!) {
            item.quntity!.value = 0;
          }
        }
      });
    });
  }

  Future addCartBottomSheet(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Orders",
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
                ),
              ),
              StoreViewProductsList(),
              GestureDetector(
                onTap: () async {
                  await _exploreController.addItem();
                  Get.back();
                },
                child: Container(
                  height: SizeUtils.verticalBlockSize * 7,
                  decoration: BoxDecoration(color: AppConst.kSecondaryColor),
                  child: Center(
                    child: Text(
                      "Continue",
                      style: TextStyle(
                          color: AppConst.white,
                          fontWeight: FontWeight.bold,
                          fontSize: SizeUtils.horizontalBlockSize * 5),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(18), topLeft: Radius.circular(18)),
      ),
    );
  }

  total() {
    _exploreController.totalValue.value = 0;
    _exploreController.addCartProduct.forEach((element) {
      _exploreController.totalValue.value =
          _exploreController.totalValue.value +
              (element.cashback! * element.quntity!.value).toInt();
    });
  }
}
