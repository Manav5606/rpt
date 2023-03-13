import 'dart:async';
import 'dart:developer';

import 'package:customer_app/app/controller/add_location_controller.dart';
import 'package:customer_app/app/ui/common/shimmer_widget.dart';
import 'package:customer_app/app/ui/pages/stores/chatOrder/chatOrder.dart';
import 'package:customer_app/screens/addcart/order_sucess_screen.dart';
import 'package:customer_app/screens/history/history_order_tracking_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/ui/pages/location_picker/address_model.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/constants/string_constants.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/screens/addcart/checkorder_status_screen.dart';
import 'package:customer_app/screens/addcart/controller/addcart_controller.dart';
import 'package:customer_app/screens/addcart/models/review_cart_model.dart';
import 'package:customer_app/screens/home/controller/home_controller.dart';
import 'package:customer_app/screens/home/home_screen.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:sizer/sizer.dart';

class OrderCheckOutScreen extends StatefulWidget {
  @override
  State<OrderCheckOutScreen> createState() => _OrderCheckOutScreenState();
}

class _OrderCheckOutScreenState extends State<OrderCheckOutScreen> {
  final AddCartController _addCartController = Get.find();
  final AddLocationController _addLocationController = Get.find();
  final HomeController _homeController = Get.find();
  late Razorpay _razorpay;
  late ScrollController _delivertTimeController;
  late ScrollController _nextDaySlotsController;
  int selectExpandeIndex = 0;
  // bool pickedup = false;

  String storeName = '';
  String storeID = "123456";

  @override
  void initState() {
    Map arg = Get.arguments ?? {};

    storeName = arg['storeName'] ?? '';
    storeID = arg['id'] ?? '';
    _delivertTimeController = ScrollController();
    _nextDaySlotsController = ScrollController();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  @override
  void dispose() {
    _delivertTimeController.dispose();
    _nextDaySlotsController.dispose();

    super.dispose();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    //todo handle paymentError
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    //if the payment is success checkout
    finalPlaceOrder(response: response);
    //todo handle PaymentSuccess
  }

  void finalPlaceOrder({PaymentSuccessResponse? response}) async {
    await _addCartController.finalPlaceOrder(
        order_type: "online",
        total: double.parse(_addCartController
                .getOrderConfirmPageDataModel.value?.data?.total
                ?.toStringAsFixed(2) ??
            '0.0'),
        final_payable_amount: double.parse(_addCartController
                .getOrderConfirmPageDataModel.value?.data?.finalpayableAmount
                ?.toStringAsFixed(2) ??
            "0.0"),
        previous_total_amount: double.parse(_addCartController
                .getOrderConfirmPageDataModel.value?.data?.previousTotalAmount
                ?.toStringAsFixed(2) ??
            "0.0"),
        store:
            _addCartController.reviewCart.value?.data?.storeDoc?.id ?? storeID,
        cartId: _addCartController.cartId.value,
        products: _addCartController.reviewCart.value?.data?.products,
        rawItem: _addCartController.reviewCart.value?.data?.rawItems,
        inventories: _addCartController.reviewCart.value?.data?.inventories,
        deliveryTimeSlot: _addCartController.dayTimeSlots.value,
        walletAmount: double.parse(_addCartController.getOrderConfirmPageDataModel.value?.data?.usedWalletAmount?.toStringAsFixed(2) ?? "0.0"),
        deliveryFee: _addCartController.getOrderConfirmPageDataModel.value?.data?.deliveryFee ?? 0,
        packagingFee: _addCartController.getOrderConfirmPageDataModel.value?.data?.packagingFee ?? 0,
        // bill_discount_offer_amount: _addCartController.getOrderConfirmPageDataModel.value?.data?.billDiscountOfferAmount ?? 0,
        // bill_discount_offer_status: _addCartController.getOrderConfirmPageDataModel.value?.data?.billDiscountOfferStatus ?? false,
        // bill_discount_offer_target: _addCartController.getOrderConfirmPageDataModel.value?.data?.billDiscountOfferTarget ?? 0,
        // omit_bill_amount: _addCartController.getOrderConfirmPageDataModel.value?.data?.omit_bill_amount ?? 0,
        razorPayPaymentId: response?.paymentId ?? '',
        razorPayOrderId: response?.orderId ?? '',
        razorPaySignature: response?.signature ?? '',
        lat: _addCartController.selectAddressIndex.value?.location?.lat ?? _addLocationController.latitude.value,
        lng: _addCartController.selectAddressIndex.value?.location?.lng ?? _addLocationController.longitude.value,
        address: _addCartController.selectAddressIndex.value?.address ?? _addLocationController.userAddress.value,
        pickedup: _addCartController.pickedup.value);

    if (_addCartController.orderModel.value != null) {
      _addCartController.formatDate();
      await Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => OrderSucessScreen(
                    order: _addCartController.orderModel.value!,
                    type: "order",
                  )),
          (Route<dynamic> route) => route.isFirst);
      _addCartController.refresh();
      _homeController.apiCall();
      // _homeController.getAllCartsData();
    } else {
      Get.to(
          OrderFailScreen(
            order: _addCartController.orderModel.value!,
            type: "order",
          ),
          transition: Transition.fadeIn);
      Timer(Duration(seconds: 2), () {
        Get.offAllNamed(AppRoutes.BaseScreen);
      });
      // Snack.bottom('Error', 'Failed to send receipt');

    }
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    //todo handle external wallets
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        title: Column(
          children: [
            Text("Your Orders",
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
                      child: Text(storeName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'MuseoSans',
                            color: Color(0xff9e9e9e),
                            fontSize: SizeUtils.horizontalBlockSize * 3.8,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                          )),
                    )
                  : Text(storeName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'MuseoSans',
                        color: Color(0xff9e9e9e),
                        fontSize: SizeUtils.horizontalBlockSize * 3.8,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                      )),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Obx(
                () => _addCartController.isLoading.value
                    ? Column(
                        children: [
                          ShimmerEffect(
                            child: _buildPlayerModelList(
                              iconData: Icons.access_time_filled,
                              title: _addCartController
                                      .deliveryMessage.value.isNotEmpty
                                  ? _addCartController.deliveryMessage.value
                                  : "Select Delivery Time",
                              bottomWidget: timeSheetView(context),
                              isEnable: _addCartController
                                      .selectAddressHouse.value.isNotEmpty ||
                                  _addCartController
                                      .selectAddress.value.isNotEmpty,
                              key: 2,
                            ),
                          ),
                          ShimmerEffect(child: DisplayGuaranteeCard()),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 1.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 2.w,
                                    bottom: 2.h,
                                  ),
                                  child: Row(
                                    children: [
                                      ShimmerEffect(
                                        child: Text(
                                          'View Order Details',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                                SizeUtils.horizontalBlockSize *
                                                    4.5,
                                            fontFamily: 'MuseoSans',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ShimmerEffect(
                                  child: CheckoutWalletCard(
                                    name: storeName,
                                    balance: _addCartController
                                            .getOrderConfirmPageDataModel
                                            .value
                                            ?.data
                                            ?.walletAmount ??
                                        0,
                                    ID: storeID,
                                  ),
                                )
                              ],
                            ),
                          ),
                          ShimmerEffect(child: payView()),
                        ],
                      )
                    : Column(
                        key: Key(
                            'builder ${_addCartController.selectExpendTile.value.toString()}'),
                        children: [
                          // _buildPlayerModelList(
                          //   iconData: Icons.location_on_rounded,
                          //   title: _addCartController
                          //               .selectAddressHouse.value.isNotEmpty ||
                          //           _addCartController
                          //               .selectAddress.value.isNotEmpty
                          //       ? "${_addCartController.selectAddressHouse.value} ${_addCartController.selectAddress.value}"
                          //       : StringContants.addDeliveryAddresses,
                          //   bottomWidget: addressView(context),
                          //   isEnable: true,
                          //   key: 0,
                          // ),
                          // _buildPlayerModelList(
                          //   iconData: Icons.account_balance_wallet_outlined,
                          //   title: StringContants.walletAmount,
                          //   bottomWidget: walletAmountView(context),
                          //   isEnable: _addCartController
                          //           .selectAddressHouse.value.isNotEmpty ||
                          //       _addCartController.selectAddress.value.isNotEmpty,
                          //   key: 1,
                          // ),
                          _buildPlayerModelList(
                            iconData: Icons.access_time_filled,
                            title: (_addCartController.deliveryMessage.value !=
                                        null &&
                                    _addCartController.deliveryMessage.value !=
                                        "")
                                ? _addCartController.deliveryMessage.value
                                : "Select Delivery Time",
                            bottomWidget: timeSheetView(context),
                            isEnable: _addCartController
                                    .selectAddressHouse.value.isNotEmpty ||
                                _addCartController
                                    .selectAddress.value.isNotEmpty,
                            key: 2,
                          ),
                          // _buildPlayerModelList(
                          //     iconData: Icons.payment,
                          //     title: StringContants.paymentMode,
                          //     bottomWidget: paymentMode(),
                          //     key: 3,
                          //     isEnable: _addCartController
                          //         .deliveryMessage.value.isNotEmpty),
                          DisplayGuaranteeCard(),

                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 1.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 2.w,
                                    bottom: 2.h,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        'View Order Details',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize:
                                              SizeUtils.horizontalBlockSize *
                                                  4.5,
                                          fontFamily: 'MuseoSans',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                CheckoutWalletCard(
                                  name: storeName,
                                  balance: _addCartController
                                          .getOrderConfirmPageDataModel
                                          .value
                                          ?.data
                                          ?.walletAmount ??
                                      0,
                                  ID: storeID,
                                )
                              ],
                            ),
                          ),
                          payView(),
                        ],
                      ),
              ),
            ),
          ),
          Obx(
            () => _addCartController.isLoading.value
                ? Container(
                    height: 10.h,
                    decoration: BoxDecoration(color: AppConst.white),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: Row(
                        children: [
                          Container(
                            width: 50.w,
                            height: 9.h,
                            child: ShimmerEffect(child: paymentMode()),
                          ),
                          ShimmerEffect(
                            child: Container(
                              width: 40.w,
                              height: 6.h,
                              decoration: BoxDecoration(
                                color: (_addCartController
                                            .isTodaySlotsAvailable.value ||
                                        _addCartController
                                            .isTomorrowSlotsAvailable.value)
                                    ? AppConst.darkGreen
                                    : AppConst.grey,
                                border: Border.all(
                                    width: 0.5, color: AppConst.darkGreen),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : Container(
                    height: 10.h,
                    decoration: BoxDecoration(color: Color(0xffe6faf1)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: Row(
                        children: [
                          Container(
                            width: 50.w,
                            height: 9.h,
                            child: paymentMode(),
                          ),
                          InkWell(
                            onTap: () async {
                              if (_addCartController
                                      .isTodaySlotsAvailable.value ||
                                  _addCartController
                                      .isTomorrowSlotsAvailable.value) {
                                if (_addCartController
                                        .selectPaymentMode.value ==
                                    'paynow') {
                                  if (_addCartController
                                              .dayTimeSlots.value?.day !=
                                          null &&
                                      _addCartController
                                              .dayTimeSlots.value?.startTime !=
                                          null) {
                                    await _addCartController.createRazorPayOrder(
                                        storeId: _addCartController
                                                .store.value?.sId ??
                                            '',
                                        amount: double.parse(_addCartController
                                                .getOrderConfirmPageDataModel
                                                .value
                                                ?.data
                                                ?.finalpayableAmount
                                                ?.toStringAsFixed(2) ??
                                            "0.0"));
                                    _addCartController.deliveryMessage.value ==
                                        "";
                                  } else {
                                    _addCartController.selectExpendTile.value =
                                        2;
                                  }
                                  if (_addCartController
                                          .createRazorpayResponseModel.value !=
                                      null) {
                                    if (_addCartController
                                                .dayTimeSlots.value?.day !=
                                            null &&
                                        _addCartController.dayTimeSlots.value
                                                ?.startTime !=
                                            null) {
                                      launchPayment(
                                          _addCartController
                                                  .getOrderConfirmPageDataModel
                                                  .value
                                                  ?.data
                                                  ?.finalpayableAmount
                                                  ?.toInt() ??
                                              00,
                                          _addCartController
                                                  .createRazorpayResponseModel
                                                  .value
                                                  ?.orderId ??
                                              '');
                                      _addCartController
                                              .deliveryMessage.value ==
                                          "";
                                    } else {
                                      _addCartController
                                          .selectExpendTile.value = 2;
                                    }
                                  } else {
                                    Get.showSnackbar(GetBar(
                                      message: "failed to create razor order",
                                      duration: Duration(seconds: 2),
                                    ));
                                  }
                                } else {
                                  if (_addCartController
                                              .dayTimeSlots.value?.day !=
                                          null &&
                                      _addCartController
                                              .dayTimeSlots.value?.startTime !=
                                          null) {
                                    finalPlaceOrder();
                                    _addCartController.deliveryMessage.value ==
                                        "";
                                  } else {
                                    _addCartController.selectExpendTile.value =
                                        2;
                                  }
                                }
                              }
                            },
                            child: Container(
                              width: 40.w,
                              height: 6.h,
                              decoration: BoxDecoration(
                                color: (_addCartController
                                            .isTodaySlotsAvailable.value ||
                                        _addCartController
                                            .isTomorrowSlotsAvailable.value)
                                    ? AppConst.darkGreen
                                    : AppConst.grey,
                                border: Border.all(
                                    width: 0.5, color: AppConst.darkGreen),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                  child: Text(
                                (_addCartController.selectPaymentMode.value ==
                                        "paybycash")
                                    ? "Pay Cash \u{20B9}${_addCartController.getOrderConfirmPageDataModel.value?.data?.finalpayableAmount ?? 0}"
                                    : "Pay \u{20B9}${_addCartController.getOrderConfirmPageDataModel.value?.data?.finalpayableAmount ?? 0}",
                                style: TextStyle(
                                  fontFamily: 'MuseoSans',
                                  color: AppConst.white,
                                  fontSize: SizeUtils.horizontalBlockSize * 4,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal,
                                ),
                              )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
          ),
          // Obx(
          //   () => GestureDetector(
          //     onTap: () async {
          //       if (_addCartController.selectPaymentMode.value == 'paynow') {
          //         await _addCartController.createRazorPayOrder(
          //             storeId: _addCartController.store.value?.sId ?? '',
          //             amount: _addCartController
          //                     .getOrderConfirmPageDataModel.value?.data?.total
          //                     ?.toDouble() ??
          //                 00);
          //         if (_addCartController.createRazorpayResponseModel.value !=
          //             null) {
          //           launchPayment(
          //               _addCartController.getOrderConfirmPageDataModel.value
          //                       ?.data?.total
          //                       ?.toInt() ??
          //                   00,
          //               _addCartController
          //                       .createRazorpayResponseModel.value?.orderId ??
          //                   '');
          //         } else {
          //           Get.showSnackbar(GetBar(
          //             message: "failed to create razor order",
          //             duration: Duration(seconds: 2),
          //           ));
          //         }
          //       } else {
          //         finalPlaceOrder();
          //       }
          //     },
          //     // onTap: onTap,
          //     child: Container(
          //       decoration: BoxDecoration(
          //         color: AppConst.kSecondaryColor,
          //         borderRadius: BorderRadius.circular(6),
          //       ),
          //       height: SizeUtils.verticalBlockSize * 6,
          //       child: Padding(
          //         padding: EdgeInsets.symmetric(
          //           horizontal: SizeUtils.horizontalBlockSize * 2,
          //         ),
          //         child: Row(
          //           children: [
          //             Expanded(
          //               child: Center(
          //                 child: Text(
          //                   "Go to CheckOut",
          //                   style: TextStyle(
          //                     color: AppConst.white,
          //                     fontSize: SizeUtils.horizontalBlockSize * 4,
          //                   ),
          //                 ),
          //               ),
          //             ),
          //             Padding(
          //               padding: const EdgeInsets.all(8.0),
          //               child: Container(
          //                 decoration: BoxDecoration(
          //                   color: AppConst.darkGrey,
          //                   borderRadius: BorderRadius.circular(6),
          //                 ),
          //                 child: Center(
          //                   child: Padding(
          //                     padding: EdgeInsets.symmetric(
          //                         horizontal:
          //                             SizeUtils.horizontalBlockSize * 3,
          //                         vertical: SizeUtils.verticalBlockSize * 1),
          //                     child: Text(
          //                       "\u{20B9}${_addCartController.getOrderConfirmPageDataModel.value?.data?.total.toString() ?? ''}",
          //                       style: TextStyle(
          //                         color: AppConst.white,
          //                         fontSize: SizeUtils.horizontalBlockSize * 3,
          //                       ),
          //                     ),
          //                   ),
          //                 ),
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
    );
  }

  Widget addressView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          StringContants.addDeliveryAddresses,
          style: TextStyle(
            fontSize: SizeUtils.horizontalBlockSize * 4.5,
            fontWeight: FontWeight.bold,
          ),
        ),
        ListView.separated(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount:
              _addCartController.cartLocationModel.value?.addresses?.length ??
                  0,
          itemBuilder: (context, index) {
            return Obx(
              () => GestureDetector(
                onTap: () async {
                  _addCartController.currentSelectValue.value = index;
                  _addCartController.isSelectFirstAddress.value = true;
                },
                child: Container(
                  color: AppConst.transparent,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IgnorePointer(
                            child: Radio(
                              value: true,
                              groupValue: _addCartController
                                          .currentSelectValue.value ==
                                      index &&
                                  _addCartController.isSelectFirstAddress.value,
                              onChanged: (value) {},
                            ),
                          ),
                          Flexible(
                            child: Text(
                              "${_addCartController.cartLocationModel.value?.addresses?[index].house ?? ''} ${_addCartController.cartLocationModel.value?.addresses?[index].address ?? ''}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: AppConst.grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: SizeUtils.horizontalBlockSize * 4),
                            ),
                          ),
                        ],
                      ),
                      if (_addCartController.currentSelectValue.value ==
                              index &&
                          _addCartController.isSelectFirstAddress.value)
                        button(
                            onTap: () {
                              selectAddress(_addCartController
                                  .cartLocationModel.value?.addresses?[index]);
                              _addCartController.pickedup.value = false;
                            },
                            text: "Choose Address")
                      else
                        SizedBox(),
                    ],
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(height: 0);
          },
        ),
        Obx(() => _addCartController.cartLocationModel.value?.storeAddress !=
                null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    StringContants.storeAddresses,
                    style: TextStyle(
                      fontSize: SizeUtils.horizontalBlockSize * 4.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      _addCartController.isSelectFirstAddress.value = false;
                    },
                    child: Container(
                      color: AppConst.transparent,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              IgnorePointer(
                                child: IgnorePointer(
                                  child: Radio(
                                    value: true,
                                    groupValue: !_addCartController
                                        .isSelectFirstAddress.value,
                                    onChanged: (value) {},
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  "${_addCartController.cartLocationModel.value?.storeAddress?.house ?? ''} ${_addCartController.cartLocationModel.value?.storeAddress?.address ?? ''}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: AppConst.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize:
                                          SizeUtils.horizontalBlockSize * 4),
                                ),
                              ),
                            ],
                          ),
                          if (!_addCartController.isSelectFirstAddress.value)
                            button(
                                onTap: () {
                                  selectAddress(_addCartController
                                      .cartLocationModel.value?.storeAddress);
                                  _addCartController.pickedup.value = true;
                                },
                                text: "Choose Address")
                          else
                            SizedBox(),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : SizedBox()),
        SizedBox(height: SizeUtils.horizontalBlockSize * 4),
        GestureDetector(
          // onTap: () {
          //   showModalBottomSheet(
          //     isScrollControlled: true,
          //     context: context,
          //     useRootNavigator: true,
          //     builder: (context) {
          //       return AddressModel(
          //         isHomeScreen: true,
          //       );
          //     },
          //   );
          // },
          onTap: () async {
            Get.toNamed(AppRoutes.NewLocationScreen,
                arguments: {"isFalse": false});
          },
          child: Text(
            StringContants.addAddresses,
            style: TextStyle(
                fontSize: SizeUtils.horizontalBlockSize * 4.5,
                fontWeight: FontWeight.bold,
                color: AppConst.green),
          ),
        ),
      ],
    );
  }

  void selectAddress(Addresses? addresses) async {
    try {
      _addCartController.selectAddress.value = addresses?.address ?? '';
      _addCartController.selectAddressHouse.value = addresses?.house ?? '';
      _addCartController.selectAddressIndex.value = addresses;
      await _addCartController.selectCartLocation(
          addresses: addresses, cardId: _addCartController.cartId.value);
      // await _addCartController.getCartPageInformation(
      //   storeId: _addCartController.store.value?.sId ?? '',
      // );

      _addCartController.formatDate();
      _addCartController.selectExpendTile.value = 1;
    } catch (e) {
      _addCartController.selectExpendTile.value = 0;
      print(e);
    }
  }

  Widget paymentMode() {
    return Obx(
      () => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 4.h,
            child: Row(
              children: [
                Radio<String>(
                  activeColor: AppConst.darkGreen,
                  value: "paybycash",
                  groupValue: _addCartController.selectPaymentMode.value,
                  onChanged: (value) {
                    _addCartController.selectPaymentMode.value =
                        value.toString();
                  },
                ),
                Text(
                  "Pay by Cash",
                  style: TextStyle(
                    fontFamily: 'MuseoSans',
                    color: AppConst.black,
                    fontSize: SizeUtils.horizontalBlockSize * 3.5,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 4.h,
            child: Row(
              children: [
                Radio<String>(
                  activeColor: AppConst.darkGreen,
                  value: "paynow",
                  groupValue: _addCartController.selectPaymentMode.value,
                  onChanged: (value) {
                    _addCartController.selectPaymentMode.value =
                        value.toString();
                  },
                ),
                Text(
                  "Pay Now",
                  style: TextStyle(
                    fontFamily: 'MuseoSans',
                    color: AppConst.black,
                    fontSize: SizeUtils.horizontalBlockSize * 3.5,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget walletAmountView(BuildContext context) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       RadioListTile(
  //         title: Text("Any offers around you"),
  //         value: "offer",
  //         groupValue: _addCartController.selectPaymentMode.value,
  //         onChanged: (value) {
  //           _addCartController.selectPaymentMode.value = value.toString();
  //         },
  //       ),
  //       Row(
  //         children: [
  //           Expanded(child: Text("Wallet Amount")),
  //           Text(
  //               "${_addCartController.getOrderConfirmPageDataModel.value?.data?.usedWalletAmount ?? 0}"),
  //         ],
  //       ),
  //       Obx(
  //         () => Row(
  //           children: [
  //             Flexible(
  //               child: RadioListTile(
  //                 title: Text("Yes"),
  //                 value: "yes",
  //                 groupValue: _addCartController.selectWalletMode.value,
  //                 onChanged: (value) {
  //                   _addCartController.selectWalletMode.value =
  //                       value.toString();
  //                 },
  //               ),
  //             ),
  //             Flexible(
  //               child: RadioListTile(
  //                 title: Text("No"),
  //                 value: "no",
  //                 groupValue: _addCartController.selectWalletMode.value,
  //                 onChanged: (value) {
  //                   _addCartController.selectWalletMode.value =
  //                       value.toString();
  //                 },
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //       button(
  //           onTap: () async {
  //             await _addCartController.getOrderConfirmPageData(
  //                 storeId: _addCartController.store.value?.sId ?? '',
  //                 distance: 0,
  //                 products: _addCartController.reviewCart.value?.data?.products,
  //                 inventories:
  //                     _addCartController.reviewCart.value?.data?.inventories,
  //                 walletAmount: 0);
  //             _addCartController.selectExpendTile.value = 2;
  //           },
  //           text: "Choose Wallet")
  //     ],
  //   );
  // }

  Widget timeSheetView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        chooseSecondTimeWidget(context),
        SizedBox(height: 1.h),
        chooseThirdTimeWidget1(),
        SizedBox(height: 1.h),
        button(
          onTap: () {
            if (_addCartController.isTodaySlotsAvailable.value ||
                _addCartController.isTomorrowSlotsAvailable.value) {
              if (_addCartController.selectTimeSheetIndex.value == 1) {
                _addCartController.timeSlots.value = _addCartController
                    .getOrderConfirmPageDataModel
                    .value
                    ?.data
                    ?.deliverySlots?[
                        int.parse(_addCartController.currentDay.value)]
                    .slots
                    ?.first;
                _addCartController.deliveryMessage.value =
                    _addCartController.displayHour.value;

                _addCartController.selectExpendTile.value = 3;
              } else {
                _addCartController.deliveryMessage.value =
                    "${_addCartController.timeZoneCustom.value}  ${_addCartController.timeTitleCustom.value}";
                _addCartController.selectExpendTile.value = 3;
              }
            }
          },
          text: (_addCartController.isTodaySlotsAvailable.value ||
                  _addCartController.isTomorrowSlotsAvailable.value)
              ? "Choose Time"
              : "Delivery Slot not available",
        )
      ],
    );
  }

  Widget payView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        children: [
          bottomRow(
              'Item Subtotal',
              (_addCartController.getOrderConfirmPageDataModel.value?.data
                          ?.previousTotalAmount ??
                      0.0)
                  .toString(),
              true),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.5.h),
            child: Container(
              height: 1,
              color: AppConst.lightGrey,
            ),
          ),
          bottomRow(
              'Gst and Packaging',
              (_addCartController.getOrderConfirmPageDataModel.value?.data
                          ?.gstAndPackaging ??
                      '0')
                  .toString(),
              true),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.5.h),
            child: Container(
              height: 1,
              color: AppConst.lightGrey,
            ),
          ),
          bottomRow(
              'Delivery Fee',
              (_addCartController.getOrderConfirmPageDataModel.value?.data
                          ?.deliveryFee ??
                      '0')
                  .toString(),
              true),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.5.h),
            child: Container(
              height: 1,
              color: AppConst.lightGrey,
            ),
          ),
          bottomRow(
              'Bill Discount ',
              (_addCartController.getOrderConfirmPageDataModel.value?.data
                          ?.billDiscountOfferAmount ??
                      '0')
                  .toString(),
              false),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.5.h),
            child: Container(
              height: 1,
              color: AppConst.lightGrey,
            ),
          ),
          bottomRow(
              'Wallet Amount',
              (_addCartController.getOrderConfirmPageDataModel.value?.data
                          ?.usedWalletAmount ??
                      '0')
                  .toString(),
              false),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.7.h),
            child: Container(
              height: 1,
              color: AppConst.darkGrey,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Amount',
                style: TextStyle(
                  fontFamily: 'MuseoSans',
                  color: AppConst.black,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: SizeUtils.horizontalBlockSize * 3.5,
                ),
              ),
              Text(
                " \u{20B9}${(_addCartController.getOrderConfirmPageDataModel.value?.data?.finalpayableAmount ?? '0').toString()}",
                style: TextStyle(
                  fontFamily: 'MuseoSans',
                  color: AppConst.black,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: SizeUtils.horizontalBlockSize * 3.5,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h)
        ],
      ),
    );
  }

  Widget chooseSecondTimeWidget(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          _addCartController.selectTimeSheetIndex.value = 1;
        },
        onDoubleTap: () {
          _addCartController.selectTimeSheetIndex.value = 2;
        },
        child: Container(
          height: 8.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: _addCartController.selectTimeSheetIndex.value == 1
                ? Color(0xffe6faf1)
                : AppConst.white,
            border: Border.all(
                color: _addCartController.selectTimeSheetIndex.value == 1
                    ? AppConst.green
                    : AppConst.grey),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: 0.5.h,
              top: 1.h,
            ),
            child: Row(
              children: [
                Radio<int>(
                  activeColor: AppConst.darkGreen,
                  value: (_addCartController.selectTimeSheetIndex.value),
                  groupValue: 1,
                  onChanged: (value) {},
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Standard Fast Delivery",
                      style: TextStyle(
                        fontFamily: 'MuseoSans',
                        color: AppConst.darkGreen,
                        fontSize: SizeUtils.horizontalBlockSize * 4,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    Text(
                      _addCartController.displayHour.value,
                      style: TextStyle(
                        fontFamily: 'MuseoSans',
                        color: AppConst.grey,
                        fontSize: SizeUtils.horizontalBlockSize * 3.7,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget chooseThirdTimeWidget1() {
    return Container(
      height: 18.h,
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(8),
      //   color: _addCartController.selectTimeSheetIndex.value == 2
      //       ? Color(0xffe6faf1)
      //       : AppConst.white,
      //   border: Border.all(
      //       color: _addCartController.selectTimeSheetIndex.value == 2
      //           ? AppConst.green
      //           : AppConst.grey),
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _daySelection1(),
          SizedBox(
            height: 1.h,
          ),
          ((_addCartController.isTodaySlotsAvailable.value &&
                      _addCartController.selectedDayIndex.value == 0) &&
                  ((_addCartController.remainingSlotForDay != null &&
                      _addCartController.remainingSlotForDay!.length > 0))
              ? Container(
                  height: 7.h,
                  child: Obx(
                    () => ListView.separated(
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            width: 2.w,
                          );
                        },
                        shrinkWrap: true,
                        controller: _delivertTimeController,
                        physics: PageScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            ((_addCartController.remainingSlotForDay?.length ??
                                    1) -
                                1),
                        itemBuilder: (context, index) {
                          return Obx(
                            () {
                              return GestureDetector(
                                onTap: () {
                                  _addCartController
                                      .selectTimeSheetIndex.value = 2;
                                  if (_addCartController
                                          .selectedTimeIndex.value ==
                                      index) {
                                    _addCartController.selectedTimeIndex.value =
                                        -1;
                                  } else {
                                    _addCartController.selectedTimeIndex.value =
                                        index;

                                    _addCartController
                                            .dayTimeSlots.value?.startTime =
                                        _addCartController
                                            .remainingSlotForDay![index]
                                            .startTime;

                                    _addCartController
                                            .dayTimeSlots.value?.endTime =
                                        _addCartController
                                            .remainingSlotForDay![index]
                                            .endTime;

                                    _addCartController
                                            .dayTimeSlots.value?.cutOffTime =
                                        _addCartController
                                            .remainingSlotForDay![index]
                                            .cutOffTime;
                                    _addCartController.dayTimeSlots.value?.day =
                                        int.parse(_addCartController
                                            .currentDay.value);

                                    _addCartController.timeZoneCustom.value =
                                        getTemp1(index);
                                    _addCartController.dayTimeSlots.refresh();
                                  }
                                },
                                child: Container(
                                  height: 6.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: _addCartController
                                                .selectedTimeIndex.value ==
                                            index
                                        ? Color(0xffe6faf1)
                                        : AppConst.white,
                                    border: Border.all(
                                        color: _addCartController
                                                    .selectedTimeIndex.value ==
                                                index
                                            ? AppConst.green
                                            : AppConst.grey),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 2.w),
                                    child: Row(
                                      children: [
                                        IgnorePointer(
                                          child: Radio(
                                            activeColor: AppConst.darkGreen,
                                            value: index,
                                            groupValue: _addCartController
                                                .selectedTimeIndex.value,
                                            onChanged: (value) {
                                              _addCartController
                                                      .selectedTimeIndex
                                                      .value ==
                                                  value;
                                            },
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              getTemp1(index),
                                              style: TextStyle(
                                                color: AppConst.black,
                                                fontSize: SizeUtils
                                                        .horizontalBlockSize *
                                                    3.5,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "MuseoSans",
                                                fontStyle: FontStyle.normal,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                  ),
                )
              : SizedBox()),
          ((_addCartController.isTomorrowSlotsAvailable.value &&
                      _addCartController.selectedDayIndex.value == 1) &&
                  ((_addCartController.nextDaySlots != null &&
                      _addCartController.nextDaySlots!.length > 0))
              ? Container(
                  height: 7.h,
                  child: Obx(
                    () => ListView.separated(
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            width: 2.w,
                          );
                        },
                        shrinkWrap: true,
                        controller: _nextDaySlotsController,
                        physics: PageScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            ((_addCartController.nextDaySlots?.length ?? 1) -
                                1),
                        itemBuilder: (context, index) {
                          return Obx(
                            () {
                              return GestureDetector(
                                onTap: () {
                                  _addCartController
                                      .selectTimeSheetIndex.value = 2;
                                  if (_addCartController
                                          .selectedTimeIndexForNextDay.value ==
                                      index) {
                                    _addCartController
                                        .selectedTimeIndexForNextDay.value = -1;
                                  } else {
                                    _addCartController
                                        .selectedTimeIndexForNextDay
                                        .value = index;

                                    _addCartController
                                            .dayTimeSlots.value?.startTime =
                                        _addCartController
                                            .nextDaySlots![index].startTime;

                                    _addCartController
                                            .dayTimeSlots.value?.endTime =
                                        _addCartController
                                            .nextDaySlots![index].endTime;

                                    _addCartController
                                            .dayTimeSlots.value?.cutOffTime =
                                        _addCartController
                                            .nextDaySlots![index].cutOffTime;

                                    _addCartController.dayTimeSlots.value?.day =
                                        (int.parse(_addCartController
                                                .currentDay.value) +
                                            1);

                                    _addCartController.timeZoneCustom.value =
                                        getTempNextDay(index);
                                    _addCartController.dayTimeSlots.refresh();
                                  }
                                },
                                child: Container(
                                  height: 6.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: _addCartController
                                                .selectedTimeIndexForNextDay
                                                .value ==
                                            index
                                        ? Color(0xffe6faf1)
                                        : AppConst.white,
                                    border: Border.all(
                                        color: _addCartController
                                                    .selectedTimeIndexForNextDay
                                                    .value ==
                                                index
                                            ? AppConst.green
                                            : AppConst.grey),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 2.w),
                                    child: Row(
                                      children: [
                                        IgnorePointer(
                                          child: Radio(
                                            activeColor: AppConst.darkGreen,
                                            value: index,
                                            groupValue: _addCartController
                                                .selectedTimeIndexForNextDay
                                                .value,
                                            onChanged: (value) {
                                              _addCartController
                                                      .selectedTimeIndexForNextDay
                                                      .value ==
                                                  value;
                                            },
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              getTempNextDay(index),
                                              style: TextStyle(
                                                color: AppConst.black,
                                                fontSize: SizeUtils
                                                        .horizontalBlockSize *
                                                    3.5,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "MuseoSans",
                                                fontStyle: FontStyle.normal,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                  ),
                )
              : SizedBox())
          // Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Icon(Icons.delivery_dining_outlined),
          //       SizedBox(
          //         width: 2.w,
          //       ),
          //       Text("Delivery Slots Not Available ")
          //     ],
          //   )),
        ],
      ),
    );
  }

  Widget _daySelection1() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: InkWell(
        onTap: (() {
          _addCartController.selectTimeSheetIndex.value = 2;
        }),
        child: Container(
          height: 7.h,
          color: AppConst.transparent,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(
              horizontal: 3.w,
            ),
            itemCount: 2,
            addAutomaticKeepAlives: false,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 2.w,
                ),
                child: Obx(
                  () {
                    return GestureDetector(
                      onTap: () {
                        _addCartController.selectedDayIndex.value = index;
                        _addCartController.dayTimeSlots.value?.day =
                            _addCartController.deliverySlots[index]?.day ?? 0;

                        _addCartController.timeTitleCustom.value =
                            _addCartController.weekDayList[index].day ?? '';
                        _addCartController.dayIndexForTimeSlot.value =
                            _addCartController.weekDayList[index].value!;
                      },
                      child: Container(
                        width: 40.w,
                        decoration: BoxDecoration(
                          color:
                              // _addCartController.selectedDayIndex.value == index
                              //     ? AppConst.darkGreen
                              //     :
                              AppConst.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              width: 2,
                              color:
                                  _addCartController.selectedDayIndex.value ==
                                          index
                                      ? AppConst.green
                                      : AppConst.lightGrey),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 0.2.h),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _addCartController.weekDayList[index].date ??
                                      '',
                                  style: TextStyle(
                                    fontSize:
                                        SizeUtils.horizontalBlockSize * 3.5,
                                    fontFamily: 'MuseoSans',
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                    color:
                                        // _addCartController
                                        //             .selectedDayIndex.value ==
                                        //         index
                                        //     ? AppConst.white
                                        // :
                                        AppConst.black,
                                  ),
                                ),
                                SizedBox(
                                  height: 0.5.h,
                                ),
                                Text(
                                  index == 0
                                      ? "Today"
                                      : _addCartController
                                          .weekDayList[index].day
                                          .toString()
                                          .substring(0, 3)
                                          .toUpperCase(),
                                  style: TextStyle(
                                    fontSize: SizeUtils.horizontalBlockSize * 3,
                                    fontFamily: 'MuseoSans',
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                    color:
                                        // _addCartController
                                        //             .selectedDayIndex.value ==
                                        //         index
                                        //     ? AppConst.white
                                        //     :
                                        AppConst.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  String getTemp1(index) {
    var date1 =
        "${(_addCartController.remainingSlotForDay![index].startTime?.hour ?? 0) > 12 ? ((_addCartController.remainingSlotForDay![index].startTime?.hour ?? 0) - 12) : _addCartController.remainingSlotForDay![index].startTime?.hour}:${_addCartController.remainingSlotForDay![index].startTime?.minute}";
    var date2 =
        (_addCartController.remainingSlotForDay![index].startTime?.hour ?? 0) >
                12
            ? "PM - "
            : "AM - ";

    var date3 =
        "${(_addCartController.remainingSlotForDay![index].endTime?.hour ?? 0) > 12 ? ((_addCartController.remainingSlotForDay![index].endTime?.hour ?? 0) - 12) : _addCartController.remainingSlotForDay![index].endTime?.hour}:${_addCartController.remainingSlotForDay![index].endTime?.minute}";
    var date4 =
        (_addCartController.remainingSlotForDay![index].endTime?.hour ?? 0) > 12
            ? "PM"
            : "AM";

    var lastText = date1 + date2 + date3 + date4;
    return lastText;
  }

  String getTempNextDay(index) {
    var date1 =
        "${(_addCartController.nextDaySlots![index].startTime?.hour ?? 0) > 12 ? ((_addCartController.nextDaySlots![index].startTime?.hour ?? 0) - 12) : _addCartController.nextDaySlots![index].startTime?.hour}:${_addCartController.nextDaySlots![index].startTime?.minute}";
    var date2 =
        (_addCartController.nextDaySlots![index].startTime?.hour ?? 0) > 12
            ? "PM - "
            : "AM - ";

    var date3 =
        "${(_addCartController.nextDaySlots![index].endTime?.hour ?? 0) > 12 ? ((_addCartController.nextDaySlots![index].endTime?.hour ?? 0) - 12) : _addCartController.nextDaySlots![index].endTime?.hour}:${_addCartController.nextDaySlots![index].endTime?.minute}";
    var date4 =
        (_addCartController.nextDaySlots![index].endTime?.hour ?? 0) > 12
            ? "PM"
            : "AM";

    var lastText = date1 + date2 + date3 + date4;
    return lastText;
  }

  String getTemp(index) {
    var date1 =
        "${(_addCartController.getOrderConfirmPageDataModel.value?.data?.deliverySlots?[_addCartController.dayIndexForTimeSlot.value].slots?[index].startTime?.hour ?? 0) > 12 ? ((_addCartController.getOrderConfirmPageDataModel.value?.data?.deliverySlots?[_addCartController.dayIndexForTimeSlot.value].slots?[index].startTime?.hour ?? 0) - 12) : _addCartController.getOrderConfirmPageDataModel.value?.data?.deliverySlots?[_addCartController.dayIndexForTimeSlot.value].slots?[index].startTime?.hour}:${_addCartController.getOrderConfirmPageDataModel.value?.data?.deliverySlots?[_addCartController.dayIndexForTimeSlot.value].slots?[index].startTime?.minute}";
    var date2 = (_addCartController
                    .getOrderConfirmPageDataModel
                    .value
                    ?.data
                    ?.deliverySlots?[
                        _addCartController.dayIndexForTimeSlot.value]
                    .slots?[index]
                    .startTime
                    ?.hour ??
                0) >
            12
        ? "PM - "
        : "AM - ";

    var date3 =
        "${(_addCartController.getOrderConfirmPageDataModel.value?.data?.deliverySlots?[_addCartController.dayIndexForTimeSlot.value].slots?[index].endTime?.hour ?? 0) > 12 ? ((_addCartController.getOrderConfirmPageDataModel.value?.data?.deliverySlots?[_addCartController.dayIndexForTimeSlot.value].slots?[index].endTime?.hour ?? 0) - 12) : _addCartController.getOrderConfirmPageDataModel.value?.data?.deliverySlots?[_addCartController.dayIndexForTimeSlot.value].slots?[index].endTime?.hour}:${_addCartController.getOrderConfirmPageDataModel.value?.data?.deliverySlots?[_addCartController.dayIndexForTimeSlot.value].slots?[index].endTime?.minute}";
    var date4 = (_addCartController
                    .getOrderConfirmPageDataModel
                    .value
                    ?.data
                    ?.deliverySlots?[
                        _addCartController.dayIndexForTimeSlot.value]
                    .slots?[index]
                    .endTime
                    ?.hour ??
                0) >
            12
        ? "PM"
        : "AM";

    var lastText = date1 + date2 + date3 + date4;
    return lastText;
  }

  Widget chooseThirdTimeWidget() {
    return Container(
      height: 7.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: _addCartController.selectTimeSheetIndex.value == 2
            ? Color(0xffe6faf1)
            : AppConst.white,
        border: Border.all(
            color: _addCartController.selectTimeSheetIndex.value == 2
                ? AppConst.green
                : AppConst.grey),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: 0.5.h,
          top: 1.h,
        ),
        child: _addCartController.timeTitleCustom.value.isNotEmpty ||
                _addCartController.timeZoneCustom.value.isNotEmpty
            ? GestureDetector(
                onTap: () {
                  _addCartController.selectTimeSheetIndex.value = 2;
                },
                child: Container(
                  color: AppConst.transparent,
                  child: Row(
                    children: [
                      Radio<int>(
                        activeColor: AppConst.darkGreen,
                        value: (_addCartController.selectTimeSheetIndex.value),
                        groupValue: 2,
                        onChanged: (value) {},
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.ScheduleTimeScreen);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Change Time",
                              style: TextStyle(
                                  color: AppConst.black,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "MuseoSans",
                                  fontStyle: FontStyle.normal,
                                  fontSize: SizeUtils.horizontalBlockSize * 4),
                            ),
                            GestureDetector(
                              // onTap: () {
                              //   Get.toNamed(AppRoutes.ScheduleTimeScreen);
                              // },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${_addCartController.timeTitleCustom.value}",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: 'MuseoSans',
                                      color: AppConst.grey,
                                      fontSize:
                                          SizeUtils.horizontalBlockSize * 3.7,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Text(
                                    "${_addCartController.timeZoneCustom.value}",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: 'MuseoSans',
                                      color: AppConst.grey,
                                      fontSize:
                                          SizeUtils.horizontalBlockSize * 3.7,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            : GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.ScheduleTimeScreen);
                },
                child: Container(
                  color: AppConst.transparent,
                  child: Row(
                    children: [
                      Radio<int>(
                        activeColor: AppConst.darkGreen,
                        value: (_addCartController.selectTimeSheetIndex.value),
                        groupValue: 2,
                        onChanged: (value) {},
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Change Time",
                            style: TextStyle(
                              fontFamily: 'MuseoSans',
                              color: AppConst.black,
                              fontSize: SizeUtils.horizontalBlockSize * 4,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          Text(
                            "Choose Custom Time",
                            style: TextStyle(
                              fontFamily: 'MuseoSans',
                              color: AppConst.grey,
                              fontSize: SizeUtils.horizontalBlockSize * 3.7,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget bottomRow(String title, String value, bool isPlus) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'MuseoSans',
            color: Color(0xff3a3a3a),
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            fontSize: SizeUtils.horizontalBlockSize * 3.5,
          ),
        ),
        Text(
          isPlus ? " \u{20B9}${value}" : " -\u{20B9}${value}",
          style: TextStyle(
            fontFamily: 'MuseoSans',
            color:
                isPlus ? AppConst.black : AppConst.green, //Color(0xffdd2863),
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
            fontSize: SizeUtils.horizontalBlockSize * 3.5,
          ),
        ),
      ],
    );
  }

  Widget _buildPlayerModelList(
      {required IconData iconData,
      required String title,
      required int key,
      required Widget bottomWidget,
      required bool isEnable}) {
    return Container(
      child: IgnorePointer(
        ignoring: !isEnable,
        child: ExpansionTile(
          key: Key(key.toString()),
          initiallyExpanded: key == _addCartController.selectExpendTile.value,
          onExpansionChanged: ((newState) {
            if (newState)
              _addCartController.selectExpendTile.value = key;
            else
              _addCartController.selectExpendTile.value = -1;
          }),
          title: Row(
            children: [
              Icon(
                iconData,
                size: 3.h,
                color: isEnable ? AppConst.black : AppConst.grey,
              ),
              SizedBox(
                width: SizeUtils.verticalBlockSize * 1,
              ),
              Flexible(
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'MuseoSans',
                    fontSize: SizeUtils.horizontalBlockSize * 4,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    color: isEnable ? AppConst.black : AppConst.grey,
                  ),
                ),
              ),
            ],
          ),
          children: <Widget>[
            ListTile(
              title: bottomWidget,
            )
          ],
        ),
      ),
    );
  }

  Widget button({required GestureTapCallback onTap, required String text}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: SizeUtils.horizontalBlockSize * 12,
          decoration: BoxDecoration(
            color: (_addCartController.isTodaySlotsAvailable.value ||
                    _addCartController.isTomorrowSlotsAvailable.value)
                ? AppConst.darkGreen
                : AppConst.grey,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: 'MuseoSans',
                color: AppConst.white,
                fontSize: SizeUtils.horizontalBlockSize * 4,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void launchPayment(int amount, String orderId) async {
    var options = {
      'key': 'rzp_test_n1q5GFiD3BLkNw', //'rzp_test_K5F950Y92Z3p6X',
      'amount': (amount * 100),
      'order_id': orderId,
      'name': 'Seeya',
      'prefill': {'contact': '9876543210', 'email': 'ujjwolmainali7@gmail.com'},
      'external': {'wallets': []}
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      log('e :$e');
    }
  }
}

class DisplayGuaranteeCard extends StatelessWidget {
  const DisplayGuaranteeCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  margin: EdgeInsets.only(left: 2.w, right: 4.w),
                  height: 5.h,
                  width: 10.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    // color: AppConst.white
                  ),
                  child: Image.asset(
                    "assets/images/bestoffer.png",
                    fit: BoxFit.contain,
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "100% satisfaction guarantee",
                    style: TextStyle(
                        fontFamily: 'MuseoSans',
                        color: Color(0xff2b78c6),
                        fontSize: SizeUtils.horizontalBlockSize * 4.5,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                        letterSpacing: -0.7),
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Place your order with peace of mind.",
                        style: TextStyle(
                            fontFamily: 'MuseoSans',
                            color: AppConst.grey,
                            fontSize: SizeUtils.horizontalBlockSize * 3.5,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                            letterSpacing: -0.3),
                      ),
                      Icon(
                        Icons.info,
                        color: AppConst.grey,
                        size: 2.h,
                      )
                    ],
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Container(
              padding: EdgeInsets.only(left: 2.w, top: 1.h, right: 2.w),
              height: 9.h,
              width: 98.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: AppConst.veryLightGrey),
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text:
                      "By placing your order you agree to be bound by the bloyal ",
                  style: TextStyle(
                    fontFamily: 'MuseoSans',
                    color: AppConst.grey,
                    fontSize: SizeUtils.horizontalBlockSize * 3,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                TextSpan(
                  text: "Terms of Services ",
                  style: TextStyle(
                    fontFamily: 'MuseoSans',
                    color: AppConst.green,
                    fontSize: SizeUtils.horizontalBlockSize * 3,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                TextSpan(
                  text: "and ",
                  style: TextStyle(
                    fontFamily: 'MuseoSans',
                    color: AppConst.grey,
                    fontSize: SizeUtils.horizontalBlockSize * 3,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                TextSpan(
                  text: "Privacy Policy ",
                  style: TextStyle(
                    fontFamily: 'MuseoSans',
                    color: AppConst.green,
                    fontSize: SizeUtils.horizontalBlockSize * 3,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                TextSpan(
                  text:
                      ". Your Statement will refelect the final order total after order completion. To know ",
                  style: TextStyle(
                    fontFamily: 'MuseoSans',
                    color: AppConst.grey,
                    fontSize: SizeUtils.horizontalBlockSize * 3,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                TextSpan(
                  text: "Learn more..",
                  style: TextStyle(
                    fontFamily: 'MuseoSans',
                    color: AppConst.green,
                    fontSize: SizeUtils.horizontalBlockSize * 3,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                  ),
                )
              ])),
            ),
          )
        ],
      ),
    );
  }
}

class CheckoutWalletCard extends StatelessWidget {
  CheckoutWalletCard(
      {Key? key, this.ID, this.balance, this.isSelected, this.name})
      : super(key: key);
  String? name;
  String? ID;
  num? balance;
  bool? isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 21.h,
      width: 100.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppConst.veryLightGrey),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
        child: Column(
          children: [
            Container(
              height: 16.h,
              width: 100.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color(0xff36ced8)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 2.w,
                      ),
                      Container(
                        height: 9.h,
                        width: 20.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppConst.white.withOpacity(0.3),
                        ),
                        child: Center(
                          child: Text(
                            (name ?? "S").substring(0, 1),
                            // "S",
                            style: TextStyle(
                              color: AppConst.white,
                              fontWeight: FontWeight.w700,
                              fontFamily: "MuseoSans",
                              fontStyle: FontStyle.normal,
                              fontSize: SizeUtils.horizontalBlockSize * 11,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // height: 5.h,
                            width: 40.w,
                            child: Text(
                              (name ?? ""),
                              // "Sreeja Kirana & GeneralSreeja Kirana & General",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: const Color(0xff006a71),
                                fontWeight: FontWeight.w700,
                                fontFamily: "MuseoSans",
                                fontStyle: FontStyle.normal,
                                fontSize: SizeUtils.horizontalBlockSize * 3.5,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Text(
                            (ID != Null && ID!.length > 6)
                                ? "ID: ${ID?.substring(ID!.length - 6)}"
                                : "ID: 123456",
                            style: TextStyle(
                              color: const Color(0xff00878f),
                              fontWeight: FontWeight.w500,
                              fontFamily: "MuseoSans",
                              fontStyle: FontStyle.normal,
                              fontSize: SizeUtils.horizontalBlockSize * 3.3,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      ClipPath(
                        clipper: Clip1Clipper(),
                        child: Container(
                          height: 12.h,
                          width: 28.w,
                          decoration: BoxDecoration(color: Color(0xffe1ffa2)),
                          child: Center(
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                text: "Balance\n ",
                                style: TextStyle(
                                  color: const Color(0xff6fa400),
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "MuseoSans",
                                  fontStyle: FontStyle.normal,
                                  fontSize: SizeUtils.horizontalBlockSize * 3.5,
                                ),
                              ),
                              TextSpan(
                                  text: "\u{20B9}${balance ?? 0}", // "₹130",
                                  style: TextStyle(
                                    fontFamily: 'MuseoSans',
                                    color: Color(0xff6fa400),
                                    fontSize: SizeUtils.horizontalBlockSize * 6,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                  )),
                            ])),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Text(
                    'Use wallet & Save your money',
                    style: TextStyle(
                      color: Color(0xff008890),
                      fontSize: SizeUtils.horizontalBlockSize * 3.3,
                      fontFamily: 'MuseoSans',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 0.5.h,
                  )
                ],
              ),
            ),
            Spacer(),
            Text("Your Wallet has been applied.",
                style: TextStyle(
                  fontFamily: 'MuseoSans',
                  color: AppConst.green,
                  fontSize: SizeUtils.horizontalBlockSize * 3.5,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                )),
          ],
        ),
      ),
    );
  }
}

class Clip1Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    // path.lineTo(0, size.height);
    path.quadraticBezierTo(0, size.height, 0, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
