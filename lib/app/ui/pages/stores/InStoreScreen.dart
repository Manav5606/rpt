import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/ui/pages/stores/storedetailscreen.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/screens/addcart/controller/addcart_controller.dart';
import 'package:customer_app/screens/home/controller/home_controller.dart';
import 'package:customer_app/widgets/backButton.dart';
import 'package:customer_app/widgets/cartWidget.dart';
import 'package:customer_app/widgets/instorelist.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class InStoreScreen extends StatelessWidget {
  final HomeController _homeController = Get.find();
  final AddCartController _addCartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: NestedScrollView(
          physics: BouncingScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            var category = _homeController.getHomePageFavoriteShopsModel.value!.keywords!;
            return <Widget>[
              SliverAppBar(
                expandedHeight: 18.h,
                centerTitle: true,
                pinned: true,
                stretch: true,
                floating: true,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                title: (innerBoxIsScrolled)
                    ? CircleAvatar(
                        backgroundColor: AppConst.white, radius: SizeUtils.horizontalBlockSize * 3.82, child: Image.asset("assets/images/image4.png"))
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            // "Pickup",
                            category.first.name.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontFamily: 'MuseoSans',
                                fontSize: SizeUtils.horizontalBlockSize * 5,
                                color: AppConst.black),
                          ),
                        ],
                      ),
                leading: BackButtonCircle(),
                //  SizedBox(),
                //     IconButton(
                //   onPressed: () {
                //     Get.back();
                //   },
                //   // color: Colors.white,
                //   icon: Icon(
                //     Icons.arrow_back_rounded,
                //     size: SizeUtils.horizontalBlockSize * 7,
                //     color: Colors.black,
                //   ),
                // ),
                actions: [
                  CartWidget(
                    onTap: () async {
                      if ((_homeController.getAllCartsModel.value?.carts?.length ?? 0) == 1) {
                        Get.toNamed(
                          AppRoutes.CartReviewScreen,
                          arguments: {
                            'logo': _homeController.getAllCartsModel.value?.carts?.first.store?.logo,
                            'storeName': _homeController.getAllCartsModel.value?.carts?.first.store?.name,
                            'totalCount': _homeController.getAllCartsModel.value?.cartItemsTotal.toString() ?? "",
                          },
                        );
                        await _addCartController.getReviewCartData(cartId: _homeController.getAllCartsModel.value?.carts?[1].sId ?? "");
                        // await _addCartController.getCartPageInformation(storeId: _homeController.getAllCartsModel.value?.carts?[1].store?.sId ?? "");
                        await _addCartController.getCartLocation(
                            storeId: _homeController.getAllCartsModel.value?.carts?.first.store?.sId ?? "",
                            cartId: _homeController.getAllCartsModel.value?.carts?.first.sId ?? "");
                        _addCartController.store.value = _homeController.getAllCartsModel.value?.carts?.first.store;
                        _addCartController.cartId.value = _homeController.getAllCartsModel.value?.carts?.first.sId ?? "";
                      }
                      Get.toNamed(AppRoutes.AddCartListScreen);
                    },
                    count: _homeController.getAllCartsModel.value?.cartItemsTotal.toString() ?? "",
                  ),
                  SizedBox(
                    width: 2.w,
                  )
                ],
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  collapseMode: CollapseMode.parallax,
                  background: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Stack(
                        children: [
                          Positioned(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 18.h,
                              color: Colors.yellow,
                              child: Image.network(
                                category.first.image,
                                fit: BoxFit.fill,
                                height: SizeUtils.verticalBlockSize * 12,
                                width: SizeUtils.horizontalBlockSize * 24,
                              ),
                            ),
                          ),
                          // Positioned(
                          //   top: 6,
                          //   left: 10,
                          //   child: CircleAvatar(
                          //       radius: 2.4.h,
                          //       backgroundColor: AppConst.white,
                          //       child: const SizedBox()),
                          // ),
                          Positioned(
                            bottom: 15,
                            left: 10,
                            child: Text(
                              category.first.name.toString(),
                              // "Pickup",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'MuseoSans',
                                  fontSize: SizeUtils.horizontalBlockSize * 6,
                                  color: AppConst.black),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                    ],
                  ),
                ),
              ),
              // SliverAppBar(
              //   expandedHeight: 18.h,
              //   pinned: true,
              //   floating: true,
              //   snap: true,
              //   leading: BackButtonWidget(),
              //   actions: [
              //     CartWidget(),
              //   ],
              //   flexibleSpace: FlexibleSpaceBar(
              //     centerTitle: innerBoxIsScrolled,
              //     title: Text(
              //       'In-Store Prices',
              //       style: TextStyle(color: AppConst.black),
              //     ),
              //     collapseMode: CollapseMode.parallax,
              //     titlePadding: EdgeInsets.only(bottom: 0.5.h, left: 2.w),
              //     background: Image.network(
              //       'https://img.freepik.com/free-vector/profitable-pricing-strategy-price-formation-promo-action-clearance-shopping-idea-design-element-cheap-products-advertisement-customers-attraction_335657-1627.jpg?t=st=1648791828~exp=1648792428~hmac=ec422dc7ea557ba1d914f455df088665adf4e08b13d044c9f76814013962ccc7&w=826',
              //       fit: BoxFit.contain,
              //     ),
              //   ),
              // )
            ];
          },
          body: Padding(
            padding: EdgeInsets.only(
              top: 1.h,
              left: 2.w,
              right: 2.w,
            ),
            child: SingleChildScrollView(
              controller: _homeController.remoteConfigScrollController,
              child: Column(
                children: [
                  InStoreList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
