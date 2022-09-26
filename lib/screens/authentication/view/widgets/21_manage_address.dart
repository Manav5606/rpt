// import 'package:flutter/material.dart';
// import 'package:customer_app/controllers/userViewModel.dart';
// import 'package:customer_app/data/models/address_model.dart';
// import 'package:customer_app/utils/utils.dart';
// import 'package:customer_app/widgets/gradient_button.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class ManageAddress extends StatelessWidget {
//   final Function(AddressModel selectedAddress)? onAddressSelect;
//   final bool showAddAddress;

//   const ManageAddress({this.showAddAddress: true, this.onAddressSelect, Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: mapIndexed<Widget, AddressModel>(UserViewModel.user.value.addresses!, (index, item) {
//         AddressModel data = UserViewModel.user.value.addresses![index];
//         return GestureDetector(
//           onTap: () {
//             UserViewModel.setLocationIndex(index);
//             UserViewModel.setLocation(LatLng(data.location!.lat!, data.location!.lng!), data.id);

//             if (onAddressSelect != null) {
//               onAddressSelect!(data);
//             }
//           },
//           child: Container(
//             margin: const EdgeInsets.only(bottom: 8.0),
//             child: AddressWidget(
//               addressType: data.title!,
//               address: data.address!,
//               selected: index == UserViewModel.locationIndex.value,
//             ),
//           ),
//         );
//       }).toList()
//         ..add(Visibility(
//           visible: showAddAddress,
//           child: GradientButton(
//             onTap: () {
//               Get.to(() => LocationPickerScreen());
//             },
//             height: 50,
//             label: 'Add New Address',
//             fontStyle: TextStyle(color: Colors.white),
//           ),
//         )),
//     );
//   }
// }

// class AddressWidget extends StatelessWidget {
//   final String addressType;
//   final String address;
//   final bool selected;

//   AddressWidget({@required this.addressType, @required this.address, this.selected: false, Key key}) : super(key: key);

//   IconData getAddressIcon() {
//     switch (addressType) {
//       case AddressType.HOME:
//         return FeatherIcons.mapPin;

//       case AddressType.WORK:
//         return FeatherIcons.briefcase;

//       default:
//         return FeatherIcons.mapPin;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       constraints: BoxConstraints(minHeight: 110.0),
//       padding: EdgeInsets.all(12),
//       width: double.infinity,
//       decoration: BoxDecoration(
//           color: Colors.white,
//           border: Border.all(color: selected ? AppConst.themeBlue : Colors.grey.shade200, width: 1),
//           boxShadow: [BoxShadow(offset: Offset(0, 12), blurRadius: 12, color: Colors.grey.shade200)],
//           borderRadius: BorderRadius.circular(4)),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(
//             getAddressIcon(),
//             color: AppConst.themePurple,
//             size: 16,
//           ),
//           UISpacingHelper.horizontalSpaceSmall,
//           Flexible(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('${addressType.trim().capitalize}', style: AppConst.titleText1_2),
//                 UISpacingHelper.verticalSpaceSmall,
//                 Text(
//                   '${address.trim().capitalize}',
//                   style: AppConst.descriptionTextOpen,
//                   maxLines: 3,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 UISpacingHelper.verticalSpace12,
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// class ManageAddressScreen extends StatefulWidget {
//   final bool switchLocation;

//   ManageAddressScreen({this.switchLocation = false});

//   @override
//   _ManageAddressScreenState createState() => _ManageAddressScreenState();
// }

// class _ManageAddressScreenState extends State<ManageAddressScreen> {
//   bool loading = false;

//   loadScreen() => setState(() => loading = !loading);

//   @override
//   Widget build(BuildContext context) {
//     return IsScreenLoading(
//       screenLoading: loading,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(
//             'Manage address',
//             style: AppConst.appbarTextStyle,
//           ),
//           iconTheme: IconThemeData(color: Colors.white),
//         ),
//         body: Container(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: 15,
//               ),
//               Padding(
//                   padding: EdgeInsets.only(left: 20),
//                   child: Text(
//                     'Saved address',
//                     style: AppConst.titleText1,
//                   )),
//               SizedBox(
//                 height: 10,
//               ),
//               Expanded(
//                   child: ListView.builder(
//                       itemCount: UserViewModel.user.value.addresses.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         var data = UserViewModel.user.value.addresses[index];
//                         return GestureDetector(
//                           onTap: () async {
//                             UserViewModel.setLocationIndex(index);
//                             UserViewModel.setLocation(LatLng(data.location.lat, data.location.lng), data.id);
//                             if (widget.switchLocation) {
//                               Get.back(result: true);
//                             } else {
//                               if (LocalStorage.checkFirstTime()) {
//                                 Get.offAll(() => AllOffersNearYou());
//                               } else {
//                                 if (await NewApi.getHomeFavShops() == 0) {
//                                   Get.offAll(() => AllOffersNearYou());
//                                 } else {
//                                   Get.offAll(() => Home());
//                                 }
//                               }
//                             }
//                           },
//                           child: Container(
//                             height: 122,
//                             padding: EdgeInsets.all(10),
//                             margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//                             width: double.infinity,
//                             decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 border: Border.all(color: Colors.grey.shade200, width: 1),
//                                 boxShadow: [
//                                   BoxShadow(offset: Offset(0, 12), blurRadius: 12, color: Colors.grey.shade200)
//                                 ],
//                                 borderRadius: BorderRadius.circular(4)),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Icon(
//                                   FeatherIcons.mapPin,
//                                   color: AppConst.themePurple,
//                                   size: 16,
//                                 ),
//                                 SizedBox(
//                                   width: 5,
//                                 ),
//                                 Flexible(
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text('${data.title.trim().capitalize}', style: AppConst.titleText1_2),
//                                       SizedBox(
//                                         height: 3,
//                                       ),
//                                       Text(
//                                         '${data.address.trim().capitalize}',
//                                         style: AppConst.descriptionTextOpen,
//                                         maxLines: 3,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                       SizedBox(
//                                         height: 10,
//                                       ),
//                                       Row(
//                                         children: [
//                                           Text(
//                                             'Edit',
//                                             style: TextStyle(
//                                                 fontFamily: 'Stag',
//                                                 fontSize: 14,
//                                                 decoration: TextDecoration.underline,
//                                                 color: AppConst.themePurple),
//                                           ),
//                                           SizedBox(
//                                             width: 30,
//                                           ),
//                                           GestureDetector(
//                                               onTap: () async {
//                                                 /*loadScreen();
//                           bool error = await MapRepo.deleteCustomerAddress(address.id);
//                           loadScreen();
//                           if(!error){
//                             setState(() {
//                               UserViewModel.user.value.addresses.remove(address);
//                             });
//                           }*/
//                                               },
//                                               child: Text(
//                                                 'Delete',
//                                                 style: TextStyle(
//                                                     fontFamily: 'Stag',
//                                                     fontSize: 14,
//                                                     decoration: TextDecoration.underline,
//                                                     color: AppConst.themePurple),
//                                               ))
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         );
//                       }))
//             ],
//           ),
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//         floatingActionButton: Padding(
//           padding: const EdgeInsets.all(20),
//           child: GradientButton(
//             onTap: () {
//               Get.to(() => LocationPickerScreen());
//             },
//             height: 50,
//             label: 'Add New Address',
//             fontStyle: TextStyle(color: Colors.white),
//           ),
//         ),
//       ),
//     );
//   }
// }
