import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:customer_app/app/constants/colors.dart';
import 'package:customer_app/app/data/model/order_model.dart';
import 'package:customer_app/screens/history/history_order_tracking_screen.dart';
import 'package:customer_app/screens/home/controller/home_controller.dart';
import 'package:customer_app/widgets/snack.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/screens/wallet/controller/paymentController.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:customer_app/widgets/backButton.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class PayView extends StatefulWidget {
  @override
  State<PayView> createState() => _PayViewState();
}

class _PayViewState extends State<PayView> {
  final PaymentController paycontroller = Get.find();
  final HomeController _homeController = Get.find();
  final TextEditingController amountController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    amountController;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    amountController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dynamic argumentData = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Row(
          children: [
            SizedBox(
              width: 5.w,
            ),
            SizedBox(
              height: 3.5.h,
              child: Image(
                image: AssetImage(
                  'assets/images/Redeem.png',
                ),
              ),
            ),
            SizedBox(
              width: 4.w,
            ),
            Text("Redeem Cash",
                style: TextStyle(
                  fontFamily: 'MuseoSans',
                  color: AppConst.black,
                  fontSize: SizeUtils.horizontalBlockSize * 4.5,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                )),
          ],
        ),
      ),
      body: Obx(
        () => Form(
          key: _formKey,
          child: paycontroller.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 2.h,
                            ),
                            Container(
                              height: 22.h,
                              width: 76.w,
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: argumentData['color'] ??
                                      randomGenerator(),
                                  // circleColors[new Random().nextInt(7)],
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(color: AppConst.grey)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 2.w, vertical: 1.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 1.h, left: 3.w),
                                      width: 20.w,
                                      height: 10.h,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppConst.white.withOpacity(0.1),
                                      ),
                                      child: Center(
                                        child: Text(
                                            paycontroller
                                                    .redeemCashInStorePageDataIndex
                                                    .value
                                                    .name
                                                    ?.substring(0, 1) ??
                                                "",
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: AppConst.white,
                                                fontWeight: FontWeight.w600,
                                                fontStyle: FontStyle.normal,
                                                fontSize: SizeUtils
                                                        .horizontalBlockSize *
                                                    7.5)),
                                      ),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 1.h),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              "Card ID ${paycontroller.redeemCashInStorePageDataIndex.value.sId?.substring((paycontroller.redeemCashInStorePageDataIndex.value.sId?.length ?? 6) - 6) ?? "123456"}",
                                              style: TextStyle(
                                                fontFamily: 'MuseoSans',
                                                color: AppConst.white,
                                                fontSize: SizeUtils
                                                        .horizontalBlockSize *
                                                    4.5,
                                                fontWeight: FontWeight.w500,
                                                fontStyle: FontStyle.normal,
                                              )),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            // ClipRRect(
                            //   borderRadius: BorderRadius.circular(100),
                            //   child: CachedNetworkImage(
                            //     width: 12.w,
                            //     height: 6.h,
                            //     fit: BoxFit.contain,
                            //     imageUrl: paycontroller
                            //             .redeemCashInStorePageDataIndex
                            //             .value
                            //             .logo ??
                            //         'https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg',
                            //     progressIndicatorBuilder: (context, url,
                            //             downloadProgress) =>
                            //         Center(
                            //             child: CircularProgressIndicator(
                            //                 value:
                            //                     downloadProgress.progress)),
                            //     errorWidget: (context, url, error) =>
                            //         Image.network(
                            //             'https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg'),
                            //   ),
                            // ),
                            SizedBox(
                              height: 3.h,
                            ),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                  paycontroller.redeemCashInStorePageDataIndex
                                          .value.name ??
                                      '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: 'MuseoSans',
                                    color: AppConst.black,
                                    fontSize: SizeUtils.horizontalBlockSize * 5,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                    letterSpacing: -0.36,
                                  )),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text("You are Paying",
                                  style: TextStyle(
                                    fontFamily: 'MuseoSans',
                                    color: AppConst.grey,
                                    fontSize:
                                        SizeUtils.horizontalBlockSize * 5.2,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                  )),
                            ),
                            SizedBox(
                              height: 0.5.h,
                            ),
                            TextFormField(
                              validator: (value) => ((value != null &&
                                      value.isEmpty)
                                  ? 'Amount cannot be blank'
                                  : (int.parse(value!) >
                                          (paycontroller
                                                  .redeemCashInStorePageDataIndex
                                                  .value
                                                  .earnedCashback ??
                                              0))
                                      ? "Amount can not be greater than wallet balance"
                                      : null),
                              controller: amountController,
                              cursorHeight: 45,
                              maxLines: 1,
                              maxLength: 11,
                              textDirection: TextDirection.ltr,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              onChanged: (value) {
                                paycontroller.amountText.value = value;
                              },
                              decoration: InputDecoration(
                                counterText: "",
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: -1),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: "\u20b90",
                                hintTextDirection: TextDirection.ltr,
                              ),
                              style: TextStyle(
                                  fontSize: SizeUtils.horizontalBlockSize * 10),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            // TextField(
                            //   controller: paycontroller.descriptionController,
                            //   cursorHeight: 25,
                            //   maxLines: 1,
                            //   maxLength: 25,
                            //   textDirection: TextDirection.ltr,
                            //   keyboardType: TextInputType.text,
                            //   textAlign: TextAlign.center,
                            //   decoration: InputDecoration(
                            //     counterText: "",
                            //     enabledBorder: InputBorder.none,
                            //     focusedBorder: InputBorder.none,
                            //     hintText: "Add Description",
                            //     hintStyle: AppStyles.STORES_SUBTITLE_STYLE,
                            //     hintTextDirection: TextDirection.ltr,
                            //   ),
                            //   style: TextStyle(
                            //       fontSize:
                            //           SizeUtils.horizontalBlockSize * 5),
                            // ),
                            // SizedBox(
                            //   height: 4.h,
                            // ),
                            // Padding(
                            //   padding: EdgeInsets.all(2.h),
                            //   child: Align(
                            //     alignment: Alignment.topLeft,
                            //     child: FittedBox(
                            //       fit: BoxFit.scaleDown,
                            //       child: Text(
                            //         "Pay from",
                            //         style: AppStyles.STORE_NAME_STYLE,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            //   Obx(
                            //     () => Column(
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: [
                            //         // GestureDetector(
                            //         //   onTap: () {
                            //         //     paycontroller.isSelectedWallet.value =
                            //         //         !paycontroller
                            //         //             .isSelectedWallet.value;
                            //         //   },
                            //         //   child: Row(
                            //         //     children: [
                            //         //       Checkbox(
                            //         //         checkColor: AppConst.white,
                            //         //         shape: CircleBorder(),
                            //         //         value: paycontroller
                            //         //             .isSelectedWallet.value,
                            //         //         onChanged: (bool? value) {
                            //         //           if (paycontroller
                            //         //               .isSelectedCard.value) {
                            //         //             paycontroller.isSelectedCard
                            //         //                 .value = false;
                            //         //             paycontroller.isSelectedWallet
                            //         //                 .value = value!;
                            //         //           } else {
                            //         //             paycontroller.isSelectedWallet
                            //         //                 .value = value!;
                            //         //           }
                            //         //         },
                            //         //       ),
                            //         //       Column(
                            //         //         crossAxisAlignment:
                            //         //             CrossAxisAlignment.start,
                            //         //         children: [
                            //         //           Text(
                            //         //             "Wallet balance",
                            //         //             style:
                            //         //                 AppStyles.STORE_NAME_STYLE,
                            //         //           ),
                            //         //           SizedBox(
                            //         //             height: 1.h,
                            //         //           ),
                            //         //           Obx(() => Text(
                            //         //               "You have \u20b9 ${paycontroller.redeemCashInStorePageDataIndex.value.earnedCashback ?? 0.0}")),
                            //         //         ],
                            //         //       ),
                            //         //       Spacer(),
                            //         //       Icon(
                            //         //         Icons.credit_card,
                            //         //         size:
                            //         //             SizeUtils.horizontalBlockSize *
                            //         //                 8,
                            //         //         color: AppConst.blue,
                            //         //       ),
                            //         //       SizedBox(
                            //         //         width: 2.w,
                            //         //       ),
                            //         //     ],
                            //         //   ),
                            //         // ),
                            //         /*   Padding(
                            //   padding: EdgeInsets.only(left: 2.h, right: 2.h, top: 1.h, bottom: 1.h),
                            //   child: Divider(),
                            // ),
                            // GestureDetector(
                            //   onTap: () {
                            //     paycontroller.isSelectedCard.value = !paycontroller.isSelectedCard.value;
                            //   },
                            //   child: Row(
                            //     children: [
                            //       Checkbox(
                            //         checkColor: AppConst.white,
                            //         shape: CircleBorder(),
                            //         value: paycontroller.isSelectedCard.value,
                            //         onChanged: (bool? value) {
                            //           if (paycontroller.isSelectedWallet.value) {
                            //             paycontroller.isSelectedWallet.value = false;
                            //             paycontroller.isSelectedCard.value = value!;
                            //           } else {
                            //             paycontroller.isSelectedCard.value = value!;
                            //           }
                            //         },
                            //       ),
                            //       Column(
                            //         crossAxisAlignment: CrossAxisAlignment.start,
                            //         children: [
                            //           Text(
                            //             "Wallet balance bank account",
                            //             style: AppStyles.STORE_NAME_STYLE,
                            //           ),
                            //           SizedBox(
                            //             height: 1.h,
                            //           ),
                            //           Text("You have \u20b950"),
                            //         ],
                            //       ),
                            //       Spacer(),
                            //       Icon(
                            //         Icons.credit_card_outlined,
                            //         size: SizeUtils.horizontalBlockSize * 8,
                            //         color: Colors.blue,
                            //       ),
                            //       SizedBox(
                            //         width: 2.w,
                            //       ),
                            //     ],
                            //   ),
                            // ),*/
                            //         // Padding(
                            //         //   padding: EdgeInsets.only(
                            //         //       left: 2.h,
                            //         //       right: 2.h,
                            //         //       top: 1.h,
                            //         //       bottom: 1.h),
                            //         //   child: Divider(),
                            //         // ),
                            //         // Padding(
                            //         //   padding: EdgeInsets.all(2.h),
                            //         //   child: Row(
                            //         //     children: [
                            //         //       Icon(Icons.add, color: AppConst.blue),
                            //         //       SizedBox(
                            //         //         width: 2.w,
                            //         //       ),
                            //         //       Text(
                            //         //         'Add a new bank account',
                            //         //         style:
                            //         //             TextStyle(color: AppConst.blue),
                            //         //       )
                            //         //     ],
                            //         //   ),
                            //         // )
                            //         /*  InkWell(
                            //   onTap: () => paycontroller.isSelectedCard.value = !paycontroller.isSelectedCard.value,
                            //   child: ListTile(
                            //     leading: Checkbox(
                            //       checkColor: AppConst.white,
                            //       shape: CircleBorder(),
                            //       value: paycontroller.isSelectedCard.value,
                            //       onChanged: (bool? value) {
                            //         if (paycontroller.isSelectedWallet.value) {
                            //           paycontroller.isSelectedWallet.value = false;
                            //           paycontroller.isSelectedCard.value = value!;
                            //         } else {
                            //           paycontroller.isSelectedCard.value = value!;
                            //         }
                            //       },
                            //     ),
                            //     title: Text(
                            //       "Pay from card",
                            //       style: AppStyles.STORE_NAME_STYLE,
                            //     ),
                            //     subtitle: Container(
                            //       height: SizeUtils.horizontalBlockSize * 6,
                            //       width: SizeUtils.horizontalBlockSize * 45,
                            //       child: TextField(
                            //         keyboardType: TextInputType.number,
                            //         maxLength: 15,
                            //         decoration: InputDecoration(
                            //           counterText: '',
                            //           enabled: true,
                            //         ),
                            //       ),
                            //     ),
                            //     trailing: Container(
                            //       height: SizeUtils.horizontalBlockSize * 15,
                            //       width: SizeUtils.horizontalBlockSize * 10,
                            //       child: Icon(
                            //         Icons.credit_card,
                            //         size: SizeUtils.horizontalBlockSize * 8,
                            //         color: Colors.blue,
                            //       ),
                            //     ),
                            //   ),
                            // )*/
                            //       ],
                            //     ),
                            //   ),
                            /*        IconButton(
                          onPressed: () => showModalBottomSheet(
                              context: context,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(SizeUtils.horizontalBlockSize * 6),
                                topRight: Radius.circular(SizeUtils.horizontalBlockSize * 6),
                              )),
                              builder: (context) {
                                return PaymentBottomSheet();
                              }),
                          icon: Icon(
                            Icons.add,
                            color: Colors.blue,
                          )),
                          SizedBox(
                          height: SizeUtils.horizontalBlockSize * 4.5,
                          ),*/
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Paying from Wallet Balance",
                            style: TextStyle(
                              fontFamily: 'MuseoSans',
                              color: AppConst.grey,
                              fontSize: SizeUtils.horizontalBlockSize * 4,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              letterSpacing: -0.48,
                            )),
                        Obx(() => Text(
                            " \u20b9${paycontroller.redeemCashInStorePageDataIndex.value.earnedCashback ?? 0.0}",
                            style: TextStyle(
                              fontFamily: 'MuseoSans',
                              color: AppConst.black,
                              fontSize: SizeUtils.horizontalBlockSize * 4,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              letterSpacing: -0.48,
                            ))),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Obx(
                        () => InkWell(
                          onTap: () async {
                            final form = _formKey.currentState!;
                            if (form.validate()) {
                              var temp =
                                  double.parse(paycontroller.amountText.value);
                              if (temp > 0) {
                                await paycontroller.redeemBalance(
                                    storeId: (paycontroller
                                            .redeemCashInStorePageDataIndex
                                            .value
                                            .sId ??
                                        ''),
                                    amount: temp);
                                if (paycontroller.orderModel.value != null) {
                                  await Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            HistoryOrderTrackingScreen(
                                          // displayHour: _addCartController.displayHour.value,
                                          order: paycontroller.orderModel.value,
                                        ),
                                      ),
                                      (Route<dynamic> route) => route.isFirst);
                                  _homeController.apiCall();
                                  amountController.clear();
                                  paycontroller.isLoading.value = false;
                                } else {
                                  Snack.bottom(
                                      'Error', 'Failed to Redeem the Cash');
                                  paycontroller.isLoading.value = false;
                                }
                              } else {
                                Get.snackbar(
                                    "", "Please Enter Amount greater than 0");
                              }
                            }

                            // Get.toNamed(AppRoutes.paymentList);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: (paycontroller.amountText.value != "")
                                    ? Color(0xff005b41)
                                    : AppConst.grey,
                                borderRadius: BorderRadius.circular(12)),
                            height: 7.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Icon(Icons.check_circle_outline),
                                Text(" Pay Now",
                                    style: TextStyle(
                                      fontFamily: 'MuseoSans',
                                      color: AppConst.white,
                                      fontSize:
                                          SizeUtils.horizontalBlockSize * 5,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                    )),
                              ],
                            ),
                            // Obx(
                            //   () {
                            //     return Padding(
                            //       padding: EdgeInsets.all(1.h),
                            //       child: ElevatedButton(
                            //         style: ButtonStyle(
                            //           shape: MaterialStateProperty.all<
                            //                   RoundedRectangleBorder>(
                            //               RoundedRectangleBorder(
                            //             borderRadius: BorderRadius.circular(8.0),
                            //             // side: BorderSide(color: Colors.red)
                            //           )),
                            //           backgroundColor: paycontroller
                            //                       .amountText.value.isNotEmpty &&
                            //                   paycontroller.isSelectedWallet.value
                            //               ? MaterialStateProperty.all<Color>(
                            //                   Color(0xff005b41),
                            //                 )
                            //               : MaterialStateProperty.all<Color>(
                            //                   AppConst.grey),
                            //         ),
                            //         onPressed: () async {
                            //           if (paycontroller.formKey.currentState!
                            //               .validate()) {
                            //             var temp = double.parse(
                            //                 paycontroller.amountText.value);
                            //             if (paycontroller.isSelectedWallet.value) {
                            //               await paycontroller.redeemBalance(
                            //                   storeId: (paycontroller
                            //                           .redeemCashInStorePageDataIndex
                            //                           .value
                            //                           .sId ??
                            //                       ''),
                            //                   amount: temp);
                            //               if (paycontroller.redeemBalanceModel.value
                            //                       ?.error ??
                            //                   true) {
                            //                 await _errorDailog(context);
                            //               } else {
                            //                 // Position position = await Geolocator.getCurrentPosition();
                            //                 // LatLng latLng = LatLng(position.latitude, position.longitude);
                            //                 // await paycontroller.getRedeemCashInStorePage(latLng);
                            //                 await _sucessDailog(context);
                            //               }
                            //               paycontroller.amountController.clear();
                            //             }

                            //             // Get.toNamed(AppRoutes.paymentList);
                            //           }
                            //         },
                            //         child: paycontroller.isLoading.value
                            //             ? Row(
                            //                 mainAxisAlignment:
                            //                     MainAxisAlignment.center,
                            //                 children: [
                            //                   Center(
                            //                     child: CircularProgressIndicator(
                            //                       color: AppConst.white,
                            //                     ),
                            //                   ),
                            //                 ],
                            //               )
                            //             : Row(
                            //                 mainAxisAlignment:
                            //                     MainAxisAlignment.center,
                            //                 children: [
                            //                   // Icon(Icons.check_circle_outline),
                            //                   Text(" Pay Now",
                            //                       style: TextStyle(
                            //                         fontFamily: 'MuseoSans',
                            //                         color: AppConst.white,
                            //                         fontSize: SizeUtils
                            //                                 .horizontalBlockSize *
                            //                             5,
                            //                         fontWeight: FontWeight.w700,
                            //                         fontStyle: FontStyle.normal,
                            //                       )),
                            //                 ],
                            //               ),
                            //       ),
                            //     );
                            //   },
                            // ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  // _sucessDailog(BuildContext context) {
  //   AwesomeDialog(
  //     context: context,
  //     animType: AnimType.LEFTSLIDE,
  //     headerAnimationLoop: false,
  //     dialogType: DialogType.SUCCES,
  //     // showCloseIcon: true,
  //     title: 'Success',
  //     desc: 'Payment Successfully',
  //     btnOkOnPress: () {
  //       Get.toNamed(AppRoutes.BaseScreen);
  //       debugPrint('OnClcik');
  //     },
  //     btnOkIcon: Icons.check_circle,
  //     onDissmissCallback: (type) {
  //       debugPrint('Dialog Dismiss from callback $type');
  //     },
  //   ).show();
  // }

  // _errorDailog(BuildContext context) {
  //   AwesomeDialog(
  //     context: context,
  //     dialogType: DialogType.ERROR,
  //     animType: AnimType.RIGHSLIDE,
  //     headerAnimationLoop: true,
  //     title: 'Error',
  //     desc: 'Payment Failed',
  //     btnOkOnPress: () {
  //       paycontroller.isLoading.value = true;
  //       // paycontroller.redeemCashInStorePageDataIndex.value.earnedCashback =
  //       //     paycontroller.redeemBalanceModel.value?.actBalance;
  //       paycontroller.redeemCashInStorePageDataIndex.refresh();
  //       Future.delayed(Duration(seconds: 1))
  //           .then((value) => paycontroller.isLoading.value = false);
  //     },
  //     btnOkIcon: Icons.cancel,
  //     btnOkColor: AppConst.kPrimaryColor,
  //   ).show();
  // }
}
