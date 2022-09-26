import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/ui/common/shimmer_widget.dart';
import 'package:customer_app/app/ui/pages/search/controller/exploreContoller.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/data/repositories/new_main_api.dart';
import 'package:customer_app/data/storeswithproductmodel.dart';
import 'package:customer_app/data/storeswithproductsdata.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:customer_app/widgets/arrowIcon.dart';
import 'package:get/get.dart';

class SearchedStoreProductsListShimmer extends StatelessWidget {
  final ScrollController? controller;
  SearchedStoreProductsListShimmer({Key? key, this.controller})
      : super(key: key);
  final ExploreController _exploreController = Get.find();
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: this.controller,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: storesWithProductsData.length, //data.length,
      itemBuilder: (context, index) {
        return ListViewChild(
          storesWithProductsModel: storesWithProductsData[index],
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: SizeUtils.horizontalBlockSize * 2.55,
        );
      },
    );
  }
}

class ListViewChild extends StatelessWidget {
  final StoresWithProductsModel storesWithProductsModel;
  const ListViewChild({Key? key, required this.storesWithProductsModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: SizeUtils.horizontalBlockSize * 2.55,
        ),
        InkWell(
          onTap: () => {},
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerEffect(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(storesWithProductsModel.image!),
                  backgroundColor: AppConst.white,
                  radius: SizeUtils.horizontalBlockSize * 7.65,
                ),
              ),
              ShimmerEffect(
                child: SizedBox(
                  width: SizeUtils.horizontalBlockSize * 2.55,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerEffect(
                      child: Text(
                        storesWithProductsModel.name!,
                        style: AppStyles.STORE_NAME_STYLE,
                      ),
                    ),
                    ShimmerEffect(
                      child: Row(
                        children: [
                          (storesWithProductsModel.category1!.isNotEmpty)
                              ? Text(
                                  '\u2022 ${storesWithProductsModel.category1!}')
                              : Text(''),
                          (storesWithProductsModel.category2!.isNotEmpty)
                              ? Text(
                                  '\u2022 ${storesWithProductsModel.category2!}')
                              : Text(''),
                          (storesWithProductsModel.category3!.isNotEmpty)
                              ? Text(
                                  '\u2022 ${storesWithProductsModel.category3!}')
                              : Text(''),
                        ],
                      ),
                    ),
                    if (storesWithProductsModel.pickup!.isEmpty &&
                        storesWithProductsModel.delivery!.isNotEmpty)
                      ShimmerEffect(
                        child: Text(
                          storesWithProductsModel.delivery!,
                          style: AppStyles.BOLD_STYLE_GREEN,
                        ),
                      )
                    else if (storesWithProductsModel.delivery!.isEmpty &&
                        storesWithProductsModel.pickup!.isNotEmpty)
                      ShimmerEffect(
                        child: Text(storesWithProductsModel.pickup!,
                            style: AppStyles.BOLD_STYLE_GREEN),
                      )
                    else
                      ShimmerEffect(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(storesWithProductsModel.pickup!,
                                style: AppStyles.BOLD_STYLE),
                            Text(
                              storesWithProductsModel.delivery!,
                              style: AppStyles.BOLD_STYLE_GREEN,
                            ),
                          ],
                        ),
                      ),
                    Row(
                      children: [
                        ShimmerEffect(
                          child: Container(
                            margin: EdgeInsets.all(
                                SizeUtils.horizontalBlockSize - 0.92),
                            padding: EdgeInsets.all(
                                SizeUtils.horizontalBlockSize - 0.92),
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
                              "${storesWithProductsModel.instoreprices!}",
                              style: AppStyles.STORES_SUBTITLE_STYLE,
                            ),
                          ),
                        ),
                        (storesWithProductsModel.distance!.isNotEmpty)
                            ? ShimmerEffect(
                                child: Container(
                                  margin: EdgeInsets.all(
                                      SizeUtils.horizontalBlockSize - 0.92),
                                  padding: EdgeInsets.all(
                                      SizeUtils.horizontalBlockSize - 0.92),
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
                                    "Pickup ${storesWithProductsModel.distance!} min",
                                    style: AppStyles.STORES_SUBTITLE_STYLE,
                                  ),
                                ),
                              )
                            : ShimmerEffect(child: Container()),
                      ],
                    ),
                  ],
                ),
              ),
              ShimmerEffect(child: ArrowForwardIcon())
            ],
          ),
        ),
        SizedBox(
          height: SizeUtils.horizontalBlockSize * 1.27,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: SizeUtils.horizontalBlockSize * 24,
              padding: EdgeInsets.fromLTRB(
                  0, SizeUtils.horizontalBlockSize * 2.55, 0, 0),
              child: ListView.separated(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 4, //storesWithProductsModel.products!.length,
                itemBuilder: (context, index) {
                  StoreProducts product =
                      storesWithProductsModel.products![index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerEffect(
                        child: Container(
                          height: SizeUtils.horizontalBlockSize * 17.3,
                          width: SizeUtils.horizontalBlockSize * 16.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                SizeUtils.horizontalBlockSize * 1.27),
                            image: DecorationImage(
                                image: NetworkImage(product.image!),
                                fit: BoxFit.fill),
                            gradient: RadialGradient(
                              colors: [
                                AppConst.white,
                                AppConst.veryLightGrey,
                              ],
                              radius: 1,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: SizeUtils.horizontalBlockSize * 3,
                        width: SizeUtils.horizontalBlockSize * 15.3,
                        child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: ShimmerEffect(
                              child: Text(
                                "20% cashback",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            )),
                      )
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    width: SizeUtils.horizontalBlockSize * 3.5,
                  );
                },
              ),
            ),
            SizedBox(
              width: SizeUtils.horizontalBlockSize * 2.55,
            ),
            ShimmerEffect(
              child: Container(
                height: SizeUtils.horizontalBlockSize * 15.3,
                width: SizeUtils.horizontalBlockSize * 15.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      SizeUtils.horizontalBlockSize * 1.27),
                  gradient: RadialGradient(
                    colors: [
                      AppConst.white,
                      AppConst.veryLightGrey,
                    ],
                    radius: 1,
                  ),
                ),
                child: Center(
                  child:
                      Text('+${storesWithProductsModel.products!.length - 4}'),
                ),
              ),
            ),
          ],
        ),
        Divider(
          thickness: 1,
        )
      ],
    );
  }
}
