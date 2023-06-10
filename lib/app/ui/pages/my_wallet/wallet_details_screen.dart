import 'package:customer_app/app/constants/colors.dart';
import 'package:customer_app/app/ui/pages/signIn/phone_authentication_screen.dart';
import 'package:customer_app/app/utils/utils.dart';
import 'package:customer_app/screens/more_stores/all_offers_listview.dart';
import 'package:customer_app/screens/more_stores/morestore_controller.dart';
import 'package:customer_app/widgets/copied/confirm_dialog.dart';
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
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../location_picker/address_model.dart';

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
    // Color color = argumentData['color'];
    Color color = Color(0xff003d29);
    String name = argumentData['name'] ?? "";
    String StoreId = argumentData['storeId'] ?? "";
    String logo = argumentData['logo'] ?? "";

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: color, statusBarIconBrightness: Brightness.light),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: color,
          title: Text(name,
              style: TextStyle(
                fontFamily: 'MuseoSans',
                color: AppConst.white,
                fontSize: SizeUtils.horizontalBlockSize * 4,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
              )),
          iconTheme: IconThemeData(color: AppConst.white),
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: color, statusBarIconBrightness: Brightness.light),
        ),
        body: Obx(
          () => _myWalletController.isTransactionLoading.value
              ? Center(child: WalletDetailScreenShimmer())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Padding(
                    //   padding:
                    //       EdgeInsets.symmetric(horizontal: 0.w, vertical: 1.h),
                    //   child: Row(
                    //     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       BackButtonWidget(),
                    //       SizedBox(
                    //         width: 2.w,
                    //       ),
                    //       (logo).isEmpty
                    //           ? CircleAvatar(
                    //               child: Text(name.substring(0, 1),
                    //                   style: TextStyle(
                    //                       fontFamily: 'Poppins',
                    //                       color: AppConst.white,
                    //                       fontWeight: FontWeight.w600,
                    //                       fontStyle: FontStyle.normal,
                    //                       fontSize:
                    //                           SizeUtils.horizontalBlockSize *
                    //                               6)),
                    //               backgroundColor: color,
                    //               radius: SizeUtils.horizontalBlockSize * 6.5,
                    //             )
                    //           : CircleAvatar(
                    //               backgroundImage: NetworkImage(logo),
                    //               backgroundColor: AppConst.white,
                    //               radius: SizeUtils.horizontalBlockSize * 6.5,
                    //             ),
                    //       SizedBox(
                    //         width: 2.w,
                    //       ),
                    //       Expanded(
                    //         child: Text(
                    //           "${name}",
                    //           style: TextStyle(
                    //               color: AppConst.black,
                    //               fontSize: SizeUtils.horizontalBlockSize * 5),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    WalletDetailCard(color),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              child: Text(
                                " My Transactions", //Transactions
                                style: TextStyle(
                                    color: AppConst.black,
                                    fontFamily: 'MuseoSans',
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                    letterSpacing: -0.36,
                                    fontSize:
                                        SizeUtils.horizontalBlockSize * 4.5),
                              ),
                              // color: Colors.red,
                            ),
                          ),
                        ],
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
                    GestureDetector(
                      onTap: () {
                        SeeyaConfirmDialog(
                            title: "Are you sure!",
                            subTitle: (walletData?.deactivated == false)
                                ? "You Want to Deactivate the Wallet?"
                                : "You Want to Activate the Wallet?",
                            onCancel: () => Get.back(),
                            onConfirm: () async {
                              //exit the dialog;
                              Get.back();
                              //exit this screen

                              if (walletData?.deactivated == false) {
                                _myWalletController
                                    .updateWalletStatusByCustomer(
                                        storeId: walletData?.sId, status: true);
                                walletData?.deactivated = true;
                              } else {
                                _myWalletController
                                    .updateWalletStatusByCustomer(
                                        storeId: walletData?.sId,
                                        status: false);
                                walletData?.deactivated = false;
                              }
                            }).show(context);
                      },
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 2.h, horizontal: 3.w),
                          child: BottomWideButton(
                            text: (walletData?.deactivated == false)
                                ? "Deactivate Wallet"
                                : "Activate Wallet",
                            color: (walletData?.deactivated == false)
                                ? AppConst.white
                                : AppConst.darkGreen,
                            Textcolor: (walletData?.deactivated == false)
                                ? AppConst.red
                                : AppConst.white,
                            borderColor: (walletData?.deactivated == false)
                                ? AppConst.red
                                : AppConst.darkGreen,
                          )),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Padding WalletDetailCard(Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 0.w),
      child: Container(
        height: 25.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          // border: Border.all(),
          // borderRadius: BorderRadius.only(
          //     bottomLeft: Radius.circular(32),
          //     bottomRight: Radius.circular(32))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  "\u{20B9} ${(walletData?.earnedCashback ?? 0) + (walletData?.welcomeOfferAmount ?? 0)} ",
                  style: TextStyle(
                    color: AppConst.white,
                    fontSize: SizeUtils.horizontalBlockSize * 11,
                    fontFamily: 'MuseoSans',
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                Text(
                  "Your available Balance",
                  style: TextStyle(
                    color: AppConst.white,
                    fontSize: SizeUtils.horizontalBlockSize * 3.5,
                    fontFamily: 'MuseoSans',
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
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
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 1.h),
                          height: 12.h,
                          // decoration: BoxDecoration(
                          //     border: Border.all(
                          //   width: 0.1,
                          // )),
                          child: Image(
                            image: AssetImage(
                              'assets/images/scanme.png',
                            ),
                          ),
                        ),

                        // CircleAvatar(
                        //   radius: 6.w,
                        //   foregroundImage: NetworkImage(
                        //       "https://img.freepik.com/free-vector/tiny-people-using-qr-code-online-payment-isolated-flat-illustration_74855-11136.jpg?t=st=1649328483~exp=1649329083~hmac=5171d5a26cfeb0c063c6afc1f8af8cb4460c207134f830b2ff0d833279d8bf7e&w=1380"),
                        // ),
                      ),
                      // SizedBox(
                      //   height: 1.h,
                      // ),
                      // Text("Scan",
                      //     style: TextStyle(
                      //       color: AppConst.white,
                      //       fontSize: SizeUtils.horizontalBlockSize * 4,
                      //     ))
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
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 1.h),
                          height: 12.h,
                          // decoration: BoxDecoration(
                          //     border: Border.all(
                          //   width: 0.1,
                          // )),
                          child: Image(
                            image: AssetImage(
                              'assets/images/refund.png',
                            ),
                          ),
                        ),

                        // CircleAvatar(
                        //   radius: 6.w,
                        //   backgroundColor: AppConst.white,
                        //   foregroundImage: NetworkImage(
                        //       "https://img.freepik.com/free-vector/successful-financial-operation-business-accounting-invoice-report-happy-people-with-tax-receipt-duty-paying-money-savings-cash-income-vector-isolated-concept-metaphor-illustration_335657-2188.jpg?t=st=1649328544~exp=1649329144~hmac=635d4a3527c71f715e710f64fa046e8faf59de565b6be17f34a03ef3d5d8fa4d&w=826"),
                        // ),
                      ),
                      // SizedBox(
                      //   height: 1.h,
                      // ),
                      // Text("Refund",
                      //     style: TextStyle(
                      //       color: AppConst.white,
                      //       fontSize: SizeUtils.horizontalBlockSize * 4,
                      //     ))
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
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 1.h),
                          height: 12.h,
                          // decoration: BoxDecoration(
                          //     border: Border.all(
                          //   width: 0.1,
                          // )),
                          child: Image(
                            image: AssetImage(
                              'assets/images/storevisit.png',
                            ),
                          ),
                        ),
                        // CircleAvatar(
                        //   radius: 6.w,
                        //   backgroundColor: AppConst.white,
                        //   foregroundImage: NetworkImage(
                        //       "https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg"),
                        // ),
                      ),
                      // SizedBox(
                      //   height: 1.h,
                      // ),
                      // Text(
                      //   "Store",
                      //   style: TextStyle(
                      //       color: AppConst.white,
                      //       fontSize: SizeUtils.horizontalBlockSize * 4),
                      // )
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
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
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
        ),
        Container(
          color: AppConst.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 3.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                    child: Container(
                        height: 5.5.h,
                        width: 30.w,
                        child: FittedBox(
                          child: SvgPicture.asset(
                            "assets/icons/logoname1.svg",
                            fit: BoxFit.fill,
                            color: AppConst.grey,
                          ),
                        )),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Can't find your store ?",
                      style: TextStyle(
                        fontFamily: 'MuseoSans',
                        color: AppConst.grey,
                        fontSize: SizeUtils.horizontalBlockSize * 3.5,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    GestureDetector(
                      onTap: () async {
                        dynamic value = Get.to(AddressModel(
                          // isSavedAddress: false,
                          isHomeScreen: true,
                          page: "home",
                        ));
                      },
                      child: Container(
                        decoration: BoxDecoration(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Click here to change the location",
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: 'MuseoSans',
                                fontSize: SizeUtils.horizontalBlockSize * 3.5,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                                color: AppConst.darkGreen,
                              ),
                            ),
                            Icon(
                              Icons.location_on_sharp,
                              color: AppConst.darkGreen,
                              size: 2.h,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 7.h,
              ),
            ],
          ),
        ),
      ],
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
                                CupertinoIcons.arrow_up_right,
                                color: AppConst.white,
                                size: 3.5.h,
                              ),
                              backgroundColor:
                                  Color(0xff5764da), // AppConst.blue,
                              radius: SizeUtils.horizontalBlockSize * 6,
                            )
                          : CircleAvatar(
                              child: Icon(
                                CupertinoIcons.arrow_down_left,
                                color: AppConst.white,
                                size: 3.5.h,
                              ),
                              backgroundColor: AppConst.green,
                              radius: SizeUtils.horizontalBlockSize * 6,
                            ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 55.w,
                            child: Text(
                              '${_myWalletController.myWalletTransactionModel.value?.data?[index].comment ?? 'no comment'}',
                              overflow: TextOverflow.visible,
                              style: TextStyle(
                                fontSize: SizeUtils.horizontalBlockSize * 4.2,
                                fontFamily: 'MuseoSans',
                                color: Color(0xff3a3a3a),
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Text(
                            DateFormat('d MMMM yyyy  hh:mm a').format(
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
                              fontSize: SizeUtils.horizontalBlockSize * 3.5,
                              color: Color(0xff888888),
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                              '${((_myWalletController.myWalletTransactionModel.value?.data?[index].debitOrCredit)?.toUpperCase() == "DEBIT") ? "" : "+"} \u{20b9}${_myWalletController.myWalletTransactionModel.value?.data?[index].amount ?? '0.0'}',
                              style: TextStyle(
                                fontFamily: 'MuseoSans',
                                color: ((_myWalletController
                                                .myWalletTransactionModel
                                                .value
                                                ?.data?[index]
                                                .debitOrCredit)
                                            ?.toUpperCase() ==
                                        "DEBIT")
                                    ? AppConst.black
                                    : AppConst.green,
                                fontSize: SizeUtils.horizontalBlockSize * 4.5,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                              )),
                          Text(
                            ' ${_myWalletController.myWalletTransactionModel.value?.data?[index].debitOrCredit ?? '---'}',
                            style: TextStyle(
                                fontSize: SizeUtils.horizontalBlockSize * 4,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'MuseoSans',
                                fontStyle: FontStyle.normal,
                                color: AppConst.black),
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
                return SizedBox(
                  height: 1.h,
                );
              },
            )),
    );
  }
}
