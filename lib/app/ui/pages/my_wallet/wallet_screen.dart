import 'dart:math';
import 'dart:ui';

import 'package:customer_app/app/constants/colors.dart';
import 'package:customer_app/app/data/model/my_wallet_model.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/screens/history/history_screen.dart';
import 'package:customer_app/screens/more_stores/morestore_controller.dart';
import 'package:customer_app/screens/wallet/loyaltyCardList.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/controller/my_wallet_controller.dart';
import 'package:customer_app/app/ui/pages/my_wallet/wallet_details_screen.dart';
import 'package:customer_app/app/ui/pages/my_wallet/wallet_screen_shimmer.dart';

import 'package:customer_app/screens/wallet/controller/paymentController.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:customer_app/widgets/backButton.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../screens/new_base_screen.dart';

class WalletScreen extends GetView<MyWalletController> {
  final MyWalletController _myWalletController = Get.find()
    ..getAllWalletByCustomer();
  final PaymentController _paymentController = Get.find();

  @override
  Widget build(BuildContext context) {
    Map arg = Get.arguments ?? {};
    bool? navWithOutTransaction = arg['navWithOutTranscation'];
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: AppConst.white,
          statusBarIconBrightness: Brightness.dark),
      child: Scaffold(
        backgroundColor: AppConst.referContainerbg,
        appBar: AppBar(
          elevation: 1,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: AppConst.white,
              statusBarIconBrightness: Brightness.dark),
          // backgroundColor: Color(0xff005b41),
          title: Text("My Wallets",
              style: TextStyle(
                fontFamily: 'MuseoSans',
                color: AppConst.black,
                fontSize: SizeUtils.horizontalBlockSize * 4.5,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
              )),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0).copyWith(top: 2.h),
                child: Container(
                  height: 5.h,
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.h),
                  decoration: BoxDecoration(
                    color: ColorConstants.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 2),
                      ),
                    ],
                    // border: Border.all(color: AppConst.grey, width: 0.5),
                    // borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                      textAlign: TextAlign.left,
                      // textDirection: TextDirection.rtl,
                      controller: _myWalletController.searchText,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.only(left: 3.w, top: 0.5.h),
                          isDense: true,
                          counterText: "",
                          border: InputBorder.none,
                          // OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(12),
                          //   borderSide:
                          //       BorderSide(width: 1, color: AppConst.transparent),
                          // ),
                          focusedBorder: InputBorder.none,
                          // OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(12),
                          //   borderSide: BorderSide(color: AppConst.black),
                          // ),
                          hintTextDirection: TextDirection.rtl,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: Icon(
                              Icons.search,
                              color: AppConst.darkGrey,
                              size: 25,
                            ),
                          ),
                          hintText: " Search your store here",
                          hintStyle: TextStyle(
                              color: AppConst.darkGrey,
                              fontSize:
                                  (SizerUtil.deviceType == DeviceType.tablet)
                                      ? 9.sp
                                      : 10.sp)),
                      showCursor: true,
                      cursorColor: AppConst.black,
                      cursorHeight: SizeUtils.horizontalBlockSize * 5,
                      maxLength: 30,
                      style: TextStyle(
                        color: AppConst.black,
                        fontSize: (SizerUtil.deviceType == DeviceType.tablet)
                            ? 9.sp
                            : 10.sp,
                      ),
                      onChanged: (value) {
                        _myWalletController.searchValue.value = value;
                      }),
                ),
              ),
              SizedBox(
                height: 0.5.h,
              ),
              Container(
                height: 8.h,
                color: AppConst.Lightgrey,
                child: ListView(
                  padding:
                      EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.5.h),
                  scrollDirection: Axis.horizontal,
                  children: [
                    //_myWalletController.myWalletModel.value?.data.first.businesstype.sId on basis of this id filter the list for each category
                    Obx(
                      () => (_myWalletController.intSelectedForWallet.value ==
                              1)
                          ? GestureDetector(
                              onTap: () {
                                _myWalletController.intSelectedForWallet.value =
                                    1;
                                _myWalletController
                                    .selectBusineesTypeIdForWallet.value = '';
                              },
                              child: SelectedDisplayBusinessType(
                                text: "All",
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                _myWalletController.intSelectedForWallet.value =
                                    1;
                                _myWalletController
                                    .selectBusineesTypeIdForWallet.value = '';
                              },
                              child: DisplayBusinessType(
                                text: "All",
                              ),
                            ),
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    Obx(
                      () => (_myWalletController.intSelectedForWallet.value ==
                              2)
                          ? GestureDetector(
                              onTap: () {
                                _myWalletController.intSelectedForWallet.value =
                                    2;
                                _myWalletController
                                    .selectBusineesTypeIdForWallet
                                    .value = "61f95fcd0a984e3d1c8f9ec9";
                                // print(_myWalletController.intSelectedForWallet.value);
                              },
                              child: SelectedDisplayBusinessType(
                                text: "Grocery",
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                _myWalletController.intSelectedForWallet.value =
                                    2;
                                _myWalletController
                                    .selectBusineesTypeIdForWallet
                                    .value = "61f95fcd0a984e3d1c8f9ec9";
                                // print(_myWalletController.intSelectedForWallet.value);
                              },
                              child: DisplayBusinessType(
                                text: "Grocery",
                              ),
                            ),
                    ),

                    SizedBox(
                      width: 3.w,
                    ),
                    Obx(
                      () => (_myWalletController.intSelectedForWallet.value ==
                              3)
                          ? GestureDetector(
                              onTap: () {
                                _myWalletController.intSelectedForWallet.value =
                                    3;
                                _myWalletController
                                    .selectBusineesTypeIdForWallet
                                    .value = "641ecc4ad9f0df5fa16d708d";
                                // print(_myWalletController.intSelectedForWallet.value);
                              },
                              child: SelectedDisplayBusinessType(
                                text: "Dry Fruits",
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                _myWalletController.intSelectedForWallet.value =
                                    3;
                                _myWalletController
                                    .selectBusineesTypeIdForWallet
                                    .value = "641ecc4ad9f0df5fa16d708d";
                                // print(_myWalletController.intSelectedForWallet.value);
                              },
                              child: DisplayBusinessType(
                                text: "Dry Fruits",
                              ),
                            ),
                    ),

                    SizedBox(
                      width: 3.w,
                    ),
                    Obx(
                      () => (_myWalletController.intSelectedForWallet.value ==
                              4)
                          ? GestureDetector(
                              onTap: () {
                                _myWalletController.intSelectedForWallet.value =
                                    4;
                                _myWalletController
                                    .selectBusineesTypeIdForWallet
                                    .value = "63a68a03f5416c5c5b0ab0a5";
                                // print(_myWalletController.intSelectedForWallet.value);
                              },
                              child: SelectedDisplayBusinessType(
                                text: "Pharmacy",
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                _myWalletController.intSelectedForWallet.value =
                                    4;
                                _myWalletController
                                    .selectBusineesTypeIdForWallet
                                    .value = "63a68a03f5416c5c5b0ab0a5";
                                // print(_myWalletController.intSelectedForWallet.value);
                              },
                              child: DisplayBusinessType(
                                text: "Pharmacy",
                              ),
                            ),
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    Obx(
                      () => (_myWalletController.intSelectedForWallet.value ==
                              5)
                          ? GestureDetector(
                              onTap: () {
                                _myWalletController.intSelectedForWallet.value =
                                    5;
                                _myWalletController
                                    .selectBusineesTypeIdForWallet
                                    .value = "625cc6c0c30c356c00c6a9bb";
                                // print(_myWalletController.intSelectedForWallet.value);
                              },
                              child: SelectedDisplayBusinessType(
                                text: "Meat",
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                _myWalletController.intSelectedForWallet.value =
                                    5;
                                _myWalletController
                                    .selectBusineesTypeIdForWallet
                                    .value = "625cc6c0c30c356c00c6a9bb";
                                // print(_myWalletController.intSelectedForWallet.value);
                              },
                              child: DisplayBusinessType(
                                text: "Meat",
                              ),
                            ),
                    ),

                    SizedBox(
                      width: 3.w,
                    ),
                    Obx(
                      () => (_myWalletController.intSelectedForWallet.value ==
                              6)
                          ? GestureDetector(
                              onTap: () {
                                _myWalletController.intSelectedForWallet.value =
                                    6;
                                _myWalletController
                                    .selectBusineesTypeIdForWallet
                                    .value = "63a689eff5416c5c5b0ab0a4";
                                // print(_myWalletController.intSelectedForWallet.value);
                              },
                              child: SelectedDisplayBusinessType(
                                text: "Pet food",
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                _myWalletController.intSelectedForWallet.value =
                                    6;
                                _myWalletController
                                    .selectBusineesTypeIdForWallet
                                    .value = "63a689eff5416c5c5b0ab0a4";
                                // print(_myWalletController.intSelectedForWallet.value);
                              },
                              child: DisplayBusinessType(
                                text: "Pet food",
                              ),
                            ),
                    ),

                    SizedBox(
                      width: 3.w,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 3.w, top: 3.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Available Wallets",
                        style: TextStyle(
                          fontFamily: 'MuseoSans',
                          color: AppConst.black,
                          fontSize: (SizerUtil.deviceType == DeviceType.tablet)
                              ? 9.sp
                              : 11.5.sp,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                        )),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.h),
                child: WalletCardList(
                  navWithOutTransaction: navWithOutTransaction ?? false,
                ),
              ),
            ],
          ),
        ),

        // SafeArea(
        //   minimum: EdgeInsets.only(left: 1.w, right: 1.w),
        //   child: Obx(
        //     () => _myWalletController.isLoading.value
        //         // true
        //         ? WalletScreenShimmer()
        //         : Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               // BackButtonAppbar(
        //               //   text: "Wallet",
        //               // ),

        //               Expanded(
        //                   child: Container(
        //                 child: SingleChildScrollView(
        // child: (_myWalletController
        //                 .myWalletModel.value?.data ==
        //             null ||
        //         _myWalletController
        //                 .myWalletModel.value?.data?.length ==
        //             0)
        //     ? EmptyScreen(
        //         text1: "You haven't placed any",
        //         text2: "orders yet!",
        //         icon: Icons.receipt,
        //       )
        //     : Column(
        //                           children: [
        //                             Padding(
        //                                 padding: EdgeInsets.symmetric(
        //                                     vertical: 1.h, horizontal: 2.w)),
        //                             //   child: Text(
        //                             //       "List of all available stores with their wallets are given below. ",
        //                             //       style: TextStyle(
        //                             //         fontFamily: 'MuseoSans',
        //                             //         color: AppConst.black,
        //                             //         fontSize:
        //                             //             SizeUtils.horizontalBlockSize *
        //                             //                 4,
        //                             //         fontWeight: FontWeight.w300,
        //                             //         fontStyle: FontStyle.normal,
        //                             //       )),
        //                             // ),
        //                             Obx(
        //                               () => ListView.separated(
        //                                 shrinkWrap: true,
        //                                 physics: NeverScrollableScrollPhysics(),
        //                                 itemCount: _myWalletController
        //                                         .myWalletModel
        //                                         .value
        //                                         ?.data
        //                                         ?.length ??
        //                                     0,
        //                                 itemBuilder: (context, index) {
        //                                   Color? color = randomGenerator();
        //                                   return Padding(
        //                                     padding: EdgeInsets.symmetric(
        //                                         vertical: 1.5.h,
        //                                         horizontal: 2.w),
        //                                     child: InkWell(
        //                                       highlightColor:
        //                                           AppConst.highLightColor,
        //                                       onTap: () async {
        //                                         Get.to(
        //                                             () => WalletTransactionCard(
        //                                                 storeSearchModel:
        //                                                     _paymentController
        //                                                         .redeemCashInStorePageDataIndex
        //                                                         .value,
        //                                                 walletData:
        //                                                     _myWalletController
        //                                                         .myWalletModel
        //                                                         .value
        //                                                         ?.data?[index]),
        //                                             arguments: {
        //                                               "name": controller
        //                                                       .myWalletModel
        //                                                       .value
        //                                                       ?.data?[index]
        //                                                       .name ??
        //                                                   "",
        //                                               "color": color,
        //                                             });

        //                                         await controller
        //                                             .getAllWalletTransactionByCustomer(
        //                                                 storeId: controller
        //                                                         .myWalletModel
        //                                                         .value
        //                                                         ?.data?[index]
        //                                                         .sId ??
        //                                                     "");
        //                                         controller.storeId.value =
        //                                             controller
        //                                                     .myWalletModel
        //                                                     .value
        //                                                     ?.data?[index]
        //                                                     .sId ??
        //                                                 "";
        //                                       },
        //                                       child: CardlistView(
        //                                           color: color,
        //                                           StoreID:
        //                                               "${controller.myWalletModel.value?.data?[index].sId ?? ''}",
        //                                           StoreName:
        //                                               "${controller.myWalletModel.value?.data?[index].name ?? 'Store Name'}",
        //                                           distanceOrOffer: controller
        //                                                   .myWalletModel
        //                                                   .value
        //                                                   ?.data?[index]
        //                                                   .welcomeOffer ??
        //                                               0,
        //                                           Balance: (controller
        //                                                       .myWalletModel
        //                                                       .value
        //                                                       ?.data?[index]
        //                                                       .earnedCashback ??
        //                                                   0) +
        //                                               (controller
        //                                                       .myWalletModel
        //                                                       .value
        //                                                       ?.data?[index]
        //                                                       .welcomeOfferAmount ??
        //                                                   0)),
        //                                       //  Padding(
        //                                       //   padding: EdgeInsets.symmetric(
        //                                       //       horizontal: 2.w, vertical: 2.h),
        //                                       //   child: Column(
        //                                       //     children: [
        //                                       //       Row(
        //                                       //         mainAxisAlignment:
        //                                       //             MainAxisAlignment
        //                                       //                 .spaceBetween,
        //                                       //         children: [
        //                                       //           Row(children: [
        //                                       //             // Container(
        //                                       //             //   decoration: BoxDecoration(
        //                                       //             //       shape:
        //                                       //             //           BoxShape.circle,
        //                                       //             //       border: Border.all(
        //                                       //             //           color: Colors.grey
        //                                       //             //               .shade400)),
        //                                       //             //   child: ClipOval(
        //                                       //             //     child:
        //                                       //             //         CachedNetworkImage(
        //                                       //             //       width: 12.w,
        //                                       //             //       height: 6.h,
        //                                       //             //       fit: BoxFit.fill,
        //                                       //             //       imageUrl: controller
        //                                       //             //               .myWalletModel
        //                                       //             //               .value
        //                                       //             //               ?.data?[index]
        //                                       //             //               .logo ??
        //                                       //             //           'https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg',
        //                                       //             //       progressIndicatorBuilder: (context,
        //                                       //             //               url,
        //                                       //             //               downloadProgress) =>
        //                                       //             //           Center(
        //                                       //             //               child: CircularProgressIndicator(
        //                                       //             //                   value: downloadProgress
        //                                       //             //                       .progress)),
        //                                       //             //       errorWidget: (context,
        //                                       //             //               url, error) =>
        //                                       //             //           Center(
        //                                       //             //         child: Text(
        //                                       //             //             controller
        //                                       //             //                     .myWalletModel
        //                                       //             //                     .value
        //                                       //             //                     ?.data?[
        //                                       //             //                         index]
        //                                       //             //                     .name
        //                                       //             //                     ?.substring(
        //                                       //             //                         0,
        //                                       //             //                         1) ??
        //                                       //             //                 "",
        //                                       //             //             style: TextStyle(
        //                                       //             //                 fontSize:
        //                                       //             //                     SizeUtils.horizontalBlockSize *
        //                                       //             //                         6)),
        //                                       //             //       ),
        //                                       //             //     ),
        //                                       //             //   ),
        //                                       //             // ),

        //                                       //             (controller
        //                                       //                         .myWalletModel
        //                                       //                         .value
        //                                       //                         ?.data?[index]
        //                                       //                         .logo)!
        //                                       //                     .isEmpty
        //                                       //                 ? CircleAvatar(
        //                                       //                     child: Text(
        //                                       //                         controller
        //                                       //                                 .myWalletModel
        //                                       //                                 .value
        //                                       //                                 ?.data?[
        //                                       //                                     index]
        //                                       //                                 .name
        //                                       //                                 ?.substring(
        //                                       //                                     0,
        //                                       //                                     1) ??
        //                                       //                             "",
        //                                       //                         style: TextStyle(
        //                                       //                             fontSize:
        //                                       //                                 SizeUtils.horizontalBlockSize *
        //                                       //                                     6)),
        //                                       //                     backgroundColor: Colors
        //                                       //                             .primaries[
        //                                       //                         Random().nextInt(Colors
        //                                       //                             .primaries
        //                                       //                             .length)],
        //                                       //                     radius: SizeUtils
        //                                       //                             .horizontalBlockSize *
        //                                       //                         6.5,
        //                                       //                   )
        //                                       //                 : CircleAvatar(
        //                                       //                     backgroundImage:
        //                                       //                         NetworkImage(controller
        //                                       //                                 .myWalletModel
        //                                       //                                 .value
        //                                       //                                 ?.data?[
        //                                       //                                     index]
        //                                       //                                 .logo ??
        //                                       //                             ''),
        //                                       //                     backgroundColor:
        //                                       //                         Colors.white,
        //                                       //                     radius: SizeUtils
        //                                       //                             .horizontalBlockSize *
        //                                       //                         6.5,
        //                                       //                   ),
        //                                       //             SizedBox(
        //                                       //               width: 1.h,
        //                                       //             ),
        //                                       //             Column(
        //                                       //               crossAxisAlignment:
        //                                       //                   CrossAxisAlignment
        //                                       //                       .start,
        //                                       //               children: [
        //                                       //                 Container(
        //                                       //                   width: 60.w,
        //                                       //                   child: Text(
        //                                       //                     controller
        //                                       //                             .myWalletModel
        //                                       //                             .value
        //                                       //                             ?.data?[
        //                                       //                                 index]
        //                                       //                             .name ??
        //                                       //                         'Store Name',
        //                                       //                     overflow:
        //                                       //                         TextOverflow
        //                                       //                             .ellipsis,
        //                                       //                     style: TextStyle(
        //                                       //                       fontSize: SizeUtils
        //                                       //                               .horizontalBlockSize *
        //                                       //                           4.5,
        //                                       //                       fontWeight:
        //                                       //                           FontWeight
        //                                       //                               .bold,
        //                                       //                     ),
        //                                       //                   ),
        //                                       //                 ),
        //                                       //                 SizedBox(
        //                                       //                   height: 1.h,
        //                                       //                 ),
        //                                       //                 Container(
        //                                       //                   width: 60.w,
        //                                       //                   child: Text(
        //                                       //                     " Welcome Offer \u{20B9} ${controller.myWalletModel.value?.data?[index].welcomeOfferAmount ?? '0'}",
        //                                       //                     overflow:
        //                                       //                         TextOverflow
        //                                       //                             .ellipsis,
        //                                       //                     style: TextStyle(
        //                                       //                         fontSize:
        //                                       //                             SizeUtils
        //                                       //                                     .horizontalBlockSize *
        //                                       //                                 4,
        //                                       //                         fontWeight:
        //                                       //                             FontWeight
        //                                       //                                 .w500,
        //                                       //                         color: Colors
        //                                       //                             .black54),
        //                                       //                   ),
        //                                       //                 ),
        //                                       //               ],
        //                                       //             )
        //                                       //           ]),
        //                                       //           // Spacer(),
        //                                       //           Column(
        //                                       //             crossAxisAlignment:
        //                                       //                 CrossAxisAlignment
        //                                       //                     .end,
        //                                       //             children: [
        //                                       //               Text(
        //                                       //                 '₹ ${controller.myWalletModel.value?.data?[index].earnedCashback ?? '0'} ',
        //                                       //                 style: AppStyles
        //                                       //                     .BOLD_STYLE_GREEN,
        //                                       //               ),
        //                                       //             ],
        //                                       //           )
        //                                       //         ],
        //                                       //       ),
        //                                       //     ],
        //                                       //   ),
        //                                       // ),
        //                                     ),
        //                                   );
        //                                 },
        //                                 separatorBuilder: (context, index) {
        //                                   return Padding(
        //                                     padding: EdgeInsets.symmetric(
        //                                         vertical: 1.h),
        //                                     child: Container(
        //                                         height: 1,
        //                                         color: AppConst.grey),
        //                                   );
        //                                 },
        //                               ),
        //                             ),
        //                           ],
        //                         ),
        //                 ),
        //               ))
        //             ],
        //           ),
        //   ),
        // ),
      ),
    );
  }
}

class WalletCardList extends StatelessWidget {
  bool navWithOutTransaction;
  WalletCardList({Key? key, this.navWithOutTransaction = false})
      : super(key: key);
  @override
  final MyWalletController _myWalletController = Get.find();

  Widget build(BuildContext context) {
    return Obx(
      () => _myWalletController.isLoading.value
          // true
          ? Container(height: 90.h, child: WalletScreenShimmer())
          : (_myWalletController.myWalletModel.value?.data == null ||
                  _myWalletController.myWalletModel.value?.data?.length == 0)
              ? EmptyScreen(
                  text1: "You haven't placed any",
                  text2: "orders yett!",
                  icon: Icons.receipt,
                )
              : Obx(
                  () => ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _myWalletController.searchValue.value.isEmpty
                        ? (_myWalletController.selectBusineesTypeIdForWallet.value == ''
                            ? (_myWalletController.myWalletModel.value?.data
                                    ?.where((c) => c.deactivated == false)
                                    .toList()
                                    .length ??
                                0)
                            : (_myWalletController.myWalletModel.value?.data
                                    ?.where((c) =>
                                        c.deactivated == false &&
                                        c.totalCashbackSubBusinessType!.first
                                                .subBusinessType ==
                                            _myWalletController
                                                .selectBusineesTypeIdForWallet
                                                .value)
                                    .toList()
                                    .length ??
                                0))
                        : (_myWalletController.myWalletModel.value?.data
                                ?.where((c) => c.name!
                                    .toLowerCase()
                                    .contains(_myWalletController.searchValue.value.toLowerCase()))
                                .toList()
                                .length ??
                            0),
                    itemBuilder: (context, index) {
                      return WalletListView(
                        walletData: _myWalletController.searchValue.value.isEmpty
                            ? (_myWalletController.selectBusineesTypeIdForWallet.value == ''
                                ? (_myWalletController.myWalletModel.value!.data!
                                    .where((c) => c.deactivated == false)
                                    .toList()[index])
                                : (_myWalletController.myWalletModel.value!.data!
                                    .where((c) =>
                                        c.deactivated == false &&
                                        c.totalCashbackSubBusinessType!.first.subBusinessType ==
                                            _myWalletController
                                                .selectBusineesTypeIdForWallet
                                                .value)
                                    .toList()[index]))
                            : (_myWalletController.myWalletModel.value!.data!
                                .where((c) =>
                                    c.deactivated == false &&
                                    c.name!
                                        .toLowerCase()
                                        .contains(_myWalletController.searchValue.value.toLowerCase()))
                                .toList()[index]),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox();
                    },
                  ),
                ),
    );
  }
}

class WalletListView extends StatelessWidget {
  WalletData walletData;
  bool navWithOutTransaction;
  WalletListView(
      {Key? key, required this.walletData, this.navWithOutTransaction = false})
      : super(key: key);
  final PaymentController _paymentController = Get.find();
  final MyWalletController _myWalletController = Get.find();
  final MoreStoreController _moreStoreController = Get.find();
  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
    Color? color = randomGenerator();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
      child: Column(
        children: [
          InkWell(
            onTap: () async {
              if (navWithOutTransaction) {
                _moreStoreController.storeId.value = walletData.sId ?? '';
                await _moreStoreController.getStoreData(
                  id: walletData.sId ?? '',
                );
              } else {
                Get.to(
                    () => WalletTransactionCard(
                        storeSearchModel: _paymentController
                            .redeemCashInStorePageDataIndex.value,
                        walletData: walletData),
                    arguments: {
                      "name": walletData.name ?? "",
                      "logo": walletData.logo ?? "",
                      "color": color,
                      "storeId": walletData.sId ?? "",
                    });

                await _myWalletController.getAllWalletTransactionByCustomer(
                    storeId: walletData.sId ?? "");
                _myWalletController.storeId.value = walletData.sId ?? "";
              }
            },
            child: CardlistView(
                color: color,
                StoreID: "${walletData.sId ?? ''}",
                StoreName: "${walletData.name ?? 'Store Name'}",
                distanceOrOffer: walletData.welcomeOffer ?? 0,
                Balance: (walletData.earnedCashback ?? 0) +
                    (walletData.welcomeOfferAmount ?? 0)),
          ),
        ],
      ),
    );
  }
}

class SelectedDisplayBusinessType extends StatelessWidget {
  String? text;
  SelectedDisplayBusinessType({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 9.h,
      // width: 20.w,
      // padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: AppConst.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppConst.green)),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18),
          child: Text(text ?? "",
              style: TextStyle(
                fontFamily: 'MuseoSans',
                color: ColorConstants.black,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
              )),
        ),
      ),
    );
  }
}

class DisplayBusinessType extends StatelessWidget {
  String? text;
  DisplayBusinessType({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 9.h,
      // width: 20.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: AppConst.white),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18),
          child: Text(text ?? "",
              style: TextStyle(
                fontFamily: 'MuseoSans',
                color: Color(0xff462f03),
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
              )),
        ),
      ),
    );
  }
}
