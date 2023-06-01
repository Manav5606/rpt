import 'dart:async';
import 'dart:developer';

import 'package:customer_app/app/controller/my_wallet_controller.dart';
import 'package:customer_app/app/data/repository/hive_repository.dart';
import 'package:customer_app/app/ui/pages/signIn/phone_authentication_screen.dart';
import 'package:customer_app/app/ui/pages/signIn/signup_screen.dart';
import 'package:customer_app/screens/authentication/repository/maprepo.dart';
import 'package:customer_app/screens/root/root.dart';
import 'package:flutter/cupertino.dart';
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

class AddressModel extends StatefulWidget {
  final bool isHomeScreen;
  final bool isSavedAddress;
  final String? page;
  final bool editOrDelete;

  AddressModel(
      {Key? key,
      this.isHomeScreen = false,
      this.isSavedAddress = true,
      this.editOrDelete = false,
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

  @override
  void initState() {
    // TODO: implement initState

    // HomeController().getCurrentLocation();b
    super.initState();
    // final AddLocationController _addLocationController =
    //     Get.put(AddLocationController());
    // final HomeController _homeController = Get.put(HomeController());
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final AddLocationController _addLocationController =
    //     Get.put(AddLocationController());
    final AddLocationController _addLocationController = Get.find()
      ..getUserData();

    // final HomeController _homeController = Get.lazyPut(HomeController());
    //  final islocationPermission = HomeController().getCurrentLocation();
    _addLocationController.isRecentAddress.value = widget.isHomeScreen;
    return Scaffold(
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
              (widget.editOrDelete == true) ? "My Addresses" : "Choose address",
              style: TextStyle(
                color: AppConst.black,
                fontFamily: 'MuseoSans',
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
                fontSize: SizeUtils.horizontalBlockSize * 4.5,
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 1.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(
                    () => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: SearchField(
                        controller: _addLocationController.searchController,
                        focusNode: focusNode,
                        suffixIcon: (_addLocationController.searchText.value !=
                                    null &&
                                _addLocationController.searchText.value != "")
                            ? GestureDetector(
                                onTap: () {
                                  _addLocationController.searchController
                                      .clear();
                                  _addLocationController.predictions.clear();
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
                        prefixIcon: (_addLocationController.searchText.value !=
                                    null &&
                                _addLocationController.searchText.value != "")
                            ? null
                            : GestureDetector(
                                onTap: () {
                                  _addLocationController.searchController
                                      .clear();
                                  _addLocationController.predictions.clear();
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
                          _addLocationController.searchText.value = value;
                          if (_debounce?.isActive ?? false) _debounce?.cancel();
                          _debounce =
                              Timer(const Duration(milliseconds: 500), () {
                            if (value.isEmpty) {
                              _addLocationController.predictions.clear();
                            } else {
                              _addLocationController.autoCompleteSearch(value);
                            }
                          });
                        },
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
                              fontSize: SizeUtils.horizontalBlockSize * 4,
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
                    child: Obx((() => (_addLocationController.isGpson.value ==
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
                                    );
                                  } else {
                                    Get.toNamed(AppRoutes.NewLocationScreen,
                                        arguments: {
                                          "isFalse": false,
                                          "page": widget.page,
                                          // "isHome": widget.isHomeScreen
                                        });
                                  }
                                }
                              });

                              _addLocationController
                                  .isFullAddressBottomSheet.value = false;
                            },
                            child: Padding(
                              padding: EdgeInsets.only(left: 2.w, bottom: 1.h),
                              child: Row(
                                children: [
                                  Center(
                                    child: Icon(
                                      Icons.gps_fixed_rounded,
                                      color: AppConst.green,
                                      size: SizeUtils.horizontalBlockSize * 6,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Text(
                                    "Use current location",
                                    style: TextStyle(
                                        color: AppConst.green,
                                        fontFamily: 'MuseoSans',
                                        fontStyle: FontStyle.normal,
                                        fontSize:
                                            SizeUtils.horizontalBlockSize * 3.8,
                                        fontWeight: FontWeight.w500),
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
                  Container(
                    height: 1.5.w,
                    color: AppConst.veryLightGrey,
                  ),
                  Obx(
                    () => _addLocationController.predictions.length == 0
                        ? SizedBox()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 1.h, horizontal: 3.w),
                                child: Text(
                                  "Search your Address",
                                  style: TextStyle(
                                    fontSize:
                                        SizeUtils.horizontalBlockSize * 4.2,
                                    fontFamily: 'MuseoSans',
                                    color: AppConst.black,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ),
                              _addLocationController.predictions.length == 0
                                  ? Text(
                                      StringContants.searchResultsNotFound,
                                    )
                                  : ListView.builder(
                                      itemCount: _addLocationController
                                          .predictions.length,
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
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
                                                            element.placeId ==
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
                                                              description: element
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

                                                Get.toNamed(
                                                    AppRoutes.NewLocationScreen,
                                                    arguments: {
                                                      "isFalse": true,
                                                      "page": widget.page
                                                      // "isHome": widget.isHomeScreen
                                                    })?.whenComplete(() =>
                                                    Get.back(result: true));

                                                _addLocationController
                                                    .isFullAddressBottomSheet
                                                    .value = false;
                                                // : Get.back();
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 1.h,
                                                    horizontal: 2.w),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.location_on,
                                                      color: AppConst.grey,
                                                      size: 3.h,
                                                    ),
                                                    SizedBox(
                                                      width: 2.w,
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        _addLocationController
                                                                .predictions[
                                                                    index]
                                                                .description ??
                                                            "",
                                                        style: TextStyle(
                                                            fontSize: SizeUtils
                                                                    .horizontalBlockSize *
                                                                3.8,
                                                            fontFamily:
                                                                'MuseoSans',
                                                            color:
                                                                AppConst.grey,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontStyle: FontStyle
                                                                .normal),
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
                                horizontal: 3.w, vertical: 1.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                widget.isSavedAddress
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          (_addLocationController.userModel
                                                      ?.addresses?.isNotEmpty ??
                                                  false)
                                              ? Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 1.h),
                                                  child: Text(
                                                    "Saved Addresses",
                                                    style: TextStyle(
                                                      fontSize: SizeUtils
                                                              .horizontalBlockSize *
                                                          4.2,
                                                      fontFamily: 'MuseoSans',
                                                      color: AppConst.black,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                    ),
                                                  ),
                                                )
                                              : SizedBox(),
                                          (_addLocationController.userModel
                                                      ?.addresses?.isNotEmpty ??
                                                  false)
                                              ? ListView.separated(
                                                  padding: EdgeInsets.zero,
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
                                                                .value =
                                                            _addLocationController
                                                                    .userModel
                                                                    ?.addresses?[
                                                                        index]
                                                                    .address ??
                                                                '';
                                                        _addLocationController
                                                                .userAddress
                                                                .value =
                                                            _addLocationController
                                                                    .userModel
                                                                    ?.addresses?[
                                                                        index]
                                                                    .address ??
                                                                '';
                                                        _addLocationController
                                                                .userAddressTitle
                                                                .value =
                                                            _addLocationController
                                                                    .userModel
                                                                    ?.addresses?[
                                                                        index]
                                                                    .title ??
                                                                '';
                                                        _addLocationController
                                                                .userHouse
                                                                .value =
                                                            _addLocationController
                                                                    .userModel
                                                                    ?.addresses?[
                                                                        index]
                                                                    .house ??
                                                                '';
                                                        _addLocationController
                                                                .userAppartment
                                                                .value =
                                                            _addLocationController
                                                                    .userModel
                                                                    ?.addresses?[
                                                                        index]
                                                                    .apartment ??
                                                                '';

                                                        _addLocationController
                                                                .latitude
                                                                .value =
                                                            _addLocationController
                                                                    .userModel
                                                                    ?.addresses?[
                                                                        index]
                                                                    .location
                                                                    ?.lat ??
                                                                0.0;

                                                        _addLocationController
                                                                .longitude
                                                                .value =
                                                            _addLocationController
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
                                                            : Get.back();
                                                        _homeController
                                                            .isLoading
                                                            .value = false;
                                                      },
                                                      child: Column(
                                                        children: [
                                                          ListTile(
                                                              contentPadding:
                                                                  EdgeInsets.symmetric(
                                                                      vertical:
                                                                          1.h),
                                                              leading: Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        bottom:
                                                                            2.h,
                                                                        left: 3
                                                                            .w),
                                                                child: Icon(
                                                                  Icons.home,
                                                                  size: 3.h,
                                                                  color:
                                                                      AppConst
                                                                          .grey,
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
                                                              title: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    _addLocationController
                                                                            .userModel
                                                                            ?.addresses?[index]
                                                                            .title ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'MuseoSans',
                                                                        color: AppConst
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontStyle:
                                                                            FontStyle
                                                                                .normal,
                                                                        fontSize:
                                                                            SizeUtils.horizontalBlockSize *
                                                                                4),
                                                                  ),
                                                                  Text(
                                                                    "${_addLocationController.userModel?.addresses?[index].house ?? ''},${_addLocationController.userModel?.addresses?[index].apartment ?? ''} ${_addLocationController.userModel?.addresses?[index].address ?? ''}",
                                                                    maxLines: 2,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'MuseoSans',
                                                                        color: AppConst
                                                                            .grey,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontStyle:
                                                                            FontStyle
                                                                                .normal,
                                                                        fontSize:
                                                                            SizeUtils.horizontalBlockSize *
                                                                                3.5),
                                                                  ),
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
                                                                        borderRadius:
                                                                            BorderRadius.only(
                                                                          bottomLeft:
                                                                              Radius.circular(8.0),
                                                                          bottomRight:
                                                                              Radius.circular(8.0),
                                                                          topLeft:
                                                                              Radius.circular(8.0),
                                                                          topRight:
                                                                              Radius.circular(8.0),
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
                                                                                'addresses': _addLocationController.userModel?.addresses?[index]
                                                                              })?.whenComplete(() => setState(() {}));
                                                                            },
                                                                          ),
                                                                          if ((_addLocationController.userModel?.addresses?.length ?? 0) > 1 &&
                                                                              _addLocationController.userAddress.value != _addLocationController.userModel?.addresses?[index].address)
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
                                                    return Divider(height: 0);
                                                  },
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
                                    : Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 1.h),
                                        child: Text(
                                          "Recent Searches",
                                          style: TextStyle(
                                            fontSize:
                                                SizeUtils.horizontalBlockSize *
                                                    4.2,
                                            fontFamily: 'MuseoSans',
                                            color: AppConst.black,
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.normal,
                                          ),
                                        ),
                                      ),
                                (widget.page == "review" ||
                                        widget.page == "explore" ||
                                        widget.page == "scan" ||
                                        widget.page == "redeem" ||
                                        widget.editOrDelete == true)
                                    ? SizedBox()
                                    : Obx(
                                        () => ListView.separated(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
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
                                              highlightColor:
                                                  AppConst.highLightColor,
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
                                                    ? Get.toNamed(AppRoutes
                                                            .NewLocationScreen)
                                                        ?.whenComplete(() =>
                                                            Get.back(
                                                                result: true))
                                                    : Get.back();

                                                _addLocationController
                                                    .isFullAddressBottomSheet
                                                    .value = false;
                                              },
                                              child: ListTile(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 1.h),
                                                leading: Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 1.h, left: 3.w),
                                                  child: Icon(
                                                    Icons.access_time_rounded,
                                                    size: 3.h,
                                                    color: AppConst.grey,
                                                  ),
                                                ),
                                                title: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      // parts[0],
                                                      _addLocationController
                                                          .SortByCharactor(
                                                              _addLocationController
                                                                      .recentAddressDetails[
                                                                          index]
                                                                      .description ??
                                                                  "",
                                                              " "),
                                                      maxLines: 1,

                                                      style: TextStyle(
                                                          fontFamily:
                                                              'MuseoSans',
                                                          color: AppConst.black,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontSize: SizeUtils
                                                                  .horizontalBlockSize *
                                                              4),
                                                    ),
                                                    Text(
                                                      _addLocationController
                                                              .recentAddressDetails[
                                                                  index]
                                                              .description ??
                                                          "",
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'MuseoSans',
                                                          color: AppConst.grey,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontSize: SizeUtils
                                                                  .horizontalBlockSize *
                                                              3.5),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                          separatorBuilder: (context, index) {
                                            return SizedBox();
                                          },
                                          itemCount: _addLocationController
                                              .recentAddressDetails.length,
                                        ),
                                      ),
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

class SelectLocationAddress extends StatefulWidget {
  SelectLocationAddress({
    Key? key,
  }) : super(key: key);

  @override
  State<SelectLocationAddress> createState() => _SelectLocationAddressState();
}

class _SelectLocationAddressState extends State<SelectLocationAddress> {
  bool locationListAvilable = false;

  final AddLocationController _addLocationController =
      Get.put(AddLocationController());

  final HomeController _homeController = Get.put(HomeController());
  final HiveRepository hiveRepository = HiveRepository();
  @override
  void initState() {
    super.initState();
    _addLocationController.userModel = hiveRepository.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    Map arg = Get.arguments ?? {};
    locationListAvilable = arg['locationListAvilable'];
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: AppConst.darkGreen,
          statusBarIconBrightness: Brightness.light),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        bottomSheet: Container(
            decoration: BoxDecoration(
                color: AppConst.white, borderRadius: BorderRadius.circular(12)),
            child: Container(
              height: locationListAvilable ? 52.h : 28.h,
              child: Padding(
                padding: EdgeInsets.only(
                    left: 3.w, right: 3.w, top: 2.h, bottom: 1.h),
                child: Column(
                  children: [
                    Text(
                      'Please Enable your location to make the delivery process smooth like Butter',
                      maxLines: 2,
                      style: TextStyle(
                        color: AppConst.black,
                        fontFamily: 'MuseoSans',
                        fontWeight: FontWeight.w600,
                        fontSize: SizeUtils.horizontalBlockSize * 4.2,
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 1.h,
                          width: 4.w,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: AppConst.grey),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(
                          'Select your Precise Location',
                          maxLines: 1,
                          style: TextStyle(
                            color: AppConst.grey,
                            fontFamily: 'MuseoSans',
                            fontWeight: FontWeight.w600,
                            fontSize: SizeUtils.horizontalBlockSize * 3.5,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 1.h,
                          width: 4.w,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: AppConst.grey),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(
                          'Confirm your location while using the app',
                          maxLines: 1,
                          style: TextStyle(
                            color: AppConst.grey,
                            fontFamily: 'MuseoSans',
                            fontWeight: FontWeight.w600,
                            fontSize: SizeUtils.horizontalBlockSize * 3.5,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Obx((() => (_addLocationController.isGpson.value == true &&
                            _addLocationController.checkPermission.value ==
                                true)
                        ? GestureDetector(
                            onTap: () {
                              // Get.back();
                              _addLocationController
                                  .getCurrentLocation1()
                                  .then((value) {
                                if (value.latitude != 0.0 &&
                                    value.longitude != 0.0) {
                                  _homeController.isLoading.value = true;
                                  Get.offAllNamed(AppRoutes.BaseScreen);
                                }
                              });
                            },
                            child: GpsContainer())
                        : InkWell(
                            onTap: (() {
                              _addLocationController.getCurrentLocation2();
                            }),
                            child: BottomWideButton(
                              text: _addLocationController
                                          .checkPermission.value !=
                                      true
                                  ? "Grant Permission"
                                  : "Enable Location",
                            ),
                          ))),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            locationListAvilable
                                ? (_addLocationController
                                            .userModel?.addresses?.isNotEmpty ??
                                        false)
                                    ? ListView.separated(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount:
                                            //  2,

                                            _addLocationController
                                                    .isSeeMoreEnable.value
                                                ? _addLocationController
                                                        .userModel
                                                        ?.addresses
                                                        ?.length ??
                                                    0
                                                : (_addLocationController
                                                                .userModel
                                                                ?.addresses
                                                                ?.length ??
                                                            0) <
                                                        4
                                                    ? _addLocationController
                                                            .userModel
                                                            ?.addresses
                                                            ?.length ??
                                                        0
                                                    : 4,
                                        itemBuilder: (context, index) {
                                          return Obx(
                                            () => GestureDetector(
                                              onTap: () async {
                                                _addLocationController
                                                    .currentSelectValue
                                                    .value = index;
                                                _homeController
                                                    .isLoading.value = true;
                                                Get.offAllNamed(
                                                    AppRoutes.BaseScreen);

                                                _addLocationController
                                                        .userAddress.value =
                                                    _addLocationController
                                                            .userModel
                                                            ?.addresses?[index]
                                                            .address ??
                                                        '';
                                                _addLocationController
                                                        .userAddressTitle
                                                        .value =
                                                    _addLocationController
                                                            .userModel
                                                            ?.addresses?[index]
                                                            .title ??
                                                        '';
                                                _addLocationController
                                                        .userHouse.value =
                                                    _addLocationController
                                                            .userModel
                                                            ?.addresses?[index]
                                                            .house ??
                                                        '';
                                                _addLocationController
                                                        .userAppartment.value =
                                                    _addLocationController
                                                            .userModel
                                                            ?.addresses?[index]
                                                            .apartment ??
                                                        '';
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
                                                        ?.addresses?[index]
                                                        .id);
                                                _homeController.pageNumber = 1;
                                                _homeController
                                                    .isPageAvailable = true;
                                                _homeController.isPageLoading
                                                    .value = false;
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
                                                _homeController
                                                    .isLoading.value = false;
                                              },
                                              child: Column(
                                                children: [
                                                  ListTile(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 0.5.h),
                                                    leading: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        IgnorePointer(
                                                          child: Radio(
                                                            value: true,
                                                            groupValue:
                                                                _addLocationController
                                                                        .currentSelectValue
                                                                        .value ==
                                                                    index,
                                                            onChanged: (value) {
                                                              _addLocationController
                                                                  .currentSelectValue
                                                                  .value = index;
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    title: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          _addLocationController
                                                                  .userModel
                                                                  ?.addresses?[
                                                                      index]
                                                                  .title ??
                                                              '',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: SizeUtils
                                                                      .horizontalBlockSize *
                                                                  4.2),
                                                        ),
                                                        Text(
                                                          "${_addLocationController.userModel?.addresses?[index].house ?? ''} ${_addLocationController.userModel?.addresses?[index].apartment ?? ''} ${_addLocationController.userModel?.addresses?[index].address ?? ''}",
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .grey[600],
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontSize: SizeUtils
                                                                      .horizontalBlockSize *
                                                                  3.7),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return Divider(height: 0);
                                        },
                                      )
                                    : Center(
                                        child: Text(
                                          '',
                                        ),
                                      )
                                : SizedBox(),
                            Obx((() =>
                                (_addLocationController.isGpson.value == true &&
                                        _addLocationController
                                                .checkPermission.value ==
                                            true)
                                    ? GestureDetector(
                                        onTap: () {
                                          // Get.back();
                                          _addLocationController
                                              .getCurrentLocation2()
                                              .then((value) {
                                            if (value.latitude != 0.0 &&
                                                value.longitude != 0.0) {
                                              dynamic value =
                                                  Get.offAll(AddressModel(
                                                isHomeScreen: true,
                                                page: "home",
                                              ));
                                            }
                                          });
                                        },
                                        child: BottomWideButton(
                                          text: "Choose another Address",
                                          color: AppConst.transparent,
                                          Textcolor: AppConst.darkGreen,
                                        ),
                                      )
                                    : InkWell(
                                        onTap: (() {
                                          _addLocationController
                                              .getCurrentLocation2();
                                        }),
                                        child: BottomWideButton(
                                          text: _addLocationController
                                                      .checkPermission.value !=
                                                  true
                                              ? ""
                                              : "Choose another Address",
                                          color: AppConst.transparent,
                                          Textcolor: AppConst.darkGreen,
                                          borderColor: _addLocationController
                                                      .checkPermission.value !=
                                                  true
                                              ? AppConst.transparent
                                              : AppConst.darkGreen,
                                        ),
                                      ))),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
        body: SignUpBackground(),
      ),
    );
  }
}
