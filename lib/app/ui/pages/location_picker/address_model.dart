import 'dart:async';
import 'dart:developer';

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
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../../controllers/userViewModel.dart';

class AddressModel extends StatefulWidget {
  final bool isHomeScreen;
  final bool isSavedAddress;

  AddressModel(
      {Key? key, this.isHomeScreen = false, this.isSavedAddress = true})
      : super(key: key);

  @override
  State<AddressModel> createState() => _AddressModelState();
}

class _AddressModelState extends State<AddressModel> {
  final AddLocationController _addLocationController = Get.find()
    ..getUserData();
  final HomeController _homeController = Get.put(HomeController());

  FocusNode focusNode = FocusNode();

  Timer? _debounce;
  bool selected = false;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _addLocationController.isRecentAddress.value = widget.isHomeScreen;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          children: [
            InkWell(
              onTap: () => Get.back(),
              // Get.toNamed(AppRoutes.BaseScreen),
              child: Icon(
                Icons.arrow_back,
                color: AppConst.black,
                size: SizeUtils.horizontalBlockSize * 7.2,
              ),
            ),
            SizedBox(
              width: 4.w,
            ),
            Text(
              "Choose address",
              style: TextStyle(
                  fontSize: SizeUtils.horizontalBlockSize * 5,
                  color: AppConst.black,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(clipBehavior: Clip.none, children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // SizedBox(
                    //   height: 2.h,
                    // ),
                    SearchField(
                      controller: _addLocationController.searchController,
                      focusNode: focusNode,
                      suffixIcon: Obx(
                        () => GestureDetector(
                          onTap: () {
                            _addLocationController.searchController.clear();
                            _addLocationController.predictions.clear();
                          },
                          child: Icon(
                            _addLocationController.searchText.value.isNotEmpty
                                ? Icons.close
                                : Icons.search,
                            color: AppConst.black, size: 2.5.h,
                            // _addLocationController.searchText.value.isNotEmpty
                            //     ? kPrimaryColor
                            //     : kIconColor,
                          ),
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
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 1,
                          width: 40.w,
                          color: AppConst.grey,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3.w),
                          child: Text(
                            "OR",
                            style: TextStyle(
                              color: AppConst.grey,
                              fontSize: SizeUtils.horizontalBlockSize * 4,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          height: 1,
                          width: 40.w,
                          color: AppConst.grey,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        Get.toNamed(AppRoutes.NewLocationScreen, arguments: {
                          "isFalse": false,
                          "isHome": widget.isHomeScreen
                        });
                        _addLocationController.getCurrentAddress();
                      },
                      child: Container(
                        height: 5.h,
                        margin: EdgeInsets.only(
                          bottom: 3.h,
                        ),
                        decoration: BoxDecoration(
                          // shape: BoxShape.circle,
                          color: AppConst.white,
                          borderRadius: BorderRadius.circular(12),
                          // border: Border.all(
                          //     // color: AppConst.black,
                          //     // width: SizeUtils.horizontalBlockSize - 2.92
                          //     ),
                          boxShadow: [
                            BoxShadow(
                              color: AppConst.grey,
                              blurRadius: 3,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Icon(
                                  Icons.gps_fixed_rounded,
                                  color: AppConst.kSecondaryTextColor,
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
                      ),
                    ),
                    // Divider(
                    //     // height: 2.h,
                    //     ),
                    /*Text(
                      StringContants.recentLocations,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    ListTile(
                      minVerticalPadding: 0,
                      horizontalTitleGap: 0,
                      contentPadding: EdgeInsets.zero,
                      leading: Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Icon(Icons.access_time),
                      ),
                      title: Text('Permitta, Ongole'),
                    ),
                    SizedBox(
                      height: 20,
                    ),*/
                    Obx(
                      () => _addLocationController.predictions.length == 0
                          ? SizedBox()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 1.h,
                                ),
                                // Text(
                                //   StringContants.searchResults,
                                //   style: TextStyle(
                                //     fontSize: SizeUtils.horizontalBlockSize * 4.6,
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // ),
                                // SizedBox(
                                //   height: 1.h,
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
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              GestureDetector(
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
                                                  widget.isHomeScreen
                                                      ? Get.toNamed(AppRoutes
                                                              .NewLocationScreen)
                                                          ?.whenComplete(() =>
                                                              Get.back(
                                                                  result: true))
                                                      : Get.back();
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 1.h),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.location_city,
                                                        // CupertinoIcons
                                                        //     .building_2_fill,
                                                        color: AppConst.black,
                                                        size: SizeUtils
                                                                .horizontalBlockSize *
                                                            6,
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
                                                                4,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Divider(height: 0),
                                            ],
                                          );
                                        },
                                      ),
                              ],
                            ),
                    ),
                    Obx(
                      () => _addLocationController.predictions.length == 0
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                widget.isSavedAddress
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          // Text(
                                          //   StringContants.savedAddresses,
                                          //   style: TextStyle(
                                          //     fontSize:
                                          //         SizeUtils.horizontalBlockSize *
                                          //             4.5,
                                          //     fontWeight: FontWeight.bold,
                                          //   ),
                                          // ),
                                          // SizedBox(
                                          //   height: 1.h,
                                          // ),
                                          (_addLocationController.userModel
                                                      ?.addresses?.isNotEmpty ??
                                                  false)
                                              ? ListView.separated(
                                                  padding: EdgeInsets.zero,
                                                  shrinkWrap: true,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  itemCount: _addLocationController
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
                                                              3
                                                          ? _addLocationController
                                                                  .userModel
                                                                  ?.addresses
                                                                  ?.length ??
                                                              0
                                                          : 3,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Obx(
                                                      () => GestureDetector(
                                                        onTap: () async {
                                                          _addLocationController
                                                              .currentSelectValue
                                                              .value = index;
                                                        },
                                                        child: Column(
                                                          children: [
                                                            ListTile(
                                                              contentPadding:
                                                                  EdgeInsets.symmetric(
                                                                      vertical:
                                                                          0.5.h),
                                                              leading: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  IgnorePointer(
                                                                    child:
                                                                        Radio(
                                                                      value:
                                                                          true,
                                                                      groupValue: _addLocationController
                                                                              .currentSelectValue
                                                                              .value ==
                                                                          index,
                                                                      onChanged:
                                                                          (value) {},
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
                                                                            ?.addresses?[index]
                                                                            .title ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            SizeUtils.horizontalBlockSize *
                                                                                4.2),
                                                                  ),
                                                                  Text(
                                                                    "${_addLocationController.userModel?.addresses?[index].house ?? ''} ${_addLocationController.userModel?.addresses?[index].address ?? ''}",
                                                                    maxLines: 2,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: TextStyle(
                                                                        color: Colors.grey[
                                                                            600],
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w300,
                                                                        fontSize:
                                                                            SizeUtils.horizontalBlockSize *
                                                                                3.7),
                                                                  ),
                                                                ],
                                                              ),
                                                              trailing:
                                                                  PopupMenuButton(
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            8.0),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            8.0),
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            8.0),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            8.0),
                                                                  ),
                                                                ),
                                                                itemBuilder:
                                                                    (ctx) {
                                                                  return [
                                                                    _buildPopupMenuItem(
                                                                      'Edit',
                                                                      Icons
                                                                          .edit,
                                                                      () async {
                                                                        await Future.delayed(Duration(
                                                                            milliseconds:
                                                                                200));
                                                                        Get.toNamed(
                                                                            AppRoutes.EditAddressScreen,
                                                                            arguments: {
                                                                              'addresses': _addLocationController.userModel?.addresses?[index]
                                                                            })?.whenComplete(() =>
                                                                            setState(() {}));
                                                                      },
                                                                    ),
                                                                    if ((_addLocationController.userModel?.addresses?.length ??
                                                                                0) >
                                                                            1 &&
                                                                        _homeController.userAddress.value !=
                                                                            _addLocationController
                                                                                .userModel
                                                                                ?.addresses?[
                                                                                    index]
                                                                                .address)
                                                                      _buildPopupMenuItem(
                                                                          'Delete',
                                                                          Icons
                                                                              .delete,
                                                                          () async {
                                                                        await _addLocationController.deleteCustomerAddress(_addLocationController.userModel?.addresses?[index].id ??
                                                                            '');

                                                                        _addLocationController
                                                                            .userModel
                                                                            ?.addresses
                                                                            ?.remove(_addLocationController.userModel?.addresses?[index]);
                                                                        UserViewModel.setUser(
                                                                            _addLocationController.userModel!);
                                                                        setState(
                                                                            () {});
                                                                      }),
                                                                  ];
                                                                },
                                                              ),

                                                              /*Container(
                                                                  color: Colors.transparent,
                                                                  child: GestureDetector(
                                                                      onTap: () {
                                                                        Get.toNamed(AppRoutes.EditAddressScreen,
                                                                            arguments: {'addresses': _addLocationController.userModel?.addresses?[index]});
                                                                      },
                                                                      child: Padding(
                                                                        padding: const EdgeInsets.all(8.0),
                                                                        child: Text(
                                                                          "Edit",
                                                                          style: AppStyles.BOLD_STYLE_GREEN,
                                                                        ),
                                                                      )),
                                                                )*/
                                                              // EditDeleteButton(),
                                                            ),
                                                            if (_addLocationController
                                                                    .currentSelectValue
                                                                    .value ==
                                                                index)
                                                              GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                  _homeController
                                                                      .isLoading
                                                                      .value = true;
                                                                  Get.back();

                                                                  _homeController
                                                                      .userAddress
                                                                      .value = _addLocationController
                                                                          .userModel
                                                                          ?.addresses?[
                                                                              index]
                                                                          .address ??
                                                                      '';
                                                                  _homeController
                                                                      .userAddressTitle
                                                                      .value = _addLocationController
                                                                          .userModel
                                                                          ?.addresses?[
                                                                              index]
                                                                          .title ??
                                                                      '';
                                                                  await UserViewModel.setLocation(
                                                                      LatLng(
                                                                          _addLocationController.userModel?.addresses?[index].location?.lat ??
                                                                              0.0,
                                                                          _addLocationController.userModel?.addresses?[index].location?.lng ??
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
                                                                      .isLoading
                                                                      .value = false;
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: SizeUtils
                                                                          .horizontalBlockSize *
                                                                      12,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: AppConst
                                                                        .kSecondaryColor,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(6),
                                                                  ),
                                                                  child: Center(
                                                                      child:
                                                                          Text(
                                                                    "Choose Address",
                                                                    style: TextStyle(
                                                                        color: AppConst
                                                                            .white,
                                                                        fontSize:
                                                                            SizeUtils.horizontalBlockSize *
                                                                                4),
                                                                  )),
                                                                ),
                                                              )
                                                            else
                                                              SizedBox(),
                                                          ],
                                                        ),
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
                                                    'No Saved Addresses',
                                                  ),
                                                ),
                                          if ((_addLocationController.userModel
                                                      ?.addresses?.length ??
                                                  0) >
                                              3)
                                            OutlinedButton(
                                              style: OutlinedButton.styleFrom(
                                                tapTargetSize:
                                                    MaterialTapTargetSize
                                                        .padded,
                                              ),
                                              onPressed: () {
                                                _addLocationController
                                                        .isSeeMoreEnable.value =
                                                    !_addLocationController
                                                        .isSeeMoreEnable.value;
                                              },
                                              child: _addLocationController
                                                      .isSeeMoreEnable.value
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          StringContants
                                                              .seeLess,
                                                          style: TextStyle(
                                                            color:
                                                                AppConst.black,
                                                            fontSize: SizeUtils
                                                                    .horizontalBlockSize *
                                                                4,
                                                          ),
                                                        ),
                                                        Icon(
                                                          Icons
                                                              .keyboard_arrow_up,
                                                          color: AppConst.black,
                                                          size: SizeUtils
                                                                  .horizontalBlockSize *
                                                              6,
                                                        )
                                                      ],
                                                    )
                                                  : Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          StringContants
                                                              .seeMore,
                                                          style: TextStyle(
                                                            color:
                                                                AppConst.black,
                                                            fontSize: SizeUtils
                                                                    .horizontalBlockSize *
                                                                4,
                                                          ),
                                                        ),
                                                        Icon(
                                                          Icons
                                                              .keyboard_arrow_down_rounded,
                                                          color: AppConst.black,
                                                          size: SizeUtils
                                                                  .horizontalBlockSize *
                                                              6,
                                                        )
                                                      ],
                                                    ),
                                            ),
                                        ],
                                      )
                                    : SizedBox(),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Divider(
                                  height: 1.h,
                                  color: AppConst.black,
                                ),
                                Text(
                                  StringContants.recentAddresses,
                                  style: TextStyle(
                                    fontSize:
                                        SizeUtils.horizontalBlockSize * 4.5,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Obx(
                                  () => ListView.separated(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
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
                                                      Get.back(result: true))
                                              : Get.back();
                                        },
                                        child: ListTile(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 0.5.w),
                                          leading: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.access_time_rounded,
                                                size: SizeUtils
                                                        .horizontalBlockSize *
                                                    6,
                                              ),
                                            ],
                                          ),
                                          title: Text(
                                            _addLocationController
                                                    .recentAddressDetails[index]
                                                    .description ??
                                                "",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: SizeUtils
                                                        .horizontalBlockSize *
                                                    4.0),
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return Divider(height: 0);
                                    },
                                    itemCount: _addLocationController
                                        .recentAddressDetails.length,
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                              ],
                            )
                          : SizedBox(),
                    )
                  ],
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  PopupMenuItem _buildPopupMenuItem(
      String title, IconData iconData, VoidCallback? onTap) {
    return PopupMenuItem(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            iconData,
            color: Colors.black,
          ),
          Text(title),
        ],
      ),
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
