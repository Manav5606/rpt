import 'dart:math';

import 'package:customer_app/app/constants/colors.dart';
import 'package:customer_app/app/utils/utils.dart';
import 'package:customer_app/screens/more_stores/morestore_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/controller/my_wallet_controller.dart';
import 'package:customer_app/app/data/model/my_wallet_model.dart';

import 'package:customer_app/app/ui/common/loader.dart';
import 'package:customer_app/app/ui/pages/my_wallet/wallet_details_screen_shimmer.dart';
import 'package:customer_app/app/ui/pages/search/controller/exploreContoller.dart';
import 'package:customer_app/constants/app_const.dart';

import 'package:customer_app/models/getRedeemCashStorePageDataModel.dart';

import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/screens/scanReceipt/storeview_screen.dart';
import 'package:customer_app/screens/wallet/controller/paymentController.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:customer_app/widgets/backButton.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class WalletDetailsScreen extends StatelessWidget {
  WalletDetailsScreen({
    Key? key,
  }) : super(key: key);

  final MyWalletController _myWalletController = Get.find();

  final PaymentController _paymentController = Get.find();

  @override
  Widget build(BuildContext context) {
    return WalletTransactionCard(
      walletData: _myWalletController.myWallet.value,
      storeSearchModel: _paymentController.redeemCashInStorePageDataIndex.value,
    );
  }
}

class WalletTransactionCard extends StatelessWidget {
  WalletTransactionCard(
      {Key? key, required this.walletData, required this.storeSearchModel})
      : super(key: key);
  final MyWalletController _myWalletController = Get.find();
  final PaymentController _paymentController = Get.find();
  final ExploreController _exploreController = Get.find();
  final MoreStoreController _moreStoreController = Get.find();

  final WalletData? walletData;
  final RedeemCashInStorePageData storeSearchModel;

  @override
  Widget build(BuildContext context) {
    dynamic argumentData = Get.arguments;
    Color color = argumentData['color'];
    String name = argumentData['name'] ?? "S";
    String logo = argumentData['logo'] ?? "";

    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => _myWalletController.isTransactionLoading.value
              ? Center(child: WalletDetailScreenShimmer())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BackButtonWidget(),
                          SizedBox(
                            width: 2.w,
                          ),
                          (logo).isEmpty
                              ? CircleAvatar(
                                  child: Text(name.substring(0, 1),
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: AppConst.white,
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FontStyle.normal,
                                          fontSize:
                                              SizeUtils.horizontalBlockSize *
                                                  6)),
                                  backgroundColor: color,
                                  radius: SizeUtils.horizontalBlockSize * 6.5,
                                )
                              : CircleAvatar(
                                  backgroundImage: NetworkImage(logo),
                                  backgroundColor: AppConst.white,
                                  radius: SizeUtils.horizontalBlockSize * 6.5,
                                ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Expanded(
                            child: Text(
                              "${name}",
                              style: TextStyle(
                                  color: AppConst.black,
                                  fontSize: SizeUtils.horizontalBlockSize * 5),
                            ),
                          ),
                        ],
                      ),
                    ),
                    WalletDetailCard(color),
                    SizedBox(
                      height: 3.h,
                      child: Center(
                        child: Container(
                          child: Text(
                            " ", //Transactions
                            style: TextStyle(
                                color: AppConst.black,
                                fontSize: SizeUtils.horizontalBlockSize * 4),
                          ),
                          // color: Colors.red,
                        ),
                      ),
                    ),
                    Flexible(
                      child: (_myWalletController.myWalletTransactionModel.value
                                  ?.data?.isNotEmpty !=
                              true)
                          ? EmptyScreen(
                              text1: "Transaction not found for ",
                              text2: "selected store!",
                              icon: Icons.receipt,
                            )
                          :
                          // EmptyOrderScreen(),
                          TransactionList(),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Padding WalletDetailCard(Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
      child: Container(
        height: 25.h,
        width: double.infinity,
        decoration: BoxDecoration(
            color: color,
            border: Border.all(),
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  "\u{20B9} ${walletData?.earnedCashback ?? '0.0'} ",
                  style: TextStyle(
                    color: AppConst.white,
                    fontSize: SizeUtils.horizontalBlockSize * 8,
                  ),
                ),
                Text(
                  "Main wallet",
                  style: TextStyle(
                    color: AppConst.grey,
                    fontSize: SizeUtils.horizontalBlockSize * 4,
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          await _exploreController.getStoreData(
                              id: '${walletData?.sId}',
                              // storeSearchModel.sId.toString(),
                              isScanFunction: true);
                          _paymentController.redeemCashInStorePageDataIndex
                              .value = storeSearchModel;
                          Get.to(() => ScanStoreViewScreen());
                        },
                        child: CircleAvatar(
                          radius: 6.w,
                          foregroundImage: NetworkImage(
                              "https://img.freepik.com/free-vector/tiny-people-using-qr-code-online-payment-isolated-flat-illustration_74855-11136.jpg?t=st=1649328483~exp=1649329083~hmac=5171d5a26cfeb0c063c6afc1f8af8cb4460c207134f830b2ff0d833279d8bf7e&w=1380"),
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text("Scan",
                          style: TextStyle(
                            color: AppConst.white,
                            fontSize: SizeUtils.horizontalBlockSize * 4,
                          ))
                    ],
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          // _paymentController.isLoading.value = false;

                          // _paymentController.redeemCashInStorePageDataIndex
                          //     .value = storeSearchModel;
                          Get.toNamed(AppRoutes.PayView,
                              arguments: {"color": randomGenerator()});
                        },
                        child: CircleAvatar(
                          radius: 6.w,
                          backgroundColor: AppConst.white,
                          foregroundImage: NetworkImage(
                              "https://img.freepik.com/free-vector/successful-financial-operation-business-accounting-invoice-report-happy-people-with-tax-receipt-duty-paying-money-savings-cash-income-vector-isolated-concept-metaphor-illustration_335657-2188.jpg?t=st=1649328544~exp=1649329144~hmac=635d4a3527c71f715e710f64fa046e8faf59de565b6be17f34a03ef3d5d8fa4d&w=826"),
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text("Refund",
                          style: TextStyle(
                            color: AppConst.white,
                            fontSize: SizeUtils.horizontalBlockSize * 4,
                          ))
                    ],
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          // Get.to(() => StoreScreen());
                          // _exploreController.isLoadingStoreData.value = true;

                          await _moreStoreController.getStoreData(
                              id: '${walletData?.sId}');
                          // Get.back();
                          // (_exploreController.getStoreDataModel.value?.error ??
                          //         false)
                          //     ? null
                          //     : Get.toNamed(AppRoutes.MoreStoreProductView);
                        },
                        child: CircleAvatar(
                          radius: 6.w,
                          backgroundColor: AppConst.white,
                          foregroundImage: NetworkImage(
                              "https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg"),
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        "Store",
                        style: TextStyle(
                            color: AppConst.white,
                            fontSize: SizeUtils.horizontalBlockSize * 4),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmptyScreen extends StatelessWidget {
  EmptyScreen({
    Key? key,
    required this.text1,
    required this.text2,
    required this.icon,
  }) : super(key: key);
  IconData? icon;
  String? text1;
  String? text2;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Container(
              //   height: 15.h,
              //   width: 45.w,
              //   child: Lottie.asset(
              //       'assets/lottie/receipt.json'),
              // ),
              Icon(
                icon,
                // Icons.receipt,
                size: 15.h,
                color: AppConst.grey,
              ),
            ],
          ),
          SizedBox(
            height: 4.h,
          ),
          Text(
            text1!,
            // "You haven't placed any ",
            style: TextStyle(
              fontSize: SizeUtils.horizontalBlockSize * 5.5,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            text2!,
            // "orders yet! ",
            style: TextStyle(
              fontSize: SizeUtils.horizontalBlockSize * 5.5,
              fontWeight: FontWeight.w300,
            ),
          )
        ],
      ),
    );
  }
}

class TransactionList extends StatelessWidget {
  TransactionList({Key? key}) : super(key: key);

  final MyWalletController _myWalletController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      (() => _myWalletController.isTransactionLoading.value
          ? LoadingWidget()
          : ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                  child: Row(
                    children: [
                      // Container(
                      //   decoration: BoxDecoration(
                      //       shape: BoxShape.circle,
                      //       border: Border.all(color: Colors.grey.shade400)),
                      //   child: ClipRRect(
                      //     borderRadius: BorderRadius.circular(50),
                      //     child: CachedNetworkImage(
                      //       width: 12.w,
                      //       height: 6.h,
                      //       fit: BoxFit.fill,
                      //       imageUrl: _myWalletController
                      //               .myWalletTransactionModel
                      //               .value
                      //               ?.data?[index]
                      //               .store
                      //               ?.logo ??
                      //           'https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg',
                      //       progressIndicatorBuilder:
                      //           (context, url, downloadProgress) => Center(
                      //               child: CircularProgressIndicator(
                      //                   value: downloadProgress.progress)),
                      //       errorWidget: (context, url, error) => Image.network(
                      //           'https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg'),
                      //     ),
                      //   ),
                      // ),
                      ((_myWalletController.myWalletTransactionModel.value
                                      ?.data?[index].debitOrCredit)
                                  ?.toUpperCase() ==
                              "DEBIT")
                          ? CircleAvatar(
                              child: Icon(
                                CupertinoIcons.arrow_down_left,
                                color: AppConst.white,
                                size: 3.h,
                              ),
                              backgroundColor: AppConst.blue,
                              radius: SizeUtils.horizontalBlockSize * 6.5,
                            )
                          : CircleAvatar(
                              child: Icon(
                                CupertinoIcons.arrow_up_right,
                                color: AppConst.white,
                                size: 3.h,
                              ),
                              backgroundColor: AppConst.orange,
                              radius: SizeUtils.horizontalBlockSize * 6.5,
                            ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat('E d MMM hh:mm a').format(
                              DateTime.fromMillisecondsSinceEpoch(
                                _myWalletController.myWalletTransactionModel
                                            .value?.data?[index].createdAt !=
                                        null
                                    ? int.parse((_myWalletController
                                            .myWalletTransactionModel
                                            .value
                                            ?.data?[index]
                                            .createdAt)
                                        .toString())
                                    : 1638362708701,
                              ),
                            ),
                            style: TextStyle(
                              fontSize: SizeUtils.horizontalBlockSize * 4.2,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Container(
                            width: 60.w,
                            child: Text(
                              '${_myWalletController.myWalletTransactionModel.value?.data?[index].comment ?? 'no comment'}',
                              overflow: TextOverflow.visible,
                              style: TextStyle(
                                fontSize: SizeUtils.horizontalBlockSize * 4,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [
                          Text(
                            ' ₹ ${_myWalletController.myWalletTransactionModel.value?.data?[index].amount ?? '0.0'}',
                            style: AppStyles.BOLD_STYLE_GREEN,
                          ),
                          Text(
                            ' ${_myWalletController.myWalletTransactionModel.value?.data?[index].debitOrCredit ?? '---'}',
                            style: TextStyle(
                              fontSize: SizeUtils.horizontalBlockSize * 4,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              itemCount: _myWalletController
                      .myWalletTransactionModel.value?.data?.length ??
                  0,
              separatorBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(left: 15.w),
                  child: Divider(
                    color: AppConst.black,
                  ),
                );
              },
            )),
    );
  }
}
