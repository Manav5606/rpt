import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
import 'package:sizer/sizer.dart';

import '../../app/constants/responsive.dart';
import '../../constants/app_const.dart';
import '../../theme/styles.dart';

class MyCartScreen extends StatelessWidget {
  MyCartScreen({Key? key}) : super(key: key);
  final TextEditingController amountController = TextEditingController();
  final ExploreController _exploreController = Get.find();
  final PaymentController _paymentController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => IsScreenLoading(
          screenLoading: _exploreController.isLoadingSubmit.value,
          child: Scaffold(
            floatingActionButton: Container(
              width: double.infinity,
              height: 10.h,
              color: AppConst.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(
                          "₹ ",
                          style: TextStyle(
                              fontSize: SizeUtils.horizontalBlockSize * 6,
                              fontWeight: FontWeight.w500),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: amountController,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                                fontSize: SizeUtils.horizontalBlockSize * 5),
                            cursorColor: AppConst.themePurple,
                            // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            onChanged: (value) {
                              _exploreController.amountText.value = value;
                            },

                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppConst.transparent),
                              ),
                              hintText: ' Enter bill amount',
                              hintStyle: TextStyle(
                                fontSize: SizeUtils.horizontalBlockSize * 5,
                                color: AppConst.grey,
                              ),
                              labelStyle: AppConst.body,
                            ),
                          ),
                        ),
                        Obx(
                          () => GestureDetector(
                            onTap: () async {
                              try {
                                if (_exploreController
                                    .amountText.value.isNotEmpty) {
                                  _exploreController.isLoadingSubmit.value =
                                      true;
                                  bool error =
                                      await ScanRecipetService.placeOrder(
                                    images: Get.arguments,
                                    total: double.parse(amountController.text),
                                    storeId: _exploreController
                                        .getStoreDataModel
                                        .value
                                        ?.data
                                        ?.store
                                        ?.sId,
                                    //  _paymentController
                                    //     .redeemCashInStorePageDataIndex.value,
                                    products: _exploreController.addCartProduct,
                                    latLng: _paymentController.latLng,
                                  );
                                  if (error) {
                                    Snack.bottom(
                                        'Error', 'Failed to send receipt');
                                    _exploreController.isLoadingSubmit.value =
                                        false;
                                  } else {
                                    clearList();
                                    _exploreController.addCartProduct.clear();
                                    total();
                                    Get.toNamed(AppRoutes.BaseScreen);
                                    Snack.top(
                                        'Success', 'Receipt Sent Successfully');
                                    _exploreController.isLoadingSubmit.value =
                                        false;
                                  }
                                }
                              } catch (e) {
                                _exploreController.isLoadingSubmit.value =
                                    false;
                                print(e);
                              }
                            },
                            child: Container(
                              color:
                                  _exploreController.amountText.value.isNotEmpty
                                      ? AppConst.themePurple
                                      : AppConst.themePurple.withOpacity(0.5),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 3.w, vertical: 1.h),
                                child: Text(
                                  'Submit',
                                  style: TextStyle(
                                    fontSize: SizeUtils.horizontalBlockSize * 4,
                                    fontWeight: FontWeight.w500,
                                    color: AppConst.white,
                                    fontFamily: 'Stag',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Apply coupon?",
                      style: TextStyle(
                          fontSize: SizeUtils.horizontalBlockSize * 4,
                          fontWeight: FontWeight.w500,
                          color: AppConst.themePurple),
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              // leading: GestureDetector(
              //   onTap: () {
              //     clearList();
              //     _exploreController.addCartProduct.clear();
              //     Get.toNamed(AppRoutes.ScanStoreViewScreen);
              //   },
              //   child: Icon(Icons.arrow_back),
              // ),
              actions: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(right: 3.w),
                    child: Text(
                      "My Carts",
                      style: TextStyle(
                        color: AppConst.grey,
                        fontSize: SizeUtils.horizontalBlockSize * 4,
                      ),
                    ),
                  ),
                ),
              ],
              title: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Personal FoodsCo ",
                    style: TextStyle(
                      color: AppConst.black,
                      fontWeight: FontWeight.w600,
                      fontSize: SizeUtils.horizontalBlockSize * 5,
                    ),
                  ),
                  Text(
                    "Shopping in 94103",
                    style: TextStyle(
                      color: AppConst.black,
                      fontSize: SizeUtils.horizontalBlockSize * 4,
                    ),
                  ),
                ],
              ),
            ),
            body: WillPopScope(
              onWillPop: handleBackPressed,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CachedNetworkImage(
                              width: 12.w,
                              height: 6.h,
                              fit: BoxFit.contain,
                              imageUrl:
                                  'https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg',
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                      child: CircularProgressIndicator(
                                          value: downloadProgress.progress)),
                              errorWidget: (context, url, error) => Image.network(
                                  'https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg'),
                            ),
                          ),
                          Container(
                            width: 65.w,
                            child: Padding(
                              padding: EdgeInsets.only(left: 2.w, right: 2.w),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _exploreController.getStoreDataModel.value
                                            ?.data?.store?.name ??
                                        '',
                                    overflow: TextOverflow.ellipsis,
                                    style: AppStyles.BOLD_STYLE,
                                  ),
                                  Text(
                                    "",
                                    style: AppStyles.STORES_SUBTITLE_STYLE,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Spacer(),
                          Obx(
                            () => Text(
                              '\u20b9 ${_exploreController.totalValue.value} ',
                              style: AppStyles.BOLD_STYLE,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 2,
                      height: 1,
                    ),
                    Obx(
                      () => _exploreController.addCartProduct.isEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: SizeUtils.verticalBlockSize * 25,
                                ),
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(2.h),
                                    child: Text(
                                      'Card is Empty',
                                      style: TextStyle(
                                        fontSize:
                                            SizeUtils.horizontalBlockSize * 4,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppConst.kSecondaryColor,
                                  ),
                                  child: GestureDetector(
                                    onTap: () async {
                                      clearList();
                                      await addCartBottomSheet(context);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(2.h),
                                      child: Text(
                                        'Add to Cart',
                                        style: TextStyle(
                                          color: AppConst.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize:
                                              SizeUtils.horizontalBlockSize * 4,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          : Obx(
                              () => ListView.separated(
                                itemCount:
                                    _exploreController.addCartProduct.length,
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: 1.h,
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
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: CachedNetworkImage(
                                                width: 12.w,
                                                height: 6.h,
                                                fit: BoxFit.contain,
                                                imageUrl: _exploreController
                                                        .addCartProduct[i]
                                                        .logo ??
                                                    'https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg',
                                                progressIndicatorBuilder: (context,
                                                        url,
                                                        downloadProgress) =>
                                                    Center(
                                                        child: CircularProgressIndicator(
                                                            value:
                                                                downloadProgress
                                                                    .progress)),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Image.network(
                                                        'https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg'),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 2.w),
                                              child: Container(
                                                width: 50.w,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      _exploreController
                                                              .addCartProduct[i]
                                                              .name ??
                                                          '',
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style:
                                                          AppStyles.BOLD_STYLE,
                                                    ),
                                                    Text(
                                                      _exploreController
                                                              .addCartProduct[i]
                                                              .name ??
                                                          '',
                                                      style: AppStyles
                                                          .STORES_SUBTITLE_STYLE,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Obx(
                                              () => Container(
                                                width: 12.w,
                                                height: 5.h,
                                                child: Center(
                                                  child: Text(
                                                    _exploreController
                                                            .addCartProduct[i]
                                                            .quntity
                                                            ?.value
                                                            .toString() ??
                                                        '',
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: AppStyles.BOLD_STYLE,
                                                  ),
                                                ),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                    border: Border.all(
                                                        color: AppConst.grey)),
                                              ),
                                            ),
                                            // Spacer(),
                                            Obx(
                                              () => _exploreController
                                                          .addCartProduct[i]
                                                          .quntity!
                                                          .value >
                                                      0
                                                  ? Text(
                                                      " \u20b9 ${(_exploreController.addCartProduct[i].cashback! * _exploreController.addCartProduct[i].quntity!.value).toString()}",
                                                      style: AppStyles
                                                          .STORE_NAME_STYLE,
                                                    )
                                                  : Text(
                                                      " \u20b9 ${_exploreController.addCartProduct[i].cashback.toString()}",
                                                      style: AppStyles
                                                          .STORE_NAME_STYLE,
                                                    ),
                                            )
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            _exploreController.addCartProduct
                                                .removeAt(i);
                                            _exploreController.addCartProduct
                                                .refresh();
                                            total();
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              FaIcon(
                                                FontAwesomeIcons.trash,
                                                size: SizeUtils
                                                        .horizontalBlockSize *
                                                    4,
                                                color: AppConst.green,
                                              ),
                                              SizedBox(
                                                width: 3.w,
                                              ),
                                              Text(
                                                "Remove",
                                                style: TextStyle(
                                                    fontSize: SizeUtils
                                                            .horizontalBlockSize *
                                                        4,
                                                    fontWeight:
                                                        FontWeight.w500),
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
        subTitle: "You haven't clicked any photo of your bill.",
        onCancel: () => Get.back(),
        onConfirm: () async {
          clearList();
          _exploreController.addCartProduct.clear();
          total();
          Get.toNamed(AppRoutes.BaseScreen);
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
