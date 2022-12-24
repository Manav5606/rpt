// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:customer_app/app/data/model/user_model.dart';
// import 'package:customer_app/constants/app_const.dart';
// import 'package:customer_app/constants/value_constants.dart';
// import 'package:customer_app/controllers/userViewModel.dart';
// import 'package:customer_app/data/repositories/main_repo.dart';
// import 'package:customer_app/screens/authentication/repository/maprepo.dart';
// import 'package:customer_app/screens/authentication/view/widgets/waitingForMapLoadingWIdget.dart';
// import 'package:customer_app/screens/home/views/all_offers_near_you.dart';
// import 'package:customer_app/utils/ui_spacing_helper.dart';
// import 'package:customer_app/widgets/copied/21_manage_address.dart';
// import 'package:customer_app/widgets/copied/confirm_dialog.dart';
// import 'package:customer_app/widgets/gradient_button.dart';
// import 'package:customer_app/widgets/modal_sheet.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class LocationPickerScreen extends StatefulWidget {
//   const LocationPickerScreen({Key? key}) : super(key: key);

//   @override
//   _LocationPickerScreenState createState() => _LocationPickerScreenState();
// }

// class _LocationPickerScreenState extends State<LocationPickerScreen> {
//   final TextEditingController _textEditingController = TextEditingController();
//   final TextEditingController _houseEditingController = TextEditingController();
//   final TextEditingController _apartmentEditingController = TextEditingController();
//   final TextEditingController _directionToReachEditingController = TextEditingController();
//   Completer<GoogleMapController> _controller = Completer();
//   late CameraPosition initialCameraPosition;
//   late LatLng currentPosition;
//   late BitmapDescriptor markerImage;
//   Set<Marker> gMarker = Set<Marker>();
//   bool loading = true;

//   //Bottom Sheet
//   String selected = AddressType.HOME;

//   getData() async {
//     markerImage = await MapRepo.getPinIcon();
//     Position position = await MapRepo.determinePosition();
//     initialCameraPosition = CameraPosition(
//       target: LatLng(position.latitude, position.longitude),
//       zoom: 18,
//     );
//     currentPosition = LatLng(position.latitude, position.longitude);

//     await addMarker(LatLng(position.latitude, position.longitude));
//     setState(() {
//       loading = false;
//     });
//   }

//   addMarker(LatLng latLng) async {
//     gMarker.clear();
//     gMarker.add(Marker(markerId: MarkerId('gMarker'), position: latLng, icon: markerImage));
//     Placemark? placemarks = await MapRepo.getAddressFromLatLng(latLng);
//     if (placemarks != null) {
//       setState(() {
//         if (placemarks.thoroughfare!.isNotEmpty && placemarks.subLocality!.isNotEmpty) {
//           _textEditingController.text = "${placemarks.thoroughfare!}, ${placemarks.subLocality!} ${placemarks.subAdministrativeArea}";
//         } else if (placemarks.thoroughfare!.isEmpty) {
//           _textEditingController.text = "${placemarks.subLocality!}, ${placemarks.subAdministrativeArea}";
//         } else if (placemarks.subLocality!.isEmpty) {
//           _textEditingController.text = "${placemarks.thoroughfare!}, ${placemarks.subAdministrativeArea}";
//         }
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     getData();
//   }

//   setNewLocation(LatLng latLng) async {
//     currentPosition = latLng;
//     await addMarker(latLng);
//     await _updateCameraPosition(latLng);
//     setState(() {});
//   }

//   _updateCameraPosition(LatLng loc) async {
//     currentPosition = loc;
//     CameraPosition cPosition = CameraPosition(
//       zoom: 18,
//       tilt: 1,
//       target: LatLng(loc.latitude, loc.longitude),
//     );
//     GoogleMapController controller = await _controller.future;
//     await controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
//   }

//   getToUserLocation() async {
//     Position pos = await MapRepo.determinePosition();

//     await addMarker(LatLng(pos.latitude, pos.longitude));
//     await _updateCameraPosition(LatLng(pos.latitude, pos.longitude));

//     setState(() {});
//   }

//   // searchFromTxtField(String value) async {
//   //   Address address = await MapRepo.getAddressFromAddress(value);
//   //   await addMarker(
//   //       LatLng(address.coordinates.latitude, address.coordinates.longitude));
//   //   await _updateCameraPosition(
//   //       LatLng(address.coordinates.latitude, address.coordinates.longitude));
//   //   setState(() {});
//   //   _textEditingController.text = address.addressLine;
//   //   FocusScope.of(context).unfocus();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: loading
//           ? WaitingMapWidget()
//           : Stack(
//               children: [
//                 Container(
//                   height: MediaQuery.of(context).size.height,
//                   width: MediaQuery.of(context).size.width,
//                   child: GoogleMap(
//                     markers: gMarker,
//                     zoomControlsEnabled: false,
//                     mapType: MapType.normal,
//                     compassEnabled: false,
//                     initialCameraPosition: initialCameraPosition,
//                     onTap: setNewLocation,
//                     myLocationButtonEnabled: true,
//                     mapToolbarEnabled: true,
//                     onMapCreated: (GoogleMapController controller) {
//                       _controller = Completer();
//                       _controller.complete(controller);
//                     },
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 0,
//                   right: 0,
//                   left: 0,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           getToUserLocation();
//                         },
//                         child: Container(
//                           height: 35,
//                           width: 35,
//                           margin: EdgeInsets.only(right: 10),
//                           decoration: BoxDecoration(
//                               color: AppConst.white,
//                               borderRadius: BorderRadius.circular(4),
//                               border: Border.all(color: AppConst.lightGrey, width: 1),
//                               boxShadow: [AppConst.shadowBasic]),
//                           child: Center(
//                             child: Icon(
//                               Icons.gps_fixed_rounded,
//                               color: AppConst.grey,
//                               size: 18,
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                       ),
//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                         decoration: BoxDecoration(
//                             color: AppConst.white,
//                             borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(12)),
//                             boxShadow: [BoxShadow(offset: Offset(0, 1), color: AppConst.lightGrey, blurRadius: 10, spreadRadius: 2)]),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Delivery Location',
//                               style: AppConst.titleText1,
//                             ),
//                             SizedBox(
//                               height: 16.0,
//                             ),
//                             getFormFields(),
//                             SizedBox(
//                               height: 24.0,
//                             ),
//                             Text(
//                               'Tag this location',
//                               style: AppConst.header,
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 tagLocationSelectionCard('Home'),
//                                 tagLocationSelectionCard('Work'),
//                                 tagLocationSelectionCard('Hotel'),
//                                 tagLocationSelectionCard('Offer'),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 20,
//                             ),
//                             GradientButton(
//                               height: 50,
//                               label: 'Confirm Location and Proceed',
//                               fontStyle: TextStyle(fontWeight: FontWeight.w400, letterSpacing: 0.3, color: AppConst.white, fontSize: 14),
//                               onTap: () async {
//                                 try {
//                                   setState(() => loading = true);

//                                   bool error = await MapRepo.addCustomerAddress(
//                                     address: _textEditingController.text,
//                                     title: selected,
//                                     lat: currentPosition.latitude,
//                                     lng: currentPosition.longitude,
//                                     apartment: _apartmentEditingController.text,
//                                     house: _houseEditingController.text,
//                                     directionToReach: _directionToReachEditingController.text,
//                                   );

//                                   if (error) {
//                                     print("Error ============== > $error");
//                                   } else {
//                                     onLocationSetSuccess();
//                                   }

//                                   if (error) {
//                                     //address limit reached. Ask to replace the address,
//                                     SeeyaModalSheet(
//                                         title: "Replace Address",
//                                         child: ManageAddress(
//                                           showAddAddress: false,
//                                           onAddressSelect: (address) {
//                                             SeeyaConfirmDialog(
//                                                 title: "Replace your address",
//                                                 subTitle: "Are you sure you want to replace your address?",
//                                                 onCancel: () {
//                                                   Get.back();
//                                                 },
//                                                 onConfirm: () async {
//                                                   //close the dialog
//                                                   Get.back();

//                                                   //close the modal sheet
//                                                   Get.back();

//                                                   try {
//                                                     setState(() => loading = true);

//                                                     await MapRepo.replaceCustomerAddress(
//                                                       id: address.id!,
//                                                       title: selected,
//                                                       address: _textEditingController.text,
//                                                       lat: currentPosition.latitude,
//                                                       lng: currentPosition.longitude,
//                                                       apartment: _apartmentEditingController.text,
//                                                       house: _houseEditingController.text,
//                                                       directionToReach: _directionToReachEditingController.text,
//                                                     );

//                                                     onLocationSetSuccess();
//                                                   } finally {
//                                                     setState(() => loading = false);
//                                                   }
//                                                   //call replace dialog,
//                                                 }).show(context);
//                                           },
//                                         )).show(context);
//                                   } else {
//                                     onLocationSetSuccess();
//                                   }
//                                 } finally {
//                                   setState(() => loading = false);
//                                 }
//                               },
//                             )
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 )
//               ],
//             ),
//     );
//   }

//   void onLocationSetSuccess() async {
//     // print("Uploading location");
//     _controller = Completer<GoogleMapController>();
//     //fetch all the user address and append to user model
//     UserModel? user = await MainRepo.getCustomerInfoWithToken(UserViewModel.token.value);
//     print(user);
//     if (user != null) {
//       UserViewModel.setUser(user);
//     }

//     // UserViewModel.setLocation(
//     //   LatLng(currentPosition.latitude, currentPosition.longitude),
//     // );

//     Get.offAll(() => AllOffersNearYou());

//     // if (LocalStorage.checkFirstTime()) {
//     //   Get.offAll(() => AllOffersNearYou());
//     // } else {
//     //   if (await NewApi.getHomeFavShops() == 0) {
//     //     Get.offAll(() => AllOffersNearYou());
//     //   } else {
//     //     Get.offAll(() => Home());
//     //   }
//     // }
//   }

//   tagLocationSelectionCard(String label) {
//     return InkWell(
//       onTap: () {
//         setState(() {
//           selected = label.toUpperCase();
//         });
//       },
//       child: Container(
//         height: 30,
//         width: 65,
//         decoration: BoxDecoration(
//             color: AppConst.white,
//             borderRadius: BorderRadius.circular(4),
//             border: Border.all(color: label != selected ? AppConst.grey : AppConst.transparent),
//             gradient: label.toLowerCase() == selected.toLowerCase() ? AppConst.gradient1 : null,
//             boxShadow: [if (label != selected) BoxShadow(color: AppConst.black, offset: Offset(0.5, 0.5), spreadRadius: 0, blurRadius: 0.5)]),
//         child: Center(
//           child: Text(
//             label,
//             style: TextStyle(
//               color: label == selected ? AppConst.white : AppConst.black,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget getFormFields() {
//     return Column(
//       children: [
//         TextFormField(
//           controller: _textEditingController,
//           // onFieldSubmitted: searchFromTxtField,
//           maxLines: 1,
//           style: TextStyle(fontSize: 12),
//           decoration: InputDecoration(
//             contentPadding: EdgeInsets.only(left: 5, right: 10),
//             floatingLabelBehavior: FloatingLabelBehavior.always,
//             prefixIcon: Icon(
//               Icons.location_on_outlined,
//               color: AppConst.black,
//               size: 16,
//             ),
//             prefixIconConstraints: BoxConstraints(maxWidth: 40, minWidth: 30),
//             suffixText: 'Change',
//             suffixStyle: TextStyle(
//                 fontSize: 14, fontWeight: FontWeight.w400, color: AppConst.themePurple, fontFamily: 'Stag', decoration: TextDecoration.underline),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(5),
//               borderSide: BorderSide(
//                 color: AppConst.blue,
//               ),
//             ),
//             fillColor: AppConst.white,
//             filled: true,
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(5),
//               borderSide: BorderSide(
//                 color: AppConst.lightGrey,
//                 width: 1.0,
//               ),
//             ),
//           ),
//         ),
//         UISpacingHelper.verticalSpace12,
//         TextFormField(
//           controller: _houseEditingController,
//           maxLines: 1,
//           style: TextStyle(fontSize: 12),
//           decoration: InputDecoration(
//             labelText: "House/Flat/Block No (Optional)",
//             contentPadding: EdgeInsets.only(left: 5, right: 10),
//             floatingLabelBehavior: FloatingLabelBehavior.always,
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(5),
//               borderSide: BorderSide(
//                 color: AppConst.blue,
//               ),
//             ),
//             fillColor: AppConst.white,
//             filled: true,
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(5),
//               borderSide: BorderSide(
//                 color: AppConst.lightGrey,
//                 width: 1.0,
//               ),
//             ),
//           ),
//         ),
//         UISpacingHelper.verticalSpace12,
//         TextFormField(
//           controller: _apartmentEditingController,
//           maxLines: 1,
//           style: TextStyle(fontSize: 12),
//           decoration: InputDecoration(
//             labelText: "Apartment/Road/Area (Optional)",
//             contentPadding: EdgeInsets.only(left: 5, right: 10),
//             floatingLabelBehavior: FloatingLabelBehavior.always,
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(5),
//               borderSide: BorderSide(
//                 color: AppConst.blue,
//               ),
//             ),
//             fillColor: AppConst.white,
//             filled: true,
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(5),
//               borderSide: BorderSide(
//                 color: AppConst.lightGrey,
//                 width: 1.0,
//               ),
//             ),
//           ),
//         ),
//         UISpacingHelper.verticalSpace12,
//         TextFormField(
//           controller: _directionToReachEditingController,
//           maxLines: 6,
//           style: TextStyle(fontSize: 12),
//           decoration: InputDecoration(
//             labelText: "Direction To Reach (Optional)",
//             hintMaxLines: 6,
//             contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
//             floatingLabelBehavior: FloatingLabelBehavior.always,
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(5),
//               borderSide: BorderSide(
//                 color: AppConst.blue,
//               ),
//             ),
//             fillColor: AppConst.white,
//             filled: true,
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(5),
//               borderSide: BorderSide(
//                 color: AppConst.lightGrey,
//                 width: 1.0,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
