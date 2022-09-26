import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/widgets/cartWidget.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HomeAppBar extends StatelessWidget {
  final GestureTapCallback onTap;
  final String address;
  final bool isRedDot;

  const HomeAppBar({Key? key, required this.onTap, required this.address, required this.isRedDot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.location_on_rounded,
            color: AppConst.black,
            size: SizeUtils.horizontalBlockSize * 7.5,
          ),
          SizedBox(
            width: 1.w,
          ),
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    address,
                    // maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: SizeUtils.horizontalBlockSize * 4,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'MuseoSans-500.otf',
                        color: AppConst.black,
                        letterSpacing: 0.4),

                    // AppStyles.ADDRESS_STYLE,
                  ),
                ),
                SizedBox(
                  width: 1.w,
                ),
                Icon(
                  Icons.keyboard_arrow_down_outlined,
                  size: 6.w,
                ),
              ],
            ),
          ),
          CartWidget(
            onTap: () async {
              //   log("_homeController.getAllCartsModel.value?.carts?.length :${_homeController.getAllCartsModel.value?.carts?.length}");
              //   if ((_homeController.getAllCartsModel.value?.carts?.length ?? 0) == 1) {
              //     await _addCartController.getReviewCartData(
              //         cartId: _homeController.getAllCartsModel.value?.carts?.first.sId ?? "");
              //     // await _addCartController.getCartPageInformation(storeId: _homeController.getAllCartsModel.value?.carts?[1].store?.sId ?? "");
              //     await _addCartController.getCartLocation(
              //         storeId: _homeController.getAllCartsModel.value?.carts?.first.store?.sId ?? "",
              //         cartId: _homeController.getAllCartsModel.value?.carts?.first.sId ?? "");
              //     _addCartController.store.value = _homeController.getAllCartsModel.value?.carts?.first.store;
              //     _addCartController.cartId.value = _homeController.getAllCartsModel.value?.carts?.first.sId ?? "";
              //     Get.toNamed(
              //       AppRoutes.CartReviewScreen,
              //       arguments: {
              //         'logo': _homeController.getAllCartsModel.value?.carts?.first.store?.logo,
              //         'storeName': _homeController.getAllCartsModel.value?.carts?.first.store?.name,
              //         'totalCount': _homeController.getAllCartsModel.value?.cartItemsTotal.toString() ?? "",
              //       },
              //     );
              //   } else {
              //     await Get.toNamed(AppRoutes.AddCartListScreen);
              //     if (Constants.isAbleToCallApi) await _homeController.getAllCartsData();
              //   }
            },
            count: '',
            isRedButton: isRedDot,
          ),
        ],
      ),
    );
  }
}
