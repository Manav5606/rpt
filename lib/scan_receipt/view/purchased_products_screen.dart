import 'dart:developer';
import 'dart:io';

import 'package:customer_app/app/data/model/order_model.dart';
import 'package:customer_app/screens/history/history_order_tracking_screen.dart';
import 'package:customer_app/screens/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/controllers/cartModel.dart';
import 'package:customer_app/controllers/top_products_view_model.dart';
import 'package:customer_app/data/models/mixed/productModel.dart';
import 'package:customer_app/data/repositories/new_main_api.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/scan_receipt/scan_recipet_service.dart';

import 'package:customer_app/utils/ui_spacing_helper.dart';
import 'package:customer_app/widgets/copied/confirm_dialog.dart';
import 'package:customer_app/widgets/product_card_widget.dart';
import 'package:customer_app/widgets/screenLoader.dart';
import 'package:customer_app/widgets/snack.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../app/constants/responsive.dart';
import '../../screens/wallet/controller/paymentController.dart';

class PurchasedProductsScreen extends StatefulWidget {
  final StoreModel? storeModel;
  final bool isWithStore;

  PurchasedProductsScreen({this.storeModel, this.isWithStore = false});

  @override
  _PurchasedProductsScreenState createState() =>
      _PurchasedProductsScreenState();
}

class _PurchasedProductsScreenState extends State<PurchasedProductsScreen> {
  List<File>? images;
  final TextEditingController amountController = TextEditingController();

  List<ProductModel>? _pAvailableForCashback;
  RxBool isLoading = false.obs;
  RxString amount = ''.obs;

  bool isFetchingCashbackProducts = false;

  // bool isBillSubmitInProgress = false;

  toggleFetchCashbackProductState() =>
      setState(() => isFetchingCashbackProducts = !isFetchingCashbackProducts);
  final PaymentController _paymentController = Get.find();
  final HomeController _homeController = Get.find();

  // toggleBillSubmitState() => setState(() => isBillSubmitInProgress = !isBillSubmitInProgress);

  @override
  void initState() {
    CartItemModel.products.clear();
    // Get.put(PurchasedProductViewModel());

    Get.put(TopProductsViewModel());
    TopProductsViewModel topProductsViewModel = Get.find();
    topProductsViewModel.productList.forEach((v) {
      // vm!.purchasedList.add(CartModel(product: v, count: 0));
    });
    images = Get.arguments;
    fetchProductsForCashback();

    super.initState();
  }

  void fetchProductsForCashback() async {
    toggleFetchCashbackProductState();
    //NewApi.getCashBackProducts(widget.storeModel!.id).then((products) {
    //   _pAvailableForCashback = products ?? [];
    //}).whenComplete(toggleFetchCashbackProductState);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: handleBackPressed,
      child: Obx(
        () => IsScreenLoading(
            screenLoading: isLoading.value,
            child: Scaffold(
              // backgroundColor: AppConst.black,
              // extendBodyBehindAppBar: true,
              appBar: AppBar(
                centerTitle: true,
                elevation: 0,
                title: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Enter bill Amoumt    ",
                      style: TextStyle(
                        fontFamily: 'MuseoSans',
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        color: AppConst.black,
                        fontSize: SizeUtils.horizontalBlockSize * 4.5,
                      ),
                    ),
                    Container(
                      width: 70.w,
                      child: Center(
                        child: Text(
                          "Store not selected for this Receipt",
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
                      ),
                    ),
                  ],
                ),
              ),
              body: ListView.builder(
                itemCount: images!.length,
                physics: PageScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (_, index) => Padding(
                  padding: EdgeInsets.only(bottom: 1.h),
                  child: Image.file(images![index]),
                ),
              ),
              // floatingActionButtonLocation:
              //     FloatingActionButtonLocation.centerDocked,
              // floatingActionButton: _buildBottomDrawer(),
              bottomSheet: Container(
                width: double.infinity,
                height: 8.h,
                decoration: BoxDecoration(
                  color: AppConst.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(width: 0.1, color: AppConst.grey),
                ),
                child: EnterAmount(),
              ),
            )),
      ),
    );
  }

  Widget EnterAmount() {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize * 4),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 1.h),
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
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: SizeUtils.horizontalBlockSize * 4),
                cursorColor: AppConst.black,
                // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (value) {
                  amount.value = value;
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                  enabledBorder: InputBorder.none,
                  hintText: ' Enter bill amount',
                  hintStyle: TextStyle(
                    fontSize: SizeUtils.horizontalBlockSize * 3.7,
                    color: AppConst.grey,
                  ),
                  // labelStyle: AppConst.body,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              FocusScope.of(context).unfocus();
              if (amount.value.isNotEmpty) {
                // if (widget.storeModel == null) {
                isLoading.value = true;
                OrderData? order =
                    await ScanRecipetService.placeOrderWithoutStore(
                  images: images,
                  total: double.parse(amountController.text),
                  latLng: _paymentController.latLng,
                );

                if (order != null) {
                  await Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            HistoryOrderTrackingScreen(
                          // displayHour: _addCartController.displayHour.value,
                          order: order,
                        ),
                      ),
                      (Route<dynamic> route) => route.isFirst);
                  _homeController.apiCall();
                  isLoading.value = false;
                } else {
                  Snack.bottom('Error', 'Failed to send receipt');
                  isLoading.value = false;
                }
                // }
              } else {
                Snack.top('Wait', 'Please Enter amount');
              }
            },
            child: Obx(
              () {
                return Padding(
                  padding: EdgeInsets.only(top: 1.h),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: amount.value.isNotEmpty
                          ? Color(0xff005b41)
                          : Color(0xff005b41).withOpacity(0.5),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                      child: Row(
                        children: [
                          Text(
                            'Submit',
                            style: TextStyle(
                              fontSize: SizeUtils.horizontalBlockSize * 4,
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> handleBackPressed() async {
    SeeyaConfirmDialog(
        title: "Are you sure?",
        subTitle: "You haven't clicked any photo of your bill.",
        onCancel: () => Get.back(),
        onConfirm: () {
          //exit the dialog;
          Get.back();
          //exit this screen
          Get.back();
        }).show(context);
    return false;
  }

  _buildBottomDrawer() => Container(
        height: (_pAvailableForCashback?.length ?? 0) > 0
            ? Get.height * .18
            : SizeUtils.verticalBlockSize * 10,
        decoration: BoxDecoration(
            color: AppConst.white,
            borderRadius: (_pAvailableForCashback?.length ?? 0) > 0
                ? BorderRadius.only(
                    topLeft: Radius.circular(6.0),
                    topRight: Radius.circular(6.0),
                  )
                : BorderRadius.circular(6.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (_pAvailableForCashback?.length ?? 0) > 0
                ? Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UISpacingHelper.verticalSpace12,
                          Text("Cashback Offers", style: AppConst.titleText),
                          UISpacingHelper.verticalSpaceMedium,
                          Expanded(
                              child: CashbackProductGridWidget(
                                  _pAvailableForCashback!)),
                        ],
                      ),
                    ),
                  )
                : Container(),
            UISpacingHelper.verticalSpaceMedium,
            EnterAmount(),
          ],
        ),
      );
}

class CashbackProductGridWidget extends StatelessWidget {
  final List<ProductModel> products;

  const CashbackProductGridWidget(this.products, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return products.length > 0
        ? GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              mainAxisExtent: 200.0,
            ),
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index) {
              return Obx(() {
                bool isSelected =
                    CartItemModel.products.contains(products[index]);
                return GestureDetector(
                    onTap: () {
                      if (isSelected) {
                        CartItemModel.products.remove(products[index]);
                      } else {
                        CartItemModel.products.add(products[index]);
                      }
                    },
                    child: ProductCardWidget(
                        data: products[index], isAdded: isSelected));
              });
            },
          )
        : Container();
  }
}
