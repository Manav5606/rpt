import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/ui/pages/search/controller/exploreContoller.dart';
import 'package:customer_app/app/ui/pages/search/models/GetStoreDataModel.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:customer_app/widgets/custom_popupmenu.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class StoreViewProductsList extends StatelessWidget {
  final ScrollController? controller;
  final Function(int)? onChange;

  StoreViewProductsList({Key? key, this.controller, this.onChange}) : super(key: key);

  final ExploreController _exploreController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      child: Obx(
        () => (_exploreController.getStoreDataModel.value?.data?.mainProducts?.isNotEmpty ?? false)
            ? ListView.separated(
                controller: this.controller,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: _exploreController.getStoreDataModel.value?.data?.mainProducts?.length ?? 0,
                //data.length,
                itemBuilder: (context, index) {
                  MainProducts? storesWithProductsModel = _exploreController.getStoreDataModel.value?.data?.mainProducts?[index];
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize * 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              storesWithProductsModel?.name ?? "",
                              style: AppStyles.STORE_NAME_STYLE,
                            ),
                            ((storesWithProductsModel?.products?.length ?? 0) > 5)
                                ? Text(
                                    "View More",
                                    style: TextStyle(
                                      fontSize: SizeUtils.horizontalBlockSize * 4,
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: SizeUtils.verticalBlockSize * 1,
                      ),
                      if (storesWithProductsModel!.products!.isEmpty)
                        SizedBox()
                      else
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                height: SizeUtils.verticalBlockSize * 20,
                                width: double.infinity,
                                child: ListView.separated(
                                  physics: ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: storesWithProductsModel.products?.length ?? 0,
                                  itemBuilder: (context, i) {
                                    StoreModelProducts product = storesWithProductsModel.products![i];
                                    return Container(
                                      width: SizeUtils.horizontalBlockSize * 40,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Stack(
                                            // crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Center(
                                                child: Image.network(
                                                  product.logo!,
                                                  fit: BoxFit.cover,
                                                  height: SizeUtils.verticalBlockSize * 12,
                                                  width: SizeUtils.horizontalBlockSize * 24,
                                                ),
                                              ),
                                              Obx(
                                                () => product.quntity!.value > 0 && product.isQunitityAdd?.value == false
                                                    ? _shoppingItem(product)
                                                    : GestureDetector(
                                                        onTap: () async {
                                                          if (product.quntity!.value == 0) {
                                                            product.quntity!.value++;
                                                            log("storesWithProductsModel?.products?[index] : ${product}");
                                                            _exploreController.addToCart(
                                                                cart_id: _exploreController.cartIndex.value?.sId ?? '',
                                                                store_id: storesWithProductsModel.sId ?? '',
                                                                index: 0,
                                                                increment: true,
                                                                product: product);
                                                          }
                                                          if (product.quntity!.value != 0 && product.isQunitityAdd?.value == false) {
                                                            product.isQunitityAdd?.value = false;
                                                            await Future.delayed(Duration(milliseconds: 500))
                                                                .whenComplete(() => product.isQunitityAdd?.value = true);
                                                          }
                                                          // addItem(product);
                                                        },
                                                        child: product.isQunitityAdd?.value == true && product.quntity!.value != 0
                                                            ? _dropDown(product, storesWithProductsModel.sId ?? '')
                                                            : Align(
                                                                alignment: Alignment.topRight,
                                                                child: Container(
                                                                  height: SizeUtils.horizontalBlockSize * 8,
                                                                  width: SizeUtils.horizontalBlockSize * 8,
                                                                  decoration: BoxDecoration(
                                                                    shape: BoxShape.circle,
                                                                    color: AppConst.grey,
                                                                  ),
                                                                  child: product.isQunitityAdd?.value == true && product.quntity!.value != 0
                                                                      ? Center(
                                                                          child: Text("${product.quntity!.value}",
                                                                              style: TextStyle(
                                                                                color: AppConst.white,
                                                                                fontSize: SizeUtils.horizontalBlockSize * 4,
                                                                              )),
                                                                        )
                                                                      : Icon(
                                                                          Icons.add,
                                                                          color: AppConst.white,
                                                                        ),
                                                                ),
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
                    height: 2.h,
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
      ),
    );
  }

  List<String> quntityList = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];

  Widget _dropDown(product, String sId) {
    return Obx(
      () => CustomPopMenu(
        title: 'Quantity',
        child: Align(
          alignment: Alignment.topRight,
          child: Container(
            height: SizeUtils.horizontalBlockSize * 8,
            width: SizeUtils.horizontalBlockSize * 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppConst.grey,
            ),
            child: product.isQunitityAdd?.value == true && product.quntity!.value != 0
                ? Center(
                    child: Text("${product.quntity!.value}",
                        style: TextStyle(
                          color: AppConst.white,
                          fontSize: SizeUtils.horizontalBlockSize * 4,
                        )),
                  )
                : Icon(
                    Icons.add,
                    color: AppConst.white,
                  ),
          ),
        ),
        list: quntityList,
        onSelected: (value) async {
          product.quntity!.value = value;
          if (product.quntity!.value == 0) {
            product.isQunitityAdd?.value = false;
          }
          log('product :${product.name}');
          _exploreController.addToCart(
              cart_id: _exploreController.cartIndex.value?.sId ?? '', store_id: sId, index: 0, increment: true, product: product);
        },
      ),
    );
  }

  Widget _shoppingItem(product) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeUtils.horizontalBlockSize * 5),
        color: AppConst.grey,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: SizeUtils.verticalBlockSize * 1),
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _decrementButton(product),
              Text(
                '${product.quntity!.value}',
                style: TextStyle(fontSize: SizeUtils.horizontalBlockSize * 5, fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              _incrementButton(product),
            ],
          ),
        ),
      ),
    );
  }

  Widget _incrementButton(product) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppConst.white,
        ),
        child: Icon(
          Icons.add,
          color: AppConst.grey,
        ),
      ),
      onTap: () async {
        product.isQunitityAdd?.value = false;
        product.quntity!.value++;
        await Future.delayed(Duration(seconds: 2)).whenComplete(() => product.isQunitityAdd?.value = true);
        // addItem(products);
      },
    );
  }

  Widget _decrementButton(product) {
    return GestureDetector(
      onTap: () async {
        product.isQunitityAdd?.value = false;
        product.quntity!.value--;
        await Future.delayed(Duration(seconds: 2)).whenComplete(() => product.isQunitityAdd?.value = true);
        // addItem(products);
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppConst.white,
        ),
        child: Icon(
          Icons.remove,
          color: AppConst.grey,
        ),
      ),
    );
  }
}
