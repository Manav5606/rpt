// import 'dart:async';
// import 'dart:developer';

// import 'package:customer_app/app/ui/pages/signIn/phone_authentication_screen.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:customer_app/app/constants/responsive.dart';
// import 'package:customer_app/app/controller/add_location_controller.dart';
// import 'package:customer_app/app/ui/pages/location_picker/address_model.dart';
// import 'package:customer_app/constants/app_const.dart';

// import 'package:customer_app/constants/string_constants.dart';
// import 'package:customer_app/controllers/userViewModel.dart';

// import 'package:customer_app/routes/app_list.dart';
// import 'package:customer_app/screens/home/controller/home_controller.dart';
// import 'package:customer_app/widgets/getstorge.dart';
// import 'package:customer_app/widgets/search_field.dart';
// import 'package:get/get.dart';
// import 'package:get/route_manager.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:sizer/sizer.dart';

// class MyAddressesScreen extends StatefulWidget {
//   const MyAddressesScreen({Key? key}) : super(key: key);

//   @override
//   _MyAddressesScreenState createState() => _MyAddressesScreenState();
// }

// class _MyAddressesScreenState extends State<MyAddressesScreen> {
//   final AddLocationController _addLocationController =
//       Get.put(AddLocationController());
//   final HomeController _homeController = Get.put(HomeController());

//   FocusNode focusNode = FocusNode();

//   Timer? _debounce;
//   bool selected = false;

//   @override
//   Widget build(BuildContext context) {
//     _addLocationController.isRecentAddress.value;
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         elevation: 0,
//         centerTitle: true,
//         title: Row(
//           children: [
//             InkWell(
//               onTap: () => Get.back(),
//               // Get.toNamed(AppRoutes.BaseScreen),
//               child: Icon(
//                 Icons.arrow_back,
//                 color: AppConst.black,
//                 size: SizeUtils.horizontalBlockSize * 7.2,
//               ),
//             ),
//             SizedBox(
//               width: 4.w,
//             ),
//             Text(
//               "My address",
//               style: TextStyle(
//                 color: AppConst.black,
//                 fontFamily: 'MuseoSans',
//                 fontWeight: FontWeight.w700,
//                 fontStyle: FontStyle.normal,
//                 fontSize: SizeUtils.horizontalBlockSize * 4.5,
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 1.h),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Obx(
//                 () => Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 2.w),
//                   child: SearchField(
//                     controller: _addLocationController.searchController,
//                     focusNode: focusNode,
//                     suffixIcon: (_addLocationController.searchText.value !=
//                                 null &&
//                             _addLocationController.searchText.value != "")
//                         ? GestureDetector(
//                             onTap: () {
//                               _addLocationController.searchController.clear();
//                               _addLocationController.predictions.clear();
//                             },
//                             child: Icon(
//                               Icons.close,

//                               color: AppConst.black, size: 2.5.h,
//                               // _addLocationController.searchText.value.isNotEmpty
//                               //     ? kPrimaryColor
//                               //     : kIconColor,
//                             ),
//                           )
//                         : null,
//                     prefixIcon: (_addLocationController.searchText.value !=
//                                 null &&
//                             _addLocationController.searchText.value != "")
//                         ? null
//                         : GestureDetector(
//                             onTap: () {
//                               _addLocationController.searchController.clear();
//                               _addLocationController.predictions.clear();
//                             },
//                             child: Icon(
//                               Icons.search,
//                               color: AppConst.black,
//                               size: 2.8.h,
//                             ),
//                           ),

//                     // onEditingComplete: () {
//                     //   focusNode.unfocus();
//                     //   log('onEditingComplete :-->>>>>>>>>>000');
//                     //   if (_addLocationController.searchController.text.isNotEmpty) {
//                     //     log('onEditingComplete :-->>>>>>>>>>111');
//                     //     _addLocationController.autoCompleteSearch(
//                     //         _addLocationController.searchController.text);
//                     //   } else {
//                     //     log('onEditingComplete :-->>>>>>>>>>222');
//                     //     _addLocationController.predictions.clear();
//                     //   }
//                     // },
//                     onChange: (String value) {
//                       _addLocationController.searchText.value = value;
//                       if (_debounce?.isActive ?? false) _debounce?.cancel();
//                       _debounce = Timer(const Duration(milliseconds: 500), () {
//                         if (value.isEmpty) {
//                           _addLocationController.predictions.clear();
//                         } else {
//                           _addLocationController.autoCompleteSearch(value);
//                         }
//                       });
//                     },
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(vertical: 1.h),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       height: 1,
//                       width: 40.w,
//                       color: AppConst.lightGrey,
//                     ),
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 3.w),
//                       child: Text(
//                         "or",
//                         style: TextStyle(
//                           color: AppConst.grey,
//                           fontFamily: 'MuseoSans',
//                           fontWeight: FontWeight.w500,
//                           fontStyle: FontStyle.normal,
//                           fontSize: SizeUtils.horizontalBlockSize * 4,
//                         ),
//                       ),
//                     ),
//                     Container(
//                       height: 1,
//                       width: 40.w,
//                       color: AppConst.lightGrey,
//                     )
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 2.w),
//                 child: Obx((() => (_addLocationController.isGpson.value == true)
//                     ? GestureDetector(
//                         onTap: () async {
//                           // Get.back();
//                           _addLocationController
//                               .getCurrentLocation2()
//                               .then((value) {
//                             if (value.latitude != 0.0 &&
//                                 value.longitude != 0.0) {
//                               Get.toNamed(AppRoutes.NewLocationScreen,
//                                   arguments: {
//                                     "isFalse": false,
//                                     "page": "home",
//                                   });
//                             }
//                           });
//                           _addLocationController
//                               .isFullAddressBottomSheet.value = false;
//                         },
//                         child: Padding(
//                           padding: EdgeInsets.only(left: 2.w, bottom: 1.h),
//                           child: Row(
//                             children: [
//                               Center(
//                                 child: Icon(
//                                   Icons.gps_fixed_rounded,
//                                   color: AppConst.green,
//                                   size: SizeUtils.horizontalBlockSize * 6,
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 2.w,
//                               ),
//                               Text(
//                                 "Use current location",
//                                 style: TextStyle(
//                                     color: AppConst.green,
//                                     fontFamily: 'MuseoSans',
//                                     fontStyle: FontStyle.normal,
//                                     fontSize:
//                                         SizeUtils.horizontalBlockSize * 3.8,
//                                     fontWeight: FontWeight.w500),
//                               ),
//                             ],
//                           ),
//                         ),
//                       )
//                     : InkWell(
//                         onTap: (() {
//                           _addLocationController.getCurrentLocation2();
//                         }),
//                         child: BottomWideButton(
//                           text: "Enable Location",
//                         ),
//                       ))),
//               ),
//               Container(
//                 height: 1.5.w,
//                 color: AppConst.veryLightGrey,
//               ),
//               Obx(
//                 () => _addLocationController.predictions.length == 0
//                     ? SizedBox()
//                     : Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.symmetric(
//                                 vertical: 1.h, horizontal: 3.w),
//                             child: Text(
//                               "Search your Address",
//                               style: TextStyle(
//                                 fontSize: SizeUtils.horizontalBlockSize * 4.2,
//                                 fontFamily: 'MuseoSans',
//                                 color: AppConst.black,
//                                 fontWeight: FontWeight.w700,
//                                 fontStyle: FontStyle.normal,
//                               ),
//                             ),
//                           ),
//                           _addLocationController.predictions.length == 0
//                               ? Text(
//                                   StringContants.searchResultsNotFound,
//                                 )
//                               : ListView.builder(
//                                   itemCount:
//                                       _addLocationController.predictions.length,
//                                   padding: EdgeInsets.zero,
//                                   shrinkWrap: true,
//                                   physics: NeverScrollableScrollPhysics(),
//                                   itemBuilder: (context, index) {
//                                     return Column(
//                                       children: [
//                                         InkWell(
//                                           highlightColor:
//                                               AppConst.highLightColor,
//                                           onTap: () async {
//                                             int valueIndex =
//                                                 _addLocationController
//                                                     .recentAddressDetails
//                                                     .indexWhere((element) =>
//                                                         element.placeId ==
//                                                         _addLocationController
//                                                             .predictions[index]
//                                                             .placeId);
//                                             if (valueIndex < 0) {
//                                               try {
//                                                 _addLocationController
//                                                     .savePredictionsList
//                                                     .clear();
//                                                 _addLocationController
//                                                     .savePredictionsList
//                                                     .add(_addLocationController
//                                                         .predictions[index]);
//                                                 for (var element
//                                                     in _addLocationController
//                                                         .savePredictionsList) {
//                                                   RecentAddressDetails
//                                                       recentAddressDetails =
//                                                       RecentAddressDetails(
//                                                           description: element
//                                                               .description,
//                                                           placeId:
//                                                               element.placeId);

//                                                   _addLocationController
//                                                       .recentAddressDetails
//                                                       .add(
//                                                           recentAddressDetails);
//                                                 }
//                                                 AppSharedPreference
//                                                     .setRecentAddress(
//                                                         _addLocationController
//                                                             .recentAddressDetails);
//                                                 _addLocationController
//                                                     .getSaveAddress();
//                                               } catch (e, st) {
//                                                 log('data : Error: $e $st');
//                                               }
//                                             }
//                                             await _addLocationController
//                                                 .getLatLngFromRecentAddress(
//                                                     _addLocationController
//                                                             .predictions[index]
//                                                             .placeId ??
//                                                         '');

//                                             Get.toNamed(
//                                                     AppRoutes.NewLocationScreen)
//                                                 ?.whenComplete(() =>
//                                                     Get.back(result: true));
//                                           },
//                                           child: Padding(
//                                             padding: EdgeInsets.symmetric(
//                                                 vertical: 1.h, horizontal: 2.w),
//                                             child: Row(
//                                               children: [
//                                                 Icon(
//                                                   Icons.location_on,
//                                                   color: AppConst.grey,
//                                                   size: 3.h,
//                                                 ),
//                                                 SizedBox(
//                                                   width: 2.w,
//                                                 ),
//                                                 Flexible(
//                                                   child: Text(
//                                                     _addLocationController
//                                                             .predictions[index]
//                                                             .description ??
//                                                         "",
//                                                     style: TextStyle(
//                                                         fontSize: SizeUtils
//                                                                 .horizontalBlockSize *
//                                                             3.8,
//                                                         fontFamily: 'MuseoSans',
//                                                         color: AppConst.grey,
//                                                         fontWeight:
//                                                             FontWeight.w600,
//                                                         fontStyle:
//                                                             FontStyle.normal),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     );
//                                   },
//                                 ),
//                         ],
//                       ),
//               ),
//               Obx(
//                 () => _addLocationController.predictions.length == 0
//                     ? Padding(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: 3.w, vertical: 1.h),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             (_addLocationController
//                                         .userModel?.addresses?.isNotEmpty ??
//                                     false)
//                                 ? Padding(
//                                     padding:
//                                         EdgeInsets.symmetric(vertical: 1.h),
//                                     child: Text(
//                                       StringContants.savedAddresses,
//                                       style: TextStyle(
//                                         fontSize:
//                                             SizeUtils.horizontalBlockSize * 4.2,
//                                         fontFamily: 'MuseoSans',
//                                         color: AppConst.black,
//                                         fontWeight: FontWeight.w700,
//                                         fontStyle: FontStyle.normal,
//                                       ),
//                                     ),
//                                   )
//                                 : SizedBox(),
//                             (_addLocationController
//                                         .userModel?.addresses?.isNotEmpty ??
//                                     false)
//                                 ? ListView.separated(
//                                     padding: EdgeInsets.zero,
//                                     shrinkWrap: true,
//                                     physics: NeverScrollableScrollPhysics(),
//                                     itemCount: (_addLocationController
//                                             .userModel?.addresses?.length ??
//                                         0),

//                                     // _addLocationController
//                                     //         .isSeeMoreEnable.value
//                                     //     ? _addLocationController
//                                     //             .userModel?.addresses?.length ??
//                                     //         0
//                                     //     : (_addLocationController
//                                     //             .userModel?.addresses?.length ??
//                                     //         0),
//                                     // <
//                                     //         3
//                                     //     ? _addLocationController
//                                     //             .userModel?.addresses?.length ??
//                                     //         0
//                                     //     : 3,
//                                     itemBuilder: (context, index) {
//                                       return
//                                           // Obx(
//                                           //   () =>
//                                           InkWell(
//                                         highlightColor: AppConst.highLightColor,
//                                         onTap: () async {
//                                           _addLocationController
//                                               .currentSelectValue.value = index;
//                                           _homeController.isLoading.value =
//                                               true;
//                                           Get.offAllNamed(AppRoutes.BaseScreen);

//                                           _addLocationController.userAddress
//                                               .value = _addLocationController
//                                                   .userModel
//                                                   ?.addresses?[index]
//                                                   .address ??
//                                               '';
//                                           _addLocationController
//                                               .userAddressTitle
//                                               .value = _addLocationController
//                                                   .userModel
//                                                   ?.addresses?[index]
//                                                   .title ??
//                                               '';
//                                           await UserViewModel.setLocation(
//                                               LatLng(
//                                                   _addLocationController
//                                                           .userModel
//                                                           ?.addresses?[index]
//                                                           .location
//                                                           ?.lat ??
//                                                       0.0,
//                                                   _addLocationController
//                                                           .userModel
//                                                           ?.addresses?[index]
//                                                           .location
//                                                           ?.lng ??
//                                                       0.0),
//                                               _addLocationController.userModel
//                                                   ?.addresses?[index].id);
//                                           _homeController.pageNumber = 1;
//                                           _homeController.isPageAvailable =
//                                               true;
//                                           _homeController.isPageLoading.value =
//                                               false;
//                                           _homeController
//                                               .homePageFavoriteShopsList
//                                               .clear();
//                                           await _homeController
//                                               .getHomePageFavoriteShops();
//                                           await _homeController
//                                               .getAllCartsData();
//                                           _homeController
//                                               .getHomePageFavoriteShopsModel
//                                               .refresh();
//                                           _homeController.isLoading.value =
//                                               false;
//                                         },
//                                         child: Column(
//                                           children: [
//                                             ListTile(
//                                               contentPadding:
//                                                   EdgeInsets.symmetric(
//                                                       vertical: 1.h),
//                                               leading: Padding(
//                                                 padding: EdgeInsets.only(
//                                                     bottom: 2.h, left: 3.w),
//                                                 child: Icon(
//                                                   Icons.home,
//                                                   size: 3.h,
//                                                   color: AppConst.grey,
//                                                 ),
//                                               ),
//                                               title: Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   Text(
//                                                     _addLocationController
//                                                             .userModel
//                                                             ?.addresses?[index]
//                                                             .title ??
//                                                         '',
//                                                     style: TextStyle(
//                                                         fontFamily: 'MuseoSans',
//                                                         color: AppConst.black,
//                                                         fontWeight:
//                                                             FontWeight.w500,
//                                                         fontStyle:
//                                                             FontStyle.normal,
//                                                         fontSize: SizeUtils
//                                                                 .horizontalBlockSize *
//                                                             4),
//                                                   ),
//                                                   Text(
//                                                     "${_addLocationController.userModel?.addresses?[index].house ?? ''} ${_addLocationController.userModel?.addresses?[index].address ?? ''}",
//                                                     maxLines: 2,
//                                                     overflow:
//                                                         TextOverflow.ellipsis,
//                                                     style: TextStyle(
//                                                         fontFamily: 'MuseoSans',
//                                                         color: AppConst.grey,
//                                                         fontWeight:
//                                                             FontWeight.w500,
//                                                         fontStyle:
//                                                             FontStyle.normal,
//                                                         fontSize: SizeUtils
//                                                                 .horizontalBlockSize *
//                                                             3.5),
//                                                   ),
//                                                 ],
//                                               ),
//                                               trailing: PopupMenuButton(
//                                                 shape: RoundedRectangleBorder(
//                                                   borderRadius:
//                                                       BorderRadius.only(
//                                                     bottomLeft:
//                                                         Radius.circular(8.0),
//                                                     bottomRight:
//                                                         Radius.circular(8.0),
//                                                     topLeft:
//                                                         Radius.circular(8.0),
//                                                     topRight:
//                                                         Radius.circular(8.0),
//                                                   ),
//                                                 ),
//                                                 itemBuilder: (ctx) {
//                                                   return [
//                                                     _buildPopupMenuItem(
//                                                       'Edit',
//                                                       Icons.edit,
//                                                       () async {
//                                                         await Future.delayed(
//                                                             Duration(
//                                                                 milliseconds:
//                                                                     200));
//                                                         Get.toNamed(
//                                                             AppRoutes
//                                                                 .EditAddressScreen,
//                                                             arguments: {
//                                                               'addresses':
//                                                                   _addLocationController
//                                                                       .userModel
//                                                                       ?.addresses?[index]
//                                                             })?.whenComplete(
//                                                             () => setState(
//                                                                 () {}));
//                                                       },
//                                                     ),
//                                                     if ((_addLocationController
//                                                                     .userModel
//                                                                     ?.addresses
//                                                                     ?.length ??
//                                                                 0) >
//                                                             1 &&
//                                                         _addLocationController
//                                                                 .userAddress
//                                                                 .value !=
//                                                             _addLocationController
//                                                                 .userModel
//                                                                 ?.addresses?[
//                                                                     index]
//                                                                 .address)
//                                                       _buildPopupMenuItem(
//                                                           'Delete',
//                                                           Icons.delete,
//                                                           () async {
//                                                         await _addLocationController
//                                                             .deleteCustomerAddress(
//                                                                 _addLocationController
//                                                                         .userModel
//                                                                         ?.addresses?[
//                                                                             index]
//                                                                         .id ??
//                                                                     '');

//                                                         _addLocationController
//                                                             .userModel
//                                                             ?.addresses
//                                                             ?.remove(_addLocationController
//                                                                     .userModel
//                                                                     ?.addresses?[
//                                                                 index]);
//                                                         UserViewModel.setUser(
//                                                             _addLocationController
//                                                                 .userModel!);
//                                                         setState(() {});
//                                                       }),
//                                                   ];
//                                                 },
//                                               ),
//                                             ),
//                                             // if (_addLocationController
//                                             //         .currentSelectValue.value ==
//                                             //     index)
//                                             //   GestureDetector(
//                                             //     onTap: () async {
//                                             //       _homeController
//                                             //           .isLoading.value = true;
//                                             //       Get.back();

//                                             //       _homeController
//                                             //               .userAddress.value =
//                                             //           _addLocationController
//                                             //                   .userModel
//                                             //                   ?.addresses?[
//                                             //                       index]
//                                             //                   .address ??
//                                             //               '';
//                                             //       _homeController
//                                             //               .userAddressTitle
//                                             //               .value =
//                                             //           _addLocationController
//                                             //                   .userModel
//                                             //                   ?.addresses?[
//                                             //                       index]
//                                             //                   .title ??
//                                             //               '';
//                                             //       await UserViewModel.setLocation(
//                                             //           LatLng(
//                                             //               _addLocationController
//                                             //                       .userModel
//                                             //                       ?.addresses?[
//                                             //                           index]
//                                             //                       .location
//                                             //                       ?.lat ??
//                                             //                   0.0,
//                                             //               _addLocationController
//                                             //                       .userModel
//                                             //                       ?.addresses?[
//                                             //                           index]
//                                             //                       .location
//                                             //                       ?.lng ??
//                                             //                   0.0),
//                                             //           _addLocationController
//                                             //               .userModel
//                                             //               ?.addresses?[index]
//                                             //               .id);
//                                             //       _homeController.pageNumber =
//                                             //           1;
//                                             //       _homeController
//                                             //           .isPageAvailable = true;
//                                             //       _homeController.isPageLoading
//                                             //           .value = false;
//                                             //       _homeController
//                                             //           .homePageFavoriteShopsList
//                                             //           .clear();
//                                             //       await _homeController
//                                             //           .getHomePageFavoriteShops();
//                                             //       await _homeController
//                                             //           .getAllCartsData();
//                                             //       _homeController
//                                             //           .getHomePageFavoriteShopsModel
//                                             //           .refresh();

//                                             //       _homeController
//                                             //           .isLoading.value = false;
//                                             //     },
//                                             //     child: Container(
//                                             //       height: SizeUtils
//                                             //               .horizontalBlockSize *
//                                             //           12,
//                                             //       decoration: BoxDecoration(
//                                             //         color: AppConst
//                                             //             .kSecondaryColor,
//                                             //         borderRadius:
//                                             //             BorderRadius.circular(
//                                             //                 6),
//                                             //       ),
//                                             //       child: Center(
//                                             //           child: Text(
//                                             //         "Choose Address",
//                                             //         style: TextStyle(
//                                             //             color: AppConst.white,
//                                             //             fontSize: SizeUtils
//                                             //                     .horizontalBlockSize *
//                                             //                 4),
//                                             //       )),
//                                             //     ),
//                                             //   )
//                                             // else
//                                             //   SizedBox(),
//                                           ],
//                                         ),
//                                         // ),
//                                       );
//                                     },
//                                     separatorBuilder: (context, index) {
//                                       return Divider(height: 0);
//                                     },
//                                   )
//                                 : Center(
//                                     child: Text(
//                                       'No Saved Addresses',
//                                     ),
//                                   ),
//                           ],
//                         ),
//                       )
//                     : SizedBox(),
//               ),
//               //
//               SizedBox(
//                 height: 1.h,
//               ),
//               Divider(
//                 height: 1.h,
//                 // color: AppConst.black,
//               ),
//             ],
//           ),
//         ),
//       ),
//       // body: SafeArea(
//       //   child: Padding(
//       //     padding: const EdgeInsets.symmetric(horizontal: 10.0),
//       //     child: Column(
//       //       crossAxisAlignment: CrossAxisAlignment.start,
//       //       children: [
//       //         IconButton(
//       //           padding: EdgeInsets.symmetric(vertical: 10),
//       //           visualDensity: VisualDensity(horizontal: -4),
//       //           constraints: BoxConstraints.tightFor(),
//       //           splashRadius: 15,
//       //           onPressed: () {
//       //             Navigator.pop(context);
//       //           },
//       //           icon: Icon(Icons.arrow_back),
//       //         ),
//       //         SizedBox(
//       //           height: 10,
//       //         ),
//       //         Text(
//       //           StringContants.myAddresses,
//       //           style: TextStyle(
//       //             fontSize: 20.sp,
//       //           ),
//       //         ),
//       //         SizedBox(
//       //           height: 10,
//       //         ),
//       //         Row(
//       //           mainAxisAlignment: MainAxisAlignment.start,
//       //           children: [
//       //             Padding(
//       //               padding: EdgeInsets.zero,
//       //               child: Icon(
//       //                 Icons.add,
//       //                 color: kPrimaryColor,
//       //               ),
//       //             ),
//       //             Text(
//       //               StringContants.addAddresses,
//       //               style: TextStyle(
//       //                 fontSize: 12.sp,
//       //               ),
//       //             ),
//       //           ],
//       //         ),
//       //         Divider(),
//       //       ],
//       //     ),
//       //   ),
//       // ),
//     );
//   }

//   PopupMenuItem _buildPopupMenuItem(
//       String title, IconData iconData, VoidCallback? onTap) {
//     return PopupMenuItem(
//       onTap: onTap,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Icon(
//             iconData,
//             color: Colors.grey,
//             size: 3.h,
//           ),
//           Text(
//             title,
//             style: TextStyle(
//                 fontFamily: 'MuseoSans',
//                 color: AppConst.black,
//                 fontWeight: FontWeight.w600,
//                 fontStyle: FontStyle.normal,
//                 fontSize: SizeUtils.horizontalBlockSize * 3.5),
//           ),
//         ],
//       ),
//     );
//   }
// }
