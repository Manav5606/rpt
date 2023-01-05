import 'package:bubble/bubble.dart';
import 'package:customer_app/app/constants/colors.dart';
import 'package:customer_app/app/utils/app_constants.dart';
import 'package:customer_app/screens/addcart/Widgets/store_name_call_logo.dart';
import 'package:customer_app/widgets/search_text_field/search_field_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/ui/pages/search/controller/exploreContoller.dart';
import 'package:customer_app/app/ui/pages/search/models/GetStoreDataModel.dart';
import 'package:customer_app/app/ui/pages/stores/chatOrder/chatOrder.dart';
import 'package:customer_app/app/ui/pages/stores/freshStore.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/screens/addcart/controller/addcart_controller.dart';
import 'package:customer_app/screens/more_stores/morestore_controller.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:customer_app/widgets/cartWidget.dart';
import 'package:customer_app/widgets/storesearchfield.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sizer/sizer.dart';
import 'package:toggle_switch/toggle_switch.dart';

// class MoreStoreProductScreen extends StatefulWidget {
//   const MoreStoreProductScreen({Key? key}) : super(key: key);

//   @override
//   _StoreScreenState createState() => _StoreScreenState();
// }

// class _StoreScreenState extends State<MoreStoreProductScreen> {
//   late PersistentTabController _controller;
//   // final ScrollController? gridViewScroll;
//   bool isGrocery = false;
//   final AddCartController _addCartController = Get.find();
//   @override
//   void initState() {
//     super.initState();
//     Map arg = Get.arguments ?? {};
//     isGrocery = arg['isGrocery'] ?? false;
//     _controller = PersistentTabController(initialIndex: 0);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PersistentTabView(
//       context,
//       controller: _controller,
//       screens: _buildScreens(),
//       items: _navBarsItems(),
//       confineInSafeArea: true,
//       backgroundColor: Colors.white,
//       handleAndroidBackButtonPress: true,
//       resizeToAvoidBottomInset: true,
//       stateManagement: true,
//       hideNavigationBarWhenKeyboardShows: true,
//       popAllScreensOnTapOfSelectedTab: true,
//       popActionScreens: PopActionScreensType.all,
//       navBarStyle: NavBarStyle.style14,
//       onItemSelected: (int) {
//         _addCartController.onTabChange.value =
//             !_addCartController.onTabChange.value;
//       },
//     );
//   }

//   List<Widget> _buildScreens() {
//     return [
//       MoreStoreProductView(),
//       isGrocery
//           ? ChatOrderScreen(
//               isNewStore: true,
//             )
//           : FreshStoreScreen(),
//     ];
//   }

//   List<PersistentBottomNavBarItem> _navBarsItems() {
//     return [
//       PersistentBottomNavBarItem(
//           icon: Icon(Icons.shopping_bag_outlined),
//           title: "Shop",
//           activeColorPrimary: AppConst.kSecondaryColor,
//           activeColorSecondary: AppConst.green,
//           inactiveColorPrimary: AppConst.grey),
//       PersistentBottomNavBarItem(
//           icon: isGrocery
//               ? Icon(Icons.chat_bubble_outlined)
//               : Icon(Icons.shopping_cart),
//           title: isGrocery ? "Chat Order" : "Fresh Store",
//           activeColorPrimary: AppConst.kSecondaryColor,
//           activeColorSecondary: AppConst.green,
//           inactiveColorPrimary: AppConst.grey),
//     ];
//   }
// }

class MoreStoreProductView extends StatelessWidget {
  final MoreStoreController _moreStoreController = Get.find();
  final AddCartController _addCartController = Get.find();

  @override
  Widget build(BuildContext context) {
    String? colorinversion =
        _moreStoreController.getStoreDataModel.value?.data?.store?.color;
    Color updatedColor = hexToColor(
        (_moreStoreController.getStoreDataModel.value?.data?.store?.color)!);
    return Obx(
      () => Scaffold(
        bottomSheet: ((_moreStoreController
                        .getCartIDModel.value?.totalItemsCount ??
                    0) >
                0)
            ? Obx(
                () => InkWell(
                  onTap: () async {
                    Get.toNamed(
                      AppRoutes.CartReviewScreen,
                      arguments: {
                        'logo': _moreStoreController
                            .getStoreDataModel.value?.data?.store?.logo,
                        'id': _moreStoreController
                            .getStoreDataModel.value?.data?.store?.sId,
                        'storeName': _moreStoreController
                            .getStoreDataModel.value?.data?.store?.name,
                        'totalCount': _moreStoreController
                                .getCartIDModel.value?.totalItemsCount
                                .toString() ??
                            "",
                      },
                    );
                    await _addCartController.getReviewCartData(
                        cartId:
                            _moreStoreController.getCartIDModel.value?.sId ??
                                "");
                    // await _addCartController.getCartPageInformation(storeId: _moreStoreController.addToCartModel.value?.store ?? "");
                    await _addCartController.getCartLocation(
                        storeId: _moreStoreController.storeId.value,
                        cartId:
                            _moreStoreController.getCartIDModel.value?.sId ??
                                "");
                    _addCartController.cartId.value =
                        _moreStoreController.getCartIDModel.value?.sId ?? "";
                    if (_addCartController.store.value?.sId == null) {
                      _addCartController.store.value?.sId =
                          _moreStoreController.storeId.value;
                    }
                    _addCartController.SelectedAddressForCart();
                  },
                  child: CartRibbn(
                      totalItemsCount: _moreStoreController
                          .getCartIDModel.value?.totalItemsCount),
                ),
              )
            : SizedBox(),
        body: NestedScrollView(
          physics: BouncingScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: updatedColor,
                    statusBarIconBrightness: (colorinversion == "#FFFFFF")
                        ? Brightness.dark
                        : Brightness.light),
                expandedHeight: 18.h,
                centerTitle: true,
                pinned: true,
                stretch: true,
                floating: true,
                iconTheme: (colorinversion == "#FFFFFF")
                    ? IconThemeData(color: AppConst.black)
                    : IconThemeData(color: AppConst.white),
                backgroundColor:
                    //  AppConst.yellow,
                    updatedColor,
                title: (innerBoxIsScrolled)
                    ? Obx(
                        () => Row(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // InkWell(
                            //     onTap: (() {
                            //       Get.back();
                            //     }),
                            //     child: Padding(
                            //       padding: EdgeInsets.symmetric(horizontal: 1.w),
                            //       child: Icon(Icons.arrow_back),
                            //     )),
                            // SizedBox(
                            //   width: 2.w,
                            // ),
                            Container(
                              width: 75.w,
                              // color: AppConst.red,
                              child: Text(
                                _moreStoreController.getStoreDataModel.value
                                        ?.data?.store?.name
                                        .toString() ??
                                    "",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  color: (colorinversion == "#FFFFFF")
                                      ? AppConst.black
                                      : AppConst.white,
                                  fontFamily: 'MuseoSans',
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  fontSize: SizeUtils.horizontalBlockSize * 4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )

                    // CircleAvatar(
                    //     radius: SizeUtils.horizontalBlockSize * 3.82,
                    //     child: Image.asset("assets/images/image4.png"))
                    : Row(
                        children: [
                          // InkWell(
                          //     onTap: (() {
                          //       Get.back();
                          //     }),
                          //     child: Padding(
                          //       padding: EdgeInsets.symmetric(horizontal: 1.w),
                          //       child: Icon(Icons.arrow_back),
                          //     )),
                          Text(
                            "",
                            style: TextStyle(
                                color: (colorinversion == "#FFFFFF")
                                    ? AppConst.black
                                    : AppConst.white,
                                fontSize: SizeUtils.horizontalBlockSize * 4),
                          ),
                        ],
                      ),
                // leading: IconButton(
                //   onPressed: () {
                //     Get.back();
                //   },
                //   color: (colorinversion == "#FFFFFF")
                //       ? AppConst.black
                //       : AppConst.white,
                //   icon: Icon(
                //     Icons.cancel_rounded,
                //     size: SizeUtils.horizontalBlockSize * 8,
                //     color: (colorinversion == "#FFFFFF")
                //         ? AppConst.black
                //         : AppConst.white,
                //   ),
                // ),
                // actions: [
                //   Obx(
                //     () => CartWidget(
                //       onTap: () async {
                //         Get.toNamed(
                //           AppRoutes.CartReviewScreen,
                //           arguments: {
                //             'logo': _moreStoreController
                //                 .getStoreDataModel.value?.data?.store?.logo,
                //             'storeName': _moreStoreController
                //                 .getStoreDataModel.value?.data?.store?.name,
                //             'totalCount': _moreStoreController
                //                     .getCartIDModel.value?.totalItemsCount
                //                     .toString() ??
                //                 "",
                //           },
                //         );
                //         await _addCartController.getReviewCartData(
                //             cartId:
                //                 _moreStoreController.getCartIDModel.value?.sId ??
                //                     "");
                //         // await _addCartController.getCartPageInformation(storeId: _moreStoreController.addToCartModel.value?.store ?? "");
                //         await _addCartController.getCartLocation(
                //             storeId: _moreStoreController.storeId.value,
                //             cartId:
                //                 _moreStoreController.getCartIDModel.value?.sId ??
                //                     "");
                //         _addCartController.cartId.value =
                //             _moreStoreController.getCartIDModel.value?.sId ?? "";
                //         if (_addCartController.store.value?.sId == null) {
                //           _addCartController.store.value?.sId =
                //               _moreStoreController.storeId.value;
                //         }
                //       },
                //       count:
                //           "${_moreStoreController.getCartIDModel.value?.totalItemsCount ?? 0}",
                //     ),
                //   ),
                // ],
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  collapseMode: CollapseMode.parallax,
                  background: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // SizedBox(
                      //   height: 2.h,
                      // ),
                      // SafeArea(
                      //   child: Obx(
                      //     () => CircleAvatar(
                      //       radius: SizeUtils.horizontalBlockSize * 3.82,
                      //       child: (_moreStoreController.getStoreDataModel.value
                      //                   ?.data?.store?.logo?.isNotEmpty ??
                      //               false)
                      //           ? Image.network(_moreStoreController
                      //               .getStoreDataModel.value!.data!.store!.logo
                      //               .toString())
                      //           : Image.asset("assets/images/image4.png"),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w, top: 6.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Obx(
                              () => Text(
                                _moreStoreController.getStoreDataModel.value
                                        ?.data?.store?.name
                                        .toString() ??
                                    "",
                                style: TextStyle(
                                  color: (colorinversion == "#FFFFFF")
                                      ? AppConst.black
                                      : AppConst.white,
                                  fontFamily: 'MuseoSans',
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  fontSize: SizeUtils.horizontalBlockSize * 4.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   height: 1.h,
                      // ),

                      Padding(
                        padding: EdgeInsets.only(left: 5.w, bottom: 2.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Obx(() => RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                    text: "CasBack ",
                                    style: TextStyle(
                                      color: (colorinversion == "#FFFFFF")
                                          ? AppConst.grey
                                          : AppConst.white,
                                      fontFamily: 'MuseoSans',
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                      fontSize:
                                          SizeUtils.horizontalBlockSize * 3.7,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        "${_moreStoreController.getStoreDataModel.value?.data?.store?.actual_cashback ?? 0}%",
                                    style: TextStyle(
                                      color: (colorinversion == "#FFFFFF")
                                          ? AppConst.black
                                          : AppConst.white,
                                      fontFamily: 'MuseoSans',
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.normal,
                                      fontSize:
                                          SizeUtils.horizontalBlockSize * 3.7,
                                    ),
                                  )
                                ]))),
                            SizedBox(
                              width: 3.w,
                            ),
                            _moreStoreController.displayHour.isNotEmpty
                                ? RichText(
                                    text: TextSpan(children: [
                                    TextSpan(
                                      text: "Ready by ",
                                      style: TextStyle(
                                        color: (colorinversion == "#FFFFFF")
                                            ? AppConst.grey
                                            : AppConst.white,
                                        fontFamily: 'MuseoSans',
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                        fontSize:
                                            SizeUtils.horizontalBlockSize * 3.7,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          "${_moreStoreController.displayHour}",
                                      style: TextStyle(
                                        color: (colorinversion == "#FFFFFF")
                                            ? AppConst.black
                                            : AppConst.white,
                                        fontFamily: 'MuseoSans',
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.normal,
                                        fontSize:
                                            SizeUtils.horizontalBlockSize * 3.7,
                                      ),
                                    )
                                  ]))
                                : SizedBox(),
                          ],
                        ),
                      )
                      // InkWell(
                      //   highlightColor: AppConst.highLightColor,
                      //   onTap: () {
                      //     Get.toNamed(AppRoutes.InStoreSearch, arguments: {
                      //       'storeId': _moreStoreController.storeId.value
                      //     });
                      //   },
                      //   child: SizedBox(width: 90.w, child: StoreSearchField()),
                      // ),
                      // SizedBox(
                      //   height: 1.h,
                      // ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // BannerWidget(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: (() {
                          Get.to(ChatOrderScreen(
                            isNewStore: true,
                          ));
                        }),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          child: Bubble(
                            color: AppConst.lightSkyBlue,
                            margin: BubbleEdges.only(top: 1.h),
                            stick: true,
                            nip: BubbleNip.leftTop,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 2.h, horizontal: 2.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 50.w,
                                    child: Text(
                                      "Struggling to find items? \nChat with store & place orders instantly.",
                                      style: TextStyle(
                                        color: AppConst.darkGreen,
                                        // Color(0xff003d29),
                                        fontSize:
                                            SizeUtils.horizontalBlockSize * 3.7,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 28.w,
                                    height: 5.h,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(85),
                                        color: AppConst.darkGreen),
                                    child: Center(
                                      child: Text(
                                        "Chat ",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                SizeUtils.horizontalBlockSize *
                                                    3.7,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      InkWell(
                        highlightColor: AppConst.highLightColor,
                        onTap: () {
                          Get.toNamed(AppRoutes.InStoreSearch, arguments: {
                            'storeId': _moreStoreController.storeId.value
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3.w),
                          child: StoreSearchField(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.w),
                        child: MoewStoreViewProductsList(),
                      ),
                      SizedBox(
                        height: 10.h,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CartRibbn extends StatelessWidget {
  CartRibbn({Key? key, this.totalItemsCount}) : super(key: key);

  int? totalItemsCount;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 9.h,
      decoration: BoxDecoration(color: AppConst.green),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        child: Row(
          children: [
            Icon(
              Icons.shopping_cart,
              color: AppConst.white,
            ),
            SizedBox(
              width: 3.w,
            ),
            Text("${totalItemsCount ?? 0} Item",
                style: TextStyle(
                  fontFamily: 'MuseoSans',
                  color: AppConst.white,
                  fontSize: SizeUtils.horizontalBlockSize * 4,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                )),
            Spacer(),
            Text("View Cart",
                style: TextStyle(
                  fontFamily: 'MuseoSans',
                  color: AppConst.white,
                  fontSize: SizeUtils.horizontalBlockSize * 3.7,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                )),
            SizedBox(
              width: 1.w,
            ),
            Icon(
              Icons.arrow_forward_ios_outlined,
              color: AppConst.white,
              size: 2.2.h,
            ),
          ],
        ),
      ),
    );
  }
}

class BannerWidget extends StatelessWidget {
  const BannerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {},
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(SizeUtils.horizontalBlockSize * 1),
        color: Colors.yellow[200],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.offline_bolt,
              size: SizeUtils.horizontalBlockSize * 7,
            ),
            SizedBox(
              width: 2.w,
            ),
            Text(
              'Earn 5% credit on every \n eligible pick up order',
              style: TextStyle(fontSize: SizeUtils.horizontalBlockSize * 4),
            ),
            Spacer(),
            ElevatedButton(
              child: Text(
                'Try Express free',
                style: TextStyle(fontSize: SizeUtils.horizontalBlockSize * 4),
              ),
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  primary: AppConst.kPrimaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          SizeUtils.horizontalBlockSize * 7.65))),
            ),
          ],
        ),
      ),
    );
  }
}

class DeliveryTimeWidget extends StatelessWidget {
  DeliveryTimeWidget({
    Key? key,
  }) : super(key: key);
  final ExploreController _moreStoreController = Get.find()..formatDate();

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ToggleSwitch(
            minHeight: 4.h,
            minWidth: SizeUtils.horizontalBlockSize * 23,
            borderWidth: SizeUtils.horizontalBlockSize - 2.92,
            cornerRadius: SizeUtils.horizontalBlockSize * 5,
            icons: [FontAwesomeIcons.lock, FontAwesomeIcons.truckPickup],
            iconSize: SizeUtils.horizontalBlockSize * 3.5,
            activeBgColors: [
              [Colors.white],
              [Colors.white],
            ],
            borderColor: [Colors.grey, Colors.grey],
            activeFgColor: Colors.black,
            inactiveBgColor: Colors.grey,
            inactiveFgColor: Colors.black,
            initialLabelIndex: (_moreStoreController
                            .getStoreDataModel.value?.data?.store?.storeType ??
                        'online') ==
                    'online'
                ? 0
                : 1,
            totalSwitches: 2,
            labels: ['Delivery', 'Pickup'],
            customTextStyles: [
              TextStyle(fontSize: SizeUtils.horizontalBlockSize * 3.06),
              TextStyle(fontSize: SizeUtils.horizontalBlockSize * 3.06)
            ],
            radiusStyle: true,
            onToggle: (index) {},
          ),
          _moreStoreController.displayHour.isNotEmpty
              ? Text('Ready by ${_moreStoreController.displayHour}')
              : SizedBox(),
        ],
      ),
    );
  }
}

class MoewStoreViewProductsList extends StatelessWidget {
  MoewStoreViewProductsList({Key? key}) : super(key: key);

  final MoreStoreController _moreStoreController = Get.find();

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
                      padding:
                          EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(storesWithProductsModel?.name ?? "",
                              style: TextStyle(
                                fontFamily: 'MuseoSans',
                                color: AppConst.black,
                                fontSize: SizeUtils.horizontalBlockSize * 4,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                              )),
                          // ((storesWithProductsModel?.products?.length ?? 0) >
                          //         5)
                          //     ? Text(
                          //         "View More",
                          //         style: TextStyle(
                          //           fontSize:
                          //               SizeUtils.horizontalBlockSize * 4,
                          //         ),
                          //       )
                          //     : SizedBox(),
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   height: 1.h,
                    // ),
                    if (storesWithProductsModel!.products!.isEmpty)
                      SizedBox()
                    else
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              // height: 20.h,
                              width: double.infinity,
                              child: GridView(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                // controller: gridViewScroll,
                                scrollDirection: Axis.vertical,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 2.w,
                                        mainAxisSpacing: 2.h),
                                children: List.generate(
                                    storesWithProductsModel.products?.length ??
                                        0, (index) {
                                  StoreModelProducts product =
                                      storesWithProductsModel.products![index];
                                  return Container(
                                    width: 45.w,
                                    height: 25.h,
                                    // color: AppConst.yellow,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: (product.logo != null &&
                                                  product.logo != "")
                                              ? Image.network(
                                                  product.logo!,
                                                  fit: BoxFit.cover,
                                                  height: 10.h,
                                                  width: 24.w,
                                                )
                                              : Container(
                                                  decoration: BoxDecoration(
                                                    color:
                                                        AppConst.veryLightGrey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    // border: Border.all(
                                                    //     width: 0.1,
                                                    //     color:
                                                    //         AppConst.grey)
                                                  ),
                                                  height: 10.h,
                                                  width: 30.w,
                                                  child: Center(
                                                      child: Image.asset(
                                                          "assets/images/noimage.png")),
                                                ),
                                        ),
                                        Container(
                                          // color: AppConst.red,
                                          // height: 4.5.h,
                                          child: Text(product.name.toString(),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontFamily: 'MuseoSans',
                                                color: AppConst.black,
                                                fontSize: SizeUtils
                                                        .horizontalBlockSize *
                                                    3.7,
                                                fontWeight: FontWeight.w500,
                                                fontStyle: FontStyle.normal,
                                              )),
                                        ),
                                        SizedBox(
                                          height: 0.5.h,
                                        ),
                                        Text(
                                            "Cashback \u20b9${product.cashback.toString()}",
                                            style: TextStyle(
                                              fontFamily: 'MuseoSans',
                                              color: AppConst.black,
                                              fontSize: SizeUtils
                                                      .horizontalBlockSize *
                                                  3.5,
                                              fontWeight: FontWeight.w700,
                                              fontStyle: FontStyle.normal,
                                            )),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text("₹ 125 / 3Kg",
                                                style: TextStyle(
                                                  fontFamily: 'MuseoSans',
                                                  color: AppConst.black,
                                                  fontSize: SizeUtils
                                                          .horizontalBlockSize *
                                                      3.3,
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle: FontStyle.normal,
                                                )),
                                            Spacer(),
                                            Obx(
                                              () => product.quntity!.value >
                                                          0 &&
                                                      product.isQunitityAdd
                                                              ?.value ==
                                                          false
                                                  ? _shoppingItem(product)
                                                  : GestureDetector(
                                                      onTap: () async {
                                                        if (product.quntity!
                                                                .value ==
                                                            0) {
                                                          product
                                                              .quntity!.value++;
                                                          _moreStoreController.addToCart(
                                                              store_id:
                                                                  _moreStoreController
                                                                      .storeId
                                                                      .value,
                                                              index: 0,
                                                              increment: true,
                                                              cart_id: _moreStoreController
                                                                      .getCartIDModel
                                                                      .value
                                                                      ?.sId ??
                                                                  '',
                                                              product: product);
                                                          totalCalculated();
                                                        }
                                                        if (product.quntity!
                                                                    .value !=
                                                                0 &&
                                                            product.isQunitityAdd
                                                                    ?.value ==
                                                                false) {
                                                          product.isQunitityAdd
                                                              ?.value = false;
                                                          await Future.delayed(
                                                                  Duration(
                                                                      milliseconds:
                                                                          500))
                                                              .whenComplete(
                                                                  () => product
                                                                      .isQunitityAdd
                                                                      ?.value = true);
                                                        }
                                                        // addItem(product);
                                                      },
                                                      child: product.isQunitityAdd
                                                                      ?.value ==
                                                                  true &&
                                                              product.quntity!
                                                                      .value !=
                                                                  0
                                                          ? _dropDown(
                                                              product,
                                                              storesWithProductsModel
                                                                      .sId ??
                                                                  '')
                                                          : DisplayAddPlus(),
                                                    ),
                                            ),
                                            SizedBox(
                                              width: 3.w,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                }),
                              ),

                              // ListView.separated(
                              //   physics: ClampingScrollPhysics(),
                              //   shrinkWrap: true,
                              //   scrollDirection: Axis.horizontal,
                              //   itemCount: storesWithProductsModel
                              //           .products?.length ??
                              //       0,
                              //   itemBuilder: (context, i) {
                              //     StoreModelProducts product =
                              //         storesWithProductsModel.products![i];
                              //     return Container(
                              //       width: 45.w,
                              //       height: 25.h,
                              //       child: Column(
                              //         mainAxisSize: MainAxisSize.min,
                              //         crossAxisAlignment:
                              //             CrossAxisAlignment.start,
                              //         children: [
                              //           Center(
                              //             child: (product.logo != null &&
                              //                     product.logo != "")
                              //                 ? Image.network(
                              //                     product.logo!,
                              //                     fit: BoxFit.cover,
                              //                     height: 11.h,
                              //                     width: 24.w,
                              //                   )
                              //                 : Container(
                              //                     decoration: BoxDecoration(
                              //                       color: AppConst
                              //                           .veryLightGrey,
                              //                       borderRadius:
                              //                           BorderRadius
                              //                               .circular(8),
                              //                       // border: Border.all(
                              //                       //     width: 0.1,
                              //                       //     color:
                              //                       //         AppConst.grey)
                              //                     ),
                              //                     height: 11.h,
                              //                     width: 30.w,
                              //                     child: Center(
                              //                         child: Image.asset(
                              //                             "assets/images/noimage.png")),
                              //                   ),
                              //           ),
                              //           Obx(
                              //             () =>
                              //                 product.quntity!.value > 0 &&
                              //                         product.isQunitityAdd
                              //                                 ?.value ==
                              //                             false
                              //                     ? _shoppingItem(product)
                              //                     : GestureDetector(
                              //                         onTap: () async {
                              //                           if (product.quntity!
                              //                                   .value ==
                              //                               0) {
                              //                             product.quntity!
                              //                                 .value++;
                              //                             _moreStoreController.addToCart(
                              //                                 store_id:
                              //                                     _moreStoreController
                              //                                         .storeId
                              //                                         .value,
                              //                                 index: 0,
                              //                                 increment:
                              //                                     true,
                              //                                 cart_id: _moreStoreController
                              //                                         .getCartIDModel
                              //                                         .value
                              //                                         ?.sId ??
                              //                                     '',
                              //                                 product:
                              //                                     product);
                              //                             totalCalculated();
                              //                           }
                              //                           if (product.quntity!
                              //                                       .value !=
                              //                                   0 &&
                              //                               product.isQunitityAdd
                              //                                       ?.value ==
                              //                                   false) {
                              //                             product
                              //                                 .isQunitityAdd
                              //                                 ?.value = false;
                              //                             await Future.delayed(
                              //                                     Duration(
                              //                                         milliseconds:
                              //                                             500))
                              //                                 .whenComplete(
                              //                                     () => product
                              //                                         .isQunitityAdd
                              //                                         ?.value = true);
                              //                           }
                              //                           // addItem(product);
                              //                         },
                              //                         child: product.isQunitityAdd
                              //                                         ?.value ==
                              //                                     true &&
                              //                                 product.quntity!
                              //                                         .value !=
                              //                                     0
                              //                             ? _dropDown(
                              //                                 product,
                              //                                 storesWithProductsModel
                              //                                         .sId ??
                              //                                     '')
                              //                             : Container(
                              //                                 height: 3.5.h,
                              //                                 width: product.isQunitityAdd?.value ==
                              //                                             true &&
                              //                                         product.quntity!.value !=
                              //                                             0
                              //                                     ? 8.w
                              //                                     : 15.w,
                              //                                 decoration:
                              //                                     BoxDecoration(
                              //                                   border: Border.all(
                              //                                       color: AppConst
                              //                                           .green,
                              //                                       width:
                              //                                           0.8),
                              //                                   borderRadius:
                              //                                       BorderRadius.circular(product.isQunitityAdd?.value == true &&
                              //                                               product.quntity!.value != 0
                              //                                           ? 25
                              //                                           : 8),
                              //                                   color: AppConst
                              //                                       .white,
                              //                                 ),
                              //                                 child: product.isQunitityAdd?.value ==
                              //                                             true &&
                              //                                         product.quntity!.value !=
                              //                                             0
                              //                                     ? Center(
                              //                                         child: Text(
                              //                                             "${product.quntity?.value ?? "0"}",
                              //                                             style: TextStyle(
                              //                                               fontFamily: 'MuseoSans',
                              //                                               color: AppConst.green,
                              //                                               fontSize: SizeUtils.horizontalBlockSize * 3.8,
                              //                                               fontWeight: FontWeight.w500,
                              //                                               fontStyle: FontStyle.normal,
                              //                                             )),
                              //                                       )
                              //                                     : Center(
                              //                                         child:
                              //                                             Text(
                              //                                           " Add +",
                              //                                           style:
                              //                                               TextStyle(
                              //                                             fontFamily: 'MuseoSans',
                              //                                             color: AppConst.green,
                              //                                             fontSize: SizeUtils.horizontalBlockSize * 3.8,
                              //                                             fontWeight: FontWeight.w500,
                              //                                             fontStyle: FontStyle.normal,
                              //                                           ),
                              //                                         ),
                              //                                       ),
                              //                               ),
                              //                       ),
                              //           ),
                              //           SizedBox(
                              //             width: 3.w,
                              //           ),
                              //           Text(
                              //             " \u20b9 ${product.cashback.toString()}",
                              //             style: AppStyles.STORE_NAME_STYLE,
                              //           ),
                              //           Flexible(
                              //             child: Text(
                              //               product.name.toString(),
                              //               maxLines: 2,
                              //               overflow: TextOverflow.ellipsis,
                              //               style:
                              //                   AppStyles.STORE_NAME_STYLE,
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //     );
                              //   },
                              //   separatorBuilder: (context, index) {
                              //     return SizedBox(
                              //       width: 2.w,
                              //     );
                              //   },
                              // ),
                            ),
                          ),
                        ],
                      ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return Container(
                  height: 1.5.w,
                  color: AppConst.veryLightGrey,
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

  totalCalculated() async {
    int total = 0;
    _moreStoreController.getStoreDataModel.value?.data?.mainProducts
        ?.forEach((element) {
      element.products?.forEach((element) {
        total = total + (element.quntity?.value ?? 0);
      });
    });
    // _moreStoreController.cartIndex.value?.totalItemsCount?.value = (_moreStoreController.cartIndex.value?.totalItemsCount?.value ?? 0) + total;
  }

  Widget _dropDown(product, String sId) {
    return Obx(
      () => PopupMenuButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        onSelected: (value) async {
          product.quntity!.value = value;
          if (product.quntity!.value == 0) {
            product.isQunitityAdd?.value = false;
          }
          _moreStoreController.addToCart(
            store_id: sId,
            index: 0,
            increment: true,
            product: product,
            cart_id: _moreStoreController.getCartIDModel.value?.sId ?? '',
          );
          totalCalculated();
        },
        offset: Offset(0.0, 40),
        child: DisplayProductCount(
          count: product.quntity!.value,
        ),
        // Align(
        //   alignment: Alignment.topRight,
        //   child: Container(
        //     height: 3.5.h,
        //     width: 18.w,
        //     decoration: BoxDecoration(
        //         shape: BoxShape.rectangle,
        //         color: Color(0xff005b41),
        //         borderRadius: BorderRadius.circular(4)),
        //     child: product.isQunitityAdd?.value == true &&
        //             product.quntity!.value != 0
        //         ? Center(
        //             child: Text(
        //               " -   ${product.quntity!.value}   + ",
        //               style: TextStyle(
        //                 fontFamily: 'MuseoSans',
        //                 color: AppConst.white,
        //                 fontSize: SizeUtils.horizontalBlockSize * 3.8,
        //                 fontWeight: FontWeight.w500,
        //                 fontStyle: FontStyle.normal,
        //               ),
        //             ),
        //           )
        //         : Icon(
        //             Icons.add,
        //             color: Colors.white,
        //           ),
        //   ),
        // ),
        itemBuilder: (ctx) {
          return [
            PopupMenuItem(
              value: 0,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Quantity',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: SizeUtils.verticalBlockSize * 2,
                    ),
                  ),
                  SizedBox(
                    width: SizeUtils.horizontalBlockSize * 1,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Get.back();
                    },
                    child: Icon(
                      Icons.clear,
                      size: SizeUtils.verticalBlockSize * 3,
                    ),
                  ),
                ],
              ),
            ),
            ...List.generate(
              10,
              (index) => _buildPopupMenuItem(index),
            ),
          ];
        },
      ),
    );
  }

  PopupMenuItem _buildPopupMenuItem(int title) {
    return PopupMenuItem(
      value: title,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            height: 0,
          ),
          Align(
            child: Text(
              title == 0 ? "  ${title}(Remove)" : "  $title",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: SizeUtils.verticalBlockSize * 2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _shoppingItem(product) {
    return Obx(
      () => DisplayProductCount(
        count: product.quntity!.value,
      ),
    );

    // Container(
    //     height: 3.5.h,
    //     width: 18.w,
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(4),
    //       color: Color(0xff005b41),
    //     ),
    //     child: Obx(
    //       () => Center(
    //         child: Text(
    //           " -   ${product.quntity!.value}   + ",
    //           style: TextStyle(
    //             fontFamily: 'MuseoSans',
    //             color: AppConst.white,
    //             fontSize: SizeUtils.horizontalBlockSize * 3.8,
    //             fontWeight: FontWeight.w500,
    //             fontStyle: FontStyle.normal,
    //           ),
    //         ),
    //       ),
    //     )
    // Padding(
    //   padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 1.w),
    //   child: Obx(
    //     () => Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceAround,
    //       children: <Widget>[
    //         _decrementButton(product),
    //         Text('${product.quntity!.value}',
    //             style: TextStyle(
    //                 fontSize: SizeUtils.horizontalBlockSize * 4,
    //                 fontWeight: FontWeight.w500,
    //                 color: AppConst.white)),
    //         _incrementButton(product),
    //       ],
    //     ),
    //   ),
    // ),
    // );
  }

  Widget _incrementButton(product) {
    return GestureDetector(
      child: Container(
        width: 5.w,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: AppConst.green,
        ),
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 2.h,
        ),
      ),
      onTap: () async {
        product.isQunitityAdd?.value = false;
        product.quntity!.value++;
        await Future.delayed(Duration(seconds: 2))
            .whenComplete(() => product.isQunitityAdd?.value = true);
        // addItem(products);
      },
    );
  }

  Widget _decrementButton(product) {
    return GestureDetector(
      onTap: () async {
        product.isQunitityAdd?.value = false;
        product.quntity!.value--;
        await Future.delayed(Duration(seconds: 2))
            .whenComplete(() => product.isQunitityAdd?.value = true);
        // addItem(products);
      },
      child: Container(
        width: 5.w,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: AppConst.green,
        ),
        child: Icon(
          Icons.remove,
          color: Colors.white,
          size: 2.h,
        ),
      ),
    );
  }
}

class DisplayAddPlus extends StatelessWidget {
  const DisplayAddPlus({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3.5.h,
      width:
          // product.isQunitityAdd?.value ==
          //             true &&
          //         product.quntity!.value !=
          //             0
          //     ? 8.w
          // :
          18.w,
      decoration: BoxDecoration(
        border: Border.all(color: AppConst.green, width: 0.8),
        borderRadius: BorderRadius.circular(
            // product.isQunitityAdd?.value == true &&
            //       product.quntity!.value != 0
            //   ? 25
            //   :
            4),
        color: AppConst.white,
      ),
      child:
          // product.isQunitityAdd?.value ==
          //             true &&
          //         product.quntity!.value !=
          //             0
          //     ? Center(
          //         child: Text(
          //             "${product.quntity?.value ?? "0"}",
          //             style: TextStyle(
          //               fontFamily: 'MuseoSans',
          //               color: AppConst.green,
          //               fontSize: SizeUtils.horizontalBlockSize * 3.8,
          //               fontWeight: FontWeight.w500,
          //               fontStyle: FontStyle.normal,
          //             )),
          //       )
          // :
          Center(
        child: Text(
          " Add +",
          style: TextStyle(
            fontFamily: 'MuseoSans',
            color: AppConst.green,
            fontSize: SizeUtils.horizontalBlockSize * 3.8,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
    );
  }
}
