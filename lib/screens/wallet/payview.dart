import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/screens/wallet/controller/paymentController.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:customer_app/widgets/backButton.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class PayView extends StatelessWidget {
  final PaymentController paycontroller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: paycontroller.formKey,
          child: Obx(
            () => paycontroller.isLoading.value
                ? Center(child: CircularProgressIndicator())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BackButtonWidget(),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: CachedNetworkImage(
                                    width: 12.w,
                                    height: 6.h,
                                    fit: BoxFit.contain,
                                    imageUrl: paycontroller
                                            .redeemCashInStorePageDataIndex
                                            .value
                                            .logo ??
                                        'https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg',
                                    progressIndicatorBuilder: (context, url,
                                            downloadProgress) =>
                                        Center(
                                            child: CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress)),
                                    errorWidget: (context, url, error) =>
                                        Image.network(
                                            'https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg'),
                                  ),
                                ),
                                SizedBox(
                                  height: 0.6.h,
                                ),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    paycontroller.redeemCashInStorePageDataIndex
                                            .value.name ??
                                        '',
                                    style: AppStyles.STORE_NAME_STYLE,
                                  ),
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    "You are Paying",
                                    style: AppStyles.STORES_SUBTITLE_STYLE,
                                  ),
                                ),
                                SizedBox(
                                  height: 0.5.h,
                                ),
                                TextFormField(
                                  validator: (value) => (value?.isEmpty ?? true)
                                      ? 'Amount cannot be blank'
                                      : null,
                                  controller: paycontroller.amountController,
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
                                      fontSize:
                                          SizeUtils.horizontalBlockSize * 10),
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                TextField(
                                  controller:
                                      paycontroller.descriptionController,
                                  cursorHeight: 25,
                                  maxLines: 1,
                                  maxLength: 25,
                                  textDirection: TextDirection.ltr,
                                  keyboardType: TextInputType.text,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    counterText: "",
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: "Add Description",
                                    hintStyle: AppStyles.STORES_SUBTITLE_STYLE,
                                    hintTextDirection: TextDirection.ltr,
                                  ),
                                  style: TextStyle(
                                      fontSize:
                                          SizeUtils.horizontalBlockSize * 5),
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(2.h),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "Pay from",
                                        style: AppStyles.STORE_NAME_STYLE,
                                      ),
                                    ),
                                  ),
                                ),
                                Obx(
                                  () => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          paycontroller.isSelectedWallet.value =
                                              !paycontroller
                                                  .isSelectedWallet.value;
                                        },
                                        child: Row(
                                          children: [
                                            Checkbox(
                                              checkColor: AppConst.white,
                                              shape: CircleBorder(),
                                              value: paycontroller
                                                  .isSelectedWallet.value,
                                              onChanged: (bool? value) {
                                                if (paycontroller
                                                    .isSelectedCard.value) {
                                                  paycontroller.isSelectedCard
                                                      .value = false;
                                                  paycontroller.isSelectedWallet
                                                      .value = value!;
                                                } else {
                                                  paycontroller.isSelectedWallet
                                                      .value = value!;
                                                }
                                              },
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Wallet balance",
                                                  style: AppStyles
                                                      .STORE_NAME_STYLE,
                                                ),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                Obx(() => Text(
                                                    "You have \u20b9 ${paycontroller.redeemCashInStorePageDataIndex.value.earnedCashback ?? 0.0}")),
                                              ],
                                            ),
                                            Spacer(),
                                            Icon(
                                              Icons.credit_card,
                                              size: SizeUtils
                                                      .horizontalBlockSize *
                                                  8,
                                              color: AppConst.blue,
                                            ),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                          ],
                                        ),
                                      ),
                                      /*   Padding(
                                padding: EdgeInsets.only(left: 2.h, right: 2.h, top: 1.h, bottom: 1.h),
                                child: Divider(),
                              ),
                              GestureDetector(
                                onTap: () {
                                  paycontroller.isSelectedCard.value = !paycontroller.isSelectedCard.value;
                                },
                                child: Row(
                                  children: [
                                    Checkbox(
                                      checkColor: AppConst.white,
                                      shape: CircleBorder(),
                                      value: paycontroller.isSelectedCard.value,
                                      onChanged: (bool? value) {
                                        if (paycontroller.isSelectedWallet.value) {
                                          paycontroller.isSelectedWallet.value = false;
                                          paycontroller.isSelectedCard.value = value!;
                                        } else {
                                          paycontroller.isSelectedCard.value = value!;
                                        }
                                      },
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Wallet balance bank account",
                                          style: AppStyles.STORE_NAME_STYLE,
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        Text("You have \u20b950"),
                                      ],
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.credit_card_outlined,
                                      size: SizeUtils.horizontalBlockSize * 8,
                                      color: Colors.blue,
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                  ],
                                ),
                              ),*/
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 2.h,
                                            right: 2.h,
                                            top: 1.h,
                                            bottom: 1.h),
                                        child: Divider(),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(2.h),
                                        child: Row(
                                          children: [
                                            Icon(Icons.add,
                                                color: AppConst.blue),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            Text(
                                              'Add a new bank account',
                                              style: TextStyle(
                                                  color: AppConst.blue),
                                            )
                                          ],
                                        ),
                                      )
                                      /*  InkWell(
                                onTap: () => paycontroller.isSelectedCard.value = !paycontroller.isSelectedCard.value,
                                child: ListTile(
                                  leading: Checkbox(
                                    checkColor: AppConst.white,
                                    shape: CircleBorder(),
                                    value: paycontroller.isSelectedCard.value,
                                    onChanged: (bool? value) {
                                      if (paycontroller.isSelectedWallet.value) {
                                        paycontroller.isSelectedWallet.value = false;
                                        paycontroller.isSelectedCard.value = value!;
                                      } else {
                                        paycontroller.isSelectedCard.value = value!;
                                      }
                                    },
                                  ),
                                  title: Text(
                                    "Pay from card",
                                    style: AppStyles.STORE_NAME_STYLE,
                                  ),
                                  subtitle: Container(
                                    height: SizeUtils.horizontalBlockSize * 6,
                                    width: SizeUtils.horizontalBlockSize * 45,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      maxLength: 15,
                                      decoration: InputDecoration(
                                        counterText: '',
                                        enabled: true,
                                      ),
                                    ),
                                  ),
                                  trailing: Container(
                                    height: SizeUtils.horizontalBlockSize * 15,
                                    width: SizeUtils.horizontalBlockSize * 10,
                                    child: Icon(
                                      Icons.credit_card,
                                      size: SizeUtils.horizontalBlockSize * 8,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              )*/
                                    ],
                                  ),
                                ),
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
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppConst.white,
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 3,
                                offset: Offset(2, 2),
                                color: AppConst.grey)
                          ],
                        ),
                        height: 11.h,
                        child: Obx(
                          () {
                            return Padding(
                              padding: EdgeInsets.all(2.4.h),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: paycontroller
                                              .amountText.value.isNotEmpty &&
                                          paycontroller.isSelectedWallet.value
                                      ? MaterialStateProperty.all<Color>(
                                          AppConst.kSecondaryColor)
                                      : MaterialStateProperty.all<Color>(
                                          AppConst.grey),
                                ),
                                onPressed: () async {
                                  if (paycontroller.formKey.currentState!
                                      .validate()) {
                                    var temp = double.parse(
                                        paycontroller.amountText.value);
                                    if (paycontroller.isSelectedWallet.value) {
                                      await paycontroller.redeemBalance(
                                          storeId: (paycontroller
                                                  .redeemCashInStorePageDataIndex
                                                  .value
                                                  .sId ??
                                              ''),
                                          amount: temp);
                                      if (paycontroller.redeemBalanceModel.value
                                              ?.error ??
                                          true) {
                                        await _errorDailog(context);
                                      } else {
                                        // Position position = await Geolocator.getCurrentPosition();
                                        // LatLng latLng = LatLng(position.latitude, position.longitude);
                                        // await paycontroller.getRedeemCashInStorePage(latLng);
                                        await _sucessDailog(context);
                                      }
                                      paycontroller.amountController.clear();
                                    }

                                    // Get.toNamed(AppRoutes.paymentList);
                                  }
                                },
                                child: paycontroller.isLoading.value
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: CircularProgressIndicator(
                                              color: AppConst.white,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.check_circle_outline),
                                          Text(" Pay"),
                                        ],
                                      ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  _sucessDailog(BuildContext context) {
    AwesomeDialog(
      context: context,
      animType: AnimType.LEFTSLIDE,
      headerAnimationLoop: false,
      dialogType: DialogType.SUCCES,
      // showCloseIcon: true,
      title: 'Success',
      desc: 'Payment Successfully',
      btnOkOnPress: () {
        Get.toNamed(AppRoutes.BaseScreen);
        debugPrint('OnClcik');
      },
      btnOkIcon: Icons.check_circle,
      onDissmissCallback: (type) {
        debugPrint('Dialog Dismiss from callback $type');
      },
    ).show();
  }

  _errorDailog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      animType: AnimType.RIGHSLIDE,
      headerAnimationLoop: true,
      title: 'Error',
      desc: 'Payment Failed',
      btnOkOnPress: () {
        paycontroller.isLoading.value = true;
        paycontroller.redeemCashInStorePageDataIndex.value.earnedCashback =
            paycontroller.redeemBalanceModel.value?.actBalance;
        paycontroller.redeemCashInStorePageDataIndex.refresh();
        Future.delayed(Duration(seconds: 1))
            .then((value) => paycontroller.isLoading.value = false);
      },
      btnOkIcon: Icons.cancel,
      btnOkColor: AppConst.kPrimaryColor,
    ).show();
  }
}
