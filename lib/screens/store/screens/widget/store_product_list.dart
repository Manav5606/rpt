import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/ui/pages/search/models/GetStoreDataModel.dart';
import 'package:customer_app/screens/store/controller/store_controller.dart';
import 'package:customer_app/screens/store/screens/widget/quantity_dropdown.dart';
import 'package:customer_app/theme/app_dimens.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class StoreProductList extends StatelessWidget {
  StoreProductList({Key? key}) : super(key: key);

  final StoreController _storeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (_storeController.storeDataModel?.data?.mainProducts?.isNotEmpty ??
              false)
          ? ListView.separated(
              // controller: this.controller,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount:
                  _storeController.storeDataModel?.data?.mainProducts?.length ??
                      0,
              //data.length,
              itemBuilder: (context, index) {
                MainProducts? storesWithProductsModel =
                    _storeController.storeDataModel?.data?.mainProducts?[index];
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
                                  storesWithProductsModel.products![index],
                                  storesWithProductsModel.sId,
                                ),
                              ),
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

  Widget ProjectCard(StoreModelProducts product, String? storeId) {
    return Container(
      // width: 40.w,
      // height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.network(
              product.logo ?? 'https://via.placeholder.com/40x40.png',
              fit: BoxFit.cover,
              height: 14.h,
              width: 24.w,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "${product.name.toString()}",
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
                    "Cashback \u20b9${product.cashback.toString()}",
                    style: AppStyles.NEW_STORE_TEXT_BOLD,
                  ),
                  Text(
                    "\u20b9 '2/'${product.quntity}kg",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.NEW_STORES_SUBTITLE_STYLE,
                  ),
                ],
              ),
              QuantityDropdown(
                  defaultSelected: _storeController.getCartItems(product.sId!),
                  onChanged: (value) {
                    // _storeController.cartItemsModel.sId;
                    _storeController.addToCart(
                      product: product,
                      count: value,
                    );
                    // totalCalculated();
                  }),
            ],
          ),
          SizedBox(height: 6)
        ],
      ),
    );
  }
}
