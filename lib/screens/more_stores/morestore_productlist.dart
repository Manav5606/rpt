import 'package:bubble/bubble.dart';
import 'package:customer_app/app/constants/colors.dart';
import 'package:customer_app/app/ui/common/shimmer_widget.dart';
import 'package:customer_app/app/ui/pages/stores/storeswithproductslist.dart';
import 'package:customer_app/app/utils/app_constants.dart';
import 'package:customer_app/screens/addcart/Widgets/store_name_call_logo.dart';
import 'package:customer_app/screens/base_screen.dart';
import 'package:customer_app/screens/history/history_screen.dart';
import 'package:customer_app/screens/more_stores/all_offers_listview.dart';
import 'package:customer_app/widgets/search_text_field/search_field_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

class MoreStoreProductView extends StatefulWidget {
  @override
  State<MoreStoreProductView> createState() => _MoreStoreProductViewState();
}

class _MoreStoreProductViewState extends State<MoreStoreProductView> {
  final MoreStoreController _moreStoreController = Get.find();

  final AddCartController _addCartController = Get.find();
  String businessID = "";
  String navBackTo = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Map arg = Get.arguments ?? {};

    businessID = arg['businessID'] ?? "";
    navBackTo = arg['navBackTo'] ?? "";
  }

  @override
  Widget build(BuildContext context) {
    // String? colorinversion =
    //     _moreStoreController.getStoreDataModel.value?.data?.store?.color;
    // Color updatedColor = hexToColor(
    //     (_moreStoreController.getStoreDataModel.value?.data?.store?.color)!);
    return Obx(
      () => Scaffold(
        bottomSheet:
            ((_moreStoreController.getCartIDModel.value?.totalItemsCount ?? 0) >
                    0)
                ? Obx(
                    () => (_moreStoreController.isLoadingStoreData.value)
                        ? SizedBox()
                        : InkWell(
                            onTap: () async {
                              Get.toNamed(
                                AppRoutes.CartReviewScreen,
                                arguments: {
                                  'logo': _moreStoreController.getStoreDataModel
                                      .value?.data?.store?.logo,
                                  'id': _moreStoreController.getStoreDataModel
                                      .value?.data?.store?.sId,
                                  'storeName': _moreStoreController
                                      .getStoreDataModel
                                      .value
                                      ?.data
                                      ?.store
                                      ?.name,
                                  'totalCount': _moreStoreController
                                          .getCartIDModel.value?.totalItemsCount
                                          .toString() ??
                                      "",
                                  "businessID": businessID,
                                  "navBackTo": navBackTo,
                                },
                              );
                              await _addCartController.getReviewCartData(
                                  cartId: _moreStoreController
                                          .getCartIDModel.value?.sId ??
                                      "");
                              // await _addCartController.getCartPageInformation(storeId: _moreStoreController.addToCartModel.value?.store ?? "");
                              await _addCartController.getCartLocation(
                                  storeId: _moreStoreController.storeId.value,
                                  cartId: _moreStoreController
                                          .getCartIDModel.value?.sId ??
                                      "");
                              _addCartController.cartId.value =
                                  _moreStoreController
                                          .getCartIDModel.value?.sId ??
                                      "";
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
                    statusBarColor: AppConst.white, // updatedColor,
                    statusBarIconBrightness:

                        // (colorinversion == "#FFFFFF")
                        //     ?
                        Brightness.dark
                    // : Brightness.light
                    ),
                expandedHeight: 14.h,
                elevation: 0,
                automaticallyImplyLeading: false,
                centerTitle: true,
                pinned: true,
                stretch: true,
                floating: true,
                iconTheme:
                    // (colorinversion == "#FFFFFF")
                    //     ?
                    IconThemeData(color: AppConst.black)
                // : IconThemeData(color: AppConst.white)
                ,
                backgroundColor: AppConst.white,
                // updatedColor,
                bottom: (innerBoxIsScrolled)
                    ? PreferredSize(
                        preferredSize: Size.fromHeight(120),
                        child: InkWell(
                          highlightColor: AppConst.highLightColor,
                          onTap: () {
                            Get.toNamed(AppRoutes.InStoreSearch, arguments: {
                              'storeId': _moreStoreController.storeId.value
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.w, vertical: 1.5.h),
                            child: StoreSearchField(),
                          ),
                        ),
                      )
                    : PreferredSize(
                        preferredSize: Size.fromHeight(0), child: SizedBox()),
                title: (innerBoxIsScrolled)
                    ? Obx(
                        () => (_moreStoreController.isLoadingStoreData.value)
                            ? ShimmerEffect(
                                child: Container(
                                  width: 75.w,
                                  height: 2.h,
                                  color: AppConst.black,
                                ),
                              )
                            : Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // InkWell(
                                      //     onTap: () {
                                      //       Get.back();
                                      //       // Get.toNamed(AppRoutes.BaseScreen);
                                      //     },
                                      //     child: Icon(
                                      //       Icons.arrow_back,
                                      //       size: 3.h,
                                      //       color: AppConst.black,
                                      //     )),
                                      InkWell(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: Container(
                                            height: 20,
                                            width: 5.w,
                                            // color: AppConst.black,
                                            child: SvgPicture.asset(
                                              'assets/icons/Back button.svg',
                                              color: AppConst.black,
                                            )),
                                      ),
                                      SizedBox(
                                        width: 4.w,
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 75.w,
                                            // color: AppConst.red,
                                            child: Text(
                                              _moreStoreController
                                                      .getStoreDataModel
                                                      .value
                                                      ?.data
                                                      ?.store
                                                      ?.name
                                                      .toString() ??
                                                  "",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                color: AppConst.black,

                                                // (colorinversion == "#FFFFFF")
                                                //     ? AppConst.black
                                                //     : AppConst.white,
                                                fontFamily: 'MuseoSans',
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 70.w,
                                            // color: AppConst.red,
                                            child: _moreStoreController
                                                    .displayHour.isNotEmpty
                                                ? RichText(
                                                    text: TextSpan(children: [
                                                    TextSpan(
                                                      text: "Ready by ",
                                                      style: TextStyle(
                                                        color:
                                                            AppConst.darkGrey,
                                                        // (colorinversion == "#FFFFFF")
                                                        //     ? AppConst.black
                                                        //     : AppConst.white,
                                                        fontFamily: 'MuseoSans',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 10.sp,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          "${_moreStoreController.displayHour}",
                                                      style: TextStyle(
                                                        color:
                                                            AppConst.darkGrey,
                                                        // (colorinversion == "#FFFFFF")
                                                        //     ? AppConst.black
                                                        //     : AppConst.white,
                                                        fontFamily: 'MuseoSans',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 10.sp,
                                                      ),
                                                    )
                                                  ]))
                                                : SizedBox(),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                      )
                    : Row(
                        children: [
                          InkWell(
                              onTap: () {
                                Get.back();
                                // Get.toNamed(AppRoutes.BaseScreen);
                              },
                              child: Icon(
                                Icons.arrow_back,
                                size: 3.h,
                              )),
                          Text(
                            "",
                            style: TextStyle(
                                color: AppConst.black,

                                // (colorinversion == "#FFFFFF")
                                //     ? AppConst.black
                                //     : AppConst.white,
                                fontSize: SizeUtils.horizontalBlockSize * 4),
                          ),
                        ],
                      ),

                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  collapseMode: CollapseMode.parallax,
                  background: (!innerBoxIsScrolled)
                      ? Column(
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
                              height: 3.h,
                            ),

                            Padding(
                              padding: EdgeInsets.only(left: 5.w, top: 6.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Obx(
                                    () => (_moreStoreController
                                            .isLoadingStoreData.value)
                                        ? ShimmerEffect(
                                            child: Container(
                                              width: 75.w,
                                              height: 2.5.h,
                                              color: AppConst.black,
                                            ),
                                          )
                                        : Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 90.w,
                                                child: Text(
                                                  _moreStoreController
                                                          .getStoreDataModel
                                                          .value
                                                          ?.data
                                                          ?.store
                                                          ?.name
                                                          .toString() ??
                                                      "",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                    color: AppConst.black,
                                                    // (colorinversion == "#FFFFFF")
                                                    //     ? AppConst.black
                                                    //     : AppConst.white,
                                                    fontFamily: 'MuseoSans',
                                                    fontWeight: FontWeight.w700,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 15.sp,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                  width: 90.w,
                                                  child: Obx(
                                                    () => (_moreStoreController
                                                            .isLoadingStoreData
                                                            .value)
                                                        ? ShimmerEffect(
                                                            child: Container(
                                                              width: 60.w,
                                                              height: 2.h,
                                                              color: AppConst
                                                                  .black,
                                                            ),
                                                          )
                                                        : _moreStoreController
                                                                .displayHour
                                                                .isNotEmpty
                                                            ? RichText(
                                                                text: TextSpan(
                                                                    children: [
                                                                    TextSpan(
                                                                      text:
                                                                          "Ready by ",
                                                                      style:
                                                                          TextStyle(
                                                                        color: AppConst
                                                                            .darkGrey,
                                                                        // (colorinversion == "#FFFFFF")
                                                                        //     ? AppConst.black
                                                                        //     : AppConst.white,
                                                                        fontFamily:
                                                                            'MuseoSans',
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        fontStyle:
                                                                            FontStyle.normal,
                                                                        fontSize:
                                                                            10.sp,
                                                                      ),
                                                                    ),
                                                                    TextSpan(
                                                                      text:
                                                                          "${_moreStoreController.displayHour}",
                                                                      style:
                                                                          TextStyle(
                                                                        color: AppConst
                                                                            .darkGrey,
                                                                        // (colorinversion == "#FFFFFF")
                                                                        //     ? AppConst.black
                                                                        //     : AppConst.white,
                                                                        fontFamily:
                                                                            'MuseoSans',
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        fontStyle:
                                                                            FontStyle.normal,
                                                                        fontSize:
                                                                            10.sp,
                                                                      ),
                                                                    )
                                                                  ]))
                                                            : SizedBox(),
                                                  )),
                                            ],
                                          ),
                                  ),
                                ],
                              ),
                            ),
                            // SizedBox(
                            //   height: 1.h,
                            // ),

                            // Padding(
                            //   padding: EdgeInsets.only(left: 5.w, bottom: 0.h),
                            //   child: Obx(
                            //     () => (_moreStoreController.isLoadingStoreData.value)
                            //         ? Row(
                            //             mainAxisAlignment: MainAxisAlignment.start,
                            //             children: [
                            //               ShimmerEffect(
                            //                 child: Container(
                            //                   width: 60.w,
                            //                   height: 2.h,
                            //                   color: AppConst.black,
                            //                 ),
                            //               ),
                            //             ],
                            //           )
                            //         : Row(
                            //             mainAxisAlignment: MainAxisAlignment.start,
                            //             children: [
                            //               Obx(
                            //                 () =>
                            //                     // DisplayCashback(
                            //                     //     iscashbackPercentage: true,
                            //                     //     cashback: int.parse(
                            //                     //         "${_moreStoreController.getStoreDataModel.value?.data?.store?.actual_cashback}")),
                            //                     RichText(
                            //                         text: TextSpan(children: [
                            //                   TextSpan(
                            //                     text: "Cashback ",
                            //                     style: TextStyle(
                            //                       color: AppConst.darkGrey,
                            //                       // (colorinversion == "#FFFFFF")
                            //                       //     ? AppConst.black
                            //                       //     : AppConst.white,
                            //                       fontFamily: 'MuseoSans',
                            //                       fontWeight: FontWeight.w400,
                            //                       fontStyle: FontStyle.normal,
                            //                       fontSize: 10.sp,
                            //                     ),
                            //                   ),
                            //                   TextSpan(
                            //                       text:
                            //                           "${_moreStoreController.getStoreDataModel.value?.data?.store?.actual_cashback ?? 0}%",
                            //                       style: TextStyle(
                            //                         color: AppConst.darkGrey,
                            //                         // (colorinversion == "#FFFFFF")
                            //                         //     ? AppConst.black
                            //                         //     : AppConst.white,
                            //                         fontFamily: 'MuseoSans',
                            //                         fontWeight: FontWeight.w400,
                            //                         fontStyle: FontStyle.normal,
                            //                         fontSize: 10.sp,
                            //                       ))
                            //                 ])),
                            //               ),
                            //               Padding(
                            //                 padding: EdgeInsets.only(
                            //                     left: 3.w, right: 2.w, top: 0.5.h),
                            //                 child: Icon(
                            //                   Icons.circle,
                            //                   color: AppConst.grey,
                            //                   size: 0.8.h,
                            //                 ),
                            //               ),
                            //               _moreStoreController.displayHour.isNotEmpty
                            //                   ? RichText(
                            //                       text: TextSpan(children: [
                            //                       TextSpan(
                            //                         text: "Ready by ",
                            //                         style: TextStyle(
                            //                           color: AppConst.darkGrey,
                            //                           // (colorinversion == "#FFFFFF")
                            //                           //     ? AppConst.black
                            //                           //     : AppConst.white,
                            //                           fontFamily: 'MuseoSans',
                            //                           fontWeight: FontWeight.w400,
                            //                           fontStyle: FontStyle.normal,
                            //                           fontSize: 10.sp,
                            //                         ),
                            //                       ),
                            //                       TextSpan(
                            //                         text:
                            //                             "${_moreStoreController.displayHour}",
                            //                         style: TextStyle(
                            //                           color: AppConst.darkGrey,
                            //                           // (colorinversion == "#FFFFFF")
                            //                           //     ? AppConst.black
                            //                           //     : AppConst.white,
                            //                           fontFamily: 'MuseoSans',
                            //                           fontWeight: FontWeight.w400,
                            //                           fontStyle: FontStyle.normal,
                            //                           fontSize: 10.sp,
                            //                         ),
                            //                       )
                            //                     ]))
                            //                   : SizedBox(),
                            //             ],
                            //           ),
                            //   ),
                            // )
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
                        )
                      : SizedBox(),
                ),
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => (_moreStoreController.isLoadingStoreData.value ||
                          _moreStoreController.isLoading.value)
                      ? Column(
                          children: [
                            ShimmerEffect(child: StoreChatBubble()),
                            SizedBox(
                              height: 2.h,
                            ),
                            ShimmerEffect(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 3.w),
                                child: StoreSearchField(),
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            ProductShimmerEffect(),
                            ProductShimmerEffect(),
                            ProductShimmerEffect(),
                          ],
                        )
                      : Column(
                          children: [
                            SizedBox(
                              height: 1.h,
                            ),
                            InkWell(
                              highlightColor: AppConst.highLightColor,
                              onTap: () {
                                Get.toNamed(AppRoutes.InStoreSearch,
                                    arguments: {
                                      'storeId':
                                          _moreStoreController.storeId.value
                                    });
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5.w),
                                child: StoreSearchField(),
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            InkWell(
                              onTap: (() {
                                Get.to(ChatOrderScreen(
                                    isNewStore: true, businessID: businessID));
                              }),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 3.w),
                                child: Bubble(
                                  color: AppConst.lightGreen.withOpacity(0.9),
                                  margin: BubbleEdges.only(top: 0.h),
                                  stick: true,
                                  nip: BubbleNip.leftTop,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 1.h, horizontal: 2.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 54.w,
                                          child: Text(
                                            "Struggling to find items? \nChat with store & place orders.",
                                            style: TextStyle(
                                                color: AppConst.black,
                                                fontWeight: FontWeight.w400,
                                                // Color(0xff003d29),
                                                fontSize: 10.sp),
                                          ),
                                        ),
                                        Container(
                                          width: 20.w,
                                          height: 4.h,
                                          decoration: BoxDecoration(
                                            color: AppConst.veryLightGrey
                                                .withOpacity(0.9),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppConst.veryLightGrey,
                                                blurRadius: 1,
                                                // offset: Offset(1, 1),
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Chat ",
                                                style: TextStyle(
                                                    color: AppConst.black,
                                                    fontSize: 12.sp,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Icon(
                                                Icons.send_rounded,
                                                color: AppConst.black,
                                                size: 2.h,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 1.h),
                            Container(
                              height: 10.h,
                              width: double.infinity,
                              decoration:
                                  BoxDecoration(color: AppConst.veryLightGrey),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    (_moreStoreController
                                                    .getStoreDataModel
                                                    .value
                                                    ?.data
                                                    ?.store
                                                    ?.actual_cashback ??
                                                0) >
                                            0
                                        ? actualCashbackOfferCard(
                                            actualCashback: _moreStoreController
                                                .getStoreDataModel
                                                .value
                                                ?.data
                                                ?.store
                                                ?.actual_cashback,
                                          )
                                        : SizedBox(),
                                    (_moreStoreController
                                                .getStoreDataModel
                                                .value
                                                ?.data
                                                ?.store
                                                ?.bill_discount_offer_status ??
                                            false)
                                        ? BIllDiscountOfferAmountCard(
                                            bill_discount_offer_amount:
                                                _moreStoreController
                                                    .getStoreDataModel
                                                    .value
                                                    ?.data
                                                    ?.store
                                                    ?.bill_discount_offer_amount,
                                            bill_discount_offer_target:
                                                _moreStoreController
                                                    .getStoreDataModel
                                                    .value
                                                    ?.data
                                                    ?.store
                                                    ?.bill_discount_offer_target,
                                          )
                                        : SizedBox(),
                                    (_moreStoreController
                                                    .getStoreDataModel
                                                    .value
                                                    ?.data
                                                    ?.store
                                                    ?.actual_welcome_offer ??
                                                0) >
                                            0
                                        ? actualCashbackOfferCard(
                                            actualCashback: _moreStoreController
                                                .getStoreDataModel
                                                .value
                                                ?.data
                                                ?.store
                                                ?.actual_welcome_offer,
                                            isWelcomeOffer: true,
                                          )
                                        : SizedBox(),
                                    (_moreStoreController
                                                .getStoreDataModel
                                                .value
                                                ?.data
                                                ?.store
                                                ?.refernAndEarn
                                                ?.status ??
                                            false)
                                        ? RefferAndEarnOfferCard(
                                            amount: _moreStoreController
                                                .getStoreDataModel
                                                .value
                                                ?.data
                                                ?.store
                                                ?.refernAndEarn
                                                ?.amount,
                                          )
                                        : SizedBox(),
                                    (_moreStoreController
                                                .getStoreDataModel
                                                .value
                                                ?.data
                                                ?.store
                                                ?.leadGenerationPromotion
                                                ?.status ??
                                            false)
                                        ? RefferAndEarnOfferCard(
                                            amount: _moreStoreController
                                                .getStoreDataModel
                                                .value
                                                ?.data
                                                ?.store
                                                ?.leadGenerationPromotion
                                                ?.amount,
                                            isLeadGeneration: true,
                                          )
                                        : SizedBox(),
                                    SizedBox(
                                      width: 5.w,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            // SizedBox(
                            //   height: 2.h,
                            // ),
                            // InkWell(
                            //   onTap: (() {
                            //     Get.to(ChatOrderScreen(
                            //         isNewStore: true, businessID: businessID));
                            //   }),
                            //   child: Padding(
                            //     padding: EdgeInsets.symmetric(horizontal: 3.w),
                            //     child: Bubble(
                            //       color: AppConst.lightSkyBlue,
                            //       margin: BubbleEdges.only(top: 0.h),
                            //       stick: true,
                            //       nip: BubbleNip.leftTop,
                            //       child: Container(
                            //         padding: EdgeInsets.symmetric(
                            //             vertical: 1.h, horizontal: 2.w),
                            //         child: Row(
                            //           mainAxisAlignment:
                            //               MainAxisAlignment.spaceBetween,
                            //           crossAxisAlignment:
                            //               CrossAxisAlignment.start,
                            //           children: [
                            //             Container(
                            //               width: 54.w,
                            //               child: Text(
                            //                 "Struggling to find items? \nChat with store & place orders.",
                            //                 style: TextStyle(
                            //                   color: AppConst.darkGreen,
                            //                   // Color(0xff003d29),
                            //                   fontSize: SizeUtils
                            //                           .horizontalBlockSize *
                            //                       3.7,
                            //                 ),
                            //               ),
                            //             ),
                            //             Container(
                            //               width: 28.w,
                            //               height: 5.h,
                            //               decoration: BoxDecoration(
                            //                   borderRadius:
                            //                       BorderRadius.circular(85),
                            //                   color: AppConst.darkGreen),
                            //               child: Center(
                            //                 child: Text(
                            //                   "Chat ",
                            //                   style: TextStyle(
                            //                       color: Colors.white,
                            //                       fontSize: SizeUtils
                            //                               .horizontalBlockSize *
                            //                           3.7,
                            //                       fontWeight: FontWeight.bold),
                            //                 ),
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // SizedBox(height: 2.h),
                            // InkWell(
                            //   highlightColor: AppConst.highLightColor,
                            //   onTap: () {
                            //     Get.toNamed(AppRoutes.InStoreSearch,
                            //         arguments: {
                            //           'storeId':
                            //               _moreStoreController.storeId.value
                            //         });
                            //   },
                            //   child: Padding(
                            //     padding: EdgeInsets.symmetric(horizontal: 3.w),
                            //     child: StoreSearchField(),
                            //   ),
                            // ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3.w),
                              child: MoewStoreViewProductsList(),
                            ),
                            Container(
                              height: 40.h,
                              color: AppConst.veryLightGrey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 2.w, vertical: 1.h),
                                        child: Container(
                                            height: 5.5.h,
                                            width: 30.w,
                                            child: FittedBox(
                                              child: SvgPicture.asset(
                                                "assets/icons/logoname1.svg",
                                                fit: BoxFit.fill,
                                                color: AppConst.grey,
                                              ),
                                            )),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 2.w, vertical: 1.h),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Struggling to find items? \nChat with store & place orders instantly.",
                                          style: TextStyle(
                                            fontFamily: 'MuseoSans',
                                            color: AppConst.grey,
                                            fontSize:
                                                SizeUtils.horizontalBlockSize *
                                                    3.5,
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.normal,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 0.5.h,
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            Get.to(ChatOrderScreen(
                                              isNewStore: true,
                                            ));
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Click here to Place a chat order",
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    fontFamily: 'MuseoSans',
                                                    fontSize: SizeUtils
                                                            .horizontalBlockSize *
                                                        3.5,
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle: FontStyle.normal,
                                                    color: AppConst.darkGreen,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.chat,
                                                  color: AppConst.darkGreen,
                                                  size: 2.h,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7.h,
                                  ),
                                ],
                              ),
                            ),
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

class RefferAndEarnOfferCard extends StatelessWidget {
  int? amount;
  bool? isLeadGeneration;
  RefferAndEarnOfferCard({Key? key, this.amount, this.isLeadGeneration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 86.w,
        height: 6.5.h,
        margin: EdgeInsets.only(left: 6.w),
        decoration: BoxDecoration(
          color: AppConst.white,
          // border: Border.all(color: AppConst.grey, width: 0.5),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: AppConst.grey,
              blurRadius: 1,
              // offset: Offset(1, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 4.h,
              width: 18.w,
              decoration:
                  BoxDecoration(color: AppConst.black, shape: BoxShape.circle),
              child: Center(
                  child: Icon(
                Icons.share,
                size: 2.2.h,
                color: AppConst.white,
              )),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (isLeadGeneration ?? false)
                      ? "Create a lead for us. "
                      : "Refer to friends and family.",
                  style: TextStyle(
                    fontFamily: 'MuseoSans',
                    color: AppConst.black,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                Text(
                  (isLeadGeneration ?? false)
                      ? "and Earn upto \u{20b9}${amount} "
                      : "Earn \u{20b9}${amount} for each successful refer",
                  style: TextStyle(
                    fontFamily: 'MuseoSans',
                    color: AppConst.grey,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ],
            )
          ],
        ));
  }
}

class actualCashbackOfferCard extends StatelessWidget {
  num? actualCashback;
  bool? isWelcomeOffer;
  actualCashbackOfferCard({Key? key, this.actualCashback, this.isWelcomeOffer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 86.w,
        height: 6.5.h,
        margin: EdgeInsets.only(left: 6.w),
        decoration: BoxDecoration(
          color: AppConst.white,
          // border: Border.all(color: AppConst.grey, width: 0.5),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: AppConst.grey,
              blurRadius: 1,
              // offset: Offset(1, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 4.h,
              width: 18.w,
              decoration:
                  BoxDecoration(color: AppConst.black, shape: BoxShape.circle),
              child: Center(
                  child: Icon(
                Icons.discount_sharp,
                size: 2.2.h,
                color: AppConst.white,
              )),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (isWelcomeOffer ?? false)
                      ? "Get \u{20b9}${actualCashback} Welcome offer at store."
                      : "Get ${actualCashback}% off on each order.",
                  style: TextStyle(
                    fontFamily: 'MuseoSans',
                    color: AppConst.black,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                Text(
                  (isWelcomeOffer ?? false)
                      ? "Offer avilable for new users"
                      : "Offer avilable for all online orders",
                  style: TextStyle(
                    fontFamily: 'MuseoSans',
                    color: AppConst.grey,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ],
            )
          ],
        ));
  }
}

class BIllDiscountOfferAmountCard extends StatelessWidget {
  int? bill_discount_offer_amount;
  int? bill_discount_offer_target;
  BIllDiscountOfferAmountCard(
      {Key? key,
      this.bill_discount_offer_amount,
      this.bill_discount_offer_target})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 86.w,
        height: 6.5.h,
        margin: EdgeInsets.only(left: 6.w),
        decoration: BoxDecoration(
          color: AppConst.white,
          // border: Border.all(color: AppConst.grey, width: 0.5),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: AppConst.grey,
              blurRadius: 1,
              // offset: Offset(1, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 4.h,
              width: 18.w,
              decoration:
                  BoxDecoration(color: AppConst.black, shape: BoxShape.circle),
              child: Center(
                  child: Icon(
                Icons.discount_sharp,
                size: 2.2.h,
                color: AppConst.white,
              )),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Get Flat \u{20b9}${bill_discount_offer_amount} off .",
                  style: TextStyle(
                    fontFamily: 'MuseoSans',
                    color: AppConst.black,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                Text(
                  "on orders above \u{20b9}${bill_discount_offer_target}.",
                  style: TextStyle(
                    fontFamily: 'MuseoSans',
                    color: AppConst.grey,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ],
            )
          ],
        ));
  }
}

class CartRibbn extends StatelessWidget {
  CartRibbn({Key? key, this.totalItemsCount}) : super(key: key);

  int? totalItemsCount;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8.h,
      decoration: BoxDecoration(
        color: AppConst.white.withOpacity(0.9),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        child: Row(
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 2.5.h,
              color: AppConst.black,
            ),
            SizedBox(
              width: 3.w,
            ),
            Text("${totalItemsCount ?? 0} Item",
                style: TextStyle(
                  fontFamily: 'MuseoSans',
                  color: AppConst.black,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                )),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                color: AppConst.green,
                // border: Border.all(color: AppConst.grey, width: 0.5),
                borderRadius: BorderRadius.circular(18),
                // gradient: LinearGradient(colors: [

                // Color(0xff068B2D),

                // Color(0xff079B2E),
                // ]),
                // boxShadow: [
                //   BoxShadow(
                //     color: AppConst.grey,
                //     blurRadius: 1,
                //     // offset: Offset(1, 1),
                //   ),
                // ],
              ),
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 1.3.h),
                child: Text("View Cart",
                    style: TextStyle(
                      fontFamily: 'MuseoSans',
                      color: AppConst.white,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                    )),
              ),
            ),
            // SizedBox(
            //   width: 1.w,
            // ),
            // Icon(
            //   Icons.send,
            //   color: AppConst.black,
            //   size: 2.2.h,
            // ),
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
                final mainProducts = _moreStoreController
                    .getStoreDataModel.value!.data!.mainProducts!;
                mainProducts.sort((a, b) => (b.products?.length ?? 0)
                    .compareTo(a.products?.length ?? 0));
                final storesWithProductsModel = mainProducts[index];
                return Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(storesWithProductsModel.name ?? "",
                              style: TextStyle(
                                fontFamily: 'MuseoSans',
                                color: AppConst.black,
                                fontSize:
                                    (SizerUtil.deviceType == DeviceType.tablet)
                                        ? 10.sp
                                        : 12.sp,
                                fontWeight: FontWeight.w500,
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
                    if (storesWithProductsModel.products!.isEmpty)
                      SizedBox()
                    else
                      Container(
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
                            mainAxisSpacing: 2.h,
                            childAspectRatio: 0.7,
                          ),
                          children: List.generate(
                              storesWithProductsModel.products?.length ?? 0,
                              (index) {
                            StoreModelProducts product =
                                storesWithProductsModel.products![index];
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: 2.w),
                              margin: EdgeInsets.only(
                                  bottom: 1.h, left: 1.w, right: 2.w),
                              width: 42.w,
                              // height: 25.h,

                              // color: AppConst.yellow,
                              decoration: BoxDecoration(
                                color: AppConst.white,
                                // border: Border.all(color: AppConst.grey, width: 0.5),
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    blurRadius: 3,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                          child: DisplayProductInGridView(
                                        logo: product.logo,
                                      )),
                                      // SizedBox(
                                      //   width: 2.w,
                                      // ),
                                      // Container(
                                      //   decoration: BoxDecoration(
                                      //     color: AppConst.white,
                                      //     // border: Border.all(color: AppConst.grey, width: 0.5),
                                      //     borderRadius:
                                      //         BorderRadius.circular(16),
                                      //     boxShadow: [
                                      //       BoxShadow(
                                      //         color: AppConst.grey,
                                      //         blurRadius: 1,
                                      //         // offset: Offset(1, 1),
                                      //       ),
                                      //     ],
                                      //   ),
                                      //   child: Padding(
                                      //     padding: EdgeInsets.symmetric(
                                      //         horizontal: 2.w, vertical: 0.5.h),
                                      //     child: Center(
                                      // child: Text(
                                      //     "\u20b9${product.cashback.toString()} OFF",
                                      //     style: TextStyle(
                                      //       fontFamily: 'MuseoSans',
                                      //       color: AppConst.green,
                                      //       fontSize: 10.sp,
                                      //       fontWeight: FontWeight.w400,
                                      //       fontStyle: FontStyle.normal,
                                      //     )),
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Flexible(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(product.name.toString(),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontFamily: 'MuseoSans',
                                                color: AppConst.black,
                                                fontSize:
                                                    (SizerUtil.deviceType ==
                                                            DeviceType.tablet)
                                                        ? 8.5.sp
                                                        : 9.5.sp,
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                              )),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text("${product.unit ?? ""}",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    fontFamily: 'MuseoSans',
                                                    color: AppConst.greenText,
                                                    fontSize: (SizerUtil
                                                                .deviceType ==
                                                            DeviceType.tablet)
                                                        ? 8.sp
                                                        : 9.sp,
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle: FontStyle.normal,
                                                  )),
                                              SizedBox(
                                                width: 2.w,
                                              ),
                                              Text(
                                                  "\u20b9${product.cashback.toString()} OFF",
                                                  style: TextStyle(
                                                    fontFamily: 'MuseoSans',
                                                    color: AppConst.greenText,
                                                    fontSize: (SizerUtil
                                                                .deviceType ==
                                                            DeviceType.tablet)
                                                        ? 8.5.sp
                                                        : 9.5.sp,
                                                    fontWeight: FontWeight.w700,
                                                    fontStyle: FontStyle.normal,
                                                  )),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "\u{20b9}${product.selling_price ?? ""}",
                                                  style: TextStyle(
                                                    fontFamily: 'MuseoSans',
                                                    color: AppConst.black,
                                                    fontSize: (SizerUtil
                                                                .deviceType ==
                                                            DeviceType.tablet)
                                                        ? 9.sp
                                                        : 10.5.sp,
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle: FontStyle.normal,
                                                  )),
                                              // SizedBox(
                                              //   width: 14.w,
                                              //   child: Text("/${product.unit ?? ""}",
                                              //       maxLines: 1,
                                              //       style: TextStyle(
                                              //         fontFamily: 'MuseoSans',
                                              //         color: AppConst.black,
                                              //         fontSize: SizeUtils
                                              //                 .horizontalBlockSize *
                                              //             3.3,
                                              //         fontWeight: FontWeight.w500,
                                              //         fontStyle: FontStyle.normal,
                                              //       )),
                                              // ),
                                              // RichText(
                                              //     text: TextSpan(children: [
                                              //   // TextSpan(
                                              //   //     text:
                                              //   //         "\u20b9${product.mrp ?? ""}",
                                              //   //     style: TextStyle(
                                              //   //         fontFamily: 'MuseoSans',
                                              //   //         color: AppConst.grey,
                                              //   //         fontSize: SizeUtils
                                              //   //                 .horizontalBlockSize *
                                              //   //             3.3,
                                              //   //         fontWeight:
                                              //   //             FontWeight.w500,
                                              //   //         fontStyle:
                                              //   //             FontStyle.normal,
                                              //   //         decoration: TextDecoration
                                              //   //             .lineThrough)),
                                              //   TextSpan(
                                              //       text:
                                              //           " \u20b9${product.selling_price ?? ""}",
                                              //       style: TextStyle(
                                              //         fontFamily: 'MuseoSans',
                                              //         color: AppConst.black,
                                              //         fontSize: SizeUtils
                                              //                 .horizontalBlockSize *
                                              //             3.5,
                                              //         fontWeight: FontWeight.w500,
                                              //         fontStyle: FontStyle.normal,
                                              //       )),
                                              //   TextSpan(
                                              //       text:
                                              //           "/ ${product.unit ?? ""}",
                                              //       style: TextStyle(
                                              //         fontFamily: 'MuseoSans',
                                              //         color: AppConst.black,
                                              //         fontSize: SizeUtils
                                              //                 .horizontalBlockSize *
                                              //             3.3,
                                              //         fontWeight: FontWeight.w500,
                                              //         fontStyle: FontStyle.normal,
                                              //       ))
                                              // ])),

                                              // Text(
                                              //     "\u20b9${product.mrp ?? "--"}/ ${product.unit ?? ""}",
                                              //     overflow: TextOverflow.ellipsis,
                                              //     style: TextStyle(
                                              //       fontFamily: 'MuseoSans',
                                              //       color: AppConst.black,
                                              //       fontSize: SizeUtils
                                              //               .horizontalBlockSize *
                                              //           3.3,
                                              //       fontWeight: FontWeight.w500,
                                              //       fontStyle: FontStyle.normal,
                                              //     )),
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
                                                            product.quntity!
                                                                .value++;
                                                            if (_moreStoreController
                                                                    .getCartIDModel
                                                                    .value
                                                                    ?.totalItemsCount ==
                                                                0) {
                                                              _moreStoreController
                                                                  .getCartIDModel
                                                                  .value
                                                                  ?.sId = "";
                                                            }
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
                                                                product:
                                                                    product);
                                                            totalCalculated();
                                                          }
                                                          if (product.quntity!
                                                                      .value !=
                                                                  0 &&
                                                              product.isQunitityAdd
                                                                      ?.value ==
                                                                  false) {
                                                            product
                                                                .isQunitityAdd
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
                                              // SizedBox(
                                              //   width: 3.w,
                                              // )
                                            ],
                                          )
                                        ]),
                                  ),
                                  // SizedBox(
                                  //   height: 1.h,
                                  // ),
                                  // Container(
                                  //   // color: AppConst.red,
                                  //   // height: 4.5.h,
                                  //   child: Text(product.name.toString(),
                                  //       maxLines: 2,
                                  //       overflow: TextOverflow.ellipsis,
                                  //       style: TextStyle(
                                  //         fontFamily: 'MuseoSans',
                                  //         color: AppConst.black,
                                  //         fontSize: 12.sp,
                                  //         fontWeight: FontWeight.w500,
                                  //         fontStyle: FontStyle.normal,
                                  //       )),
                                  // ),
                                  // SizedBox(
                                  //   height: 1.h,
                                  // ),
                                  // Text(
                                  //     " \u20b9${product.cashback.toString()} OFF",
                                  //     style: TextStyle(
                                  //       fontFamily: 'MuseoSans',
                                  //       color: AppConst.black,
                                  //       fontSize:
                                  //           SizeUtils.horizontalBlockSize * 3.5,
                                  //       fontWeight: FontWeight.w700,
                                  //       fontStyle: FontStyle.normal,
                                  //     )),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.start,
                                  //   children: [
                                  //     Text(
                                  //         "\u{20b9}${product.selling_price ?? ""}",
                                  //         style: TextStyle(
                                  //           fontFamily: 'MuseoSans',
                                  //           color: AppConst.black,
                                  //           fontSize:
                                  //               SizeUtils.horizontalBlockSize *
                                  //                   3.5,
                                  //           fontWeight: FontWeight.w500,
                                  //           fontStyle: FontStyle.normal,
                                  //         )),
                                  //     // SizedBox(
                                  //     //   width: 14.w,
                                  //     //   child: Text("/${product.unit ?? ""}",
                                  //     //       maxLines: 1,
                                  //     //       style: TextStyle(
                                  //     //         fontFamily: 'MuseoSans',
                                  //     //         color: AppConst.black,
                                  //     //         fontSize: SizeUtils
                                  //     //                 .horizontalBlockSize *
                                  //     //             3.3,
                                  //     //         fontWeight: FontWeight.w500,
                                  //     //         fontStyle: FontStyle.normal,
                                  //     //       )),
                                  //     // ),
                                  //     // RichText(
                                  //     //     text: TextSpan(children: [
                                  //     //   // TextSpan(
                                  //     //   //     text:
                                  //     //   //         "\u20b9${product.mrp ?? ""}",
                                  //     //   //     style: TextStyle(
                                  //     //   //         fontFamily: 'MuseoSans',
                                  //     //   //         color: AppConst.grey,
                                  //     //   //         fontSize: SizeUtils
                                  //     //   //                 .horizontalBlockSize *
                                  //     //   //             3.3,
                                  //     //   //         fontWeight:
                                  //     //   //             FontWeight.w500,
                                  //     //   //         fontStyle:
                                  //     //   //             FontStyle.normal,
                                  //     //   //         decoration: TextDecoration
                                  //     //   //             .lineThrough)),
                                  //     //   TextSpan(
                                  //     //       text:
                                  //     //           " \u20b9${product.selling_price ?? ""}",
                                  //     //       style: TextStyle(
                                  //     //         fontFamily: 'MuseoSans',
                                  //     //         color: AppConst.black,
                                  //     //         fontSize: SizeUtils
                                  //     //                 .horizontalBlockSize *
                                  //     //             3.5,
                                  //     //         fontWeight: FontWeight.w500,
                                  //     //         fontStyle: FontStyle.normal,
                                  //     //       )),
                                  //     //   TextSpan(
                                  //     //       text:
                                  //     //           "/ ${product.unit ?? ""}",
                                  //     //       style: TextStyle(
                                  //     //         fontFamily: 'MuseoSans',
                                  //     //         color: AppConst.black,
                                  //     //         fontSize: SizeUtils
                                  //     //                 .horizontalBlockSize *
                                  //     //             3.3,
                                  //     //         fontWeight: FontWeight.w500,
                                  //     //         fontStyle: FontStyle.normal,
                                  //     //       ))
                                  //     // ])),

                                  //     // Text(
                                  //     //     "\u20b9${product.mrp ?? "--"}/ ${product.unit ?? ""}",
                                  //     //     overflow: TextOverflow.ellipsis,
                                  //     //     style: TextStyle(
                                  //     //       fontFamily: 'MuseoSans',
                                  //     //       color: AppConst.black,
                                  //     //       fontSize: SizeUtils
                                  //     //               .horizontalBlockSize *
                                  //     //           3.3,
                                  //     //       fontWeight: FontWeight.w500,
                                  //     //       fontStyle: FontStyle.normal,
                                  //     //     )),
                                  //     Spacer(),
                                  //     Obx(
                                  //       () => product.quntity!.value > 0 &&
                                  //               product.isQunitityAdd?.value ==
                                  //                   false
                                  //           ? _shoppingItem(product)
                                  //           : GestureDetector(
                                  //               onTap: () async {
                                  //                 if (product.quntity!.value ==
                                  //                     0) {
                                  //                   product.quntity!.value++;
                                  //                   if (_moreStoreController
                                  //                           .getCartIDModel
                                  //                           .value
                                  //                           ?.totalItemsCount ==
                                  //                       0) {
                                  //                     _moreStoreController
                                  //                         .getCartIDModel
                                  //                         .value
                                  //                         ?.sId = "";
                                  //                   }
                                  //                   _moreStoreController.addToCart(
                                  //                       store_id:
                                  //                           _moreStoreController
                                  //                               .storeId.value,
                                  //                       index: 0,
                                  //                       increment: true,
                                  //                       cart_id:
                                  //                           _moreStoreController
                                  //                                   .getCartIDModel
                                  //                                   .value
                                  //                                   ?.sId ??
                                  //                               '',
                                  //                       product: product);
                                  //                   totalCalculated();
                                  //                 }
                                  //                 if (product.quntity!.value !=
                                  //                         0 &&
                                  //                     product.isQunitityAdd
                                  //                             ?.value ==
                                  //                         false) {
                                  //                   product.isQunitityAdd
                                  //                       ?.value = false;
                                  //                   await Future.delayed(
                                  //                           Duration(
                                  //                               milliseconds:
                                  //                                   500))
                                  //                       .whenComplete(() =>
                                  //                           product
                                  //                               .isQunitityAdd
                                  //                               ?.value = true);
                                  //                 }
                                  //                 // addItem(product);
                                  //               },
                                  //               child: product.isQunitityAdd
                                  //                               ?.value ==
                                  //                           true &&
                                  //                       product.quntity!
                                  //                               .value !=
                                  //                           0
                                  //                   ? _dropDown(
                                  //                       product,
                                  //                       storesWithProductsModel
                                  //                               .sId ??
                                  //                           '')
                                  //                   : DisplayAddPlus(),
                                  //             ),
                                  //     ),
                                  //     SizedBox(
                                  //       width: 3.w,
                                  //     )
                                  //   ],
                                  // )
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
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  child: Container(
                    height: 1.5.w,
                    color: AppConst.veryLightGrey,
                  ),
                );
              },
            )
          : Container(
              height: 55.h,
              child: Center(
                child: EmptyHistoryPage(
                    icon: Icons.shopping_cart,
                    text1: "No products found ",
                    text2: "search in different stores",
                    text3: ""),
                // Text(
                //   'No data Found',
                //   style: TextStyle(
                //     fontSize: SizeUtils.horizontalBlockSize * 5,
                //   ),
                // ),
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
        color: AppConst.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppConst.grey,
            blurRadius: 1,
          ),
        ],
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
            color: AppConst.greenText,
            fontSize:
                (SizerUtil.deviceType == DeviceType.tablet) ? 9.5.sp : 10.5.sp,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
    );
  }
}
