import 'dart:developer';

import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/controller/my_wallet_controller.dart';
import 'package:customer_app/app/ui/pages/location_picker/edit_address_screen.dart';
import 'package:customer_app/app/ui/pages/location_picker/new_address.dart';
import 'package:customer_app/controllers/userViewModel.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/controller/add_location_controller.dart';
import 'package:customer_app/app/ui/pages/location_picker/bottom_confim_location.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:flutter/services.dart';
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
  final MyWalletController _myWalletController = Get.find();
  bool isHome = false;
  bool? issignup;
  bool? homeTrue;
  String page = "";

  @override
  Widget build(BuildContext context) {
    // print(_addLocationController.currentPosition.latitude);
    Map arg = Get.arguments ?? {};
    _addLocationController.isRecentAddress.value = arg['isFalse'] ?? true;
    issignup = arg['issignup'] ?? false;
    isHome = arg['isHome'] ?? true;
    homeTrue = arg['homeTrue'];
    page = arg['page'] ?? "";
    print(homeTrue);
    log("_addLocationController.isRecentAddress.value :${_addLocationController.isRecentAddress.value}");
    // _addLocationController.initLocation();
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppConst.white,
            statusBarIconBrightness: Brightness.dark),
        elevation: 0.5,
        title: Text(
          "Confirm Delivery Location",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'MuseoSans',
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            fontSize: SizeUtils.horizontalBlockSize * 4.5,
            color: AppConst.black,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(_addLocationController.currentPosition.latitude,
                    _addLocationController.currentPosition.longitude),
                zoom: 17.3,
              ),
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              onCameraIdle: _addLocationController.onCameraIdle,
              zoomControlsEnabled: false,
              onCameraMove: _addLocationController.onCameraMove,
              onMapCreated: _addLocationController.onMapCreated,
            ),
          ),

          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: 28,
                left: 6,
              ),
              child: Container(
                height: 6.h,
                width: 8.w,
                child: Image.asset('assets/icons/pinsmall.png'),
              ),
            ),
          ),
          Obx(
            () => _addLocationController.loading.value
                ? BottomConfirmLocationSheetShimmer()
                : BottomConfirmLocationSheet(
                    address: "${_addLocationController.currentAddress.value}",
                    notifyParent: () async {
                      if (page == "claimmore") {
                        _addLocationController.isRecentAddress.value = true;
                        UserViewModel.setLocation(LatLng(
                            _addLocationController
                                .middlePointOfScreenOnMap!.latitude,
                            _addLocationController
                                .middlePointOfScreenOnMap!.longitude));

                        await _myWalletController
                            .getAllWalletByCustomerByBusinessType();
                        int? value = await _myWalletController
                            .updateBusinesstypeWallets();
                        Get.toNamed(AppRoutes.SelectBusinessType,
                            arguments: {"signup": issignup});
                      } else {
                        await _addLocationController.getClaimRewardsPageCount();
                        await _addLocationController.getClaimRewardsPageData();
                        _addLocationController.isRecentAddress.value = true;
                        Get.to(() => NewAddressScreen(
                              latt: _addLocationController
                                  .middlePointOfScreenOnMap!.latitude,
                              longg: _addLocationController
                                  .middlePointOfScreenOnMap!.longitude,
                              cashBackCount:
                                  _addLocationController.totalCashBack.value,
                              add: _addLocationController.currentAddress.value,
                              storesCount:
                                  _addLocationController.storesCount.value,
                              page: page,
                              isHome: homeTrue,
                            ));
                      }
                    },
                    isFullAddesss:
                        _addLocationController.isFullAddressBottomSheet.value,
                    getUserLocation: _addLocationController.getCurrentAddress,
                    isHome: isHome,
                    skipButton: () async {
                      await _addLocationController.addCustomerAddress(
                        lng: _addLocationController
                                .middlePointOfScreenOnMap?.longitude ??
                            0,
                        lat: _addLocationController
                                .middlePointOfScreenOnMap?.latitude ??
                            0,
                        address: _addLocationController.currentAddress.value
                            .toString(),
                        title: '',
                        house: '',
                        apartment: '',
                        directionToReach: '',
                      );
                    },
                    getCurrentLocation: () async {
                      await _addLocationController.getCurrentLocation();
                    },
                    page: page,
                  ),
          ),

          // Positioned(
          //     top: 30,
          //     right: 10,
          //     child: InkWell(
          //       onTap: () async {
          //         await _addLocationController.addCustomerAddress(
          //           lng: _addLocationController
          //                   .middlePointOfScreenOnMap?.longitude ??
          //               0,
          //           lat: _addLocationController
          //                   .middlePointOfScreenOnMap?.latitude ??
          //               0,
          //           address:
          //               _addLocationController.currentAddress.value.toString(),
          //           title: '',
          //           house: '',
          //           apartment: '',
          //           directionToReach: '',
          //         );
          //       },
          //       child: Padding(
          //         padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
          //         child: Container(
          //           width: 18.w,
          //           height: 4.h,
          //           decoration: BoxDecoration(
          //               color: AppConst.lightYellow,
          //               boxShadow: [
          //                 BoxShadow(
          //                   color: AppConst.grey,
          //                   blurRadius: 3,
          //                   offset: Offset(1, 1),
          //                 ),
          //               ],
          //               borderRadius: BorderRadius.circular(12)),
          //           child: Center(
          //             child: Text(
          //               "Skip",
          //               style: TextStyle(
          //                 color: AppConst.black,
          //                 fontSize: SizeUtils.horizontalBlockSize * 4,
          //                 fontWeight: FontWeight.w500,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     )),
          // Positioned(
          //   top: 30,
          //   left: 10,
          //   child: CircleAvatar(
          //     radius: 2.4.h,
          //     backgroundColor: AppConst.white,
          //     child: IconButton(
          //         onPressed: () {},
          //         icon: Icon(
          //           Icons.arrow_back_rounded,
          //           color: AppConst.black,
          //           size: 3.h,
          //         )),
          //   ),
          // ),
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
          //                 // address: _addLocationController.currentAddress.value
          //                 //     .toString(),
          //                 // cashBackCount:
          //                 //     _addLocationController.totalCashBack.value,
          //                 // storesCount: _addLocationController.storesCount.value,
          //                 // notifyParent: () {
          //                 //   _addLocationController
          //                 //       .isFullAddressBottomSheet.value = false;
          //                 // },
          //                 // isFullAddesss: _addLocationController
          //                 //     .isFullAddressBottomSheet.value,
          //                 // getCurrentLocation: () async {
          //                 //   await _addLocationController.getCurrentLocation();
          //                 // },
          //                 )
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
          //                 // isHome: isHome,
          //                 // address: _addLocationController.currentAddress.value
          //                 //     .toString(),
          //                 // notifyParent: () async {
          //                 //   await _addLocationController
          //                 //       .getClaimRewardsPageCount();
          //                 //   await _addLocationController
          //                 //       .getClaimRewardsPageData();
          //                 //   _addLocationController
          //                 //       .isFullAddressBottomSheet.value = true;
          //                 // },
          //                 // isFullAddesss: _addLocationController
          //                 //     .isFullAddressBottomSheet.value,
          //                 // getUserLocation:
          //                 //     _addLocationController.getCurrentAddress,
          //                 // getCurrentLocation: () async {
          //                 //   await _addLocationController.getCurrentLocation();
          //                 // },
          //                 ),
          //   ),
          // )
        ],
      ),
    );
  }
}
