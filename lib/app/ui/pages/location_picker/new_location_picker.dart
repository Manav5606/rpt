import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:customer_app/app/controller/add_location_controller.dart';
import 'package:customer_app/app/ui/pages/location_picker/bottom_confim_location.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

import 'bottom_confirm_location_shimmer.dart';
import 'bottom_full_address.dart';
import 'bottom_full_address_shimmer.dart';

class AddLocationScreen extends StatefulWidget {
  const AddLocationScreen({Key? key}) : super(key: key);

  @override
  _AddLocationScreenState createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {
  final AddLocationController _addLocationController = Get.find();
  bool isHome = false;

  @override
  Widget build(BuildContext context) {
    Map arg = Get.arguments ?? {};
    _addLocationController.isRecentAddress.value = arg['isFalse'] ?? true;
    isHome = arg['isHome'] ?? true;
    log("_addLocationController.isRecentAddress.value :${_addLocationController.isRecentAddress.value}");
    _addLocationController.initLocation();
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   elevation: 0,
      //   title: Text(
      //     "Choose address",
      //     textAlign: TextAlign.center,
      //     style: TextStyle(
      //         fontSize: SizeUtils.horizontalBlockSize * 5,
      //         color: AppConst.black,
      //         fontWeight: FontWeight.bold),
      //   ),
      // ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _addLocationController.initialLocation.value,
            myLocationEnabled: false,
            myLocationButtonEnabled: false,
            onCameraIdle: _addLocationController.onCameraIdle,
            zoomControlsEnabled: false,
            onCameraMove: _addLocationController.onCameraMove,
            onMapCreated: _addLocationController.onMapCreated,
          ),

          Align(
            alignment: Alignment.center,
            child: Container(
              height: 7.h,
              width: 10.w,
              child: Image.asset('assets/icons/pinsmall.png'),
            ),
          ),
          Positioned(
            top: 30,
            left: 10,
            child: CircleAvatar(
              radius: 2.4.h,
              backgroundColor: AppConst.lightGrey,
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: AppConst.black,
                    size: 3.h,
                  )),
            ),
          ),
          Obx(
            () => _addLocationController.isFullAddressBottomSheet.value
                ? _addLocationController.bottomFullAddressLoading.value
                    ? BottomFullAddressSheetShimmer(
                        address: _addLocationController.currentAddress.value.toString(),
                        cashBackCount: _addLocationController.totalCashBack.value,
                        storesCount: _addLocationController.storesCount.value,
                        notifyParent: () {
                          _addLocationController.isFullAddressBottomSheet.value = false;
                        },
                        isFullAddesss: _addLocationController.isFullAddressBottomSheet.value,
                        getCurrentLocation: () async {
                          await _addLocationController.getCurrentLocation();
                        },
                      )
                    : BottomFullAddressSheet(
                        address: _addLocationController.currentAddress.value.toString(),
                        cashBackCount: _addLocationController.totalCashBack.value,
                        storesCount: _addLocationController.storesCount.value,
                        notifyParent: () {
                          _addLocationController.isFullAddressBottomSheet.value = false;
                        },
                        isFullAddesss: _addLocationController.isFullAddressBottomSheet.value,
                        getCurrentLocation: () async {
                          await _addLocationController.getCurrentLocation();
                        },
                      )
                : _addLocationController.loading.value
                    ? BottomConfirmLocationSheetShimmer(
                        address: _addLocationController.currentAddress.value.toString(),
                        notifyParent: _addLocationController.refresh,
                        isFullAddesss: _addLocationController.isFullAddressBottomSheet.value,
                        getUserLocation: _addLocationController.getCurrentAddress,
                      )
                    : BottomConfirmLocationSheet(
                        address: _addLocationController.currentAddress.value.toString(),
                        notifyParent: () async {
                          await _addLocationController.getClaimRewardsPageCount();
                          await _addLocationController.getClaimRewardsPageData();
                          _addLocationController.isFullAddressBottomSheet.value = true;
                        },
                        isFullAddesss: _addLocationController.isFullAddressBottomSheet.value,
                        getUserLocation: _addLocationController.getCurrentAddress,
                        isHome: isHome,
                        skipButton: () async {
                          await _addLocationController.addCustomerAddress(
                            lng: _addLocationController.middlePointOfScreenOnMap?.longitude ?? 0,
                            lat: _addLocationController.middlePointOfScreenOnMap?.latitude ?? 0,
                            address: _addLocationController.currentAddress.value.toString(),
                            title: '',
                            house: '',
                            apartment: '',
                            directionToReach: '',
                          );
                        },
                        getCurrentLocation: () async {
                          await _addLocationController.getCurrentLocation();
                        },
                      ),
          ),
          // Obx(
          //   () => Positioned(
          //     bottom: 0,
          //     right: 0,
          //     left: 0,
          //     child: _addLocationController.isFullAddressBottomSheet.value
          //         ? _addLocationController.bottomFullAddressLoading.value
          //             ? BottomFullAddressSheetShimmer(
          //                 address: _addLocationController.currentAddress.value
          //                     .toString(),
          //                 cashBackCount:
          //                     _addLocationController.totalCashBack.value,
          //                 storesCount: _addLocationController.storesCount.value,
          //                 notifyParent: () {
          //                   _addLocationController
          //                       .isFullAddressBottomSheet.value = false;
          //                 },
          //                 isFullAddesss: _addLocationController
          //                     .isFullAddressBottomSheet.value,
          //                 getCurrentLocation: () async {
          //                   await _addLocationController.getCurrentLocation();
          //                 },
          //               )
          //             : BottomFullAddressSheet(
          //                 address: _addLocationController.currentAddress.value
          //                     .toString(),
          //                 cashBackCount:
          //                     _addLocationController.totalCashBack.value,
          //                 storesCount: _addLocationController.storesCount.value,
          //                 notifyParent: () {
          //                   _addLocationController
          //                       .isFullAddressBottomSheet.value = false;
          //                 },
          //                 isFullAddesss: _addLocationController
          //                     .isFullAddressBottomSheet.value,
          //                 getCurrentLocation: () async {
          //                   await _addLocationController.getCurrentLocation();
          //                 },
          //               )
          //         : _addLocationController.loading.value
          //             ? BottomConfirmLocationSheetShimmer(
          //                 address: _addLocationController.currentAddress.value
          //                     .toString(),
          //                 notifyParent: _addLocationController.refresh,
          //                 isFullAddesss: _addLocationController
          //                     .isFullAddressBottomSheet.value,
          //                 getUserLocation:
          //                     _addLocationController.getCurrentAddress,
          //               )
          //             : BottomConfirmLocationSheet(
          //                 address: _addLocationController.currentAddress.value
          //                     .toString(),
          //                 notifyParent: () async {
          //                   await _addLocationController
          //                       .getClaimRewardsPageCount();
          //                   await _addLocationController
          //                       .getClaimRewardsPageData();
          //                   _addLocationController
          //                       .isFullAddressBottomSheet.value = true;
          //                 },
          //                 isFullAddesss: _addLocationController
          //                     .isFullAddressBottomSheet.value,
          //                 getUserLocation:
          //                     _addLocationController.getCurrentAddress,
          //                 getCurrentLocation: () async {
          //                   await _addLocationController.getCurrentLocation();
          //                 },
          //               ),
          //   ),
          // )
        ],
      ),
    );
  }
}
