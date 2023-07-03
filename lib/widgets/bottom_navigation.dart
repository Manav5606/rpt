import 'package:badges/badges.dart' as badge;
import 'package:customer_app/app/controller/signInScreenController.dart';
import 'package:customer_app/app/data/provider/hive/hive.dart';
import 'package:customer_app/controllers/userViewModel.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/screens/wallet/controller/paymentController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/constants/string_constants.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

class BottomNavigation extends StatelessWidget {
  static ValueNotifier<int> pageIndex = ValueNotifier(0);

  final SignInScreenController _signinContoller =
      Get.put(SignInScreenController());
  final PaymentController _paymentController = Get.put(PaymentController());

  final BuildContext context;

  BottomNavigation({Key? key, required this.context}) : super(key: key);

  void _onItemTapped(int index) {
    pageIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: pageIndex,
        builder: (context, int value, child) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppConst.white,
            currentIndex: value,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            onTap: _onItemTapped,
            unselectedItemColor: AppConst.darkGrey,
            // iconSize: 24,
            selectedItemColor: Color(0xff09a56b), //AppConst.green,
            selectedLabelStyle: TextStyle(
              // height: 1,
              wordSpacing: -0.5,
              fontFamily: 'MuseoSans',
              fontSize:
                  (SizerUtil.deviceType == DeviceType.tablet) ? 7.sp : 7.8.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.5,
              fontStyle: FontStyle.normal,
            ),
            unselectedLabelStyle: TextStyle(
              fontFamily: 'MuseoSans',
              fontSize:
                  (SizerUtil.deviceType == DeviceType.tablet) ? 7.sp : 7.8.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.5,
              // height: 1,
              wordSpacing: -0.5,
              fontStyle: FontStyle.normal,
            ),
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                label: StringContants.Home,
                icon: (value == 0)
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Icon(
                          Icons.home_outlined,
                          // Icons.home,
                          size: 3.h,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Icon(
                          Icons.home_outlined,
                          size: 3.h,
                        ),
                      ),
              ),
              BottomNavigationBarItem(
                label: StringContants.chats,
                icon:
                    // ((UserViewModel.unreadCount.value != 0 &&
                    //         value != 1 &&
                    //         value != 2 &&
                    //         value != 3)
                    //     ? Badge(
                    //         badgeColor: AppConst.blue,
                    //         badgeContent:
                    //             Text("${UserViewModel.unreadCount.value}"),
                    //         child: (value == 1)
                    //             ? Icon(
                    //                 CupertinoIcons.chat_bubble_2_fill,
                    //                 size: 3.5.h,
                    //               )
                    //             : Icon(
                    //                 CupertinoIcons.chat_bubble_2,
                    //                 size: 3.5.h,
                    //               ),
                    //       )
                    //     :

                    badge.Badge(
                  badgeColor: Color(0xffff2e56),

                  position: badge.BadgePosition.topEnd(top: -14, end: -8),

                  //  Color(0xff5764da),
                  badgeContent: Text(""),
                  child: (value == 1)
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Icon(
                            CupertinoIcons.chat_bubble,
                            // CupertinoIcons.chat_bubble_fill,
                            size: 2.5.h,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Icon(
                            CupertinoIcons.chat_bubble,
                            size: 2.5.h,
                          ),
                        ),
                  // )
                ),
              ),
              BottomNavigationBarItem(
                  label: "",
                  icon:

                      //  (value == 0)
                      //     ?
                      GestureDetector(
                    onTap: () {
                      (value == 2);
                      Get.bottomSheet(
                          // titlePadding: EdgeInsets.symmetric(
                          //     vertical: 1.h, horizontal: 2.w),
                          // contentPadding: EdgeInsets.symmetric(
                          //     vertical: 1.h, horizontal: 2.w),
                          // title: "Choose any one",
                          // titleStyle: TextStyle(
                          //   fontFamily: 'MuseoSans',
                          //   color: AppConst.black,
                          //   fontSize: SizeUtils.horizontalBlockSize * 4,
                          //   fontWeight: FontWeight.w700,
                          //   fontStyle: FontStyle.normal,
                          // ),

                          Container(
                        width: 90.w,
                        height: 30.h,
                        decoration: BoxDecoration(color: AppConst.white),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 1.5.h),
                              child: Text("Select any one option",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: 'MuseoSans',
                                    color: AppConst.black,
                                    fontSize: (SizerUtil.deviceType ==
                                            DeviceType.tablet)
                                        ? 10.sp
                                        : 12.5.sp,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 0.5.h),
                              child: Container(
                                width: 80.w,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 1,
                                      width: 18.w,
                                      color: AppConst.lightGrey,
                                    ),
                                    Container(
                                      height: 1,
                                      width: 18.w,
                                      color: AppConst.lightGrey,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Text("access scan and pay funtions",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: 'MuseoSans',
                                  color: AppConst.black,
                                  fontSize: (SizerUtil.deviceType ==
                                          DeviceType.tablet)
                                      ? 8.sp
                                      : 10.sp,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                )),
                            SizedBox(
                              height: 2.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    InkWell(
                                        onTap: () async {
                                          // await _homeController.checkLocationPermission();
                                          // if (_homeController.checkPermission.value) {
                                          //   Position position = await Geolocator.getCurrentPosition();
                                          //   _paymentController.latLng = LatLng(position.latitude, position.longitude);
                                          //   await _paymentController.getScanReceiptPageNearMeStoresData();
                                          //   Get.back();
                                          //   (_paymentController.getRedeemCashInStorePageData.value?.error ?? false)
                                          //       ? null
                                          //       : Get.toNamed(AppRoutes.ScanRecipetSearch);
                                          // } else {
                                          _paymentController.latLng = LatLng(
                                              UserViewModel.currentLocation
                                                  .value.latitude,
                                              UserViewModel.currentLocation
                                                  .value.longitude);
                                          await _paymentController
                                              .getScanReceiptPageNearMeStoresData();
                                          Get.back();
                                          (_paymentController
                                                      .getRedeemCashInStorePageData
                                                      .value
                                                      ?.error ??
                                                  false)
                                              ? null
                                              : Get.toNamed(
                                                  AppRoutes.ScanRecipetSearch);
                                          // }
                                        },
                                        child: SelectOneCard(
                                          function: "Scan Receipt",
                                          color: Color(0xFFC6E0DB),
                                          cardWidth: 44,
                                          imagepath: "assets/images/Scan.png",
                                          text:
                                              "Scan Stores \nReceipt to avail \ncashbacks",
                                        )

                                        // Container(
                                        //   padding: EdgeInsets.symmetric(
                                        //       vertical: 1.h, horizontal: 2.w),
                                        //   width: 30.w,
                                        //   height: 18.h,
                                        //   decoration: new BoxDecoration(
                                        //       color: AppConst.veryLightGrey,
                                        //       borderRadius:
                                        //           BorderRadius.circular(10)),
                                        //   child: Column(
                                        //     mainAxisAlignment:
                                        //         MainAxisAlignment.spaceEvenly,
                                        //     children: [
                                        //       SizedBox(
                                        //         height: 1.h,
                                        //       ),
                                        //       SizedBox(
                                        //         height: 8.h,
                                        //         child: Image(
                                        //           image: AssetImage(
                                        //             'assets/images/Scan.png',
                                        //           ),
                                        //         ),
                                        //       ),
                                        //       Text("Scan Receipt",
                                        //           maxLines: 1,
                                        //           style: TextStyle(
                                        //             fontFamily: 'MuseoSans',
                                        //             color: AppConst.black,
                                        //             fontSize: SizeUtils
                                        //                     .horizontalBlockSize *
                                        //                 3.8,
                                        //             fontWeight: FontWeight.w500,
                                        //             fontStyle: FontStyle.normal,
                                        //           ))
                                        //     ],
                                        //   ),
                                        // )

                                        // CircleAvatar(
                                        //   radius: 10.w,
                                        //   foregroundImage: NetworkImage(
                                        //       "https://img.freepik.com/free-vector/tiny-people-using-qr-code-online-payment-isolated-flat-illustration_74855-11136.jpg?t=st=1649328483~exp=1649329083~hmac=5171d5a26cfeb0c063c6afc1f8af8cb4460c207134f830b2ff0d833279d8bf7e&w=1380"),
                                        // ),
                                        ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    InkWell(
                                        onTap: () async {
                                          _paymentController.isLoading.value =
                                              true;
                                          // await _homeController.checkLocationPermission();
                                          // if (_homeController.checkPermission.value) {
                                          //   Position position = await Geolocator.getCurrentPosition();
                                          //   _paymentController.latLng = LatLng(position.latitude, position.longitude);
                                          //   await _paymentController.getRedeemCashInStorePage();
                                          //   Get.back();
                                          //   (_paymentController.getRedeemCashInStorePageData.value?.error ?? false)
                                          //       ? null
                                          //       : Get.toNamed(AppRoutes.LoyaltyCardScreen);
                                          // } else {
                                          _paymentController.latLng = LatLng(
                                              UserViewModel.currentLocation
                                                  .value.latitude,
                                              UserViewModel.currentLocation
                                                  .value.longitude);
                                          await _paymentController
                                              .getRedeemCashInStorePage();
                                          Get.back();
                                          (_paymentController
                                                      .getRedeemCashInStorePageData
                                                      .value
                                                      ?.error ??
                                                  false)
                                              ? null
                                              : Get.toNamed(
                                                  AppRoutes.LoyaltyCardScreen);
                                          // }
                                        },
                                        child: SelectOneCard(
                                          function: "Pay to store",
                                          color: Color(0xFFF2E9F7),
                                          cardWidth: 52,
                                          imagepath: "assets/images/Redeem.png",
                                          text:
                                              "Redeem Money \nPay at store \nthrough wallet.",
                                        )

                                        //  Container(
                                        //   padding: EdgeInsets.symmetric(
                                        //       vertical: 1.h, horizontal: 2.w),
                                        //   width: 30.w,
                                        //   height: 18.h,
                                        //   decoration: new BoxDecoration(
                                        //       color: AppConst.veryLightGrey,
                                        //       borderRadius:
                                        //           BorderRadius.circular(10)),
                                        //   child: Column(
                                        //     mainAxisAlignment:
                                        //         MainAxisAlignment.spaceEvenly,
                                        //     children: [
                                        //       SizedBox(
                                        //         height: 1.h,
                                        //       ),
                                        //       SizedBox(
                                        //         height: 8.h,
                                        //         child: Image(
                                        //           image: AssetImage(
                                        //             'assets/images/Redeem.png',
                                        //           ),
                                        //         ),
                                        //       ),
                                        //       Text("Pay To Store",
                                        //           maxLines: 1,
                                        //           style: TextStyle(
                                        //             fontFamily: 'MuseoSans',
                                        //             color: AppConst.black,
                                        //             fontSize: SizeUtils
                                        //                     .horizontalBlockSize *
                                        //                 3.8,
                                        //             fontWeight: FontWeight.w500,
                                        //             fontStyle: FontStyle.normal,
                                        //           ))
                                        //     ],
                                        //   ),
                                        // )
                                        // CircleAvatar(
                                        //   radius: 10.w,
                                        //   backgroundColor: Colors.white,
                                        //   foregroundImage: NetworkImage(
                                        //       "https://img.freepik.com/free-vector/successful-financial-operation-business-accounting-invoice-report-happy-people-with-tax-receipt-duty-paying-money-savings-cash-income-vector-isolated-concept-metaphor-illustration_335657-2188.jpg?t=st=1649328544~exp=1649329144~hmac=635d4a3527c71f715e710f64fa046e8faf59de565b6be17f34a03ef3d5d8fa4d&w=826"),
                                        // ),
                                        ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xffffa300), shape: BoxShape.circle),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(CupertinoIcons.camera,
                              size: 3.h, color: AppConst.white),
                        ),
                      ),
                    ),
                  )
                  // :
                  // Container(
                  //     decoration: BoxDecoration(
                  //         color: Color(0xffffa300), shape: BoxShape.circle),
                  //     child: Center(
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Icon(
                  //           CupertinoIcons.camera,
                  //           size: 3.h,
                  //           color: AppConst.white,
                  //         ),
                  //       ),
                  //     ),
                  // )
                  ),
              BottomNavigationBarItem(
                  label: StringContants.wallet,
                  icon: (value == 3)
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Icon(
                            Icons.wallet_rounded,
                            size: 3.h,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Icon(
                            Icons.wallet_rounded,
                            size: 3.h,
                          ),
                        )),
              BottomNavigationBarItem(
                  label: StringContants.myAccount,
                  icon: (value == 4)
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Icon(
                            CupertinoIcons.person,
                            // CupertinoIcons.person_fill,
                            size: 2.8.h,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Icon(
                            CupertinoIcons.person,
                            size: 2.8.h,
                          ),
                        )),
            ],
          );
        });
  }
}

class SelectOneCard extends StatelessWidget {
  String? function;
  String? text;
  String? imagepath;
  Color? color;
  double? cardWidth;
  SelectOneCard(
      {Key? key,
      this.cardWidth,
      this.color,
      this.function,
      this.imagepath,
      this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 3.w, top: 0.5.h),
      width: (cardWidth ?? 44).w,
      height: 18.h,
      decoration: new BoxDecoration(
          color: color ?? Color(0xffffe4bd),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 1.h,
          ),
          Text(function ?? "Scan",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'MuseoSans',
                color: Color(0xff442e00),
                fontSize:
                    (SizerUtil.deviceType == DeviceType.tablet) ? 9.sp : 11.sp,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
              )),
          SizedBox(
            height: 0.5.h,
          ),
          Text(text ?? "Scan Stores \nReceipt to avail \ncashbacks",
              // : "Give Customer a \nRefund on their \nrequest.",
              maxLines: 3,
              style: TextStyle(
                fontFamily: 'MuseoSans',
                color: Color(0xff442e00),
                fontSize:
                    (SizerUtil.deviceType == DeviceType.tablet) ? 8.sp : 10.sp,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
              )),
          Padding(
            padding: EdgeInsets.only(right: 3.w, bottom: 1.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 5.4.h,
                  child: Image(
                    image: AssetImage(
                      imagepath ?? 'assets/images/Scan.png',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
