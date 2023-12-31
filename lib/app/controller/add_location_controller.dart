import 'dart:async';
import 'dart:developer';
import 'package:customer_app/app/utils/app_constants.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/utils/firebas_crashlyatics.dart';
import 'package:customer_app/widgets/custom_alert_dialog.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart' as temp;

import 'package:customer_app/app/data/provider/hive/hive.dart';
import 'package:customer_app/app/data/provider/hive/hive_constants.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/data/model/getClaimRewardsPageCount_model.dart';
import 'package:customer_app/app/data/model/get_claim_rewards_model.dart';
import 'package:customer_app/app/data/model/user_model.dart';
import 'package:customer_app/app/data/repository/hive_repository.dart';
import 'package:customer_app/app/data/repository/location_repository.dart';
import 'package:customer_app/app/ui/pages/location_picker/address_model.dart';
import 'package:customer_app/widgets/getstorge.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../controllers/userViewModel.dart';
import '../data/model/customer_wallet.dart' as customer;

class AddLocationController extends GetxController {
  RxBool checkPermission = false.obs;
  RxBool isGpson = false.obs;

  UserModel? userModel;
  bool isPageAvailable = true;
  late GoogleMapController mapController;
  late Position currentPosition;
  RxString userAddress = ''.obs;
  final locationController = TextEditingController();
  LatLng? middlePointOfScreenOnMap;
  RxString currentAddress = ''.obs;
  RxString userAddressTitle = ''.obs;

  RxString userHouse = ''.obs;
  RxString userAppartment = ''.obs;

  RxString searchText = ''.obs;
  RxBool loading = false.obs;
  RxBool bottomFullAddressLoading = false.obs;
  RxBool isLoading = false.obs;

  RxInt currentSelectValue = 0.obs;
  RxBool addressModelLoading = false.obs;
  RxBool isChanged = false.obs;
  RxInt storesCount = 0.obs;
  RxInt updatedStoresCount = 0.obs;
  RxInt totalCashBack = 0.obs;
  temp.Location location = new temp.Location();
  RxBool isFullAddressBottomSheet = false.obs;
  RxBool isEditAddress = false.obs;
  final LocationRepository locationRepository = LocationRepository();
  List<Stores> allStores = [];
  List<customer.Stores> allWalletStores = [];
  RxBool isSeeMoreEnable = false.obs;
  Rx<CameraPosition> initialLocation =
      const CameraPosition(target: LatLng(0.0, 0.0)).obs;
  final TextEditingController searchController = TextEditingController();
  GooglePlace googlePlace = GooglePlace(AppConstants.gMapApiKey);
  RxList<AutocompletePrediction> predictions = <AutocompletePrediction>[].obs;
  RxList<AutocompletePrediction> savePredictionsList =
      <AutocompletePrediction>[].obs;
  RxList<RecentAddressDetails> recentAddressDetails =
      <RecentAddressDetails>[].obs;
  Rx<DetailsResult> detailsResult = DetailsResult().obs;
  final HiveRepository hiveRepository = HiveRepository();
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  List<String> title = [];
  List<String> house = [];
  List<String> appartement = [];
  List<String> addres = [];
  List<String> id = [];
  List<String> desc = [];
  List<double> lat = [];
  List<double> long = [];
  // List<String> title = [];

  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  RxBool isRecentAddress = true.obs;

  Future<void> autoCompleteSearch(String value) async {
    log('onMapCreated:---->>> 0000$value');
    lat.clear();
    long.clear();
    house.clear();

    var result = await googlePlace.autocomplete.get(
      value,
      origin: LatLon(currentPosition.latitude, currentPosition.longitude),
      location: LatLon(currentPosition.latitude, currentPosition.longitude),
      region: 'IN',
    );
    log('onMapCreated:---->>> 0001${result?.predictions?.length}');

    if (userModel?.addresses != null) {
      for (var address in userModel!.addresses!) {
        if ('${address.house ?? ''},${address.apartment ?? ''} ${address.address ?? ''}'
            .toLowerCase()
            .contains(value.toLowerCase())) {
          String titlee = address.title ?? '';
          title.add(titlee);

          String housee = address.house ?? '';
          house.add(housee);

          String addresss = address.address ?? '';
          addres.add(addresss);

          double latt = address.location!.lat ?? 0.0;
          lat.add(latt);

          double longg = address.location!.lng ?? 0.0;
          long.add(longg);

          String idd = address.id ?? '';
          id.add(idd);

          String apartment = address.apartment ?? '';
          appartement.add(apartment);
        }
      }
    }

    List<AutocompletePrediction> combinedList = [];

    // Add values from the existing list that match the search text

    if (userModel?.addresses != null) {
      combinedList.addAll(userModel!.addresses!
          .where((address) =>
              '${address.house ?? ''},${address.apartment ?? ''} ${address.address ?? ''}'
                  .toLowerCase()
                  .contains(value.toLowerCase()))
          .map((address) => AutocompletePrediction(
              description:
                  '${address.house ?? ''},${address.apartment ?? ''} ${address.address ?? ''}',
              placeId: address.id,
              id: address.title == "Home"
                  ? "1"
                  : address.title == "Work"
                      ? "2"
                      : address.title == "Hotel"
                          ? "3"
                          : "4",
              reference: address.title != "Home" ||
                      address.title != "Work" ||
                      address.title != "Work"
                  ? address.title
                  : ""))); // Update with the appropriate placeId field
    }

    // Add values from autocomplete predictions
    if (result != null && result.predictions != null) {
      combinedList.addAll(result.predictions!);
    }

    predictions.clear();
    predictions.value = combinedList;
  }

  // Future<void> autoCompleteSearch(String value) async {
  //   log('onMapCreated:---->>> 0000$value');

  //   var result = await googlePlace.autocomplete.get(
  //     value,
  //     origin: LatLon(currentPosition.latitude, currentPosition.longitude),
  //     location: LatLon(currentPosition.latitude, currentPosition.longitude),
  //     region: 'IN',
  //   );
  //   log('onMapCreated:---->>> 0001${result?.predictions?.length}');
  //   if (result != null && result.predictions != null) {
  //     predictions.clear();
  //     predictions.value = result.predictions ?? [];
  //   }
  // }

  Future<void> setLocation(double lat, double lng) async {
    log('onMapCreated:---->>> setLocation 0002$lat $lng');
    loading.value = false;
    middlePointOfScreenOnMap = LatLng(lat, lng);
    log('onMapCreated:---->>> 2222 $middlePointOfScreenOnMap');
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, lng),
          zoom: 17.3,
        ),
      ),
    );
    await getAddress();
    loading.value = false;
  }

  // Future<bool> getCurrentLocation() async {
  //   try {
  //     await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.best);
  //     bool? isEnable = await checkLocationPermission();
  //     checkPermission.value == isEnable;
  //     return isEnable;
  //   } catch (e) {
  //     checkPermission.value == false;
  //     return checkPermission.value;
  //   }
  // }

  // Future<bool> checkLocationPermission() async {
  //   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   bool localcheckPermission =
  //       serviceEnabled && await Permission.location.isGranted;
  //   if (localcheckPermission) {
  //     Position position = await Geolocator.getCurrentPosition();
  //     currentPosition = position;
  //     final box = Boxes.getCommonBox();
  //     box.put(HiveConstants.LATITUDE, "${position.latitude}");
  //     box.put(HiveConstants.LONGITUDE, "${position.longitude}");
  //     final List<Placemark> p =
  //         await placemarkFromCoordinates(position.latitude, position.longitude);
  //     log('p :$p');
  //     userAddress.value =
  //         '${p.first.street ?? ''}, ${p.first.name ?? ''}, ${p.first.subLocality ?? ''}, ${p.first.locality ?? ''}, ${p.first.administrativeArea ?? ''}, ${p.first.postalCode ?? ''}.';
  //     userAddressTitle.value =
  //         '${p.first.subLocality ?? ''} ${p.first.locality ?? ''}';
  //     UserViewModel.setLocation(LatLng(position.latitude, position.longitude));
  //     isPageAvailable = true;
  //   } else {
  //     //  await getUserLocation();
  //   }
  //   return localcheckPermission;
  // }

  // getUserLocation() async {
  //   userModel = hiveRepository.getCurrentUser();
  //   if ((userModel?.addresses?.length ?? 0) > 0) {
  //     for (final AddressModel? addressModal in (userModel?.addresses ?? [])) {
  //       if (addressModal?.status ?? false) {
  //         userAddress.value = addressModal?.address ?? '';
  //         userAddressTitle.value = addressModal?.title ?? '';
  //         UserViewModel.setLocation(LatLng(addressModal?.location?.lat ?? 0.0,
  //             addressModal?.location?.lng ?? 0.0));
  //       }
  //     }
  //   }
  // }

  Future<void> getDetails(String placeId) async {
    addressModelLoading.value = true;
    try {
      log('onMapCreated:---getDetails->>> getDetails $placeId');
      var result = await googlePlace.details.get(placeId);
      if (result != null && result.result != null) {
        detailsResult.value = result.result ?? DetailsResult();
        if (detailsResult.value.geometry != null) {
          await setLocation(detailsResult.value.geometry?.location?.lat ?? 0.0,
              detailsResult.value.geometry?.location?.lng ?? 0.0);
          Get.back();
          isFullAddressBottomSheet.value = false;
        }
      }
      addressModelLoading.value = false;
    } catch (e) {
      ReportCrashes().reportRecorderror(e);
      ReportCrashes().reportErrorCustomKey("getDetails", "$e");
      addressModelLoading.value = false;
    }
  }

  @override
  void onInit() async {
    super.onInit();
    getSaveAddress();
    // await initLocation();
    // getUserData();
  }

  void getUserData() {
    if (hiveRepository.hasUser()) {
      userModel = hiveRepository.getCurrentUser();
      log("Addlocation_conrollerUsermodel${userModel}");
    }
  }

  void getSaveAddress() async {
    if (AppSharedPreference.getRecentAddressHasData) {
      recentAddressDetails.value = AppSharedPreference.getRecentAddress;
      log('onMapCreated:---getSaveAddress->>> ${recentAddressDetails.value.length} 1st address ${recentAddressDetails.value.first.description}');
    }
  }

  Future<void> onCameraIdle() async {
    log('onMapCreated:----onCameraIdle>>> 0000 $middlePointOfScreenOnMap');
    try {
      final List<Placemark> placemarks = await placemarkFromCoordinates(
        middlePointOfScreenOnMap?.latitude ?? 0.0,
        middlePointOfScreenOnMap?.longitude ?? 0.0,
      );
      log('onMapCreated:----onCameraIdle>>> p$placemarks');

      Placemark? selectedPlace;

      final RegExp regex = RegExp(
          r'^(?=.*[a-zA-Z])(?!.*Unnamed)(?!.*[^a-zA-Z0-9\s]).*[a-zA-Z0-9\s]+$'); // this was final experssion for address

      for (final Placemark place in placemarks) {
        if (place.name != null &&
            (place.name?.trim().length ?? 0) > 8 &&
            regex.hasMatch(place.name!)) {
          selectedPlace = place;
          break;
        }
      }

      if (selectedPlace != null) {
        currentAddress.value =
            "${selectedPlace.street == selectedPlace.name ? "" : "${selectedPlace.name}, "}${selectedPlace.street},${selectedPlace.subLocality}, ${selectedPlace.locality},${selectedPlace.administrativeArea}, ${selectedPlace.country}, ${selectedPlace.postalCode}";
      } else if (placemarks.isNotEmpty) {
        final Placemark fallbackPlace = placemarks.last;
        currentAddress.value =
            "${fallbackPlace.street == fallbackPlace.name ? "" : "${fallbackPlace.name}, "}${fallbackPlace.street},${fallbackPlace.subLocality}, ${fallbackPlace.locality},${fallbackPlace.administrativeArea}, ${fallbackPlace.country}, ${fallbackPlace.postalCode}";
      }
      // final Placemark place = p[0];
      // // Address address = await GeoCode().reverseGeocoding(
      // //     latitude: _addLocationController.middlePointOfScreenOnMap.latitude, longitude: _addLocationController.middlePointOfScreenOnMap.longitude);
      // // currentAddress.value = "${place.subLocality}, ${place.locality}, ${place.postalCode}";
      // currentAddress.value =
      //     "${place.street},${place.subLocality}, ${place.locality},${place.administrativeArea}, ${place.postalCode}, ${place.country}";
      loading.value = false;
    } catch (e, st) {
      ReportCrashes().reportRecorderror(e);
      ReportCrashes().reportErrorCustomKey("onCameraIdle", "$e");
      loading.value = false;
      print('onMapCreated middlePointOfScreenOnMap $e st :$st');
    }
  }

  SortByCharactor(String data, String char) {
    int idx = data.indexOf(char);
    List parts = [
      data.substring(0, idx).trim(),
      data.substring(idx + 1).trim()
    ];
    return parts[0];
  }

  convertor(numberToFormat) {
    return NumberFormat.compact().format(numberToFormat);
  }

  void onCameraMove(CameraPosition cameraPosition) {
    log('onMapCreated:----onCameraMove>>> p$cameraPosition');
    loading.value = true;
    middlePointOfScreenOnMap = cameraPosition.target;
    log('onMapCreated:---->>> onCameraMove');
  }

  Future<void> onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    await initLocation();
  }

  Future<void> initLocation() async {
    isRecentAddress.value
        ? await getRecentLocation()
        : await getCurrentLocation();
  }

  Future<Position> getCurrentLocation1() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.deniedForever) {
        // _showPermissionDialog();
        checkPermission.value = false;
      }

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever) {
          checkPermission.value = false;
          // _showPermissionDialog();
        }
      }

      if ((permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse)) {
        checkPermission.value = true;
      }

      try {
        Position position = await Geolocator.getCurrentPosition();

        isGpson.value = true;
      } catch (e) {
        isGpson.value = false;
      }

      try {
        if ((permission == LocationPermission.always ||
                permission == LocationPermission.whileInUse) &&
            isGpson.value == true) {
          Position position = await Geolocator.getCurrentPosition();
          currentPosition = position;
          final box = Boxes.getCommonBox();
          box.put(HiveConstants.LATITUDE, "${position.latitude}");
          box.put(HiveConstants.LONGITUDE, "${position.longitude}");
          final List<Placemark> placemarks = await placemarkFromCoordinates(
              position.latitude, position.longitude);

          Placemark? selectedPlace;
          final RegExp regex = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d\s]+$');
          // Regex pattern to match a string containing at least one letter and one number

          for (final Placemark place in placemarks) {
            if (place.name != null &&
                !(place.name!.contains("Unnamed")) &&
                regex.hasMatch(place.name!)) {
              selectedPlace = place;
              break;
            }
          }

          if (selectedPlace != null) {
            userAddress.value =
                "${selectedPlace.name}, ${selectedPlace.street},${selectedPlace.subLocality}, ${selectedPlace.locality},${selectedPlace.administrativeArea}, ${selectedPlace.country}, ${selectedPlace.postalCode}";
          } else if (placemarks.isNotEmpty) {
            final Placemark fallbackPlace = placemarks.last;
            userAddress.value =
                "${fallbackPlace.name}, ${fallbackPlace.street},${fallbackPlace.subLocality}, ${fallbackPlace.locality},${fallbackPlace.administrativeArea}, ${fallbackPlace.country}, ${fallbackPlace.postalCode}";
          }
          // log('p :$p');
          // userAddress.value =
          //     '${p.first.street ?? ''}, ${p.first.name ?? ''}, ${p.first.subLocality ?? ''}, ${p.first.locality ?? ''}, ${p.first.administrativeArea ?? ''}, ${p.first.postalCode ?? ''}.';
          // userAddressTitle.value =
          //     '${p.first.subLocality ?? ''} ${p.first.locality ?? ''}';
          UserViewModel.setLocation(
              LatLng(position.latitude, position.longitude));
          isPageAvailable = true;

          return position;
        } else {
          return Position(
              longitude: 0.0,
              latitude: 0.0,
              timestamp: DateTime.now(),
              accuracy: 0.0,
              altitude: 0.0,
              heading: 0.0,
              speed: 0.0,
              speedAccuracy: 0.0);
        }
      } catch (e) {
        return Position(
            longitude: 0.0,
            latitude: 0.0,
            timestamp: DateTime.now(),
            accuracy: 0.0,
            altitude: 0.0,
            heading: 0.0,
            speed: 0.0,
            speedAccuracy: 0.0);
        ;
      }
    } catch (e) {
      return Position(
          longitude: 0.0,
          latitude: 0.0,
          timestamp: DateTime.now(),
          accuracy: 0.0,
          altitude: 0.0,
          heading: 0.0,
          speed: 0.0,
          speedAccuracy: 0.0);
    }
  }

  Future<Position> getCurrentLocation2() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.deniedForever) {
        // _showPermissionDialog();
        checkPermission.value = false;
      }

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever) {
          checkPermission.value = false;
          _showPermissionDialog();
        }
      }

      if ((permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse)) {
        checkPermission.value = true;
      }

      try {
        Position position = await Geolocator.getCurrentPosition();

        isGpson.value = true;
      } catch (e) {
        isGpson.value = false;
      }

      try {
        if ((permission == LocationPermission.always ||
                permission == LocationPermission.whileInUse) &&
            isGpson.value == true) {
          Position position = await Geolocator.getCurrentPosition();

          currentPosition = position;

          return position;
        } else {
          return Position(
              longitude: 0.0,
              latitude: 0.0,
              timestamp: DateTime.now(),
              accuracy: 0.0,
              altitude: 0.0,
              heading: 0.0,
              speed: 0.0,
              speedAccuracy: 0.0);
        }
      } catch (e) {
        return Position(
            longitude: 0.0,
            latitude: 0.0,
            timestamp: DateTime.now(),
            accuracy: 0.0,
            altitude: 0.0,
            heading: 0.0,
            speed: 0.0,
            speedAccuracy: 0.0);
        ;
      }
    } catch (e) {
      return Position(
          longitude: 0.0,
          latitude: 0.0,
          timestamp: DateTime.now(),
          accuracy: 0.0,
          altitude: 0.0,
          heading: 0.0,
          speed: 0.0,
          speedAccuracy: 0.0);
      ;
    }
  }

  Future getCurrentLocation() async {
    loading.value = true;
    bool serviceEnabled;
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      _showPermissionDialog();
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        _showPermissionDialog();
      }
    }

    // bool IsGpsOn = isGpson.value;
    checkGps() async {
      bool IsGpsOn = false;
      try {
        Position position = await Geolocator.getCurrentPosition();
        IsGpsOn = true;
        isGpson.value = IsGpsOn;
      } catch (e) {
        IsGpsOn = false;
      }
      isGpson.value = IsGpsOn;
    }

    checkGps();

    ///TODO Add LOCATION Permission and permissionHandler
    // await Geolocator.requestPermission();

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.bestForNavigation)
          .then((Position position) async {
        log('onMapCreated:---getCurrentLocation->>> position $position');
        currentPosition = position;
        middlePointOfScreenOnMap =
            LatLng(position.latitude, position.longitude);
        log('onMapCreated:---getCurrentLocation->>> middlePointOfScreenOnMap $middlePointOfScreenOnMap');
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 17.3,
            ),
          ),
        );
        await getAddress();
        loading.value = false;
      }).catchError((e) {
        print(" error ->  $e");
        loading.value = false;
      });
    }
  }

  Future getRecentLocation() async {
    log('getRecentLocation : ');
    loading.value = true;
    await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.bestForNavigation)
        .then((Position position) async {
      // currentPosition = position;
      middlePointOfScreenOnMap = LatLng(latitude.value, longitude.value);

      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(latitude.value, longitude.value),
            zoom: 17.3,
          ),
        ),
      );
      await getRecentAddress();
      loading.value = false;
    }).catchError((e) {
      ReportCrashes().reportRecorderror(e);
      ReportCrashes().reportErrorCustomKey("getRecentLocation", "$e");
      loading.value = false;
      print(" error ->  $e");
    });
  }

  Future<void> getRecentAddress() async {
    try {
      final List<Placemark> placemarks = await placemarkFromCoordinates(
          currentPosition.latitude, currentPosition.longitude);
      log(': $placemarks');

      Placemark? selectedPlace;
      final RegExp regex = RegExp(
          r'^(?=.*[a-zA-Z])(?!.*Unnamed)(?!.*[\+\-]*\d+[\+\-]*$)(?!.*[^a-zA-Z0-9\s]).*$');
      // Regex pattern to match a string containing at least one letter and one number

      for (final Placemark place in placemarks) {
        if (place.name != null && regex.hasMatch(place.name!)) {
          selectedPlace = place;
          break;
        }
      }

      if (selectedPlace != null) {
        currentAddress.value =
            "${selectedPlace.street == selectedPlace.name ? "" : "${selectedPlace.name}, "}${selectedPlace.street},${selectedPlace.subLocality}, ${selectedPlace.locality},${selectedPlace.administrativeArea}, ${selectedPlace.country}, ${selectedPlace.postalCode}";
      } else if (placemarks.isNotEmpty) {
        final Placemark fallbackPlace = placemarks.last;
        currentAddress.value =
            "${fallbackPlace.street == fallbackPlace.name ? "" : "${fallbackPlace.name}, "}${fallbackPlace.street},${fallbackPlace.subLocality}, ${fallbackPlace.locality},${fallbackPlace.administrativeArea}, ${fallbackPlace.country}, ${fallbackPlace.postalCode}";
      }
    } catch (e) {
      ReportCrashes().reportRecorderror(e);
      ReportCrashes().reportErrorCustomKey("placemarkFromCoordinates", "$e");
      print(e);
    }
  }

  Future getAddress() async {
    try {
      final List<Placemark> placemarks = await placemarkFromCoordinates(
          currentPosition.latitude, currentPosition.longitude);
      log(' getAddress : $placemarks');
      final Placemark place;
      Placemark? selectedPlace;
      final RegExp regex = RegExp(
          r'^(?=.*[a-zA-Z])(?!.*Unnamed)(?!.*[\+\-]*\d+[\+\-]*$)(?!.*[^a-zA-Z0-9\s]).*$');
      // Regex pattern to match a string containing at least one letter and one number

      for (final Placemark place in placemarks) {
        if (place.name != null &&
            !(place.name!.contains("Unnamed")) &&
            regex.hasMatch(place.name!)) {
          selectedPlace = place;
          break;
        }
      }

      if (selectedPlace != null) {
        currentAddress.value =
            "${selectedPlace.street == selectedPlace.name ? "" : "${selectedPlace.name}, "}${selectedPlace.street},${selectedPlace.subLocality}, ${selectedPlace.locality},${selectedPlace.administrativeArea}, ${selectedPlace.country}, ${selectedPlace.postalCode}";
      } else if (placemarks.isNotEmpty) {
        final Placemark fallbackPlace = placemarks.last;
        currentAddress.value =
            "${fallbackPlace.street == fallbackPlace.name ? "" : "${fallbackPlace.name}, "}${fallbackPlace.street},${fallbackPlace.subLocality}, ${fallbackPlace.locality},${fallbackPlace.administrativeArea}, ${fallbackPlace.country}, ${fallbackPlace.postalCode}";
      }
    } catch (e) {
      ReportCrashes().reportRecorderror(e);
      ReportCrashes().reportErrorCustomKey("placemarkFromCoordinates", "$e");
      print(e);
    }
  }

  Future getCurrentAddress() async {
    try {
      final List<Placemark> placemarks = await placemarkFromCoordinates(
          currentPosition.latitude, currentPosition.longitude);
      log(' getCurrentAddress : $placemarks');
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(currentPosition.latitude, currentPosition.longitude),
            zoom: 17.3,
          ),
        ),
      );
      Placemark? selectedPlace;
      final RegExp regex = RegExp(
          r'^(?=.*[a-zA-Z])(?!.*Unnamed)(?!.*[\+\-]*\d+[\+\-]*$)(?!.*[^a-zA-Z0-9\s]).*$');
      // Regex pattern to match a string containing at least one letter and one number

      for (final Placemark place in placemarks) {
        if (place.name != null &&
            !(place.name!.contains("Unnamed")) &&
            regex.hasMatch(place.name!)) {
          selectedPlace = place;
          break;
        }
      }

      if (selectedPlace != null) {
        currentAddress.value =
            "${selectedPlace.street == selectedPlace.name ? "" : "${selectedPlace.name}, "}${selectedPlace.street},${selectedPlace.subLocality}, ${selectedPlace.locality},${selectedPlace.administrativeArea}, ${selectedPlace.country}, ${selectedPlace.postalCode}";
      } else if (placemarks.isNotEmpty) {
        final Placemark fallbackPlace = placemarks.last;
        currentAddress.value =
            "${fallbackPlace.street == fallbackPlace.name ? "" : "${fallbackPlace.name}, "}${fallbackPlace.street},${fallbackPlace.subLocality}, ${fallbackPlace.locality},${fallbackPlace.administrativeArea}, ${fallbackPlace.country}, ${fallbackPlace.postalCode}";
      }
    } catch (e) {
      ReportCrashes().reportRecorderror(e);
      ReportCrashes().reportErrorCustomKey("getCurrentAddress", "$e");
      print(e);
    }
  }

  Future<void> getClaimRewardsPageCount() async {
    try {
      loading.value = true;
      final GetClaimRewardsPageCountModel? getClaimRewardsPageCountModel =
          await locationRepository.getClaimRewardsPageCount(
              middlePointOfScreenOnMap?.latitude ?? 0.0,
              middlePointOfScreenOnMap?.longitude ?? 0.0);
      storesCount.value = getClaimRewardsPageCountModel?.storesCount ?? 0;
      totalCashBack.value = getClaimRewardsPageCountModel?.totalCashBack ?? 0;
      loading.value = false;
    } catch (e) {
      ReportCrashes().reportRecorderror(e);
      ReportCrashes().reportErrorCustomKey("getClaimRewardsPageCount", "$e");
      loading.value = false;
    }
  }

  Future<void> getClaimRewardsPageData() async {
    final GetClaimRewardsModel? getClaimRewardsModel =
        await locationRepository.getClaimRewardsPageData(
            middlePointOfScreenOnMap?.latitude ?? 0.0,
            middlePointOfScreenOnMap?.longitude ?? 0.0);
    allStores.clear();
    allStores.addAll(getClaimRewardsModel?.stores ?? []);
  }

  Future<void> replaceCustomerAddress(addressModel) async {
    await locationRepository.replaceCustomerAddress(addressModel);
  }

  Future<void> deleteCustomerAddress(String id) async {
    await locationRepository.deleteCustomerAddress(id);
  }

  Future<void> deleteCustomer(String comments, bool isdelete) async {
    bool? result = await locationRepository.deleteCustomer(comments, isdelete);
    if (result = true) {
      await Hive.box<UserModel>('user').delete(HiveConstants.USER_KEY);
      await Hive.box<String>('common').delete(HiveConstants.USER_TOKEN);
      Get.offAllNamed(AppRoutes.Authentication);
    }
  }

  Future<void> addCustomerAddress(
      {required String address,
      required String title,
      required double lat,
      required double lng,
      String? house,
      String? apartment,
      String? directionToReach,
      String? page}) async {
    try {
      await locationRepository.addCustomerAddress(
          lat: lat,
          lng: lng,
          address: address,
          title: title,
          house: house,
          apartment: apartment,
          directionToReach: directionToReach,
          page: page);
    } catch (e) {
      ReportCrashes().reportRecorderror(e);
      ReportCrashes().reportErrorCustomKey("addCustomerAddress", "$e");
      print(e);
    }
  }

  Future<void> addMultipleStoreToWallet() async {
    try {
      List<Map<String, dynamic>> data = [];

      for (var allStoresList in allStores) {
        num offer = allStoresList.actualWelcomeOffer!;

        if (allStoresList.flag == 'true') {
          data.add({
            'store': allStoresList.sId,
            'balance': offer,
            'lat': currentPosition.latitude,
            'lng': currentPosition.longitude,
          });
        }
      }
      await locationRepository.addMultipleStoreToWallet(
          currentPosition.latitude, currentPosition.longitude);
    } catch (e) {
      ReportCrashes().reportRecorderror(e);
      ReportCrashes().reportErrorCustomKey("addMultipleStoreToWallet", "$e");
      print(e);
    }
  }

  Future<void> addMultipleStoreToWalletToClaimMore() async {
    try {
      List<Map<String, dynamic>> data = [];

      for (var allStoresList in allWalletStores) {
        num offer = allStoresList.actualWelcomeOffer ?? 0;

        data.add({
          'store': allStoresList.sId,
          "name": allStoresList.name,
          'balance': offer,
        });
      }
      await locationRepository.addMultipleStoreToWalletToClaimMore(data);
    } catch (e) {
      ReportCrashes().reportRecorderror(e);
      ReportCrashes().reportErrorCustomKey("addMultipleStoreToWallet", "$e");
      print(e);
    }
  }

  Future<void> getLatLngFromRecentAddress(String placeId) async {
    var result = await googlePlace.details.get(placeId);
    if (result != null && result.result != null) {
      detailsResult.value = result.result ?? DetailsResult();
      if (detailsResult.value.geometry != null) {
        latitude.value = detailsResult.value.geometry?.location?.lat ?? 0.0;
        longitude.value = detailsResult.value.geometry?.location?.lng ?? 0.0;
        await getRecentLocation();
      }
    }
  }

  void _showPermissionDialog() {
    showDialog(
      barrierDismissible: true,
      context: Get.context!,
      builder: (BuildContext context) {
        return CustomDialog(
          title: '',
          content: "Open Location Settings ",
          buttontext: 'Open Settings',
          onTap: () async {
            await openAppSettings();
          },
        );
      },
    );
  }
}

//   static Future<Position> getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return Future.error('Location services are disabled.');
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           'Location permissions are permantly denied, we cannot request permissions.');
//     }

//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission != LocationPermission.whileInUse &&
//           permission != LocationPermission.always) {
//         return Future.error(
//             'Location permissions are denied (actual value: $permission).');
//       }
//     }

//     return await Geolocator.getCurrentPosition();
//   }
// }
