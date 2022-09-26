import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:customer_app/widgets/backButton.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';

import '../../routes/app_list.dart';
import '../home/controller/home_controller.dart';
import 'controller/addcart_controller.dart';

class AddCartListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        minimum:
            EdgeInsets.only(top: SizeUtils.verticalBlockSize * 2, left: SizeUtils.horizontalBlockSize * 2, right: SizeUtils.horizontalBlockSize * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BackButtonWidget(),
            SizedBox(
              height: SizeUtils.verticalBlockSize * 1,
            ),
            Text(
              "Orders",
              style: TextStyle(fontSize: SizeUtils.horizontalBlockSize * 8, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: SizeUtils.verticalBlockSize * 2,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: AddCardList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddCardList extends StatelessWidget {
  final HomeController _homeController = Get.find();
  final AddCartController _addCartController = Get.find();

  AddCardList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _homeController.getAllCartsModel.value?.carts?.length ?? 0,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Nov 5,2020, 4:23 Pm',
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.STORES_SUBTITLE_STYLE,
                ),
                Text(
                  '14 items- 112.5',
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.STORES_SUBTITLE_STYLE,
                ),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage('https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg'),
                  backgroundColor: AppConst.white,
                  radius: SizeUtils.horizontalBlockSize * 6,
                ),
                SizedBox(
                  width: 2.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _homeController.getAllCartsModel.value?.carts?[index].store?.name ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.STORE_NAME_STYLE,
                      ),
                      Text(
                        'Sprouts Farmers Market',
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.STORES_SUBTITLE_STYLE,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    Get.toNamed(AppRoutes.CartReviewScreen,
                      arguments: {
                        'logo': _homeController.getAllCartsModel.value?.carts?[index].store?.logo,
                        'storeName': _homeController.getAllCartsModel.value?.carts?[index].store?.name,
                        'totalCount':  _homeController.getAllCartsModel.value?.carts?[index].totalItemsCount?.value.toString() ?? "",
                      },);
                    await _addCartController.getReviewCartData(cartId: _homeController.getAllCartsModel.value?.carts?[index].sId ?? "");
                    // await _addCartController.getCartPageInformation(storeId: _homeController.getAllCartsModel.value?.carts?[index].store?.sId ?? "");
                    await _addCartController.getCartLocation(
                        storeId: _homeController.getAllCartsModel.value?.carts?[index].store?.sId ?? "",
                        cartId: _homeController.getAllCartsModel.value?.carts?[index].sId ?? "");
                    _addCartController.store.value = _homeController.getAllCartsModel.value?.carts?[index].store;
                    _addCartController.cartId.value = _homeController.getAllCartsModel.value?.carts?[index].sId ?? "";
                  },
                  child: Container(
                    margin: EdgeInsets.all(1.w),
                    padding: EdgeInsets.all(1.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(SizeUtils.horizontalBlockSize * 1),
                      border: Border.all(color: AppConst.green, width: 1),
                    ),
                    child: Text(
                      "Add all to cart",
                      style: AppStyles.BOLD_STYLE_GREEN,
                    ),
                  ),
                )
              ],
            ),
            Text(
              'item  - ${_homeController.getAllCartsModel.value?.carts?[index].totalItemsCount ?? ""}',
              overflow: TextOverflow.ellipsis,
              style: AppStyles.STORES_SUBTITLE_STYLE,
            ),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          thickness: 1,
        );
      },
    );
  }
}
