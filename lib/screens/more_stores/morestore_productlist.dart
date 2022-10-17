import 'package:flutter/material.dart';
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

class MoreStoreProductScreen extends StatefulWidget {
  const MoreStoreProductScreen({Key? key}) : super(key: key);

  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<MoreStoreProductScreen> {
  late PersistentTabController _controller;
  bool isGrocery = false;
  final AddCartController _addCartController = Get.find();
  @override
  void initState() {
    super.initState();
    Map arg = Get.arguments ?? {};
    isGrocery = arg['isGrocery'] ?? false;
    _controller = PersistentTabController(initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      navBarStyle: NavBarStyle.style14,
      onItemSelected: (int) {
        _addCartController.onTabChange.value = !_addCartController.onTabChange.value;
      },
    );
  }

  List<Widget> _buildScreens() {
    return [
      MoreStoreProductView(),
      isGrocery
          ? ChatOrderScreen(
              isNewStore: true,
            )
          : FreshStoreScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          icon: Icon(Icons.shopping_bag_outlined),
          title: "Shop",
          activeColorPrimary: AppConst.kSecondaryColor,
          activeColorSecondary: AppConst.green,
          inactiveColorPrimary: AppConst.grey),
      PersistentBottomNavBarItem(
          icon: isGrocery ? Icon(Icons.chat_bubble_outlined) : Icon(Icons.shopping_cart),
          title: isGrocery ? "Chat Order" : "Fresh Store",
          activeColorPrimary: AppConst.kSecondaryColor,
          activeColorSecondary: AppConst.green,
          inactiveColorPrimary: AppConst.grey),
    ];
  }
}

class MoreStoreProductView extends StatelessWidget {
  final MoreStoreController _moreStoreController = Get.find();
  final AddCartController _addCartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          physics: BouncingScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 18.h,
                centerTitle: true,
                pinned: true,
                stretch: true,
                floating: true,
                backgroundColor: Colors.green[600],
                title: (innerBoxIsScrolled)
                    ? CircleAvatar(radius: SizeUtils.horizontalBlockSize * 3.82, child: Image.asset("assets/images/image4.png"))
                    : Text(""),
                leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  color: Colors.white,
                  icon: Icon(
                    Icons.cancel_rounded,
                    size: SizeUtils.horizontalBlockSize * 8,
                    //color: Colors.white,
                  ),
                ),
                actions: [
                  Obx(
                    () => CartWidget(
                      onTap: () async {
                        Get.toNamed(
                          AppRoutes.CartReviewScreen,
                          arguments: {
                            'logo': _moreStoreController.getStoreDataModel.value?.data?.store?.logo,
                            'storeName': _moreStoreController.getStoreDataModel.value?.data?.store?.name,
                            'totalCount': _moreStoreController.addToCartModel.value?.totalItemsCount.toString() ?? "",
                          },
                        );
                        await _addCartController.getReviewCartData(cartId: _moreStoreController.addToCartModel.value?.sId ?? "");
                        // await _addCartController.getCartPageInformation(storeId: _moreStoreController.addToCartModel.value?.store ?? "");
                        await _addCartController.getCartLocation(
                            storeId: _moreStoreController.storeId.value, cartId: _moreStoreController.addToCartModel.value?.sId ?? "");
                        _addCartController.cartId.value = _moreStoreController.addToCartModel.value?.sId ?? "";
                        if (_addCartController.store.value?.sId == null) {
                          _addCartController.store.value?.sId = _moreStoreController.storeId.value;
                        }
                      },
                      count: "${_moreStoreController.totalItemsCount.value}",
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  collapseMode: CollapseMode.parallax,
                  background: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 1.h,
                      ),
                      Obx(
                        () => CircleAvatar(
                          radius: SizeUtils.horizontalBlockSize * 3.82,
                          child: (_moreStoreController.getStoreDataModel.value?.data?.store?.logo?.isNotEmpty ?? false)
                              ? Image.network(_moreStoreController.getStoreDataModel.value!.data!.store!.logo.toString())
                              : Image.asset("assets/images/image4.png"),
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Obx(
                        () => Text(
                          _moreStoreController.getStoreDataModel.value?.data?.store?.name.toString() ?? "",
                          style: TextStyle(color: Colors.white, fontSize: SizeUtils.horizontalBlockSize * 4),
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(AppRoutes.InStoreSearch, arguments: {'storeId': _moreStoreController.storeId.value});
                        },
                        child: SizedBox(width: 90.w, child: StoreSearchField()),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Column(
              children: [
                BannerWidget(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 1.h,
                      ),
                      DeliveryTimeWidget(),
                      Divider(
                        thickness: 1,
                      ),
                      MoewStoreViewProductsList()
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
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SizeUtils.horizontalBlockSize * 7.65))),
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
            initialLabelIndex: (_moreStoreController.getStoreDataModel.value?.data?.store?.storeType ?? 'online') == 'online' ? 0 : 1,
            totalSwitches: 2,
            labels: ['Delivery', 'Pickup'],
            customTextStyles: [TextStyle(fontSize: SizeUtils.horizontalBlockSize * 3.06), TextStyle(fontSize: SizeUtils.horizontalBlockSize * 3.06)],
            radiusStyle: true,
            onToggle: (index) {},
          ),
          _moreStoreController.displayHour.isNotEmpty ? Text('Ready by ${_moreStoreController.displayHour}') : SizedBox(),
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
      () => (_moreStoreController.getStoreDataModel.value?.data?.mainProducts?.isNotEmpty ?? false)
          ? ListView.separated(
              // controller: this.controller,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: _moreStoreController.getStoreDataModel.value?.data?.mainProducts?.length ?? 0,
              //data.length,
              itemBuilder: (context, index) {
                MainProducts? storesWithProductsModel = _moreStoreController.getStoreDataModel.value?.data?.mainProducts?[index];
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
                                                          _moreStoreController.addToCart(
                                                              store_id: _moreStoreController.storeId.value,
                                                              index: 0,
                                                              increment: true,
                                                              cart_id: _moreStoreController.addToCartModel.value?.sId ?? '',
                                                              product: product);
                                                          totalCalculated();
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
                                                                  color: Colors.grey,
                                                                ),
                                                                child: product.isQunitityAdd?.value == true && product.quntity!.value != 0
                                                                    ? Center(
                                                                        child: Text("${product.quntity!.value}",
                                                                            style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: SizeUtils.horizontalBlockSize * 4,
                                                                            )),
                                                                      )
                                                                    : Icon(
                                                                        Icons.add,
                                                                        color: Colors.white,
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
    );
  }

  totalCalculated() async {
    int total = 0;
    _moreStoreController.getStoreDataModel.value?.data?.mainProducts?.forEach((element) {
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
            cart_id: _moreStoreController.addToCartModel.value?.sId ?? '',
          );
          totalCalculated();
        },
        offset: Offset(0.0, 40),
        child: Align(
          alignment: Alignment.topRight,
          child: Container(
            height: SizeUtils.horizontalBlockSize * 8,
            width: SizeUtils.horizontalBlockSize * 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
            ),
            child: product.isQunitityAdd?.value == true && product.quntity!.value != 0
                ? Center(
                    child: Text("${product.quntity!.value}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: SizeUtils.horizontalBlockSize * 4,
                        )),
                  )
                : Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
          ),
        ),
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeUtils.horizontalBlockSize * 5),
        color: Colors.grey,
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
          color: Colors.white,
        ),
        child: Icon(
          Icons.add,
          color: Colors.grey,
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
          color: Colors.white,
        ),
        child: Icon(
          Icons.remove,
          color: Colors.grey,
        ),
      ),
    );
  }
}
