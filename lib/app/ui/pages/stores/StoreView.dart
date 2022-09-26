import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/ui/pages/search/controller/exploreContoller.dart';
import 'package:customer_app/app/ui/pages/stores/StoreViewProductList.dart';
import 'package:customer_app/constants/app_const.dart';

import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/screens/addcart/controller/addcart_controller.dart';
import 'package:customer_app/widgets/cartWidget.dart';
import 'package:customer_app/widgets/storesearchfield.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:toggle_switch/toggle_switch.dart';

class StoreView extends StatelessWidget {
  final ExploreController _exploreController = Get.find();
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
                backgroundColor: AppConst.green,
                title: (innerBoxIsScrolled)
                    ? CircleAvatar(radius: SizeUtils.horizontalBlockSize * 3.82, child: Image.asset("assets/images/image4.png"))
                    : Text(""),
                leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  color: AppConst.white,
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
                            'logo': _exploreController.cartIndex.value?.store?.logo,
                            'storeName': _exploreController.cartIndex.value?.store?.name,
                            'totalCount': _exploreController.totalItemCount.value,
                          },
                        );
                        await _addCartController.getReviewCartData(cartId: _exploreController.cartIndex.value?.sId ?? "");
                        // await _addCartController.getCartPageInformation(storeId: _exploreController.cartIndex.value?.store?.sId ?? "");
                        await _addCartController.getCartLocation(
                            storeId: _exploreController.cartIndex.value?.store?.sId ?? "", cartId: _exploreController.cartIndex.value?.sId ?? "");
                        _addCartController.store.value = _exploreController.cartIndex.value?.store;
                        _addCartController.cartId.value = _exploreController.cartIndex.value?.sId ?? "";
                      },
                      count: '${_exploreController.totalItemCount.value}',
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
                          child: (_exploreController.getStoreDataModel.value?.data?.store?.logo?.isNotEmpty ?? false)
                              ? Image.network(_exploreController.getStoreDataModel.value!.data!.store!.logo.toString())
                              : Image.asset("assets/images/image4.png"),
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Obx(
                        () => Text(
                          _exploreController.getStoreDataModel.value?.data?.store?.name.toString() ?? "",
                          style: TextStyle(color: AppConst.white, fontSize: SizeUtils.horizontalBlockSize * 4),
                        ),
                      ),
                      SizedBox(
                        height: 1.5.h,
                      ),
                      InkWell(
                        onTap: () =>
                            Get.toNamed(AppRoutes.InStoreSearch, arguments: {'storeId': _exploreController.cartIndex.value?.store?.sId ?? ""}),
                        child: SizedBox(width: 90.w, child: StoreSearchField()),
                      ),
                      SizedBox(
                        height: 1.5.h,
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
                      StoreViewProductsList(
                        onChange: (value) {},
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
        color: AppConst.lightYellow,
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
  final ExploreController _exploreController = Get.find()..formatDate();

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
              [AppConst.white],
              [AppConst.white],
            ],
            borderColor: [AppConst.grey, AppConst.grey],
            activeFgColor: AppConst.black,
            inactiveBgColor: AppConst.grey,
            inactiveFgColor: AppConst.black,
            initialLabelIndex: (_exploreController.getStoreDataModel.value?.data?.store?.storeType ?? 'online') == 'online' ? 0 : 1,
            totalSwitches: 2,
            labels: ['Delivery', 'Pickup'],
            customTextStyles: [TextStyle(fontSize: SizeUtils.horizontalBlockSize * 3.06), TextStyle(fontSize: SizeUtils.horizontalBlockSize * 3.06)],
            radiusStyle: true,
            onToggle: (index) {},
          ),
          _exploreController.displayHour.isNotEmpty ? Text('Ready by ${_exploreController.displayHour}') : SizedBox(),
        ],
      ),
    );
  }
}
