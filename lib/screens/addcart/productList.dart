import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/data/model/order_model.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/screens/addcart/controller/addcart_controller.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class ProductRawItemScreen extends StatefulWidget {
  final OrderData order;

  const ProductRawItemScreen({Key? key, required this.order}) : super(key: key);

  @override
  State<ProductRawItemScreen> createState() => _ProductRawItemScreenState();
}

class _ProductRawItemScreenState extends State<ProductRawItemScreen> {
  @override
  List<Products> _modifyList = [];
  final AddCartController _addCartController = Get.find();
  late Razorpay _razorpay;

  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    checkProduct();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    //todo handle paymentError
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    log("response signature :${response.signature ?? ''}");
    log("response  orderId:${response.orderId ?? ''}");
    log("response  paymentId:${response.paymentId ?? ''}");

    //
    bool error = await _addCartController.placeOrderActive(
      store: widget.order.Id ?? '',
      razorPayPaymentId: response.paymentId ?? '',
      razorPayOrderId: response.orderId ?? '',
      razorPaySignature: response.signature ?? '',
    );
    if (error) {
      log('Error Failed to send order');
    } else {
      _addCartController.isPaymentDone.value = true;
      Get.back();
      log('Confirmed Order Sent Successfully');
    }
    //todo handle PaymentSuccess
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    //todo handle external wallets
  }

  checkProduct() {
    try {
      _modifyList.clear();
      widget.order.products?.forEach((element) {
        if (element.modified == true || element.deleted == true) {
          log('_list   before:${_modifyList.length}');
          _modifyList.add(element);
          log('_list   after:${_modifyList.length}');
        }
      });
    } catch (e, st) {
      log('e :$e st $st');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConst.transparent,
        elevation: 00,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.clear,
            color: AppConst.green,
            size: SizeUtils.verticalBlockSize * 3,
          ),
        ),
        centerTitle: true,
        title: Column(
          children: [
            Text(
              'My Items',
              style: TextStyle(
                  color: AppConst.black,
                  fontSize: SizeUtils.horizontalBlockSize * 4,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              'Rainbow Grocery - Delivery @ 12 PM - 1 PM',
              style: TextStyle(
                  color: AppConst.grey,
                  fontSize: SizeUtils.horizontalBlockSize * 3.5,
                  fontWeight: FontWeight.w700),
            )
          ],
        ),
        actions: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeUtils.horizontalBlockSize * 4),
              child: Text(
                'Chat',
                style: TextStyle(
                    color: AppConst.green,
                    fontSize: SizeUtils.horizontalBlockSize * 5,
                    fontWeight: FontWeight.w400),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: SizeUtils.verticalBlockSize * 3,
                  color: AppConst.grey.withOpacity(0.15),
                ),
                const SizedBox(
                  height: 18,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.rate_review_outlined,
                        size: 30,
                        color: AppConst.grey,
                      ),
                      SizedBox(
                        width: SizeUtils.horizontalBlockSize * 3,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Review 1 change to your order',
                            style: TextStyle(
                                color: AppConst.black.withOpacity(0.6),
                                fontWeight: FontWeight.w700,
                                fontSize: SizeUtils.horizontalBlockSize * 5),
                          ),
                          Text(
                            '4 of 9 items shopped',
                            style: TextStyle(
                                color: AppConst.grey.withOpacity(0.7),
                                fontWeight: FontWeight.w700,
                                fontSize: SizeUtils.horizontalBlockSize * 4),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeUtils.horizontalBlockSize * 4,
                ),
                Container(
                  width: double.infinity,
                  height: SizeUtils.verticalBlockSize * 3,
                  color: AppConst.grey.withOpacity(0.15),
                ),
                SizedBox(
                  height: SizeUtils.horizontalBlockSize * 4,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeUtils.horizontalBlockSize * 4),
                  child: Row(
                    children: [
                      Icon(
                        Icons.stars,
                        color: AppConst.orange,
                        size: SizeUtils.horizontalBlockSize * 6,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Replacement',
                        style: TextStyle(
                            color: AppConst.orange,
                            fontSize: SizeUtils.horizontalBlockSize * 6,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.5),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeUtils.horizontalBlockSize * 2,
                ),
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: _modifyList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeUtils.horizontalBlockSize * 4),
                        child: Row(
                          children: [
                            Text(
                              '$index',
                              style: TextStyle(
                                  color: AppConst.grey,
                                  fontWeight: FontWeight.w700,
                                  fontSize: SizeUtils.horizontalBlockSize * 5),
                            ),
                            SizedBox(
                              width: SizeUtils.horizontalBlockSize * 5,
                            ),
                            Image.asset(
                              'assets/images/image1.png',
                              height: SizeUtils.horizontalBlockSize * 12,
                            ),
                            SizedBox(
                              width: SizeUtils.horizontalBlockSize * 2,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _modifyList[index].deleted == true
                                    ? Text(
                                        'Out of Stock',
                                        style: TextStyle(
                                            color: AppConst.kPrimaryColor
                                                .withOpacity(0.7),
                                            fontSize:
                                                SizeUtils.horizontalBlockSize *
                                                    4,
                                            fontWeight: FontWeight.w500),
                                      )
                                    : const SizedBox(),
                                Text(
                                  "${_modifyList[index].name ?? ''}",
                                  style: TextStyle(
                                    color: AppConst.grey,
                                    fontSize: SizeUtils.horizontalBlockSize * 5,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  height: SizeUtils.verticalBlockSize * 1,
                                ),
                                Text(
                                  "${_modifyList[index].quantity ?? ''}",
                                  style: TextStyle(
                                    color: AppConst.grey.withOpacity(0.6),
                                    fontSize: SizeUtils.horizontalBlockSize * 4,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              "\$${_modifyList[index].sellingPrice ?? ''}",
                              style: TextStyle(
                                  color: AppConst.black.withOpacity(0.6),
                                  fontWeight: FontWeight.w800,
                                  fontSize: SizeUtils.horizontalBlockSize * 4),
                            ),
                            SizedBox(
                              width: SizeUtils.horizontalBlockSize * 4,
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: AppConst.grey,
                              size: 20,
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                          height: SizeUtils.horizontalBlockSize * 1);
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: SizeUtils.horizontalBlockSize * 1,
          ),
          GestureDetector(
            onTap: () async {
              await _addCartController.createRazorPayOrder(
                  storeId: widget.order.Id ?? '',
                  amount: widget.order.total?.toDouble() ?? 00);
              if (_addCartController.createRazorpayResponseModel.value !=
                  null) {
                launchPayment(
                    widget.order.total?.toInt() ?? 00,
                    _addCartController
                            .createRazorpayResponseModel.value?.orderId ??
                        '');
              } else {
                Get.showSnackbar(GetBar(
                  message: "failed to create razor order",
                  duration: Duration(seconds: 2),
                ));
              }
            },
            child: Container(
              color: AppConst.green,
              width: double.infinity,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(SizeUtils.horizontalBlockSize * 4),
                  child: Text(
                    "Review and MakePayment",
                    style: TextStyle(
                        fontSize: SizeUtils.horizontalBlockSize * 4,
                        color: AppConst.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
          // Container(
          //   height: SizeUtils.verticalBlockSize * 6.5,
          //   decoration: BoxDecoration(color: AppConst.grey.withOpacity(0.3)),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: [
          //       Flexible(
          //         child: Center(
          //           child: Text(
          //             'Other options...',
          //             style: TextStyle(
          //               color: Colors.blueGrey.withOpacity(0.7),
          //               fontSize: SizeUtils.horizontalBlockSize * 5,
          //               fontWeight: FontWeight.w600,
          //             ),
          //           ),
          //         ),
          //       ),
          //       Flexible(
          //         child: Center(
          //           child: Text(
          //             'Approve',
          //             style: TextStyle(
          //               color: Colors.blueGrey,
          //               fontSize: SizeUtils.horizontalBlockSize * 5,
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //         ),
          //       )
          //     ],
          //   ),
          // )
        ],
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
