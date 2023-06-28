import 'dart:async';
import 'dart:developer';

import 'package:customer_app/app/controller/my_wallet_controller.dart';
import 'package:customer_app/app/ui/pages/signIn/phone_authentication_screen.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/controller/add_location_controller.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/constants/string_constants.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/screens/home/controller/home_controller.dart';
import 'package:customer_app/widgets/getstorge.dart';
import 'package:customer_app/widgets/search_field.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

import '../../../../controllers/userViewModel.dart';
import 'package:location/location.dart' as temp;

import 'address_model_shimmer.dart';

class AddressModel extends StatefulWidget {
  final bool isHomeScreen;
  final bool isSavedAddress;
  final String? page;
  final bool editOrDelete;
  final bool isRecentAddress;
  bool issignup;

  AddressModel(
      {Key? key,
      this.isHomeScreen = false,
      this.isSavedAddress = true,
      this.isRecentAddress = true,
      this.editOrDelete = false,
      this.issignup = false,
      this.page})
      : super(key: key);

  @override
  State<AddressModel> createState() => _AddressModelState();
}

class _AddressModelState extends State<AddressModel> {
  final AddLocationController _addLocationController =
      Get.put(AddLocationController());
  final HomeController _homeController = Get.put(HomeController());
  final MyWalletController _myWalletController = Get.put(MyWalletController());
  FocusNode focusNode = FocusNode();

  Timer? _debounce;
  bool selected = false;

  bool isLoading = true;
  bool? isHomeSelected;
  bool? isHome;
  List<String> isHomeTrue = [];

  @override
  void initState() {
    super.initState();
    updateAddressStatus();
    _startLoadingTimer();
  }

  void updateAddressStatus() {
    isHomeTrue.clear();
    int? addressesLength =
        _addLocationController.userModel?.addresses?.length ?? 0;
    print(addressesLength);

    for (int index = 0; index < addressesLength; index++) {
      if (_addLocationController.userModel!.addresses![index].title == "Home") {
        isHomeTrue
            .add(_addLocationController.userModel!.addresses![index].title!);
      }
    }
    if (isHomeTrue.contains("Home")) {
      isHome = true;
    } else {
      isHome = false;
    }
    print(isHome);
    print("isHome");
  }

  void _startLoadingTimer() {
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    updateAddressStatus();
    // final AddLocationController _addLocationController =
    //     Get.put(AddLocationController());
    final AddLocationController _addLocationController = Get.find()
      ..getUserData();

    // final HomeController _homeController = Get.lazyPut(HomeController());
    //  final islocationPermission = HomeController().getCurrentLocation();
    _addLocationController.isRecentAddress.value = widget.isHomeScreen;
    return isLoading
        ? AddresShimmer()
        : Scaffold(
            appBar: AppBar(
              // automaticallyImplyLeading: false,
              elevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: AppConst.white,
                  statusBarIconBrightness: Brightness.dark),
              centerTitle: true,
              title: Row(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  // InkWell(
                  //   onTap: () => Get.back(),
                  //   // Get.toNamed(AppRoutes.BaseScreen),
                  //   child: Icon(
                  //     Icons.arrow_back,
                  //     color: AppConst.black,
                  //     size: SizeUtils.horizontalBlockSize * 7.2,
                  //   ),
                  // ),
                  // SizedBox(
                  //   width: 4.w,
                  // ),
                  Text(
                    (widget.editOrDelete == true) ? "" : "",
                    style: TextStyle(
                      color: AppConst.black,
                      fontFamily: 'MuseoSans',
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      fontSize: (SizerUtil.deviceType == DeviceType.tablet)
                          ? 9.sp
                          : 10.sp,
                    ),
                  ),
                ],
              ),
            ),
            body:

                //  NestedScrollView(
                //   physics: BouncingScrollPhysics(),
                //   headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                //     return <Widget>[
                //       SliverAppBar(
                //         systemOverlayStyle: SystemUiOverlayStyle(
                //             statusBarColor: AppConst.white,
                //             statusBarIconBrightness: Brightness.dark),
                //         expandedHeight: 10.h,
                //         centerTitle: true,
                //         pinned: true,
                //         stretch: true,
                //         floating: true,
                //         iconTheme: IconThemeData(color: AppConst.black),
                //         backgroundColor: AppConst.white,
                //         title: (innerBoxIsScrolled)
                //             ? Row(
                //                 children: [
                //                   Text(
                //                     "Choose Address",
                //                     overflow: TextOverflow.ellipsis,
                //                     maxLines: 1,
                // style: TextStyle(
                //   color: AppConst.black,
                //   fontFamily: 'MuseoSans',
                //   fontWeight: FontWeight.w700,
                //   fontStyle: FontStyle.normal,
                //   fontSize: SizeUtils.horizontalBlockSize * 4,
                // ),
                //                   ),
                //                 ],
                //               )
                //             : Row(
                //                 children: [
                //                   Text(
                //                     "",
                //                     overflow: TextOverflow.ellipsis,
                //                     maxLines: 1,
                //                     style: TextStyle(
                //                       color: AppConst.black,
                //                       fontFamily: 'MuseoSans',
                //                       fontWeight: FontWeight.w700,
                //                       fontStyle: FontStyle.normal,
                //                       fontSize: SizeUtils.horizontalBlockSize * 4,
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //         flexibleSpace: FlexibleSpaceBar(
                //           centerTitle: true,
                //           collapseMode: CollapseMode.parallax,
                //           background: Column(
                //             mainAxisAlignment: MainAxisAlignment.spaceAround,
                //             children: [
                //               SizedBox(
                //                 height: 4.h,
                //               ),
                //               Padding(
                //                 padding: EdgeInsets.only(left: 5.w, top: 6.h),
                //                 child: Row(
                //                   mainAxisAlignment: MainAxisAlignment.start,
                //                   children: [
                //                     Text(
                //                       "Choose Address",
                //                       style: TextStyle(
                //                         color: AppConst.black,
                //                         fontFamily: 'MuseoSans',
                //                         fontWeight: FontWeight.w700,
                //                         fontStyle: FontStyle.normal,
                //                         fontSize: SizeUtils.horizontalBlockSize * 4.5,
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ];
                //   },
                // body:
                SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Obx(
                        () => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 3.w),
                                child: Text(
                                  "Search for your location",
                                  style: TextStyle(
                                    fontFamily: 'MuseoSans',
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.normal,
                                    fontSize: (SizerUtil.deviceType ==
                                            DeviceType.tablet)
                                        ? 9.sp
                                        : 10.sp,
                                    color: AppConst.black,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 2.w),
                                child: SearchField(
                                  controller:
                                      _addLocationController.searchController,
                                  focusNode: focusNode,
                                  suffixIcon: (_addLocationController
                                                  .searchText.value !=
                                              null &&
                                          _addLocationController
                                                  .searchText.value !=
                                              "")
                                      ? GestureDetector(
                                          onTap: () {
                                            _addLocationController
                                                .searchController
                                                .clear();
                                            _addLocationController.predictions
                                                .clear();
                                          },
                                          child: Icon(
                                            Icons.close,

                                            color: AppConst.black, size: 2.5.h,
                                            // _addLocationController.searchText.value.isNotEmpty
                                            //     ? kPrimaryColor
                                            //     : kIconColor,
                                          ),
                                        )
                                      : null,
                                  prefixIcon: (_addLocationController
                                                  .searchText.value !=
                                              null &&
                                          _addLocationController
                                                  .searchText.value !=
                                              "")
                                      ? Icon(
                                          Icons.search,
                                          color: AppConst.grey,
                                          size: 2.8.h,
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            _addLocationController
                                                .searchController
                                                .clear();
                                            _addLocationController.predictions
                                                .clear();
                                          },
                                          child: Icon(
                                            Icons.search,
                                            color: AppConst.black,
                                            size: 2.8.h,
                                          ),
                                        ),

                                  // onEditingComplete: () {
                                  //   focusNode.unfocus();
                                  //   log('onEditingComplete :-->>>>>>>>>>000');
                                  //   if (_addLocationController.searchController.text.isNotEmpty) {
                                  //     log('onEditingComplete :-->>>>>>>>>>111');
                                  //     _addLocationController.autoCompleteSearch(
                                  //         _addLocationController.searchController.text);
                                  //   } else {
                                  //     log('onEditingComplete :-->>>>>>>>>>222');
                                  //     _addLocationController.predictions.clear();
                                  //   }
                                  // },
                                  onChange: (String value) {
                                    _addLocationController.searchText.value =
                                        value;
                                    if (_debounce?.isActive ?? false)
                                      _debounce?.cancel();
                                    _debounce = Timer(
                                        const Duration(milliseconds: 500), () {
                                      if (value.isEmpty) {
                                        _addLocationController.predictions
                                            .clear();
                                      } else {
                                        _addLocationController
                                            .autoCompleteSearch(value);
                                      }
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 1,
                              width: 40.w,
                              color: AppConst.lightGrey,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3.w),
                              child: Text(
                                "or",
                                style: TextStyle(
                                  color: AppConst.grey,
                                  fontFamily: 'MuseoSans',
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                  fontSize: (SizerUtil.deviceType ==
                                          DeviceType.tablet)
                                      ? 9.sp
                                      : 10.sp,
                                ),
                              ),
                            ),
                            Container(
                              height: 1,
                              width: 40.w,
                              color: AppConst.lightGrey,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: Obx((() => (_addLocationController
                                    .isGpson.value ==
                                true)
                            ? GestureDetector(
                                onTap: () async {
                                  // Get.back();
                                  _addLocationController
                                      .getCurrentLocation2()
                                      .then((value) async {
                                    if (value.latitude != 0.0 &&
                                        value.longitude != 0.0) {
                                      if (widget.page == "claimmore") {
                                        await _addLocationController
                                            .getCurrentLocation();

                                        UserViewModel.setLocation(LatLng(
                                            _addLocationController
                                                .currentPosition.latitude,
                                            _addLocationController
                                                .currentPosition.longitude));

                                        await _myWalletController
                                            .getAllWalletByCustomerByBusinessType();
                                        int? value = await _myWalletController
                                            .updateBusinesstypeWallets();

                                        // Get.back();

                                        Get.toNamed(
                                            AppRoutes.SelectBusinessType,
                                            arguments: {
                                              "signup": widget.issignup
                                            });
                                      } else {
                                        Get.toNamed(AppRoutes.NewLocationScreen,
                                            arguments: {
                                              "isFalse": false,
                                              "page": widget.page,
                                              "issignup": widget.issignup,
                                              "homeTrue": isHome,
                                              // "isHome": widget.isHomeScreen
                                            });
                                      }
                                    }
                                  });

                                  // _addLocationController
                                  //     .isFullAddressBottomSheet.value = false;
                                },
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 2.w, bottom: 1.h),
                                  child: Row(
                                    children: [
                                      Center(
                                        child: Icon(
                                          Icons.gps_fixed_rounded,
                                          color: AppConst.green,
                                          size: 2.5.h,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Text(
                                        "Use Current Location",
                                        style: TextStyle(
                                            color: AppConst.green,
                                            letterSpacing: -0.5,
                                            fontFamily: 'MuseoSans',
                                            fontStyle: FontStyle.normal,
                                            fontSize: (SizerUtil.deviceType ==
                                                    DeviceType.tablet)
                                                ? 9.sp
                                                : 10.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : InkWell(
                                onTap: (() {
                                  _addLocationController.getCurrentLocation2();
                                }),
                                child: BottomWideButton(
                                  text: "Enable Location",
                                ),
                              ))),
                      ),
                      // Container(
                      //   height: 1.5.w,
                      //   color: AppConst.veryLightGrey,
                      // ),
                      Obx(
                        () => _addLocationController.predictions.length == 0
                            ? SizedBox()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Padding(
                                  //   padding: EdgeInsets.symmetric(
                                  //       vertical: 1.h, horizontal: 3.w),
                                  //   child: Text(
                                  //     "Search your Address",
                                  //     style: TextStyle(
                                  //       fontSize:
                                  //           SizeUtils.horizontalBlockSize *
                                  //               4.2,
                                  //       fontFamily: 'MuseoSans',
                                  //       color: AppConst.black,
                                  //       fontWeight: FontWeight.w700,
                                  //       fontStyle: FontStyle.normal,
                                  //     ),
                                  //   ),
                                  // ),
                                  _addLocationController.predictions.length == 0
                                      ? Text(
                                          StringContants.searchResultsNotFound,
                                        )
                                      : ListView.builder(
                                          itemCount: _addLocationController
                                              .predictions.length,
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return Column(
                                              children: [
                                                InkWell(
                                                  highlightColor:
                                                      AppConst.highLightColor,
                                                  onTap: () async {
                                                    int valueIndex =
                                                        _addLocationController
                                                            .recentAddressDetails
                                                            .indexWhere((element) =>
                                                                element
                                                                    .placeId ==
                                                                _addLocationController
                                                                    .predictions[
                                                                        index]
                                                                    .placeId);
                                                    if (valueIndex < 0) {
                                                      try {
                                                        _addLocationController
                                                            .savePredictionsList
                                                            .clear();
                                                        _addLocationController
                                                            .savePredictionsList
                                                            .add(_addLocationController
                                                                    .predictions[
                                                                index]);
                                                        for (var element
                                                            in _addLocationController
                                                                .savePredictionsList) {
                                                          RecentAddressDetails
                                                              recentAddressDetails =
                                                              RecentAddressDetails(
                                                                  description:
                                                                      element
                                                                          .description,
                                                                  placeId: element
                                                                      .placeId);

                                                          _addLocationController
                                                              .recentAddressDetails
                                                              .add(
                                                                  recentAddressDetails);
                                                        }
                                                        AppSharedPreference
                                                            .setRecentAddress(
                                                                _addLocationController
                                                                    .recentAddressDetails);
                                                        _addLocationController
                                                            .getSaveAddress();
                                                      } catch (e, st) {
                                                        log('data : Error: $e $st');
                                                      }
                                                    }
                                                    await _addLocationController
                                                        .getLatLngFromRecentAddress(
                                                            _addLocationController
                                                                    .predictions[
                                                                        index]
                                                                    .placeId ??
                                                                '');
                                                    // widget.isHomeScreen
                                                    //     ?
                                                    if (_addLocationController.predictions[index].id == "1" ||
                                                        _addLocationController
                                                                .predictions[
                                                                    index]
                                                                .id ==
                                                            "2" ||
                                                        _addLocationController
                                                                .predictions[
                                                                    index]
                                                                .id ==
                                                            "3" ||
                                                        _addLocationController
                                                                .predictions[
                                                                    index]
                                                                .id ==
                                                            "4") {
                                                      _addLocationController
                                                          .currentSelectValue
                                                          .value = index;
                                                      _homeController.isLoading
                                                          .value = true;

                                                      _addLocationController
                                                              .currentAddress
                                                              .value =
                                                          _addLocationController
                                                              .addres[index];
                                                      _addLocationController
                                                              .userAddress
                                                              .value =
                                                          _addLocationController
                                                              .addres[index];
                                                      _addLocationController
                                                              .userAddressTitle
                                                              .value =
                                                          _addLocationController
                                                              .title[index];
                                                      _addLocationController
                                                              .userHouse.value =
                                                          _addLocationController
                                                              .house[index];
                                                      _addLocationController
                                                              .userAppartment
                                                              .value =
                                                          _addLocationController
                                                                  .appartement[
                                                              index];

                                                      _addLocationController
                                                              .latitude.value =
                                                          _addLocationController
                                                              .lat[index];

                                                      _addLocationController
                                                              .longitude.value =
                                                          _addLocationController
                                                              .long[index];
                                                      await UserViewModel.setLocation(
                                                          LatLng(
                                                              _addLocationController
                                                                  .lat[index],
                                                              _addLocationController
                                                                  .long[index]),
                                                          _addLocationController
                                                              .id[index]);
                                                      _homeController
                                                          .pageNumber = 1;
                                                      _homeController
                                                              .isPageAvailable =
                                                          true;
                                                      _homeController
                                                          .isPageLoading
                                                          .value = false;
                                                      if (widget.page ==
                                                          "claimmore") {
                                                        await _myWalletController
                                                            .getAllWalletByCustomerByBusinessType();
                                                        int? value =
                                                            await _myWalletController
                                                                .updateBusinesstypeWallets();
                                                        _addLocationController
                                                            .isRecentAddress
                                                            .value = true;
                                                      } else {
                                                        _homeController
                                                            .homePageFavoriteShopsList
                                                            .clear();
                                                        await _homeController
                                                            .getHomePageFavoriteShops();
                                                        await _homeController
                                                            .getAllCartsData();
                                                        _homeController
                                                            .getHomePageFavoriteShopsModel
                                                            .refresh();
                                                      }

                                                      widget.isHomeScreen
                                                          ? Get.offAllNamed(
                                                              AppRoutes
                                                                  .BaseScreen) // update the intialize map lat and lng
                                                          : (widget.page ==
                                                                  "claimmore")
                                                              ? Get.toNamed(
                                                                  AppRoutes
                                                                      .SelectBusinessType,
                                                                  arguments: {
                                                                      "signup":
                                                                          widget
                                                                              .issignup
                                                                    })
                                                              : Get.back();
                                                      _homeController.isLoading
                                                          .value = false;
                                                    } else {
                                                      Get.toNamed(
                                                          AppRoutes
                                                              .NewLocationScreen,
                                                          arguments: {
                                                            "isFalse": true,
                                                            "page": widget.page,
                                                            "issignup":
                                                                widget.issignup,
                                                            "homeTrue": isHome,
                                                            // "isHome": widget.isHomeScreen
                                                          })?.whenComplete(() =>
                                                          Get.back(
                                                              result: true));

                                                      _addLocationController
                                                          .isFullAddressBottomSheet
                                                          .value = false;
                                                    }
                                                    // : Get.back();
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 1.h,
                                                            horizontal: 2.w),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Icon(
                                                          _addLocationController.predictions[index].id == "1" ||
                                                                  _addLocationController
                                                                          .predictions[
                                                                              index]
                                                                          .id ==
                                                                      "2" ||
                                                                  _addLocationController
                                                                          .predictions[
                                                                              index]
                                                                          .id ==
                                                                      "3" ||
                                                                  _addLocationController
                                                                          .predictions[
                                                                              index]
                                                                          .id ==
                                                                      "4"
                                                              ? Icons.home
                                                              : Icons
                                                                  .location_on,
                                                          color: Colors
                                                              .grey.shade400,
                                                          size: 3.3.h,
                                                        ),
                                                        SizedBox(
                                                          width: 2.w,
                                                        ),
                                                        Flexible(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                _addLocationController
                                                                            .predictions[
                                                                                index]
                                                                            .id ==
                                                                        "1"
                                                                    ? 'Home'
                                                                    : _addLocationController.predictions[index].id ==
                                                                            "2"
                                                                        ? "Work"
                                                                        : _addLocationController.predictions[index].id ==
                                                                                "3"
                                                                            ? "Hotel"
                                                                            : _addLocationController.predictions[index].id == "4"
                                                                                ? _addLocationController.predictions[index].reference!
                                                                                : _addLocationController.predictions[index].description!.split(' ').take(3).join(' '),
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'MuseoSans',
                                                                  color: AppConst
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .normal,
                                                                  fontSize: (SizerUtil
                                                                              .deviceType ==
                                                                          DeviceType
                                                                              .tablet)
                                                                      ? 9.sp
                                                                      : 10.5.sp,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 0.5.h,
                                                              ),
                                                              Text(
                                                                _addLocationController
                                                                        .predictions[
                                                                            index]
                                                                        .description ??
                                                                    "",
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 2,
                                                                style: TextStyle(
                                                                    fontSize: (SizerUtil
                                                                                .deviceType ==
                                                                            DeviceType
                                                                                .tablet)
                                                                        ? 8.5.sp
                                                                        : 10.sp,
                                                                    fontFamily:
                                                                        'MuseoSans',
                                                                    color: Colors
                                                                        .grey
                                                                        .shade600,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .normal),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                ],
                              ),
                      ),
                      Obx(
                        () => _addLocationController.predictions.length == 0
                            ? Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0.w, vertical: 1.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    widget.isSavedAddress
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              (_addLocationController
                                                          .userModel
                                                          ?.addresses
                                                          ?.isNotEmpty ??
                                                      false)
                                                  ? Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 1.h),
                                                      child: Container(
                                                        height: 1.h,
                                                        color: AppConst
                                                            .veryLightGrey,
                                                      ),
                                                    )
                                                  : SizedBox(),
                                              (_addLocationController
                                                          .userModel
                                                          ?.addresses
                                                          ?.isNotEmpty ??
                                                      false)
                                                  ? Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 1.h,
                                                              horizontal: 3.w),
                                                      child: Text(
                                                        "Saved Addresses",
                                                        style: TextStyle(
                                                          color: AppConst.black,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontSize: (SizerUtil
                                                                      .deviceType ==
                                                                  DeviceType
                                                                      .tablet)
                                                              ? 10.5.sp
                                                              : 12.5.sp,
                                                          fontFamily:
                                                              'MuseoSans',
                                                        ),
                                                      ),
                                                    )
                                                  : SizedBox(),
                                              (_addLocationController
                                                          .userModel
                                                          ?.addresses
                                                          ?.isNotEmpty ??
                                                      false)
                                                  ? Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 2.w),
                                                      child: ListView.separated(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        shrinkWrap: true,
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        itemCount:
                                                            _addLocationController
                                                                    .userModel
                                                                    ?.addresses
                                                                    ?.length ??
                                                                0,

                                                        //  _addLocationController
                                                        //         .isSeeMoreEnable.value
                                                        //     ? _addLocationController
                                                        //             .userModel
                                                        //             ?.addresses
                                                        //             ?.length ??
                                                        //         0
                                                        //     : (_addLocationController
                                                        //                     .userModel
                                                        //                     ?.addresses
                                                        //                     ?.length ??
                                                        //                 0) <
                                                        //             3
                                                        //         ? _addLocationController
                                                        //                 .userModel
                                                        //                 ?.addresses
                                                        //                 ?.length ??
                                                        //             0
                                                        //         : 3,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return
                                                              // Obx(
                                                              //   () =>
                                                              InkWell(
                                                            highlightColor: AppConst
                                                                .highLightColor,
                                                            onTap: () async {
                                                              _addLocationController
                                                                  .currentSelectValue
                                                                  .value = index;
                                                              _homeController
                                                                  .isLoading
                                                                  .value = true;

                                                              _addLocationController
                                                                  .currentAddress
                                                                  .value = _addLocationController
                                                                      .userModel
                                                                      ?.addresses?[
                                                                          index]
                                                                      .address ??
                                                                  '';
                                                              _addLocationController
                                                                  .userAddress
                                                                  .value = _addLocationController
                                                                      .userModel
                                                                      ?.addresses?[
                                                                          index]
                                                                      .address ??
                                                                  '';
                                                              _addLocationController
                                                                  .userAddressTitle
                                                                  .value = _addLocationController
                                                                      .userModel
                                                                      ?.addresses?[
                                                                          index]
                                                                      .title ??
                                                                  '';
                                                              _addLocationController
                                                                  .userHouse
                                                                  .value = _addLocationController
                                                                      .userModel
                                                                      ?.addresses?[
                                                                          index]
                                                                      .house ??
                                                                  '';
                                                              _addLocationController
                                                                  .userAppartment
                                                                  .value = _addLocationController
                                                                      .userModel
                                                                      ?.addresses?[
                                                                          index]
                                                                      .apartment ??
                                                                  '';

                                                              _addLocationController
                                                                  .latitude
                                                                  .value = _addLocationController
                                                                      .userModel
                                                                      ?.addresses?[
                                                                          index]
                                                                      .location
                                                                      ?.lat ??
                                                                  0.0;

                                                              _addLocationController
                                                                  .longitude
                                                                  .value = _addLocationController
                                                                      .userModel
                                                                      ?.addresses?[
                                                                          index]
                                                                      .location
                                                                      ?.lng ??
                                                                  0.0;
                                                              await UserViewModel.setLocation(
                                                                  LatLng(
                                                                      _addLocationController
                                                                              .userModel
                                                                              ?.addresses?[
                                                                                  index]
                                                                              .location
                                                                              ?.lat ??
                                                                          0.0,
                                                                      _addLocationController
                                                                              .userModel
                                                                              ?.addresses?[
                                                                                  index]
                                                                              .location
                                                                              ?.lng ??
                                                                          0.0),
                                                                  _addLocationController
                                                                      .userModel
                                                                      ?.addresses?[
                                                                          index]
                                                                      .id);
                                                              _homeController
                                                                  .pageNumber = 1;
                                                              _homeController
                                                                      .isPageAvailable =
                                                                  true;
                                                              _homeController
                                                                  .isPageLoading
                                                                  .value = false;
                                                              if (widget.page ==
                                                                  "claimmore") {
                                                                await _myWalletController
                                                                    .getAllWalletByCustomerByBusinessType();
                                                                int? value =
                                                                    await _myWalletController
                                                                        .updateBusinesstypeWallets();
                                                                _addLocationController
                                                                    .isRecentAddress
                                                                    .value = true;
                                                              } else {
                                                                _homeController
                                                                    .homePageFavoriteShopsList
                                                                    .clear();
                                                                await _homeController
                                                                    .getHomePageFavoriteShops();
                                                                await _homeController
                                                                    .getAllCartsData();
                                                                _homeController
                                                                    .getHomePageFavoriteShopsModel
                                                                    .refresh();
                                                              }

                                                              widget
                                                                      .isHomeScreen
                                                                  ? Get.offAllNamed(
                                                                      AppRoutes
                                                                          .BaseScreen) // update the intialize map lat and lng
                                                                  : (widget.page ==
                                                                          "claimmore")
                                                                      ? Get.toNamed(
                                                                          AppRoutes
                                                                              .SelectBusinessType,
                                                                          arguments: {
                                                                              "signup": widget.issignup
                                                                            })
                                                                      : Get
                                                                          .back();
                                                              _homeController
                                                                      .isLoading
                                                                      .value =
                                                                  false;
                                                            },
                                                            child: Column(
                                                              children: [
                                                                ListTile(
                                                                    contentPadding:
                                                                        EdgeInsets.symmetric(
                                                                            vertical: 1
                                                                                .h),
                                                                    leading:
                                                                        Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left: 3
                                                                              .w,
                                                                          bottom:
                                                                              2.h),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .home,
                                                                        size: 3.3
                                                                            .h,
                                                                        color: Colors
                                                                            .grey
                                                                            .shade400,
                                                                      ),
                                                                    ),
                                                                    //  Column(
                                                                    //   mainAxisAlignment:
                                                                    //       MainAxisAlignment
                                                                    //           .center,
                                                                    //   children: [
                                                                    //     Icon(
                                                                    //       Icons.home,
                                                                    //       size: 3.h,
                                                                    //       color:
                                                                    //           AppConst
                                                                    //               .grey,
                                                                    //     )
                                                                    //     // IgnorePointer(
                                                                    //     //   child:
                                                                    //     //       Radio(
                                                                    //     //     value:
                                                                    //     //         true,
                                                                    //     //     groupValue: _addLocationController
                                                                    //     //             .currentSelectValue
                                                                    //     //             .value ==
                                                                    //     //         index,
                                                                    //     //     onChanged:
                                                                    //     //         (value) {},
                                                                    //     //   ),
                                                                    //     // ),
                                                                    //   ],
                                                                    // ),
                                                                    title:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          _addLocationController.userModel?.addresses?[index].title ??
                                                                              '',
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                'MuseoSans',
                                                                            color:
                                                                                AppConst.black,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                FontStyle.normal,
                                                                            fontSize: (SizerUtil.deviceType == DeviceType.tablet)
                                                                                ? 9.sp
                                                                                : 10.5.sp,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                            "${_addLocationController.userModel?.addresses?[index].house ?? ''},${_addLocationController.userModel?.addresses?[index].apartment ?? ''} ${_addLocationController.userModel?.addresses?[index].address ?? ''}",
                                                                            maxLines:
                                                                                2,
                                                                            overflow: TextOverflow
                                                                                .ellipsis,
                                                                            style: TextStyle(
                                                                                fontSize: (SizerUtil.deviceType == DeviceType.tablet) ? 8.5.sp : 10.sp,
                                                                                fontFamily: 'MuseoSans',
                                                                                color: Colors.grey.shade600,
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: FontStyle.normal)),
                                                                        // widget.editOrDelete
                                                                        //     ? Padding(
                                                                        //         padding:
                                                                        //             EdgeInsets.symmetric(vertical: 1.h),
                                                                        //         child:
                                                                        //             Row(
                                                                        //           mainAxisAlignment:
                                                                        //               MainAxisAlignment.start,
                                                                        //           children: [
                                                                        //             InkWell(
                                                                        //               onTap: (() {
                                                                        //                 _addLocationController.latitude.value = _addLocationController.userModel?.addresses?[index].location?.lat ?? 0.0;
                                                                        //                 _addLocationController.longitude.value = _addLocationController.userModel?.addresses?[index].location?.lng ?? 0.0;

                                                                        //                 Get.toNamed(AppRoutes.NewLocationScreen, arguments: {
                                                                        //                   "isFalse": true,
                                                                        //                   // "isEdit": true
                                                                        //                 });

                                                                        //                 // _addLocationController.isFullAddressBottomSheet.value = true;
                                                                        //               }),
                                                                        //               child: Text(
                                                                        //                 'Edit',
                                                                        //                 style: TextStyle(fontFamily: 'MuseoSans', color: AppConst.darkGreen, fontWeight: FontWeight.w700, fontStyle: FontStyle.normal, fontSize: SizeUtils.horizontalBlockSize * 3.5),
                                                                        //               ),
                                                                        //             ),
                                                                        //             SizedBox(
                                                                        //               width: 20.w,
                                                                        //             ),
                                                                        //             if ((_addLocationController.userModel?.addresses?.length ?? 0) > 1 &&
                                                                        //                 _addLocationController.userAddress.value != _addLocationController.userModel?.addresses?[index].address)
                                                                        //               InkWell(
                                                                        //                 onTap: (() async {
                                                                        //                   await _addLocationController.deleteCustomerAddress(_addLocationController.userModel?.addresses?[index].id ?? '');

                                                                        //                   _addLocationController.userModel?.addresses?.remove(_addLocationController.userModel?.addresses?[index]);
                                                                        //                   UserViewModel.setUser(_addLocationController.userModel!);
                                                                        //                   setState(() {});
                                                                        //                 }),
                                                                        //                 child: Text(
                                                                        //                   'Delete',
                                                                        //                   style: TextStyle(fontFamily: 'MuseoSans', color: AppConst.darkGreen, fontWeight: FontWeight.w700, fontStyle: FontStyle.normal, fontSize: SizeUtils.horizontalBlockSize * 3.5),
                                                                        //                 ),
                                                                        //               ),
                                                                        //           ],
                                                                        //         ),
                                                                        //       )
                                                                        //     : SizedBox()
                                                                      ],
                                                                    ),
                                                                    trailing: widget
                                                                            .editOrDelete
                                                                        ? PopupMenuButton(
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.only(
                                                                                bottomLeft: Radius.circular(8.0),
                                                                                bottomRight: Radius.circular(8.0),
                                                                                topLeft: Radius.circular(8.0),
                                                                                topRight: Radius.circular(8.0),
                                                                              ),
                                                                            ),
                                                                            itemBuilder:
                                                                                (ctx) {
                                                                              return [
                                                                                _buildPopupMenuItem(
                                                                                  'Edit',
                                                                                  Icons.edit,
                                                                                  () async {
                                                                                    _addLocationController.latitude.value = _addLocationController.userModel?.addresses?[index].location?.lat ?? 0.0;
                                                                                    _addLocationController.longitude.value = _addLocationController.userModel?.addresses?[index].location?.lng ?? 0.0;
                                                                                    _addLocationController.isRecentAddress.value = true;

                                                                                    await Future.delayed(Duration(milliseconds: 200));
                                                                                    Get.toNamed(AppRoutes.EditAddressScreen, arguments: {
                                                                                      'addresses': _addLocationController.userModel?.addresses?[index],
                                                                                      'isHomeSelected': isHome
                                                                                    })!
                                                                                        .whenComplete(() => setState(() {}));
                                                                                  },
                                                                                ),
                                                                                if ((_addLocationController.userModel?.addresses?.length ?? 0) > 1 && _addLocationController.userAddress.value != _addLocationController.userModel?.addresses?[index].address)
                                                                                  _buildPopupMenuItem('Delete', Icons.delete, () async {
                                                                                    await _addLocationController.deleteCustomerAddress(_addLocationController.userModel?.addresses?[index].id ?? '');

                                                                                    _addLocationController.userModel?.addresses?.remove(_addLocationController.userModel?.addresses?[index]);
                                                                                    UserViewModel.setUser(_addLocationController.userModel!);
                                                                                    setState(() {});
                                                                                  }),
                                                                              ];
                                                                            },
                                                                          )
                                                                        : null),
                                                                // if (_addLocationController
                                                                //         .currentSelectValue
                                                                //         .value ==
                                                                //     index)
                                                                //   GestureDetector(
                                                                //       onTap:
                                                                //           () async {
                                                                //         _homeController
                                                                //             .isLoading
                                                                //             .value = true;
                                                                //         Get.back();

                                                                //         _homeController
                                                                //             .userAddress
                                                                //             .value = _addLocationController
                                                                //                 .userModel
                                                                //                 ?.addresses?[index]
                                                                //                 .address ??
                                                                //             '';
                                                                //         _homeController
                                                                //             .userAddressTitle
                                                                //             .value = _addLocationController
                                                                //                 .userModel
                                                                //                 ?.addresses?[index]
                                                                //                 .title ??
                                                                //             '';
                                                                //         await UserViewModel.setLocation(
                                                                //             LatLng(
                                                                //                 _addLocationController.userModel?.addresses?[index].location?.lat ??
                                                                //                     0.0,
                                                                //                 _addLocationController.userModel?.addresses?[index].location?.lng ??
                                                                //                     0.0),
                                                                //             _addLocationController
                                                                //                 .userModel
                                                                //                 ?.addresses?[index]
                                                                //                 .id);
                                                                //         _homeController
                                                                //             .pageNumber = 1;
                                                                //         _homeController
                                                                //                 .isPageAvailable =
                                                                //             true;
                                                                //         _homeController
                                                                //             .isPageLoading
                                                                //             .value = false;
                                                                //         _homeController
                                                                //             .homePageFavoriteShopsList
                                                                //             .clear();
                                                                //         await _homeController
                                                                //             .getHomePageFavoriteShops();
                                                                //         await _homeController
                                                                //             .getAllCartsData();
                                                                //         _homeController
                                                                //             .getHomePageFavoriteShopsModel
                                                                //             .refresh();
                                                                //         _homeController
                                                                //             .isLoading
                                                                //             .value = false;
                                                                //       },
                                                                //       child:
                                                                //           BottomWideButton())
                                                                // else
                                                                //   SizedBox(),
                                                              ],
                                                              // ),
                                                            ),
                                                          );
                                                        },
                                                        separatorBuilder:
                                                            (context, index) {
                                                          return Divider(
                                                              height: 0);
                                                        },
                                                      ),
                                                    )
                                                  : Center(
                                                      child: Text(
                                                        '',
                                                      ),
                                                    ),
                                              // if ((_addLocationController.userModel
                                              //             ?.addresses?.length ??
                                              //         0) >
                                              //     3)
                                              //   OutlinedButton(
                                              //     style: OutlinedButton.styleFrom(
                                              //       tapTargetSize:
                                              //           MaterialTapTargetSize
                                              //               .padded,
                                              //     ),
                                              //     onPressed: () {
                                              //       _addLocationController
                                              //               .isSeeMoreEnable.value =
                                              //           !_addLocationController
                                              //               .isSeeMoreEnable.value;
                                              //     },
                                              //     child: _addLocationController
                                              //             .isSeeMoreEnable.value
                                              //         ? Row(
                                              //             mainAxisAlignment:
                                              //                 MainAxisAlignment
                                              //                     .center,
                                              //             children: [
                                              //               Text(
                                              //                 StringContants
                                              //                     .seeLess,
                                              //                 style: TextStyle(
                                              //                   color:
                                              //                       AppConst.black,
                                              //                   fontSize: SizeUtils
                                              //                           .horizontalBlockSize *
                                              //                       4,
                                              //                 ),
                                              //               ),
                                              //               Icon(
                                              //                 Icons
                                              //                     .keyboard_arrow_up,
                                              //                 color: AppConst.black,
                                              //                 size: SizeUtils
                                              //                         .horizontalBlockSize *
                                              //                     6,
                                              //               )
                                              //             ],
                                              //           )
                                              //         : Row(
                                              //             mainAxisAlignment:
                                              //                 MainAxisAlignment
                                              //                     .center,
                                              //             children: [
                                              //               Text(
                                              //                 StringContants
                                              //                     .seeMore,
                                              //                 style: TextStyle(
                                              //                   color:
                                              //                       AppConst.black,
                                              //                   fontSize: SizeUtils
                                              //                           .horizontalBlockSize *
                                              //                       4,
                                              //                 ),
                                              //               ),
                                              //               Icon(
                                              //                 Icons
                                              //                     .keyboard_arrow_down_rounded,
                                              //                 color: AppConst.black,
                                              //                 size: SizeUtils
                                              //                         .horizontalBlockSize *
                                              //                     6,
                                              //               )
                                              //             ],
                                              //           ),
                                              //   ),
                                            ],
                                          )
                                        : SizedBox(),
                                    (widget.page == "review" ||
                                            widget.page == "explore" ||
                                            widget.page == "scan" ||
                                            widget.page == "redeem" ||
                                            widget.editOrDelete == true)
                                        ? SizedBox()
                                        : widget.isRecentAddress
                                            ? Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 1.h),
                                                child: Container(
                                                  height: 1.h,
                                                  color: AppConst.veryLightGrey,
                                                ),
                                              )
                                            : SizedBox(),
                                    (widget.page == "review" ||
                                            widget.page == "explore" ||
                                            widget.page == "scan" ||
                                            widget.page == "redeem" ||
                                            widget.editOrDelete == true)
                                        ? SizedBox()
                                        : widget.isRecentAddress
                                            ? Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 1.h,
                                                    horizontal: 3.w),
                                                child: Text(
                                                  "Recent Searches",
                                                  style: TextStyle(
                                                    color: AppConst.black,
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: (SizerUtil
                                                                .deviceType ==
                                                            DeviceType.tablet)
                                                        ? 10.5.sp
                                                        : 12.5.sp,
                                                    fontFamily: 'MuseoSans',
                                                  ),
                                                ),
                                              )
                                            : SizedBox(),
                                    (widget.page == "review" ||
                                            widget.page == "explore" ||
                                            widget.page == "scan" ||
                                            widget.page == "redeem" ||
                                            widget.editOrDelete == true)
                                        ? SizedBox()
                                        : widget.isRecentAddress
                                            ? Obx(
                                                () => Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 2.w),
                                                  child: ListView.separated(
                                                    padding: EdgeInsets.zero,
                                                    shrinkWrap: true,
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    itemBuilder:
                                                        (context, index) {
                                                      // int idx = _addLocationController
                                                      //     .recentAddressDetails[index]
                                                      //     .description!
                                                      //     .indexOf(" ");
                                                      // List parts = [
                                                      //   _addLocationController
                                                      //       .recentAddressDetails[index]
                                                      //       .description
                                                      //       ?.substring(0, idx)
                                                      //       .trim(),
                                                      //   _addLocationController
                                                      //       .recentAddressDetails[index]
                                                      //       .description
                                                      //       ?.substring(idx + 1)
                                                      //       .trim()
                                                      // ];
                                                      return InkWell(
                                                        highlightColor: AppConst
                                                            .highLightColor,
                                                        onTap: () async {
                                                          // _addLocationController.getDetails(_addLocationController.recentAddressDetails[index].placeId ?? '');
                                                          await _addLocationController
                                                              .getLatLngFromRecentAddress(
                                                                  _addLocationController
                                                                          .recentAddressDetails[
                                                                              index]
                                                                          .placeId ??
                                                                      '');

                                                          widget.isHomeScreen
                                                              ? Get.toNamed(
                                                                      AppRoutes
                                                                          .NewLocationScreen)
                                                                  ?.whenComplete(
                                                                      () => Get.back(
                                                                          result:
                                                                              true))
                                                              : Get.back();

                                                          _addLocationController
                                                              .isFullAddressBottomSheet
                                                              .value = false;
                                                        },
                                                        child: ListTile(
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          1.h),
                                                          leading: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 3.w,
                                                                    bottom:
                                                                        2.h),
                                                            child: Icon(
                                                              Icons
                                                                  .access_time_filled_outlined,
                                                              size: 3.3.h,
                                                              color: Colors.grey
                                                                  .shade400,
                                                            ),
                                                          ),
                                                          title: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                // parts[0],
                                                                _addLocationController.SortByCharactor(
                                                                    _addLocationController
                                                                            .recentAddressDetails[index]
                                                                            .description ??
                                                                        "",
                                                                    " "),
                                                                maxLines: 1,

                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'MuseoSans',
                                                                  color: AppConst
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .normal,
                                                                  fontSize: (SizerUtil
                                                                              .deviceType ==
                                                                          DeviceType
                                                                              .tablet)
                                                                      ? 9.sp
                                                                      : 10.5.sp,
                                                                ),
                                                              ),
                                                              Text(
                                                                _addLocationController
                                                                        .recentAddressDetails[
                                                                            index]
                                                                        .description ??
                                                                    "",
                                                                maxLines: 2,
                                                                style: TextStyle(
                                                                    fontSize: (SizerUtil
                                                                                .deviceType ==
                                                                            DeviceType
                                                                                .tablet)
                                                                        ? 8.5.sp
                                                                        : 10.sp,
                                                                    fontFamily:
                                                                        'MuseoSans',
                                                                    color: Colors
                                                                        .grey
                                                                        .shade600,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .normal),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    separatorBuilder:
                                                        (context, index) {
                                                      return SizedBox();
                                                    },
                                                    itemCount:
                                                        _addLocationController
                                                            .recentAddressDetails
                                                            .length,
                                                  ),
                                                ),
                                              )
                                            : SizedBox(),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox(),
                      )
                    ],
                  ),
                ],
              ),
            ),
            // ),
          );
  }

  PopupMenuItem _buildPopupMenuItem(
      String title, IconData iconData, VoidCallback? onTap) {
    final _key = new GlobalKey<FormState>();
    return PopupMenuItem(
      key: _key,
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            iconData,
            color: Colors.grey,
            size: 3.h,
          ),
          Text(
            title,
            style: TextStyle(
                fontFamily: 'MuseoSans',
                color: AppConst.black,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
                fontSize: SizeUtils.horizontalBlockSize * 3.5),
          ),
        ],
      ),
    );
  }
}

class GpsContainer extends StatelessWidget {
  const GpsContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 1.h),
      height: 6.h,
      decoration: BoxDecoration(
        // shape: BoxShape.circle,
        color: AppConst.white,
        borderRadius: BorderRadius.circular(12),

        boxShadow: [
          BoxShadow(
            color: AppConst.grey,
            blurRadius: 3,
            offset: Offset(1, 1),
          ),
        ],
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child: Icon(
            Icons.gps_fixed_rounded,
            color: AppConst.darkGreen,
            size: SizeUtils.horizontalBlockSize * 6.5,
          ),
        ),
        SizedBox(
          width: 2.w,
        ),
        Text(
          "Use current location",
          style: TextStyle(
              color: AppConst.black,
              fontSize: SizeUtils.horizontalBlockSize * 4,
              fontWeight: FontWeight.w500),
        ),
      ]),
    );
  }
}

class RecentAddressDetails {
  String? description;
  String? placeId;

  RecentAddressDetails({this.description, this.placeId});

  RecentAddressDetails.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    placeId = json['placeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['placeId'] = this.placeId;
    return data;
  }
}

enum Options { search, upload, copy, exit }
