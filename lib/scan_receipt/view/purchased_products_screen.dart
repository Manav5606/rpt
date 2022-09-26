import 'dart:developer';
import 'dart:io';

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
              backgroundColor: AppConst.black,
              // extendBodyBehindAppBar: true,
              appBar: AppBar(
                title: Text(
                  'Add your bill',
                  style: TextStyle(
                      color: AppConst.black,
                      fontSize: SizeUtils.horizontalBlockSize * 5),
                ),
              ),
              body: ListView.builder(
                itemCount: images!.length,
                shrinkWrap: true,
                itemBuilder: (_, index) => Image.file(images![index]),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: _buildBottomDrawer(),
            )),
      ),
    );
  }

  Widget EnterAmount() {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize * 3),
      child: Row(
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
              style: TextStyle(fontSize: SizeUtils.horizontalBlockSize * 5),
              cursorColor: AppConst.themePurple,
              // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (value) {
                amount.value = value;
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
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
          GestureDetector(
            onTap: () async {
              FocusScope.of(context).unfocus();
              if (amount.value.isNotEmpty) {
                if (widget.storeModel == null) {
                  isLoading.value = true;
                  bool error = await ScanRecipetService.placeOrderWithoutStore(
                    images: images,
                    total: double.parse(amountController.text),
                    latLng: _paymentController.latLng,
                  );

                  log('error : $error');
                  if (error) {
                    Snack.bottom('Error', 'Failed to send receipt');
                  } else {
                    Get.toNamed(AppRoutes.BaseScreen);
                    isLoading.value = false;
                    Snack.top('Success', 'Receipt Sent Successfully');
                  }
                }
              } else {
                Snack.top('Wait', 'Please Enter amount');
              }
            },
            child: Obx(
              () {
                return Container(
                  color: amount.value.isNotEmpty
                      ? AppConst.themePurple
                      : AppConst.themePurple.withOpacity(0.5),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
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
