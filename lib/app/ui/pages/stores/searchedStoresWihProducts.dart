import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/ui/pages/search/controller/exploreContoller.dart';
import 'package:customer_app/app/ui/pages/search/models/GetProductsByNameModel.dart';
import 'package:customer_app/app/ui/pages/stores/searchedStoresWihProductsShimmer.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/constants/string_constants.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:customer_app/widgets/arrowIcon.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SearchedStoreProductsList extends StatelessWidget {
  final ScrollController? controller;

  SearchedStoreProductsList({Key? key, this.controller}) : super(key: key);
  final ExploreController _exploreController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _exploreController.isLoading.value
          ? SearchedStoreProductsListShimmer()
          : ListView.separated(
              controller: this.controller,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _exploreController
                      .getProductsByNameModel.value?.data?.products?.length ??
                  0,
              itemBuilder: (context, index) {
                return ListViewChild(
                  storesWithProductsModel: _exploreController
                      .getProductsByNameModel.value!.data!.products![index],
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  thickness: 1,
                  height: 2.5.h,
                );
              },
            ),
    );
  }
}

class ListViewChild extends StatelessWidget {
  final ProductsData storesWithProductsModel;

  const ListViewChild({Key? key, required this.storesWithProductsModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 2.h,
        ),
        InkWell(
          onTap: () => {},
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: AppConst.white,
                radius: SizeUtils.horizontalBlockSize * 7.65,
                child: CachedNetworkImage(
                  imageUrl: storesWithProductsModel.store?.logo ??
                      'https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg',
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => Image.network(
                      'https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg'),
                ),
              ),
              SizedBox(
                width: 3.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      storesWithProductsModel.store?.name ?? '',
                      style: AppStyles.STORE_NAME_STYLE,
                    ),
                    // Row(
                    //   children: [
                    //     (storesWithProductsModel.category1!.isNotEmpty) ? Text('\u2022 ${storesWithProductsModel.category1!}') : Text(''),
                    //     (storesWithProductsModel.category2!.isNotEmpty) ? Text('\u2022 ${storesWithProductsModel.category2!}') : Text(''),
                    //     (storesWithProductsModel.category3!.isNotEmpty) ? Text('\u2022 ${storesWithProductsModel.category3!}') : Text(''),
                    //   ],
                    // ),
                    if (storesWithProductsModel.store?.storeType?.isNotEmpty ??
                        false)
                      if ((storesWithProductsModel.store?.storeType ?? '') ==
                          'online')
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Pickup/", style: AppStyles.BOLD_STYLE),
                            Text(
                              "Delivery",
                              style: AppStyles.BOLD_STYLE_GREEN,
                            ),
                          ],
                        )
                      else
                        Text(StringContants.pickUp,
                            style: AppStyles.BOLD_STYLE),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.all(1.w),
                          padding: EdgeInsets.all(1.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                SizeUtils.horizontalBlockSize * 3.82),
                            color: AppConst.white,
                            boxShadow: [
                              BoxShadow(
                                color: AppConst.grey.withOpacity(0.5),
                                spreadRadius: 1.5,
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          child: Text(
                            StringContants.instoreprice,
                            style: AppStyles.STORES_SUBTITLE_STYLE,
                          ),
                        ),
                        (storesWithProductsModel.store?.calculatedDistance !=
                                null)
                            ? Container(
                                margin: EdgeInsets.all(1.w),
                                padding: EdgeInsets.all(1.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      SizeUtils.horizontalBlockSize * 3.82),
                                  color: AppConst.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppConst.grey.withOpacity(0.5),
                                      spreadRadius: 1.5,
                                      blurRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Text(
                                  "${storesWithProductsModel.store?.calculatedDistance!.toStringAsFixed(2)} mi away",
                                  style: AppStyles.STORES_SUBTITLE_STYLE,
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                child: ArrowForwardIcon(),
              ),
            ],
          ),
        ),
        // SizedBox(
        //   height: SizeUtils.horizontalBlockSize * 1.27,
        // ),

        /// When Product is Availbe in List
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: [
        //     Container(
        //       height: SizeUtils.horizontalBlockSize * 24,
        //       padding: EdgeInsets.fromLTRB(0, SizeUtils.horizontalBlockSize * 2.55, 0, 0),
        //       child: ListView.separated(
        //         physics: ClampingScrollPhysics(),
        //         shrinkWrap: true,
        //         scrollDirection: Axis.horizontal,
        //         itemCount: 4,
        //         //storesWithProductsModel.products!.length,
        //         itemBuilder: (context, index) {
        //           StoreProducts product = storesWithProductsModel.products![index];
        //           return Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Container(
        //                 height: SizeUtils.horizontalBlockSize * 17.3,
        //                 width: SizeUtils.horizontalBlockSize * 16.3,
        //                 decoration: BoxDecoration(
        //                   borderRadius: BorderRadius.circular(SizeUtils.horizontalBlockSize * 1.27),
        //                   image: DecorationImage(image: NetworkImage(product.image!), fit: BoxFit.fill),
        //                   gradient: RadialGradient(
        //                     colors: [
        //                       AppConst.white,
        //                       Color.fromRGBO(221, 226, 234, 1),
        //                     ],
        //                     radius: 1,
        //                   ),
        //                 ),
        //               ),
        //               Container(
        //                 height: SizeUtils.horizontalBlockSize * 3,
        //                 width: SizeUtils.horizontalBlockSize * 15.3,
        //                 child: FittedBox(
        //                     fit: BoxFit.scaleDown,
        //                     child: Text(
        //                       "20% cashback",
        //                       style: TextStyle(fontWeight: FontWeight.w700),
        //                     )),
        //               )
        //             ],
        //           );
        //         },
        //         separatorBuilder: (context, index) {
        //           return SizedBox(
        //             width: SizeUtils.horizontalBlockSize * 3.5,
        //           );
        //         },
        //       ),
        //     ),
        //     SizedBox(
        //       width: SizeUtils.horizontalBlockSize * 2.55,
        //     ),
        //     Container(
        //       height: SizeUtils.horizontalBlockSize * 15.3,
        //       width: SizeUtils.horizontalBlockSize * 15.3,
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(SizeUtils.horizontalBlockSize * 1.27),
        //         gradient: RadialGradient(
        //           colors: [
        //             AppConst.white,
        //             Color.fromRGBO(221, 226, 234, 1),
        //           ],
        //           radius: 1,
        //         ),
        //       ),
        //       child: Center(
        //         child: Text('+${storesWithProductsModel.products!.length - 4}'),
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
