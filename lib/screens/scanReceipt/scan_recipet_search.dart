import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:customer_app/app/controller/account_controller.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/app_constants.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/controllers/userViewModel.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/screens/home/controller/home_controller.dart';
import 'package:customer_app/screens/scanReceipt/scanRecipetCardList.dart';
import 'package:customer_app/screens/wallet/controller/paymentController.dart';
import 'package:customer_app/widgets/backButton.dart';
import 'package:customer_app/widgets/homescreen_appbar.dart';
import 'package:customer_app/widgets/permission_raw.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../app/ui/pages/location_picker/address_model.dart';
import '../../scan_receipt/theBoss/view/TheBossCameraScreen.dart';

class ScanRecipetSearch extends StatefulWidget {
  @override
  State<ScanRecipetSearch> createState() => _ScanRecipetSearchState();
}

class _ScanRecipetSearchState extends State<ScanRecipetSearch> {
  final PaymentController _paymentController = Get.find();

  final HomeController _homeController = Get.find();
  final MyAccountController _MyController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _homeController.checkPermission.listen((p0) async {
      _paymentController.latLng = LatLng(
          UserViewModel.currentLocation.value.latitude,
          UserViewModel.currentLocation.value.longitude);
      await _paymentController.getScanReceiptPageNearMeStoresData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Color(0xff005b41),
              statusBarIconBrightness: Brightness.light),
          iconTheme: IconThemeData(
            color: AppConst.white,
          ),
          elevation: 0,
          backgroundColor: Color(0xff005b41),
          title: Obx(
            () => HomeAppBar(
              onTap: () async {
                dynamic value = await Get.to(AddressModel(
                  isHomeScreen: true,
                ));
                _paymentController.latLng = LatLng(
                    UserViewModel.currentLocation.value.latitude,
                    UserViewModel.currentLocation.value.longitude);
                await _paymentController.getScanReceiptPageNearMeStoresData();
                if (Constants.isAbleToCallApi)
                  await _homeController.getAllCartsData();
              },
              isRedDot:
                  _homeController.getAllCartsModel.value?.cartItemsTotal != 0
                      ? true
                      : false,
              address: _homeController.userAddress.value,
              balance: (_MyController.user.balance ?? 0),
              onTapWallet: () {
                Get.toNamed(AppRoutes.Wallet);
              },
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeUtils.horizontalBlockSize * 0.2),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _homeController.checkPermission.value
                    ? SizedBox()
                    : PermissionRaw(
                        onTap: () async {
                          bool isEnable =
                              await _homeController.getCurrentLocation();
                          if (isEnable) {
                            _paymentController.latLng = LatLng(
                                UserViewModel.currentLocation.value.latitude,
                                UserViewModel.currentLocation.value.longitude);
                            await _paymentController
                                .getScanReceiptPageNearMeStoresData();
                          }
                        },
                      ),
                SizedBox(
                  height: SizeUtils.horizontalBlockSize * 1,
                ),
                GestureDetector(
                  onTap: () {
                    _paymentController.searchController.clear();
                    _paymentController.searchText.value = '';
                    _paymentController
                        .getNearMePageDataModel.value?.data?.stores
                        ?.clear();
                    Get.toNamed(AppRoutes.SearchRecipeScreen);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    child: TextField(
                        textAlign: TextAlign.left,
                        textDirection: TextDirection.rtl,
                        // controller: _paymentController.searchController,
                        textAlignVertical: TextAlignVertical.center,
                        enabled: false,
                        decoration: InputDecoration(
                            isDense: true,
                            suffixIcon: Icon(
                              Icons.search,
                              size: SizeUtils.horizontalBlockSize * 6,
                              color: AppConst.black,
                            ),
                            counterText: "",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: AppConst.black),
                            ),
                            hintTextDirection: TextDirection.rtl,
                            hintText: " Search products,stores & recipes",
                            hintStyle: TextStyle(
                                color: AppConst.grey,
                                fontSize: SizeUtils.horizontalBlockSize * 4)),
                        showCursor: true,
                        cursorColor: AppConst.black,
                        cursorHeight: SizeUtils.horizontalBlockSize * 5,
                        maxLength: 30,
                        style: TextStyle(
                          color: AppConst.black,
                          fontSize: SizeUtils.horizontalBlockSize * 4,
                        ),
                        onChanged: (value) {}),
                  ),
                ),
                SizedBox(
                  height: SizeUtils.verticalBlockSize * 1,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Text(
                    'Popular Searches',
                    style: TextStyle(
                      fontSize: SizeUtils.horizontalBlockSize * 4,
                      fontWeight: FontWeight.bold,
                      color: AppConst.black,
                    ),
                  ),
                ),
                SizedBox(height: SizeUtils.verticalBlockSize * 1),
                InkWell(
                  highlightColor: AppConst.lightGrey,
                  onTap: () {
                    // Get.toNamed(AppRoutes.MyCartScreen);
                    Get.to(() => TheBossCameraScreen());
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 0.5.h),
                    color: AppConst.blue.withOpacity(0.2),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: AppConst.grey)),
                            child: ClipOval(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: CachedNetworkImage(
                                  height: SizeUtils.verticalBlockSize * 5,
                                  width: SizeUtils.horizontalBlockSize * 10,
                                  fit: BoxFit.contain,
                                  imageUrl:
                                      'https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg',
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                  errorWidget: (context, url, error) =>
                                      Image.network(
                                          'https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg'),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: SizeUtils.horizontalBlockSize * 2,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Get no bill? start earning without bills!',
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: SizeUtils.horizontalBlockSize * 4,
                                    fontWeight: FontWeight.bold,
                                    color: AppConst.black,
                                  ),
                                ),
                                Text(
                                  'Sign up for Easy Rewards',
                                  style: TextStyle(
                                    fontSize: SizeUtils.horizontalBlockSize * 4,
                                    color: AppConst.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: AppConst.grey,
                            size: SizeUtils.horizontalBlockSize * 7,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeUtils.verticalBlockSize * 1,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: ScanReceiptCard(),
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
