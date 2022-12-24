// import 'package:flutter/material.dart';
// import 'package:customer_app/config/gqlConfig.dart';
// import 'package:customer_app/controllers/userViewModel.dart';
// import 'package:geocode/geocode.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';

// class MapRepo {
//   // ==================>> NEW FUNCTIONS <<======================
//   /// Determine the current position of the device.
//   ///
//   /// When the location services are not enabled or permissions
//   /// are denied the `Future` will return an error.
//   static Future<Position> determinePosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     // Test if location services are enabled.
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Location services are not enabled don't continue
//       // accessing the position and request users of the
//       // App to enable the location services.
//       return Future.error('Location services are disabled.');
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         // Permissions are denied, next time you could try
//         // requesting permissions again (this is also where
//         // Android's shouldShowRequestPermissionRationale
//         // returned true. According to Android guidelines
//         // your App should show an explanatory UI now.
//         return Future.error('Location permissions are denied');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately.
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }

//     // When we reach here, permissions are granted and we can
//     // continue accessing the position of the device.
//     return await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.bestForNavigation,
//     );
//   }

//   static Future<Placemark?> getAddressFromLatLng(LatLng latlng) async {
//     try {
//       // address = await GeoCode().reverseGeocoding(
//       //     latitude: latlng.latitude, longitude: latlng.longitude);
//       // print(address.streetAddress);
//       List<Placemark>? placemarks =
//           await placemarkFromCoordinates(latlng.latitude, latlng.longitude);

//       print("placemarks[0]----->${placemarks[0]}");
//       return placemarks[0];
//     } catch (e) {
//       print(e);
//     }
//     return null;
//   }

//   static Future<BitmapDescriptor> getPinIcon() async {
//     return await BitmapDescriptor.fromAssetImage(
//         ImageConfiguration(devicePixelRatio: 1.0, size: Size(50, 50)),
//         'assets/icons/pinsmall.png');
//   }

//   // static Future<Position> getCurrentLocation() async {
//   //   bool serviceEnabled;
//   //   LocationPermission permission;

//   //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   //   if (!serviceEnabled) {
//   //     return Future.error('Location services are disabled.');
//   //   }

//   //   permission = await Geolocator.checkPermission();
//   //   if (permission == LocationPermission.deniedForever) {
//   //     return Future.error(
//   //         'Location permissions are permantly denied, we cannot request permissions.');
//   //   }

//   //   if (permission == LocationPermission.denied) {
//   //     permission = await Geolocator.requestPermission();
//   //     if (permission != LocationPermission.whileInUse &&
//   //         permission != LocationPermission.always) {
//   //       return Future.error(
//   //           'Location permissions are denied (actual value: $permission).');
//   //     }
//   //   }

//   //   return await Geolocator.getCurrentPosition();
//   // }

//   // static Future<Position> getCurrentLocation2() async {
//   //   Location location = Location();

//   //   bool _serviceEnabled;
//   //   PermissionStatus _permissionGranted;
//   //   LocationData _locationData;

//   //   _serviceEnabled = await location.serviceEnabled();
//   //   if (!_serviceEnabled) {
//   //     _serviceEnabled = await location.requestService();
//   //   }

//   //   _permissionGranted = await location.hasPermission();
//   //   if (_permissionGranted == PermissionStatus.denied) {
//   //     _permissionGranted = await location.requestPermission();
//   //     // if (_permissionGranted != PermissionStatus.granted) {
//   //     //   return null;
//   //     // }
//   //   }

//   //   _locationData = await location.getLocation();
//   //   return Position(
//   //     latitude: _locationData.latitude!,
//   //     longitude: _locationData.longitude!,
//   //     accuracy: 1,
//   //     altitude: 0,
//   //     heading: 0,
//   //     speed: 0,
//   //     speedAccuracy: 0,
//   //     timestamp: DateTime.now(),
//   //   );
//   // }

// //   static Future<Address> getAddressFromAddress(String value) async {
// //     List<Address> temp = await Geocode.local.findAddressesFromQuery(value);
// //     Address address = temp[0];
// //     return address;
// //   }

// //   static Future<Address> getAddressFromLatLng(LatLng latLng) async {
// //     List<Address> temp = await Geocoder.local.findAddressesFromCoordinates(
// //         Coordinates(latLng.latitude, latLng.longitude));
// //     return temp[0];
// //   }

//   static Future<bool> addCustomerAddress(
//       {required String address,
//       required String title,
//       required double lat,
//       required double lng,
//       String? house,
//       String? apartment,
//       String? directionToReach}) async {
//     print("$address, $title, $lat, $lng");
//     final mutationAddCustomerAddress = r'''
//   mutation($address : String $title: String $lat: Float $lng: Float
//     $house: String
//     $apartment: String
//     $direction_to_reach: String){
//     addCustomerAddress(address:{
//       address: $address
//       title: $title
//       house: $house
//       apartment: $apartment
//       direction_to_reach: $direction_to_reach
//       location:{
//         lat: $lat
//         lng: $lng
//       }
//     }){
//       error
//       msg
//     }
//   }
//   ''';
//     try {
//       Map<String, dynamic> variables = {
//         'address': address,
//         'title': title,
//         'house': house,
//         'aparment': apartment,
//         'direction_to_reach': directionToReach,
//         'lat': lat,
//         'lng': lng
//       };

//       GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);
//       QueryResult result = await client.mutate(MutationOptions(
//           document: gql(mutationAddCustomerAddress), variables: variables));

//       return result.data!['addCustomerAddress']['error'];
//     } catch (e) {
//       print("Error");
//       return true;
//     }
//   }

//   static Future<bool> replaceCustomerAddress(
//       {required String id,
//       required String title,
//       required String address,
//       required double lat,
//       required double lng,
//       String? house,
//       String? apartment,
//       String? directionToReach}) async {
//     final mutationAddCustomerAddress = r'''
//   mutation($id: ID, $address : String $title: String $lat: Float $lng: Float
//     $house: String
//     $apartment: String
//     $direction_to_reach: String
//   ){
//     replaceCustomerAddress(_id: $id, address:{
//       address: $address
//       title: $title
//       house: $house
//       apartment: $apartment
//       direction_to_reach: $direction_to_reach
//       location:{
//         lat: $lat
//         lng: $lng
//       }
//     }){
//       error
//       msg
//     }
//   }
//   ''';
//     try {
//       Map<String, dynamic> variables = {
//         'id': id,
//         'address': address,
//         'title': title,
//         'house': house,
//         'aparment': apartment,
//         'direction_to_reach': directionToReach,
//         'lat': lat,
//         'lng': lng
//       };

//       GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);
//       QueryResult result = await client.mutate(MutationOptions(
//           document: gql(mutationAddCustomerAddress), variables: variables));

//       return result.data!['replaceCustomerAddress']['error'];
//     } catch (e) {
//       return true;
//     }
//   }

// //   static Future<bool> deleteCustomerAddress(String addressID) async {
// //     final mutationAddCustomerAddress = r'''
// // mutation($id: ID){
// //   deleteCustomerAddress(_id: $id){
// //     error
// //     msg
// //   }
// // }
// //   ''';
// //     try {
// //       Map<String, dynamic> variables = {'id': addressID};

// //       GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);
// //       QueryResult result = await client.mutate(MutationOptions(
// //           document: gql(mutationAddCustomerAddress), variables: variables));

// //       return result.data['deleteCustomerAddress']['error'];
// //     } catch (e) {
// //       print(e.toString());
// //       return true;
// //     }
// //   }
// }
