import 'dart:math';
import 'dart:ui';

import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/screens/history/history_screen.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/controller/my_wallet_controller.dart';
import 'package:customer_app/app/ui/pages/my_wallet/wallet_details_screen.dart';
import 'package:customer_app/app/ui/pages/my_wallet/wallet_screen_shimmer.dart';

import 'package:customer_app/screens/wallet/controller/paymentController.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:customer_app/widgets/backButton.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class WalletScreen extends GetView<MyWalletController> {
  final MyWalletController _myWalletController = Get.find()
    ..getAllWalletByCustomer();
  final PaymentController _paymentController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.only(top: 2.h, left: 1.w, right: 1.w),
        child: Obx(
          () => _myWalletController.isLoading.value
              // true
              ? Center(child: WalletScreenShimmer())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BackButtonAppbar(
                      text: "Wallet",
                    ),
                    Expanded(
                        child: Container(
                      child: SingleChildScrollView(
                        child: (_myWalletController.myWalletModel.value?.data ==
                                    null ||
                                _myWalletController
                                        .myWalletModel.value?.data?.length ==
                                    0)
                            ? EmptyScreen(
                                text1: "You haven't placed any",
                                text2: "orders yet!",
                                icon: Icons.receipt,
                              )
                            : Obx(
                                () => ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: _myWalletController
                                          .myWalletModel.value?.data?.length ??
                                      0,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      child:
                                          // (_myWalletController
                                          //                 .myWalletModel.value?.data ==
                                          //             null ||
                                          //         _myWalletController.myWalletModel.value
                                          //                 ?.data?.length ==
                                          //             0)
                                          //     ? EmptyScreen(
                                          //         text1: "You haven't placed any",
                                          //         text2: "orders yet!",
                                          //         icon: Icons.receipt,
                                          //       )
                                          // :
                                          InkWell(
                                        highlightColor: AppConst.highLightColor,
                                        onTap: () async {
                                          Get.to(() => WalletTransactionCard(
                                              storeSearchModel: _paymentController
                                                  .redeemCashInStorePageDataIndex
                                                  .value,
                                              walletData: _myWalletController
                                                  .myWalletModel
                                                  .value
                                                  ?.data?[index]));

                                          await controller
                                              .getAllWalletTransactionByCustomer(
                                                  storeId: controller
                                                          .myWalletModel
                                                          .value
                                                          ?.data?[index]
                                                          .sId ??
                                                      "");
                                          controller.storeId.value = controller
                                                  .myWalletModel
                                                  .value
                                                  ?.data?[index]
                                                  .sId ??
                                              "";
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 2.w, vertical: 2.h),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(children: [
                                                    // Container(
                                                    //   decoration: BoxDecoration(
                                                    //       shape:
                                                    //           BoxShape.circle,
                                                    //       border: Border.all(
                                                    //           color: Colors.grey
                                                    //               .shade400)),
                                                    //   child: ClipOval(
                                                    //     child:
                                                    //         CachedNetworkImage(
                                                    //       width: 12.w,
                                                    //       height: 6.h,
                                                    //       fit: BoxFit.fill,
                                                    //       imageUrl: controller
                                                    //               .myWalletModel
                                                    //               .value
                                                    //               ?.data?[index]
                                                    //               .logo ??
                                                    //           'https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg',
                                                    //       progressIndicatorBuilder: (context,
                                                    //               url,
                                                    //               downloadProgress) =>
                                                    //           Center(
                                                    //               child: CircularProgressIndicator(
                                                    //                   value: downloadProgress
                                                    //                       .progress)),
                                                    //       errorWidget: (context,
                                                    //               url, error) =>
                                                    //           Center(
                                                    //         child: Text(
                                                    //             controller
                                                    //                     .myWalletModel
                                                    //                     .value
                                                    //                     ?.data?[
                                                    //                         index]
                                                    //                     .name
                                                    //                     ?.substring(
                                                    //                         0,
                                                    //                         1) ??
                                                    //                 "",
                                                    //             style: TextStyle(
                                                    //                 fontSize:
                                                    //                     SizeUtils.horizontalBlockSize *
                                                    //                         6)),
                                                    //       ),
                                                    //     ),
                                                    //   ),
                                                    // ),

                                                    (controller
                                                                .myWalletModel
                                                                .value
                                                                ?.data?[index]
                                                                .logo)!
                                                            .isEmpty
                                                        ? CircleAvatar(
                                                            child: Text(
                                                                controller
                                                                        .myWalletModel
                                                                        .value
                                                                        ?.data?[
                                                                            index]
                                                                        .name
                                                                        ?.substring(
                                                                            0,
                                                                            1) ??
                                                                    "",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        SizeUtils.horizontalBlockSize *
                                                                            6)),
                                                            backgroundColor: Colors
                                                                    .primaries[
                                                                Random().nextInt(
                                                                    Colors
                                                                        .primaries
                                                                        .length)],
                                                            radius: SizeUtils
                                                                    .horizontalBlockSize *
                                                                6.5,
                                                          )
                                                        : CircleAvatar(
                                                            backgroundImage:
                                                                NetworkImage(controller
                                                                        .myWalletModel
                                                                        .value
                                                                        ?.data?[
                                                                            index]
                                                                        .logo ??
                                                                    ''),
                                                            backgroundColor:
                                                                Colors.white,
                                                            radius: SizeUtils
                                                                    .horizontalBlockSize *
                                                                6.5,
                                                          ),
                                                    SizedBox(
                                                      width: 1.h,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width: 60.w,
                                                          child: Text(
                                                            controller
                                                                    .myWalletModel
                                                                    .value
                                                                    ?.data?[
                                                                        index]
                                                                    .name ??
                                                                'Store Name',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              fontSize: SizeUtils
                                                                      .horizontalBlockSize *
                                                                  4.5,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 1.h,
                                                        ),
                                                        Container(
                                                          width: 60.w,
                                                          child: Text(
                                                            " Welcome Offer \u{20B9} ${controller.myWalletModel.value?.data?[index].welcomeOfferAmount ?? '0'}",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: SizeUtils
                                                                        .horizontalBlockSize *
                                                                    4,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .black54),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ]),
                                                  // Spacer(),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        '₹ ${controller.myWalletModel.value?.data?[index].earnedCashback ?? '0'} ',
                                                        style: AppStyles
                                                            .BOLD_STYLE_GREEN,
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizedBox();
                                    // Divider(
                                    //   height: 3.h,
                                    // );
                                  },
                                ),
                              ),
                      ),
                    ))
                  ],
                ),
        ),
      ),
    );
  }
}
