import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/ui/pages/stores/recommendedList.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/screens/addcart/controller/addcart_controller.dart';
import 'package:customer_app/screens/home/controller/home_controller.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:customer_app/widgets/cartWidget.dart';
import 'package:get/get.dart';

class CheckOutScreen extends StatelessWidget {
  // final HomeController _homeController = Get.find();
  final AddCartController _addCartController = Get.find();

  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);

    return SafeArea(
        minimum: EdgeInsets.only(
            top: SizeUtils.horizontalBlockSize * 3.82,
            left: SizeUtils.horizontalBlockSize * 2.55,
            right: SizeUtils.horizontalBlockSize * 2.55),
        child: Scaffold(
          body: Column(
            children: [
              Container(
                height: SizeUtils.horizontalBlockSize * 20,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        color: AppConst.black,
                        icon: Icon(
                          Icons.cancel_rounded,
                          size: SizeUtils.horizontalBlockSize * 8.9,
                          //color: AppConst.white,
                        )),
                    Container(
                      height: SizeUtils.horizontalBlockSize * 15,
                      width: SizeUtils.horizontalBlockSize * 55,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              "Sprouts Market",
                              style: AppStyles.STORE_NAME_STYLE,
                            ),
                          ),
                          Text(
                            "Shopping in 94103",
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                    // CartWidget(
                    //   onTap: () async {
                    //     if ((_homeController
                    //                 .getAllCartsModel.value?.carts?.length ??
                    //             0) ==
                    //         1) {
                    //       Get.toNamed(
                    //         AppRoutes.CartReviewScreen,
                    //         arguments: {
                    //           'logo': _homeController.getAllCartsModel.value
                    //               ?.carts?[1].store?.logo,
                    //           'storeName': _homeController.getAllCartsModel
                    //               .value?.carts?[1].store?.name,
                    //           'totalCount': _homeController
                    //                   .getAllCartsModel.value?.cartItemsTotal
                    //                   .toString() ??
                    //               "",
                    //         },
                    //       );
                    //       await _addCartController.getReviewCartData(
                    //           cartId: _homeController
                    //                   .getAllCartsModel.value?.carts?[1].sId ??
                    //               "");
                    //       // await _addCartController.getCartPageInformation(storeId: _homeController.getAllCartsModel.value?.carts?[1].store?.sId ?? "");
                    //       await _addCartController.getCartLocation(
                    //           storeId: _homeController.getAllCartsModel.value
                    //                   ?.carts?[1].store?.sId ??
                    //               "",
                    //           cartId: _homeController
                    //                   .getAllCartsModel.value?.carts?[1].sId ??
                    //               "");
                    //       _addCartController.store.value = _homeController
                    //           .getAllCartsModel.value?.carts?[1].store;
                    //       _addCartController.cartId.value = _homeController
                    //               .getAllCartsModel.value?.carts?[1].sId ??
                    //           "";
                    //     }
                    //     Get.toNamed(AppRoutes.AddCartListScreen);
                    //   },
                    //   count: _homeController
                    //           .getAllCartsModel.value?.cartItemsTotal
                    //           .toString() ??
                    //       "",
                    // ),
                  ],
                ),
                decoration: BoxDecoration(color: AppConst.white, boxShadow: [
                  BoxShadow(
                      color: AppConst.grey.withOpacity(0.5),
                      spreadRadius: -3,
                      blurRadius: 5,
                      offset: Offset(0, 6)),
                ]),
              ),
              Expanded(child: SingleChildScrollView(child: RecommendedList())),
              Container(
                height: SizeUtils.horizontalBlockSize * 15,
                width: double.infinity,
                child: Container(
                  height: SizeUtils.horizontalBlockSize * 15,
                  width: SizeUtils.horizontalBlockSize * 85,
                  decoration: BoxDecoration(
                      color: AppConst.green,
                      borderRadius: BorderRadius.circular(
                          SizeUtils.horizontalBlockSize * 5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "Go to Checkout",
                          style: TextStyle(
                              color: AppConst.white,
                              fontSize: SizeUtils.horizontalBlockSize * 5),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        height: SizeUtils.horizontalBlockSize * 10,
                        width: SizeUtils.horizontalBlockSize * 20,
                        decoration: BoxDecoration(
                            color: AppConst.kSecondaryColor,
                            borderRadius: BorderRadius.circular(
                                SizeUtils.horizontalBlockSize * 5)),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "\$25",
                            style: TextStyle(color: AppConst.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
