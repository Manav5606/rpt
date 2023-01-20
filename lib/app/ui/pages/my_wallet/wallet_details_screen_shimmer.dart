import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/controller/my_wallet_controller.dart';
import 'package:customer_app/app/ui/common/shimmer_widget.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/widgets/backButton.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class WalletDetailScreenShimmer extends StatefulWidget {
  WalletDetailScreenShimmer({Key? key}) : super(key: key);

  @override
  State<WalletDetailScreenShimmer> createState() =>
      _WalletDetailScreenShimmerState();
}

class _WalletDetailScreenShimmerState extends State<WalletDetailScreenShimmer> {
  final MyWalletController _myWalletController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
            child: Row(
              children: [
                ShimmerEffect(
                    child: Icon(
                  Icons.arrow_back,
                  size: 3.h,
                  color: AppConst.black,
                )),
                SizedBox(
                  width: 3.w,
                ),
                ShimmerEffect(
                  child: Container(
                    width: 12.w,
                    height: 6.h,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: AppConst.black),
                  ),
                ),
                SizedBox(
                  width: 2.w,
                ),
                Column(
                  children: [
                    Container(
                      child: Center(
                          child: ShimmerEffect(
                        child: Container(
                          color: AppConst.black,
                          height: 2.5.h,
                          width: 60.w,
                        ),
                      )),
                    )
                  ],
                ),
              ],
            ),
          ),
          ShimmerEffect(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
            child: Container(
              height: 25.h,
              width: double.infinity,
              color: AppConst.black,
            ),
          )),
          SizedBox(
            height: 3.h,
          ),
          Container(
            height: 400,
            // color: AppConst.black,
            width: MediaQuery.of(context).size.width,
            child: (_myWalletController.myWalletTransactionModel.value?.data ==
                    null)
                ? Container(
                    child: Center(
                        child: ShimmerEffect(
                      child: Container(
                        color: AppConst.black,
                        height: 2.h,
                        width: 40.w,
                      ),
                    )),
                  )
                : ShimmerEffect(
                    child: TransactionListShimmer(),
                  ),
          ),
        ],
      ),
    );
  }

  // Padding WalletDetailCard() {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
  //     child: Container(
  //       height: 25.h,
  //       width: double.infinity,
  //       decoration: BoxDecoration(
  //           // color: AppConst.black,
  //           border: Border.all(),
  //           borderRadius: BorderRadius.circular(12)),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: [
  //           Column(
  //             children: [
  //               Container(
  //                 child: Center(
  //                     child: ShimmerEffect(
  //                   child: Container(
  //                     color: AppConst.black,
  //                     height: 4.h,
  //                     width: 20.w,
  //                   ),
  //                 )),
  //               ),
  //               SizedBox(
  //                 height: 1.h,
  //               ),
  //               Container(
  //                 child: Center(
  //                     child: ShimmerEffect(
  //                   child: Container(
  //                     color: AppConst.black,
  //                     height: 2.h,
  //                     width: 30.w,
  //                   ),
  //                 )),
  //               )
  //             ],
  //           ),
  //           Padding(
  //             padding: EdgeInsets.symmetric(horizontal: 8.w),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceAround,
  //               children: [
  //                 Column(
  //                   children: [
  //                     InkWell(
  //                       onTap: () {},
  //                       child: CircleAvatar(
  //                         radius: 6.w,
  //                         foregroundImage: NetworkImage(
  //                             "https://img.freepik.com/free-vector/tiny-people-using-qr-code-online-payment-isolated-flat-illustration_74855-11136.jpg?t=st=1649328483~exp=1649329083~hmac=5171d5a26cfeb0c063c6afc1f8af8cb4460c207134f830b2ff0d833279d8bf7e&w=1380"),
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       height: 1.h,
  //                     ),
  //                     Container(
  //                       child: Center(
  //                           child: ShimmerEffect(
  //                         child: Container(
  //                           color: AppConst.black,
  //                           height: 2.h,
  //                           width: 20.w,
  //                         ),
  //                       )),
  //                     )
  //                   ],
  //                 ),
  //                 Column(
  //                   children: [
  //                     InkWell(
  //                       onTap: () {},
  //                       child: CircleAvatar(
  //                         radius: 6.w,
  //                         backgroundColor: AppConst.white,
  //                         foregroundImage: NetworkImage(
  //                             "https://img.freepik.com/free-vector/successful-financial-operation-business-accounting-invoice-report-happy-people-with-tax-receipt-duty-paying-money-savings-cash-income-vector-isolated-concept-metaphor-illustration_335657-2188.jpg?t=st=1649328544~exp=1649329144~hmac=635d4a3527c71f715e710f64fa046e8faf59de565b6be17f34a03ef3d5d8fa4d&w=826"),
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       height: 1.h,
  //                     ),
  //                     Container(
  //                       child: Center(
  //                           child: ShimmerEffect(
  //                         child: Container(
  //                           color: AppConst.black,
  //                           height: 2.h,
  //                           width: 20.w,
  //                         ),
  //                       )),
  //                     )
  //                   ],
  //                 ),
  //                 Column(
  //                   children: [
  //                     InkWell(
  //                       onTap: () {},
  //                       child: CircleAvatar(
  //                         radius: 6.w,
  //                         backgroundColor: AppConst.white,
  //                         foregroundImage: NetworkImage(
  //                             "https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg"),
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       height: 1.h,
  //                     ),
  //                     Container(
  //                       child: Center(
  //                           child: ShimmerEffect(
  //                         child: Container(
  //                           color: AppConst.black,
  //                           height: 2.h,
  //                           width: 20.w,
  //                         ),
  //                       )),
  //                     )
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}

class TransactionListShimmer extends StatelessWidget {
  TransactionListShimmer({Key? key}) : super(key: key);
  final MyWalletController _myWalletController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      (() => ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 5.w,
                      backgroundColor: AppConst.white,
                      foregroundImage: NetworkImage(
                          "https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg"),
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShimmerEffect(
                          child: Container(
                            color: AppConst.black,
                            height: 2.5.h,
                            width: 50.w,
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        ShimmerEffect(
                          child: Container(
                            color: AppConst.black,
                            height: 2.h,
                            width: 60.w,
                          ),
                        )
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        ShimmerEffect(
                          child: Container(
                            color: AppConst.black,
                            height: 2.h,
                            width: 8.w,
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        ShimmerEffect(
                          child: Container(
                            color: AppConst.black,
                            height: 2.h,
                            width: 8.w,
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
              return Divider();
            },
          )),
    );
  }
}
