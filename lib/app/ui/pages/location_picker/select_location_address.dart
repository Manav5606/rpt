import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/controller/add_location_controller.dart';
import 'package:customer_app/app/controller/my_wallet_controller.dart';
import 'package:customer_app/app/data/model/user_model.dart';
import 'package:customer_app/app/data/repository/hive_repository.dart';
import 'package:customer_app/app/ui/pages/location_picker/address_model.dart';
import 'package:customer_app/app/ui/pages/signIn/phone_authentication_screen.dart';
import 'package:customer_app/app/ui/pages/signIn/signup_screen.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/controllers/userViewModel.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/screens/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

class SelectLocationAddress extends StatefulWidget {
  SelectLocationAddress({
    Key? key,
  }) : super(key: key);

  @override
  State<SelectLocationAddress> createState() => _SelectLocationAddressState();
}

class _SelectLocationAddressState extends State<SelectLocationAddress> {
  bool locationListAvilable = false;
  bool? issignup;

  final AddLocationController _addLocationController =
      Get.put(AddLocationController());

  final HomeController _homeController = Get.put(HomeController());
  final HiveRepository hiveRepository = HiveRepository();
  final MyWalletController _myWalletController = Get.put(MyWalletController());
  UserModel? userModel;
  @override
  void initState() {
    super.initState();
    _addLocationController.userModel = hiveRepository.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    Map arg = Get.arguments ?? {};
    locationListAvilable = arg['locationListAvilable'] ?? false;
    issignup = arg['issignup'] ?? false;

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
                                  .then((value) async {
                                if (value.latitude != 0.0 &&
                                    value.longitude != 0.0) {
                                  if (!((userModel?.email != null &&
                                          userModel?.email != "") &&
                                      (userModel?.firstName != null &&
                                          userModel?.firstName != ""))) {
                                    UserViewModel.setLocation(LatLng(
                                        _addLocationController
                                            .currentPosition.latitude,
                                        _addLocationController
                                            .currentPosition.longitude));
                                    _addLocationController
                                        .isRecentAddress.value = false;
                                    await _myWalletController
                                        .getAllWalletByCustomerByBusinessType();
                                    int? value = await _myWalletController
                                        .updateBusinesstypeWallets();

                                    if (value != null) {
                                      Get.toNamed(AppRoutes.SelectBusinessType,
                                          arguments: {"signup": issignup});
                                    }
                                  } else {
                                    Get.offAllNamed(
                                        AppRoutes.SelectLocationAddress,
                                        arguments: {
                                          "locationListAvilable": true
                                        });
                                  }
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
                                                    AppRoutes.BaseScreen,
                                                    arguments: {"index": 3});

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
