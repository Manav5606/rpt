import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/constants/string_constants.dart';
import 'package:customer_app/screens/home/controller/home_controller.dart';
import 'package:customer_app/screens/home/models/homePageRemoteConfigModel.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../screens/more_stores/morestore_controller.dart';

class StoreWithProductsList extends StatelessWidget {
  final ScrollController? controller;

  StoreWithProductsList({Key? key, this.controller}) : super(key: key);
  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (_homeController.storeDataList.isEmpty)
          ? Center(
              child: Text(StringContants.noData),
            )
          : ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: _homeController.storeDataList.length,
              //data.length,
              itemBuilder: (context, index) {
                return ListViewChild(
                  storesWithProductsModel: _homeController.storeDataList[index],
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox();
                // Divider(
                //   thickness: 1,
                //   height: 2.h,
                // );
              },
            ),
    );
  }
}

class ListViewChild extends StatelessWidget {
  final Data storesWithProductsModel;

  ListViewChild({Key? key, required this.storesWithProductsModel})
      : super(key: key);
  final MoreStoreController _moreStoreController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          highlightColor: AppConst.highLightColor,
          onTap: () async {
            _moreStoreController.storeId.value =
                storesWithProductsModel.sId ?? '';
            await _moreStoreController.getStoreData(
              id: storesWithProductsModel.sId ?? '',
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                storesWithProductsModel.logo!.isEmpty
                    ? Padding(
                        padding: EdgeInsets.only(bottom: 1.h),
                        child: CircleAvatar(
                          child: Text(
                              storesWithProductsModel.name?.substring(0, 1) ??
                                  "",
                              style: TextStyle(
                                  fontSize: SizeUtils.horizontalBlockSize * 6)),
                          backgroundColor: AppConst.blue,
                          radius: SizeUtils.horizontalBlockSize * 6.5,
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(bottom: 1.h),
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage(storesWithProductsModel.logo!),
                          backgroundColor: AppConst.white,
                          radius: SizeUtils.horizontalBlockSize * 6.5,
                        ),
                      ),
                SizedBox(
                  width: 4.w,
                ),
                // Container(
                //   decoration: BoxDecoration(
                //       shape: BoxShape.circle,
                //       border: Border.all(color: AppConst.grey)),
                //   child: ClipOval(
                //     child: ClipRRect(
                //       child: CircleAvatar(
                //         backgroundImage:
                //             NetworkImage(storesWithProductsModel.logo!),
                //         backgroundColor: AppConst.white,
                //         radius: SizeUtils.horizontalBlockSize * 7,
                //       ),
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   width: 3.w,
                // ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        storesWithProductsModel.name!,
                        maxLines: 1,
                        style: AppStyles.STORE_NAME_STYLE,
                      ),
                      if (storesWithProductsModel.storeType?.isNotEmpty ??
                          false)
                        if ((storesWithProductsModel.storeType ?? '') ==
                            'online')
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Pickup /", style: AppStyles.BOLD_STYLE),
                              Text(
                                " Delivery",
                                style: AppStyles.BOLD_STYLE_GREEN,
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              (storesWithProductsModel.calculatedDistance !=
                                      null)
                                  ? Container(
                                      // margin: EdgeInsets.only(top: 0.5.h),
                                      padding: EdgeInsets.all(1.w),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          border:
                                              Border.all(color: AppConst.grey)),
                                      child: Text(
                                          "${(storesWithProductsModel.calculatedDistance!.toInt() / 1000).toStringAsFixed(2)} km away",
                                          // "${storesWithProductsModel.calculatedDistance!.toStringAsFixed(2)} km away",
                                          style: TextStyle(
                                              fontSize: SizeUtils
                                                      .horizontalBlockSize *
                                                  3,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Stag',
                                              color: AppConst.darkGrey,
                                              letterSpacing: 0.5)),
                                    )
                                  : SizedBox(),
                              SizedBox(
                                width: 2.w,
                              ),
                            ],
                          )
                        else
                          Row(
                            children: [
                              Text(StringContants.pickUp,
                                  style: AppStyles.BOLD_STYLE),
                              SizedBox(
                                width: 2.w,
                              ),
                              (storesWithProductsModel.calculatedDistance !=
                                      null)
                                  ? Container(
                                      // margin: EdgeInsets.only(top: 0.5.h),
                                      padding: EdgeInsets.all(1.w),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          border:
                                              Border.all(color: AppConst.grey)),
                                      child: Text(
                                          "${(storesWithProductsModel.calculatedDistance!.toInt() / 1000).toStringAsFixed(2)} km away",
                                          style: TextStyle(
                                              fontSize: SizeUtils
                                                      .horizontalBlockSize *
                                                  3,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Stag',
                                              color: AppConst.darkGrey,
                                              letterSpacing: 0.5)),
                                    )
                                  : SizedBox(),
                              SizedBox(
                                width: 2.w,
                              ),
                            ],
                          ),
                      // Row(
                      //   children: [
                      //     // Container(
                      //     //   margin: EdgeInsets.all(1.w),
                      //     //   padding: EdgeInsets.all(1.w),
                      //     //   decoration: BoxDecoration(
                      //     //       borderRadius: BorderRadius.circular(
                      //     //           SizeUtils.horizontalBlockSize * 1.5),
                      //     //       border: Border.all(color: AppConst.grey)),
                      //     //   child: Text(
                      //     //     "${StringContants.instoreprice}",
                      //     //     style: AppStyles.BOLD_STYLE,
                      //     //   ),
                      //     // ),
                      //     // (storesWithProductsModel.calculatedDistance != null)
                      //     //     ? Container(
                      //     //         margin: EdgeInsets.only(top: 1.h),
                      //     //         padding: EdgeInsets.all(1.w),
                      //     //         decoration: BoxDecoration(
                      //     //             borderRadius: BorderRadius.circular(4),
                      //     //             border: Border.all(color: AppConst.grey)),
                      //     //         child: Text(
                      //     //             "${storesWithProductsModel.calculatedDistance!.toStringAsFixed(2)} km away",
                      //     //             style: TextStyle(
                      //     //                 fontSize:
                      //     //                     SizeUtils.horizontalBlockSize * 3,
                      //     //                 fontWeight: FontWeight.w500,
                      //     //                 fontFamily: 'Stag',
                      //     //                 color: AppConst.darkGrey,
                      //     //                 letterSpacing: 0.5)),
                      //     //       )
                      //     //     : SizedBox(),
                      //     // SizedBox(
                      //     //   width: 2.w,
                      //     // ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 2.h),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppConst.grey,
                    size: SizeUtils.horizontalBlockSize * 5,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 1.h,
        ),
        storesWithProductsModel.products!.isEmpty
            ? Padding(
                padding: EdgeInsets.only(bottom: 1.h),
                child: Text(
                  "No Products",
                  style: AppStyles.STORE_NAME_STYLE,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      height: 25.h,
                      width: double.infinity,
                      child: ListView.separated(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        primary: false,
                        scrollDirection: Axis.horizontal,
                        itemCount: storesWithProductsModel.products!.length,
                        itemBuilder: (context, index) {
                          Products product =
                              storesWithProductsModel.products![index];
                          return Container(
                            width: 40.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                        child: Image.network(
                                      product.logo!,
                                      fit: BoxFit.fill,
                                      height: 15.h,
                                      width: 22.w,
                                    )),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: GestureDetector(
                                        onTap: () async {
                                          product.quntity!.value++;
                                          _moreStoreController.addToCart(
                                              store_id:
                                                  storesWithProductsModel.sId ??
                                                      '',
                                              index: 0,
                                              increment: true,
                                              cart_id: _moreStoreController
                                                      .addToCartModel
                                                      .value
                                                      ?.sId ??
                                                  '',
                                              product: product);
                                          _moreStoreController.storeId.value =
                                              storesWithProductsModel.sId ?? '';
                                          await _moreStoreController
                                              .getStoreData(
                                            id: storesWithProductsModel.sId ??
                                                '',
                                          );
                                          // Get.toNamed(AppRoutes.MoreStoreProductScreen);
                                        },
                                        child: Icon(
                                          Icons.add,
                                          size:
                                              SizeUtils.horizontalBlockSize * 7,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  " \u20b9 ${product.cashback.toString()}",
                                  style: AppStyles.STORE_NAME_STYLE,
                                ),
                                Flexible(
                                  child: Text(
                                    product.name.toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppStyles.STORE_NAME_STYLE,
                                  ),
                                ),
                                // Text(
                                //   storesWithProductsModel.quantity.toString(),
                                //   style: AppStyles.STORE_NAME_STYLE,
                                // )
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            width: 2.w,
                          );
                        },
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   width: 3.w,
                  // ),
                ],
              ),
      ],
    );
  }
}
