import 'dart:async';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/controller/add_location_controller.dart';
import 'package:customer_app/app/ui/pages/location_picker/address_model.dart';
import 'package:customer_app/app/ui/pages/signIn/signup_bs.dart';
import 'package:customer_app/app/ui/pages/signIn/signup_screen.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/widgets/copied/confirm_dialog.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/my_wallet_controller.dart';

class SelectBusinessType extends StatefulWidget {
  const SelectBusinessType({Key? key}) : super(key: key);

  @override
  State<SelectBusinessType> createState() => _SelectBusinessTypeState();
}

class _SelectBusinessTypeState extends State<SelectBusinessType> {
  final AddLocationController _addLocationController = Get.find();
  final MyWalletController _myWalletcontroller = Get.put(MyWalletController());

  @override
  void initState() {
    super.initState();
    if (_myWalletcontroller.issignup.value == true) {
      Timer(Duration(seconds: 1), () {
        FocusScope.of(context).unfocus();
      });
    }
  }

  Future<bool> handleBackPressed() async {
    SeeyaConfirmDialog(
        title: "Are you sure?",
        subTitle: "You Want to go back.",
        onCancel: () => Get.back(),
        onConfirm: () async {
          Get.back();
          //exit this screen
          if (_myWalletcontroller.issignup.value == true) {
            Get.bottomSheet(SignupBs());
          } else {
            Get.offAllNamed(AppRoutes.BaseScreen, arguments: {"index": 3});
          }

          // Get.back();
        }).show(context);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();
    Map arg = Get.arguments ?? {};
    bool signup = arg['signup'] ?? false;
    _myWalletcontroller.issignup.value = signup;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: AppConst.darkGreen,
          statusBarIconBrightness: Brightness.light),
      child: WillPopScope(
        onWillPop: handleBackPressed,
        child: Scaffold(
          backgroundColor: AppConst.white,
          bottomSheet: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              child: Obx(
                () => GestureDetector(
                  onTap: () async {
                    if (signup) {
                      Get.bottomSheet(SignupBs());
                    } else {
                      if (_myWalletcontroller.isNonVegSelected.value == true) {
                        for (int i = 0;
                            i < (_myWalletcontroller.NonVegStores.length);
                            i++) {
                          _addLocationController.allWalletStores
                              .add(_myWalletcontroller.NonVegStores[i]);
                        }
                      }
                      if (_myWalletcontroller.isPetfoodSelected.value == true) {
                        for (int i = 0;
                            i < (_myWalletcontroller.PetfoodStores.length);
                            i++) {
                          _addLocationController.allWalletStores
                              .add(_myWalletcontroller.PetfoodStores[i]);
                        }
                      }
                      if (_myWalletcontroller.walletbalanceOfSignup.value > 0) {
                        await _addLocationController
                            .addMultipleStoreToWalletToClaimMore();
                      }
                      await _myWalletcontroller.getAllWalletByCustomer();
                      _myWalletcontroller.walletbalanceOfBusinessType.value =
                          _myWalletcontroller.StoreTotalWelcomeAmount();
                      Get.offNamed(AppRoutes.BaseScreen,
                          arguments: {"index": 3});
                    }
                  },
                  child: Container(
                    height: 5.5.h,
                    decoration: BoxDecoration(
                        color: AppConst.limegreen,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(
                          (_myWalletcontroller.walletbalanceOfSignup.value > 0)
                              ? "Claim All: \u{20b9}${_myWalletcontroller.walletbalanceOfSignup.value}"
                              : "Continue",
                          style: TextStyle(
                            fontFamily: 'MuseoSans',
                            color: AppConst.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                          )),
                    ),
                  ),
                ),
              )),
          body: SafeArea(
              child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 9.h,
                  color: AppConst.darkGreen,
                  width: Device.screenWidth,
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 5.w),
                            child: Text("Balance available",
                                style: TextStyle(
                                  fontFamily: 'MuseoSans',
                                  color: AppConst.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                  letterSpacing: -0.48,
                                )),
                          ),
                          Obx(
                            () => RichText(
                                text: new TextSpan(children: [
                              new TextSpan(
                                  text: "\u{20b9}",
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    color: AppConst.radiumGreen,
                                    fontSize: 32,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                  )),
                              new TextSpan(
                                  text:
                                      "${_myWalletcontroller.walletbalanceOfSignup.value}",
                                  style: TextStyle(
                                    fontFamily: 'MuseoSans',
                                    color: AppConst.white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                  )),
                            ])),
                          )
                        ],
                      )),
                ),
                Container(
                  height: 44.h,
                  width: Device.screenHeight,
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: 4.w, right: 4.w, top: 2.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              // height: 2.h,
                              width: 60.w,
                              child: Obx(
                                () => Text(
                                    "${_addLocationController.currentAddress.value}",
                                    style: TextStyle(
                                      fontFamily: 'MuseoSans',
                                      color: AppConst.grey,
                                      fontSize: 14,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                    )),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                dynamic value = await Get.to(AddressModel(
                                    isHomeScreen: false,
                                    page: "claimmore",
                                    isRecentAddress: false,
                                    issignup: signup));
                              },
                              child: Row(
                                children: [
                                  SvgPicture.asset('assets/icons/location.svg'),
                                  SizedBox(width: 2.w),
                                  Text("Update",
                                      style: TextStyle(
                                        fontFamily: 'MuseoSans',
                                        color: AppConst.limegreen,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                      ))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                            child: Container(
                              height: 38.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              child: GoogleMap(
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(
                                      _addLocationController
                                          .currentPosition.latitude,
                                      _addLocationController
                                          .currentPosition.longitude),
                                  zoom: 15,
                                ),
                                myLocationEnabled: true,
                                myLocationButtonEnabled: false,
                                onCameraIdle:
                                    _addLocationController.onCameraIdle,
                                zoomControlsEnabled: false,
                                // onCameraMove:
                                //     _addLocationController.onCameraMove,
                                onMapCreated:
                                    _addLocationController.onMapCreated,
                                markers: _myWalletcontroller.markers,
                                minMaxZoomPreference:
                                    MinMaxZoomPreference(5, 15),

                                // _markers,
                                // markers.toSet(),

                                //     Set.from([
                                // Marker(
                                //   position: LatLng(
                                //       _myWalletcontroller.GroceryStores.first
                                //               .address?.location?.lat ??
                                //           0.0,
                                //       _myWalletcontroller.GroceryStores.first
                                //               .address?.location?.lng ??
                                //           0.0),
                                //   markerId: MarkerId('1'),
                                //   icon: _myWalletcontroller.storeIcon ??
                                //       BitmapDescriptor.defaultMarker,
                                // ),

                                //   Marker(
                                //     position: LatLng(
                                //         _addLocationController
                                //             .currentPosition.latitude,
                                //         _addLocationController
                                //             .currentPosition.longitude),
                                //     markerId: MarkerId('5'),
                                //     icon: _myWalletcontroller
                                //             .currentPositionIcon ??
                                //         BitmapDescriptor.defaultMarker,
                                //   )
                                // ]),
                              ),
                            ),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.only(top: 10.h, left: 45.w),
                          //   child: Container(
                          //     height: 7.h,
                          //     width: 10.w,
                          //     child: Image.asset('assets/icons/pinsmall.png'),
                          //   ),
                          // ),
                          // Container(
                          //   height: 38.h,
                          //   width: double.infinity,
                          //   color: AppConst.transparent,
                          // )
                        ],
                      ),
                    ],
                  ),
                ),
                // SizedBox(
                //   height: 2.h,
                // ),

                Container(
                  height: 17.h,
                  width: Device.screenWidth,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _myWalletcontroller.category.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Container(
                                      height: 8.h,
                                      width: 16.w,
                                      color: AppConst.white,
                                      child: Image.asset(
                                        _myWalletcontroller
                                            .category[index].image,
                                        fit: BoxFit.fitWidth,
                                        // scale: 1,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 6.h,
                                    right: 0.0,
                                    bottom: 0.0,
                                    child: Container(
                                      height: 4.h,
                                      width: 5.w,
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 0.5.h,
                              ),
                              Text(_myWalletcontroller.category[index].name,
                                  style: TextStyle(
                                    fontFamily: 'MuseoSans',
                                    color: AppConst.lightBlack,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                  )),
                              SizedBox(
                                height: 0.5.h,
                              ),
                              Obx(
                                () => Text(
                                    (_myWalletcontroller.category[index].id ==
                                            "61f95fcd0a984e3d1c8f9ec9")
                                        ? "\u{20b9}${_myWalletcontroller.GroceryWalletAmount.value}"
                                        : (_myWalletcontroller
                                                    .category[index].id ==
                                                "625cc6c0c30c356c00c6a9bb")
                                            ? "\u{20b9}${_myWalletcontroller.NonvegWalletAmount.value}"
                                            : (_myWalletcontroller
                                                        .category[index].id ==
                                                    "641ecc4ad9f0df5fa16d708d")
                                                ? "\u{20b9}${_myWalletcontroller.DryFruitWalletAmount.value}"
                                                : (_myWalletcontroller
                                                            .category[index]
                                                            .id ==
                                                        "63a689eff5416c5c5b0ab0a4")
                                                    ? "\u{20b9}${_myWalletcontroller.PetfoodWalletAmount.value}"
                                                    : (_myWalletcontroller
                                                                .category[index]
                                                                .id ==
                                                            "63a68a03f5416c5c5b0ab0a5")
                                                        ? "\u{20b9}${_myWalletcontroller.MedicsWalletAmount.value}"
                                                        : "",
                                    style: TextStyle(
                                      fontFamily: 'MuseoSans',
                                      color: AppConst.grey,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                    )),
                              )
                            ],
                          ),
                        );
                      }),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 4.w,
                    right: 4.w,
                  ),
                  child: Row(
                    children: [
                      Text("More Offers",
                          style: TextStyle(
                            fontFamily: 'MuseoSans',
                            color: AppConst.lightBlack,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                          ))
                    ],
                  ),
                ),
                Flexible(
                    child: Obx(
                  () => Column(
                    children: [
                      ((_myWalletcontroller.NonvegWalletAmount.value) > 0)
                          ? Padding(
                              padding: EdgeInsets.only(
                                left: 4.w,
                                right: 4.w,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundImage: AssetImage(
                                            "assets/images/Nonveg.png"),
                                      ),
                                      SizedBox(
                                        width: 4.w,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Chicken & Meat",
                                              style: TextStyle(
                                                fontFamily: 'MuseoSans',
                                                color: AppConst.lightBlack,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                fontStyle: FontStyle.normal,
                                                letterSpacing: -0.48,
                                              )),
                                          Text("Do you like Non-veg?",
                                              style: TextStyle(
                                                fontFamily: 'MuseoSans',
                                                color: AppConst.grey,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                fontStyle: FontStyle.normal,
                                              ))
                                        ],
                                      )
                                    ],
                                  ),
                                  Obx(
                                    () => GestureDetector(
                                      onTap: () {
                                        _myWalletcontroller
                                                .isNonVegSelected.value =
                                            !_myWalletcontroller
                                                .isNonVegSelected.value;
                                        if (_myWalletcontroller
                                                .isNonVegSelected.value ==
                                            false) {
                                          _myWalletcontroller
                                              .walletbalanceOfSignup
                                              .value = (_myWalletcontroller
                                                  .walletbalanceOfSignup
                                                  .value) -
                                              (_myWalletcontroller
                                                  .NonvegWalletAmount.value);
                                        } else {
                                          _myWalletcontroller
                                              .walletbalanceOfSignup
                                              .value = (_myWalletcontroller
                                                  .walletbalanceOfSignup
                                                  .value) +
                                              (_myWalletcontroller
                                                  .NonvegWalletAmount.value);
                                        }
                                      },
                                      child: Container(
                                        height: 4.h,
                                        width: 22.w,
                                        decoration: BoxDecoration(
                                            color: _myWalletcontroller
                                                    .isNonVegSelected.value
                                                ? AppConst.darkGreen
                                                : AppConst.white,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            border: Border.all(
                                                color: AppConst.darkGreen)),
                                        child: Center(
                                          child: Text(
                                              _myWalletcontroller
                                                      .isNonVegSelected.value
                                                  ? "Selected"
                                                  : "Select",
                                              style: TextStyle(
                                                fontFamily: 'MuseoSans',
                                                color: _myWalletcontroller
                                                        .isNonVegSelected.value
                                                    ? AppConst.white
                                                    : AppConst.darkGreen,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                              )),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          : SizedBox(),
                      ((_myWalletcontroller.PetfoodWalletAmount.value) > 0)
                          ? Padding(
                              padding: EdgeInsets.only(
                                  left: 4.w, right: 4.w, top: 2.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundImage: AssetImage(
                                            "assets/images/petfood.png"),
                                      ),
                                      SizedBox(
                                        width: 4.w,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Petfood",
                                              style: TextStyle(
                                                fontFamily: 'MuseoSans',
                                                color: AppConst.lightBlack,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                fontStyle: FontStyle.normal,
                                                letterSpacing: -0.48,
                                              )),
                                          Text("Do you have Pets?",
                                              style: TextStyle(
                                                fontFamily: 'MuseoSans',
                                                color: AppConst.grey,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                fontStyle: FontStyle.normal,
                                              ))
                                        ],
                                      )
                                    ],
                                  ),
                                  Obx(
                                    () => GestureDetector(
                                      onTap: () {
                                        _myWalletcontroller
                                                .isPetfoodSelected.value =
                                            !_myWalletcontroller
                                                .isPetfoodSelected.value;
                                        if (_myWalletcontroller
                                                .isPetfoodSelected.value ==
                                            false) {
                                          _myWalletcontroller
                                              .walletbalanceOfSignup
                                              .value = (_myWalletcontroller
                                                  .walletbalanceOfSignup
                                                  .value) -
                                              (_myWalletcontroller
                                                  .PetfoodWalletAmount.value);
                                        } else {
                                          _myWalletcontroller
                                              .walletbalanceOfSignup
                                              .value = (_myWalletcontroller
                                                  .walletbalanceOfSignup
                                                  .value) +
                                              (_myWalletcontroller
                                                  .PetfoodWalletAmount.value);
                                        }
                                      },
                                      child: Container(
                                        height: 4.h,
                                        width: 22.w,
                                        decoration: BoxDecoration(
                                            color: _myWalletcontroller
                                                    .isPetfoodSelected.value
                                                ? AppConst.darkGreen
                                                : AppConst.white,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            border: Border.all(
                                                color: AppConst.darkGreen)),
                                        child: Center(
                                          child: Text(
                                              _myWalletcontroller
                                                      .isPetfoodSelected.value
                                                  ? "Selected"
                                                  : "Select",
                                              style: TextStyle(
                                                fontFamily: 'MuseoSans',
                                                color: _myWalletcontroller
                                                        .isPetfoodSelected.value
                                                    ? AppConst.white
                                                    : AppConst.darkGreen,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                              )),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          : SizedBox()
                      // Container(
                      //   height: 22.h,
                      //   width: Device.screenWidth,
                      //   child: ListView.builder(
                      //       scrollDirection: Axis.vertical,
                      //       itemCount: 2,
                      //       itemBuilder: (context, index) {
                      //         return Padding(
                      //           padding: EdgeInsets.only(
                      //               left: 4.w, right: 4.w, top: 2.h),
                      //           child: Row(
                      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //             children: [
                      //               Row(
                      //                 children: [
                      //                   CircleAvatar(
                      //                     radius: 30,
                      //                     backgroundImage: AssetImage(
                      //                         _myWalletcontroller
                      //                             .category[index].image),
                      //                   ),
                      //                   SizedBox(
                      //                     width: 4.w,
                      //                   ),
                      //                   Column(
                      //                     crossAxisAlignment:
                      //                         CrossAxisAlignment.start,
                      //                     children: [
                      //                       Text("Chicken & Meat",
                      //                           style: TextStyle(
                      //                             fontFamily: 'MuseoSans',
                      //                             color: AppConst.lightBlack,
                      //                             fontSize: 16,
                      //                             fontWeight: FontWeight.w500,
                      //                             fontStyle: FontStyle.normal,
                      //                             letterSpacing: -0.48,
                      //                           )),
                      //                       Text("Do you like Non-veg?",
                      //                           style: TextStyle(
                      //                             fontFamily: 'MuseoSans',
                      //                             color: AppConst.grey,
                      //                             fontSize: 12,
                      //                             fontWeight: FontWeight.w500,
                      //                             fontStyle: FontStyle.normal,
                      //                           ))
                      //                     ],
                      //                   )
                      //                 ],
                      //               ),
                      //               GestureDetector(
                      //                 onTap: () {},
                      //                 child: Container(
                      //                   height: 4.h,
                      //                   width: 20.w,
                      //                   decoration: BoxDecoration(
                      //                       color: AppConst.darkGreen,
                      //                       borderRadius: BorderRadius.circular(8)),
                      //                   child: Center(
                      //                     child: Text("Select",
                      //                         style: TextStyle(
                      //                           fontFamily: 'MuseoSans',
                      //                           color: AppConst.white,
                      //                           fontSize: 12,
                      //                           fontWeight: FontWeight.w700,
                      //                           fontStyle: FontStyle.normal,
                      //                         )),
                      //                   ),
                      //                 ),
                      //               )
                      //             ],
                      //           ),
                      //         );
                      //       }),
                      // ),
                    ],
                  ),
                )),

                // SizedBox(
                //   height: 9.h,
                // )
              ],
            ),
          )),
        ),
      ),
    );
  }
}
