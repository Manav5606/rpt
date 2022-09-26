import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/ui/pages/stores/storeswithproductslist.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/screens/addcart/controller/addcart_controller.dart';
import 'package:customer_app/screens/home/controller/home_controller.dart';
import 'package:customer_app/widgets/cartWidget.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class StoreListScreen extends StatefulWidget {
  @override
  State<StoreListScreen> createState() => _StoreListScreenState();
}

class _StoreListScreenState extends State<StoreListScreen> with TickerProviderStateMixin {
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
                backgroundColor: AppConst.white,
                title: (innerBoxIsScrolled)
                    ? CircleAvatar(
                        backgroundColor: AppConst.white,
                        radius: SizeUtils.horizontalBlockSize * 3.82,
                        child: Image.asset("assets/images/image4.png"),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            category.last.name.toString(),
                            // "Pickup",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontFamily: 'MuseoSans',
                                fontSize: SizeUtils.horizontalBlockSize * 5,
                                color: AppConst.black),
                          ),
                          // ),
                        ],
                      ),
                leading: BackButtonCircle(),
                //  SizedBox(),

                actions: [
                  CartWidget(
                    onTap: () async {
                      if ((_homeController.getAllCartsModel.value?.carts?.length ?? 0) == 1) {
                        Get.toNamed(
                          AppRoutes.CartReviewScreen,
                          arguments: {
                            'logo': _homeController.getAllCartsModel.value?.carts?[1].store?.logo,
                            'storeName': _homeController.getAllCartsModel.value?.carts?[1].store?.name,
                            'totalCount': _homeController.getAllCartsModel.value?.cartItemsTotal.toString() ?? ""
                          },
                        );
                        await _addCartController.getReviewCartData(cartId: _homeController.getAllCartsModel.value?.carts?[1].sId ?? "");
                        // await _addCartController.getCartPageInformation(storeId: _homeController.getAllCartsModel.value?.carts?[1].store?.sId ?? "");
                        _addCartController.store.value = _homeController.getAllCartsModel.value?.carts?[1].store;
                        await _addCartController.getCartLocation(
                            storeId: _homeController.getAllCartsModel.value?.carts?[1].store?.sId ?? '',
                            cartId: _homeController.getAllCartsModel.value?.carts?[1].sId ?? "");

                        _addCartController.cartId.value = _homeController.getAllCartsModel.value?.carts?[1].sId ?? "";
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
                          //   top: 20,
                          //   left: 10,
                          //   child: CircleAvatar(
                          // radius: 2.4.h,
                          // backgroundColor: AppConst.lightGrey,
                          //       child: const SizedBox()),
                          // ),
                          Positioned(
                            bottom: 15,
                            left: 10,
                            child: Text(
                              category.last.name.toString(),
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
              //   expandedHeight: 28.h,
              //   // collapsedHeight: 70,
              //   centerTitle: true,
              //   pinned: true,
              //   stretch: true,
              //   floating: true,
              //   backgroundColor: Colors.green[600],
              //   leading: BackButtonWidget(),
              //   actions: [
              //     CartWidget(),
              //   ],
              //   flexibleSpace: FlexibleSpaceBar(
              //     centerTitle: innerBoxIsScrolled,
              //     title: Text(
              //       "Convenience",
              //       style: TextStyle(color: AppConst.black),
              //     ),
              //     collapseMode: CollapseMode.pin,
              //     titlePadding: EdgeInsets.only(bottom: 0.5.h, left: 2.w),
              //     background: Image.network(
              //       "https://img.freepik.com/free-photo/falling-broken-chocolate-chip-cookies-isolated-white-with-clipping-path_88281-2863.jpg?w=1380",
              //       fit: BoxFit.contain,
              //     ),
              //   ),
              // )
            ];
          },
          body: SingleChildScrollView(
            controller: _homeController.remoteConfigScrollController,
            child: Column(
              children: [
                StoreWithProductsList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BackButtonCircle extends StatelessWidget {
  const BackButtonCircle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 10,
          left: 10,
          child: CircleAvatar(
            radius: 2.2.h,
            backgroundColor: AppConst.white,
            child: GestureDetector(
              // color: Colors.white,
              onTap: (() => Get.back()),
              child: Icon(
                Icons.arrow_back_rounded,
                size: SizeUtils.horizontalBlockSize * 7,
                color: Colors.black,
              ),
            ),
          ),
        )
      ],
    );
  }
}
