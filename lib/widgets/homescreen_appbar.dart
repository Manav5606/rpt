import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/widgets/cartWidget.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HomeAppBar extends StatelessWidget {
  final GestureTapCallback onTap;
  final GestureTapCallback? onTapWallet;
  final String address;
  final bool isRedDot;
  final String? balance;
  final bool isHomeScreen;

  HomeAppBar(
      {Key? key,
      required this.onTap,
      required this.address,
      required this.isRedDot,
      this.balance,
      this.onTapWallet,
      this.isHomeScreen = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 2.w, top: 1.h, bottom: 1.h, right: 2.w),
      color: AppConst.green,
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.location_on_rounded,
              color: AppConst.white,
              size: 3.h,
            ),

            SizedBox(
              width: 1.w,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Container(
                //   width: isHomeScreen ? 63.w : 40.w, // test
                //   child:
                Text(
                  address,
                  // maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: (SizerUtil.deviceType == DeviceType.tablet)
                        ? 8.5.sp
                        : 9.8.sp,
                    fontFamily: 'MuseoSans',
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    color: AppConst.white,
                  ),

                  // AppStyles.ADDRESS_STYLE,
                  // ),
                ),
                // SizedBox(
                //   width: 1.w,
                // ),
                Padding(
                  padding: EdgeInsets.only(),
                  child: Icon(
                    Icons.keyboard_arrow_down_outlined,
                    size: 2.h,
                    color: AppConst.white,
                  ),
                ),
              ],
            ),
            Spacer(),
            // isHomeScreen
            // ?
            GestureDetector(
              onTap: onTapWallet,
              child: Row(
                children: [
                  Icon(
                    Icons.account_balance_wallet_rounded,
                    color: AppConst.white,
                    size: 2.5.h,
                  ),
                  Text(
                    //\u{20B9}
                    " ${balance}", //?.toStringAsFixed(2)
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: (SizerUtil.deviceType == DeviceType.tablet)
                          ? 9.sp
                          : 11.sp,
                      fontFamily: 'MuseoSans',
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      color: AppConst.white,
                    ),
                  ),
                ],
              ),

              // Container(
              //   padding: EdgeInsets.symmetric(
              //     vertical: 0.7.h,
              //     horizontal: 1.w,
              //   ),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(20),
              //     color: AppConst.green,
              //   ),
              //   child: Row(
              //     children: [
              //       Icon(
              //         Icons.account_balance_wallet_rounded,
              //         color: AppConst.white,
              //         size: 2.8.h,
              //       ),
              //       Text(
              //         //\u{20B9}
              //         " ${balance}", //?.toStringAsFixed(2)
              //         maxLines: 1,
              //         style: TextStyle(
              //           fontSize: SizeUtils.horizontalBlockSize * 3.8,
              //           color: AppConst.white,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            )
            // : CartWidget(
            //     onTap: () async {
            //       //   log("_homeController.getAllCartsModel.value?.carts?.length :${_homeController.getAllCartsModel.value?.carts?.length}");
            //       //   if ((_homeController.getAllCartsModel.value?.carts?.length ?? 0) == 1) {
            //       //     await _addCartController.getReviewCartData(
            //       //         cartId: _homeController.getAllCartsModel.value?.carts?.first.sId ?? "");
            //       //     // await _addCartController.getCartPageInformation(storeId: _homeController.getAllCartsModel.value?.carts?[1].store?.sId ?? "");
            //       //     await _addCartController.getCartLocation(
            //       //         storeId: _homeController.getAllCartsModel.value?.carts?.first.store?.sId ?? "",
            //       //         cartId: _homeController.getAllCartsModel.value?.carts?.first.sId ?? "");
            //       //     _addCartController.store.value = _homeController.getAllCartsModel.value?.carts?.first.store;
            //       //     _addCartController.cartId.value = _homeController.getAllCartsModel.value?.carts?.first.sId ?? "";
            //       //     Get.toNamed(
            //       //       AppRoutes.CartReviewScreen,
            //       //       arguments: {
            //       //         'logo': _homeController.getAllCartsModel.value?.carts?.first.store?.logo,
            //       //         'storeName': _homeController.getAllCartsModel.value?.carts?.first.store?.name,
            //       //         'totalCount': _homeController.getAllCartsModel.value?.cartItemsTotal.toString() ?? "",
            //       //       },
            //       //     );
            //       //   } else {
            //       //     await Get.toNamed(AppRoutes.AddCartListScreen);
            //       //     if (Constants.isAbleToCallApi) await _homeController.getAllCartsData();
            //       //   }
            //     },
            //     count: '',
            //     isRedButton: isRedDot,
            //   )
          ],
        ),
      ),
    );
  }
}
