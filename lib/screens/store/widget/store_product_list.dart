import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/ui/pages/search/models/GetStoreDataModel.dart';
import 'package:customer_app/screens/store/store_controller.dart';
import 'package:customer_app/screens/store/widget/quantity_dropdown.dart';
import 'package:customer_app/theme/app_dimens.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class StoreProductList extends StatelessWidget {
  StoreProductList({Key? key}) : super(key: key);

  final StoreController _moreStoreController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (_moreStoreController
                  .getStoreDataModel.value?.data?.mainProducts?.isNotEmpty ??
              false)
          ? ListView.separated(
              // controller: this.controller,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: _moreStoreController
                      .getStoreDataModel.value?.data?.mainProducts?.length ??
                  0,
              //data.length,
              itemBuilder: (context, index) {
                MainProducts? storesWithProductsModel = _moreStoreController
                    .getStoreDataModel.value?.data?.mainProducts?[index];
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeUtils.horizontalBlockSize * 2,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            storesWithProductsModel?.name ?? "",
                            style: AppStyles.STORE_NAME_STYLE,
                          ),
                          // ((storesWithProductsModel?.products?.length ?? 0) > 5)
                          //     ? Text(
                          //         "View More",
                          //         style: TextStyle(
                          //           fontSize: SizeUtils.horizontalBlockSize * 4,
                          //         ),
                          //       )
                          //     : SizedBox(),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (storesWithProductsModel!.products!.isNotEmpty)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              height: 180 * (4 / 2),
                              width: double.infinity,
                              child: GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: Dimens.paddingXS,
                                  mainAxisSpacing: Dimens.paddingS,
                                ),
                                primary: false,
                                // padding: const EdgeInsets.all(Dimens.paddingXS),
                                itemCount:
                                    storesWithProductsModel.products?.length ??
                                        0,
                                itemBuilder: (context, index) => ProjectCard(
                                    storesWithProductsModel.products![index]),
                              ),

                              // child: ListView.separated(
                              //   physics: ClampingScrollPhysics(),
                              //   shrinkWrap: true,
                              //   scrollDirection: Axis.horizontal,
                              //   itemCount:
                              //       storesWithProductsModel.products?.length ??
                              //           0,
                              //   itemBuilder: (context, i) {
                              //     StoreModelProducts product =
                              //         storesWithProductsModel.products![i];
                              //     return item();
                              //   },
                              //   separatorBuilder: (context, index) {
                              //     return SizedBox(
                              //       width: 2.w,
                              //     );
                              //   },
                              // ),
                            ),
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                        ],
                      ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  thickness: 1,
                  height: 4.h,
                );
              },
            )
          : Center(
              child: Text(
                'No data Found',
                style: TextStyle(
                  fontSize: SizeUtils.horizontalBlockSize * 5,
                ),
              ),
            ),
    );
  }

  Widget ProjectCard(StoreModelProducts item) {
    return Container(
      // width: 40.w,
      // height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.network(
              item.logo ?? 'https://via.placeholder.com/40x40.png',
              fit: BoxFit.cover,
              height: 14.h,
              width: 24.w,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "${item.toString()}",
            style: AppStyles.NEW_STORE_NAME_STYLE,
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Cashback \u20b9${item.cashback.toString()}",
                    style: AppStyles.NEW_STORE_TEXT_BOLD,
                  ),
                  Text(
                    "\u20b9 '2/'${item.quntity}kg",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.NEW_STORES_SUBTITLE_STYLE,
                  ),
                ],
              ),
              QuantityDropdown(
                  defaultSelected: _moreStoreController.totalItemsCount,
                  onChanged: (value) {
                    item.quntity!.value = value;
                    if (item.quntity!.value == 0) {
                      item.isQunitityAdd?.value = false;
                    }
                    _moreStoreController.addToCart(
                      store_id: item.sId!,
                      index: 0,
                      increment: true,
                      product: item,
                      cart_id:
                          _moreStoreController.addToCartModel.value?.sId ?? '',
                    );
                    // totalCalculated();
                  }),
              //      AddToCart(onAdd: (){
              //       item.quntity!.value = 2;
              // if (item.quntity!.value == 0) {
              //   item.isQunitityAdd?.value = false;
              // }
              //       _moreStoreController.addToCart(
              //   store_id: item.sId!,
              //   index: 0,
              //   increment: true,
              //   product: item,
              //   cart_id: _moreStoreController.addToCartModel.value?.sId ?? '',
              // );
              // // totalCalculated();
              //      }, onRemove: (){
              //      }, isAdded: false,
              //      )
            ],
          ),
          SizedBox(height: 6)
        ],
      ),
    );
  }
}
