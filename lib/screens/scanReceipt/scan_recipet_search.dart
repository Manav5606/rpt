import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:customer_app/app/controller/account_controller.dart';
import 'package:customer_app/app/controller/add_location_controller.dart';
import 'package:customer_app/screens/addcart/Widgets/store_name_call_logo.dart';
import 'package:flutter/cupertino.dart';
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
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  final AddLocationController _addLocationController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _addLocationController.checkPermission.listen((p0) async {
      _paymentController.latLng = LatLng(
          UserViewModel.currentLocation.value.latitude,
          UserViewModel.currentLocation.value.longitude);
      await _paymentController.getScanReceiptPageNearMeStoresData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: AppConst.white,
          statusBarIconBrightness: Brightness.dark),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: AppConst.white,
              statusBarIconBrightness: Brightness.dark),
          // backgroundColor: Color(0xff005b41),
          title: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.BaseScreen);
                },
                child: Icon(
                  Icons.arrow_back,
                  size: 3.h,
                  color: AppConst.black,
                ),
              ),
              Spacer(),
              SizedBox(
                height: 3.5.h,
                child: Image(
                  image: AssetImage(
                    'assets/images/Scan.png',
                  ),
                ),
              ),
              SizedBox(
                width: 4.w,
              ),
              Text("Scan any Stores",
                  style: TextStyle(
                    fontFamily: 'MuseoSans',
                    color: AppConst.black,
                    fontSize: SizeUtils.horizontalBlockSize * 4.5,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  )),
              Spacer(),
              InkWell(
                  onTap: () async {
                    dynamic value = await Get.to(AddressModel(
                      isHomeScreen: false,
                      page: "scan",
                    ));
                    _paymentController.latLng = LatLng(
                        UserViewModel.currentLocation.value.latitude,
                        UserViewModel.currentLocation.value.longitude);
                    await _paymentController
                        .getScanReceiptPageNearMeStoresData();
                    if (Constants.isAbleToCallApi)
                      await _homeController.getAllCartsData();
                  },
                  child: SizedBox(
                    width: 10.w,
                    child: Icon(
                      Icons.location_on,
                      size: 3.h,
                    ),
                  ))
            ],
          ),

          // Obx(
          //   () => HomeAppBar(
          //     onTap: () async {
          //       dynamic value = await Get.to(AddressModel(
          //         isHomeScreen: true,
          //       ));
          //       _paymentController.latLng = LatLng(
          //           UserViewModel.currentLocation.value.latitude,
          //           UserViewModel.currentLocation.value.longitude);
          //       await _paymentController.getScanReceiptPageNearMeStoresData();
          //       if (Constants.isAbleToCallApi)
          //         await _homeController.getAllCartsData();
          //     },
          //     isRedDot:
          //         _homeController.getAllCartsModel.value?.cartItemsTotal != 0
          //             ? true
          //             : false,
          //     address: _homeController.userAddress.value,
          //     balance: (_MyController.user.balance ?? 0),
          //     onTapWallet: () {
          //       Get.toNamed(AppRoutes.Wallet);
          //     },
          //   ),
          // ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
            child:
                //  Obx(
                //   () =>
                Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // _homeController.checkPermission.value
                //     ? SizedBox()
                //     : PermissionRaw(
                //         onTap: () async {
                //           bool isEnable =
                //               await _homeController.getCurrentLocation();
                //           if (isEnable) {
                //             _paymentController.latLng = LatLng(
                //                 UserViewModel.currentLocation.value.latitude,
                //                 UserViewModel
                //                     .currentLocation.value.longitude);
                //             await _paymentController
                //                 .getScanReceiptPageNearMeStoresData();
                //           }
                //         },
                //       ),
                SizedBox(
                  height: 1.h,
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
                    child: SizedBox(
                      height: 4.5.h,
                      child: TextField(
                          textAlign: TextAlign.left,
                          textDirection: TextDirection.rtl,
                          textAlignVertical: TextAlignVertical.center,
                          enabled: false,
                          decoration: InputDecoration(
                              isDense: true,
                              prefixIcon: Icon(
                                CupertinoIcons.search,
                                size: SizeUtils.horizontalBlockSize * 5,
                                color: AppConst.grey,
                              ),
                              counterText: "",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(color: AppConst.black),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(
                                    color: AppConst.black, width: 0.5),
                              ),
                              // focusedBorder: OutlineInputBorder(
                              //   borderRadius: BorderRadius.circular(4),
                              //   borderSide: BorderSide(color: AppConst.black),
                              // ),
                              hintTextDirection: TextDirection.rtl,
                              hintText: "Search Stores, Receipts & Products",
                              hintStyle: TextStyle(
                                  fontFamily: 'MuseoSans',
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                  color: AppConst.grey,
                                  fontSize:
                                      SizeUtils.horizontalBlockSize * 3.5)),
                          showCursor: true,
                          cursorColor: AppConst.black,
                          cursorHeight: SizeUtils.horizontalBlockSize * 4,
                          maxLength: 30,
                          style: TextStyle(
                            color: AppConst.black,
                            fontSize: SizeUtils.horizontalBlockSize * 4,
                          ),
                          onChanged: (value) {}),
                    ),
                  ),
                ),

                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 2.w),
                //   child: Text(
                //     'Popular Searches',
                //     style: TextStyle(
                //       fontSize: SizeUtils.horizontalBlockSize * 4,
                //       fontWeight: FontWeight.bold,
                //       color: AppConst.black,
                //     ),
                //   ),
                // ),
                // SizedBox(height: SizeUtils.verticalBlockSize * 1),
                InkWell(
                  highlightColor: AppConst.lightGrey,
                  onTap: () {
                    // Get.toNamed(AppRoutes.MyCartScreen);
                    Get.to(() => TheBossCameraScreen());
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 2.w, right: 2.w, top: 2.h, bottom: 1.h),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xffe6faf1),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 2.h),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Container(
                            //   decoration: BoxDecoration(
                            //       shape: BoxShape.circle,
                            //       border: Border.all(color: AppConst.grey)),
                            //   child: ClipOval(
                            //     child: ClipRRect(
                            //       borderRadius: BorderRadius.circular(100),
                            //       child: CachedNetworkImage(
                            //         height: SizeUtils.verticalBlockSize * 5,
                            //         width: SizeUtils.horizontalBlockSize * 10,
                            //         fit: BoxFit.contain,
                            //         imageUrl:
                            //             'https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg',
                            //         progressIndicatorBuilder: (context, url,
                            //                 downloadProgress) =>
                            //             CircularProgressIndicator(
                            //                 value: downloadProgress.progress),
                            //         errorWidget: (context, url, error) =>
                            //             Image.network(
                            //                 'https://image.freepik.com/free-vector/shop-with-sign-we-are-open_23-2148547718.jpg'),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              height: 6.h,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppConst.white,
                                  border: Border.all(
                                    width: 0.1,
                                    color: AppConst.lightGrey,
                                  )),
                              child: Image(
                                image: AssetImage(
                                  'assets/images/Store.png',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "Got no Bills? No problem place\norders and earn instantly.",
                                      style: TextStyle(
                                        fontFamily: 'MuseoSans',
                                        color: Color(0xff005b41),
                                        fontSize:
                                            SizeUtils.horizontalBlockSize * 4,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                      )),
                                  Text("Sign Up and gain Easy Rewards.",
                                      style: TextStyle(
                                        fontFamily: 'MuseoSans',
                                        color: Color(0xff005b41),
                                        fontSize:
                                            SizeUtils.horizontalBlockSize * 3.5,
                                        fontWeight: FontWeight.w300,
                                        fontStyle: FontStyle.normal,
                                      )),
                                  // Text(
                                ],
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Color(0xff005b41),
                              size: 2.5.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Padding(
                //   padding: EdgeInsets.symmetric(
                //     horizontal: 2.w,
                //   ),
                //   child: Row(
                //     children: [
                //       SizedBox(
                //         height: 3.5.h,
                //         child: Image(
                //           image: AssetImage(
                //             'assets/images/Scan.png',
                //           ),
                //         ),
                //       ),
                //       SizedBox(
                //         width: 4.w,
                //       ),
                //       Text("Scan any Stores",
                //           style: TextStyle(
                //             fontFamily: 'MuseoSans',
                //             color: Color(0xff000000),
                //             fontSize: 16,
                //             fontWeight: FontWeight.w700,
                //             fontStyle: FontStyle.normal,
                //           ))
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 1.h,
                // ),
                ScanReceiptCard(),
              ],
            ),
            // ),
          ),
        ),
      ),
    );
  }
}
