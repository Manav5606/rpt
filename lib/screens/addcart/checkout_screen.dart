import 'dart:developer';

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
  final HomeController _homeController = Get.find();
  late Razorpay _razorpay;
  int selectExpandeIndex = 0;

  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
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
          ''),
      store: _addCartController.store.value,
      cartId: _addCartController.cartId.value,
      products: _addCartController.reviewCart.value?.data?.products,
      rawItem: _addCartController.reviewCart.value?.data?.rawItems,
      inventories: _addCartController.reviewCart.value?.data?.inventories,
      deliveryTimeSlot: _addCartController.dayTimeSlots.value,
      walletAmount:
          _addCartController.reviewCart.value?.data?.walletAmount ?? 0,
      deliveryFee: _addCartController
              .getOrderConfirmPageDataModel.value?.data?.deliveryFee ??
          0,
      packagingFee: _addCartController
              .getOrderConfirmPageDataModel.value?.data?.packagingFee ??
          0,
      razorPayPaymentId: response?.paymentId ?? '',
      razorPayOrderId: response?.orderId ?? '',
      razorPaySignature: response?.signature ?? '',
      lat: _addCartController.selectAddressIndex.value?.location?.lat ?? 0,
      lng: _addCartController.selectAddressIndex.value?.location?.lng ?? 0,
      address: _addCartController.selectAddressIndex.value?.address ?? '',
    );
    if (_addCartController.orderModel.value != null) {
      _addCartController.formatDate();
      await Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => OrderTreckScreen(
              displayHour: _addCartController.displayHour.value,
              order: _addCartController.orderModel.value!,
            ),
          ),
          (Route<dynamic> route) => route.isFirst);
      _homeController.apiCall();
    }
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    //todo handle external wallets
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: EdgeInsets.only(left: SizeUtils.horizontalBlockSize * 1.8),
          child: InkWell(
            onTap: () async {
              Get.back();
              // await _exploreController.getStoreData(id: _addCartController.store.value?.sId ?? '');
            },
            child: Icon(
              Icons.clear,
              color: AppConst.black,
              size: SizeUtils.horizontalBlockSize * 7.65,
            ),
          ),
        ),
        actions: [
          Center(
            child: Padding(
              padding:
                  EdgeInsets.only(right: SizeUtils.horizontalBlockSize * 3),
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Text(
                  "My Carts",
                  style: TextStyle(
                    color: AppConst.grey,
                    fontSize: SizeUtils.horizontalBlockSize * 4,
                  ),
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
      body: Padding(
        padding: EdgeInsets.all(SizeUtils.horizontalBlockSize * 2),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Obx(
                  () => Column(
                    key: Key(
                        'builder ${_addCartController.selectExpendTile.value.toString()}'),
                    children: [
                      _buildPlayerModelList(
                        iconData: Icons.location_on_rounded,
                        title: _addCartController
                                    .selectAddressHouse.value.isNotEmpty ||
                                _addCartController
                                    .selectAddress.value.isNotEmpty
                            ? "${_addCartController.selectAddressHouse.value} ${_addCartController.selectAddress.value}"
                            : StringContants.addDeliveryAddresses,
                        bottomWidget: addressView(context),
                        isEnable: true,
                        key: 0,
                      ),
                      _buildPlayerModelList(
                        iconData: Icons.account_balance_wallet_outlined,
                        title: StringContants.walletAmount,
                        bottomWidget: walletAmountView(context),
                        isEnable: _addCartController
                                .selectAddressHouse.value.isNotEmpty ||
                            _addCartController.selectAddress.value.isNotEmpty,
                        key: 1,
                      ),
                      _buildPlayerModelList(
                        iconData: Icons.timer,
                        title:
                            _addCartController.deliveryMessage.value.isNotEmpty
                                ? _addCartController.deliveryMessage.value
                                : StringContants.chooseDeliveryTime,
                        bottomWidget: timeSheetView(context),
                        isEnable: _addCartController
                                .selectAddressHouse.value.isNotEmpty ||
                            _addCartController.selectAddress.value.isNotEmpty,
                        key: 2,
                      ),
                      _buildPlayerModelList(
                          iconData: Icons.payment,
                          title: StringContants.paymentMode,
                          bottomWidget: paymentMode(),
                          key: 3,
                          isEnable: _addCartController
                              .deliveryMessage.value.isNotEmpty),
                      payView(),
                    ],
                  ),
                ),
              ),
            ),
            Obx(
              () => GestureDetector(
                onTap: () async {
                  if (_addCartController.selectPaymentMode.value == 'paynow') {
                    await _addCartController.createRazorPayOrder(
                        storeId: _addCartController.store.value?.sId ?? '',
                        amount: _addCartController
                                .getOrderConfirmPageDataModel.value?.data?.total
                                ?.toDouble() ??
                            00);
                    if (_addCartController.createRazorpayResponseModel.value !=
                        null) {
                      launchPayment(
                          _addCartController.getOrderConfirmPageDataModel.value
                                  ?.data?.total
                                  ?.toInt() ??
                              00,
                          _addCartController
                                  .createRazorpayResponseModel.value?.orderId ??
                              '');
                    } else {
                      Get.showSnackbar(GetBar(
                        message: "failed to create razor order",
                        duration: Duration(seconds: 2),
                      ));
                    }
                  } else {
                    finalPlaceOrder();
                  }
                },
                // onTap: onTap,
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
                              "Go to CheckOut",
                              style: TextStyle(
                                color: AppConst.white,
                                fontSize: SizeUtils.horizontalBlockSize * 4,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppConst.darkGrey,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        SizeUtils.horizontalBlockSize * 3,
                                    vertical: SizeUtils.verticalBlockSize * 1),
                                child: Text(
                                  "\u{20B9}${_addCartController.getOrderConfirmPageDataModel.value?.data?.total.toString() ?? ''}",
                                  style: TextStyle(
                                    color: AppConst.white,
                                    fontSize: SizeUtils.horizontalBlockSize * 3,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
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
      await _addCartController.getCartPageInformation(
        storeId: _addCartController.store.value?.sId ?? '',
      );

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
        children: [
          RadioListTile(
            title: Text("Pay Now"),
            value: "paynow",
            groupValue: _addCartController.selectPaymentMode.value,
            onChanged: (value) {
              _addCartController.selectPaymentMode.value = value.toString();
            },
          ),
          RadioListTile(
            title: Text("Pay by Cash"),
            value: "paybycash",
            groupValue: _addCartController.selectPaymentMode.value,
            onChanged: (value) {
              _addCartController.selectPaymentMode.value = value.toString();
            },
          ),
        ],
      ),
    );
  }

  Widget walletAmountView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RadioListTile(
          title: Text("Any offers around you"),
          value: "offer",
          groupValue: _addCartController.selectPaymentMode.value,
          onChanged: (value) {
            _addCartController.selectPaymentMode.value = value.toString();
          },
        ),
        Row(
          children: [
            Expanded(child: Text("Wallet Amount")),
            Text(
                "${_addCartController.getCartPageInformationModel.value?.data?.walletAmount ?? 0}"),
          ],
        ),
        Obx(
          () => Row(
            children: [
              Flexible(
                child: RadioListTile(
                  title: Text("Yes"),
                  value: "yes",
                  groupValue: _addCartController.selectWalletMode.value,
                  onChanged: (value) {
                    _addCartController.selectWalletMode.value =
                        value.toString();
                  },
                ),
              ),
              Flexible(
                child: RadioListTile(
                  title: Text("No"),
                  value: "no",
                  groupValue: _addCartController.selectWalletMode.value,
                  onChanged: (value) {
                    _addCartController.selectWalletMode.value =
                        value.toString();
                  },
                ),
              ),
            ],
          ),
        ),
        button(
            onTap: () async {
              await _addCartController.getOrderConfirmPageData(
                  storeId: _addCartController.store.value?.sId ?? '',
                  distance: 0,
                  products: _addCartController.reviewCart.value?.data?.products,
                  inventories:
                      _addCartController.reviewCart.value?.data?.inventories,
                  walletAmount:
                      _addCartController.selectWalletMode.value == 'true'
                          ? _addCartController
                                  .reviewCart.value?.data?.walletAmount ??
                              0.0
                          : 0);
              _addCartController.selectExpendTile.value = 2;
            },
            text: "Choose Wallet")
      ],
    );
  }

  Widget timeSheetView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          StringContants.chooseDeliveryTime,
          style: TextStyle(
            fontSize: SizeUtils.horizontalBlockSize * 4.5,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: SizeUtils.horizontalBlockSize * 1.5),
        chooseSecondTimeWidget(),
        SizedBox(height: SizeUtils.horizontalBlockSize * 1.5),
        chooseThirdTimeWidget(),
        SizedBox(height: SizeUtils.horizontalBlockSize * 1.5),
        button(
          onTap: () {
            if (_addCartController.selectTimeSheetIndex.value == 1) {
              _addCartController.timeSlots.value = _addCartController
                  .getCartPageInformationModel
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
          },
          text: "Choose Time",
        )
      ],
    );
  }

  Widget payView() {
    return Column(
      children: [
        SizedBox(height: SizeUtils.horizontalBlockSize * 2),
        bottomRow(
            'Total Amount',
            (_addCartController.getOrderConfirmPageDataModel.value?.data
                        ?.previousTotalAmount ??
                    '0')
                .toString()),
        SizedBox(height: SizeUtils.horizontalBlockSize * 2),
        Divider(
          height: 0,
        ),
        SizedBox(height: SizeUtils.horizontalBlockSize * 2),
        bottomRow(
            'Gst Amount',
            (_addCartController.getOrderConfirmPageDataModel.value?.data
                        ?.totalGstAmount ??
                    '0')
                .toString()),
        SizedBox(height: SizeUtils.horizontalBlockSize * 2),
        Divider(
          height: 0,
        ),
        SizedBox(height: SizeUtils.horizontalBlockSize * 2),
        bottomRow(
            'Packaging Fee',
            (_addCartController.getOrderConfirmPageDataModel.value?.data
                        ?.packagingFee ??
                    '0')
                .toString()),
        SizedBox(height: SizeUtils.horizontalBlockSize * 2),
        bottomRow(
            'Wallet Amount',
            (_addCartController.getCartPageInformationModel.value?.data
                        ?.walletAmount ??
                    '0')
                .toString()),
        SizedBox(height: SizeUtils.horizontalBlockSize * 2),
      ],
    );
  }

  Widget chooseSecondTimeWidget() {
    return Obx(
      () => GestureDetector(
        onTap: () {
          _addCartController.selectTimeSheetIndex.value = 1;
        },
        child: Container(
          height: SizeUtils.horizontalBlockSize * 16,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
                color: _addCartController.selectTimeSheetIndex.value == 1
                    ? AppConst.black
                    : AppConst.lightGrey),
          ),
          child: Padding(
            padding: EdgeInsets.all(SizeUtils.horizontalBlockSize * 2),
            child: Row(
              children: [
                Icon(Icons.directions_car),
                SizedBox(width: SizeUtils.horizontalBlockSize * 2),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _addCartController.displayHour.value,
                      style: TextStyle(
                          fontSize: SizeUtils.horizontalBlockSize * 4),
                    ),
                    Text(
                      "Standard",
                      style: TextStyle(
                          fontSize: SizeUtils.horizontalBlockSize * 4),
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

  Widget chooseThirdTimeWidget() {
    return Container(
      height: SizeUtils.horizontalBlockSize * 16,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
            color: _addCartController.selectTimeSheetIndex.value == 2
                ? AppConst.black
                : AppConst.lightGrey),
      ),
      child: Padding(
        padding: EdgeInsets.all(SizeUtils.horizontalBlockSize * 2),
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
                      Icon(
                        Icons.timer,
                        color: AppConst.black,
                      ),
                      SizedBox(width: 2.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.ScheduleTimeScreen);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "${_addCartController.timeTitleCustom.value}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: AppConst.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize:
                                          SizeUtils.horizontalBlockSize * 4),
                                ),
                                SizedBox(
                                  width: SizeUtils.horizontalBlockSize * 2,
                                ),
                                Text(
                                  "${_addCartController.timeZoneCustom.value}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: AppConst.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize:
                                          SizeUtils.horizontalBlockSize * 4),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: SizeUtils.horizontalBlockSize * 1,
                          ),
                          Text(
                            "Change",
                            style: TextStyle(
                                fontSize: SizeUtils.horizontalBlockSize * 4),
                          ),
                        ],
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
                      Icon(Icons.calendar_today_outlined),
                      SizedBox(width: SizeUtils.horizontalBlockSize * 2),
                      Text(
                        "Schedule a time",
                        style: TextStyle(
                            fontSize: SizeUtils.horizontalBlockSize * 4),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Icon(Icons.arrow_forward_ios,
                          size: SizeUtils.horizontalBlockSize * 4),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget bottomRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: SizeUtils.horizontalBlockSize * 4.5,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: SizeUtils.horizontalBlockSize * 4.5,
            fontWeight: FontWeight.bold,
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
    return Card(
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
                color: isEnable ? AppConst.themeBlue : AppConst.grey,
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
                    fontSize: SizeUtils.horizontalBlockSize * 4.5,
                    fontWeight: FontWeight.bold,
                    color: isEnable ? null : AppConst.grey,
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
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: SizeUtils.horizontalBlockSize * 12,
          decoration: BoxDecoration(
            color: AppConst.kSecondaryColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
              child: Text(
            text,
            style: TextStyle(
                color: AppConst.white,
                fontSize: SizeUtils.horizontalBlockSize * 4),
          )),
        ),
      ),
    );
  }

  void launchPayment(int amount, String orderId) async {
    var options = {
      'key': 'rzp_test_K5F950Y92Z3p6X',
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
