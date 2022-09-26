import 'dart:async';
import 'dart:developer';

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

class AddLocationController extends GetxController {
  late GoogleMapController mapController;
  late Position currentPosition;
  final locationController = TextEditingController();
  LatLng? middlePointOfScreenOnMap;
  RxString currentAddress = ''.obs;
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
  RxBool isFullAddressBottomSheet = false.obs;
  final LocationRepository locationRepository = LocationRepository();
  List<Stores> allStores = [];
  RxBool isSeeMoreEnable = false.obs;
  Rx<CameraPosition> initialLocation = const CameraPosition(target: LatLng(0.0, 0.0)).obs;
  final TextEditingController searchController = TextEditingController();
  GooglePlace googlePlace = GooglePlace('AIzaSyAVKjCxMvk5Nymx6VYSlhc4iOasFoTxuCk');
  RxList<AutocompletePrediction> predictions = <AutocompletePrediction>[].obs;
  RxList<AutocompletePrediction> savePredictionsList = <AutocompletePrediction>[].obs;
  RxList<RecentAddressDetails> recentAddressDetails = <RecentAddressDetails>[].obs;
  Rx<DetailsResult> detailsResult = DetailsResult().obs;
  final HiveRepository hiveRepository = HiveRepository();
  UserModel? userModel;
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  RxBool isRecentAddress = true.obs;

  Future<void> autoCompleteSearch(String value) async {
    log('onMapCreated:---->>> 0000$value');

    var result = await googlePlace.autocomplete.get(
      value,
      origin: LatLon(currentPosition.latitude, currentPosition.longitude),
      location: LatLon(currentPosition.latitude, currentPosition.longitude),
      region: 'IN',
    );
    log('onMapCreated:---->>> 0001$result');
    if (result != null && result.predictions != null) {
      predictions.clear();
      predictions.value = result.predictions ?? [];
    }
  }

  Future<void> setLocation(double lat, double lng) async {
    log('onMapCreated:---->>> setLocation 0002$lat $lng');
    loading.value = false;
    middlePointOfScreenOnMap = LatLng(lat, lng);
    log('onMapCreated:---->>> 2222 $middlePointOfScreenOnMap');
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, lng),
          zoom: 18.0,
        ),
      ),
    );
    await getAddress();
    loading.value = false;
  }

  Future<void> getDetails(String placeId) async {
    addressModelLoading.value = true;
    try {
      log('onMapCreated:---getDetails->>> getDetails $placeId');
      var result = await googlePlace.details.get(placeId);
      if (result != null && result.result != null) {
        detailsResult.value = result.result ?? DetailsResult();
        if (detailsResult.value.geometry != null) {
          await setLocation(detailsResult.value.geometry?.location?.lat ?? 0.0, detailsResult.value.geometry?.location?.lng ?? 0.0);
          Get.back();
          isFullAddressBottomSheet.value = false;
        }
      }
      addressModelLoading.value = false;
    } catch (e) {
      addressModelLoading.value = false;
    }
  }

  @override
  void onInit() async {
    super.onInit();
    getSaveAddress();
    await initLocation();
    getUserData();
  }

  void getUserData() {
    if (hiveRepository.hasUser()) {
      userModel = hiveRepository.getCurrentUser();
    }
  }

  void getSaveAddress() async {
    if (AppSharedPreference.getRecentAddressHasData) {
      recentAddressDetails.value = AppSharedPreference.getRecentAddress;
      log('onMapCreated:---getSaveAddress->>> ${recentAddressDetails.value}');
    }
  }

  Future<void> onCameraIdle() async {
    log('onMapCreated:----onCameraIdle>>> 0000 $middlePointOfScreenOnMap');
    try {
      final List<Placemark> p = await placemarkFromCoordinates(
        middlePointOfScreenOnMap?.latitude ?? 0.0,
        middlePointOfScreenOnMap?.longitude ?? 0.0,
      );
      log('onMapCreated:----onCameraIdle>>> p$p');
      final Placemark place = p[0];
      // Address address = await GeoCode().reverseGeocoding(
      //     latitude: _addLocationController.middlePointOfScreenOnMap.latitude, longitude: _addLocationController.middlePointOfScreenOnMap.longitude);
      currentAddress.value = "${place.subLocality}, ${place.locality}, ${place.postalCode}";
      loading.value = false;
    } catch (e, st) {
      loading.value = false;
      print('onMapCreated middlePointOfScreenOnMap $e st :$st');
    }
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
    isRecentAddress.value ? await getRecentLocation() : await getCurrentLocation();
  }

  Future getCurrentLocation() async {
    loading.value = true;

    ///TODO Add LOCATION Permission and permissionHandler
    // await Geolocator.requestPermission();
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) async {
      log('onMapCreated:---getCurrentLocation->>> position $position');
      currentPosition = position;
      middlePointOfScreenOnMap = LatLng(position.latitude, position.longitude);
      log('onMapCreated:---getCurrentLocation->>> middlePointOfScreenOnMap $middlePointOfScreenOnMap');
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 18.0,
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

  Future getRecentLocation() async {
    log('getRecentLocation : ');
    loading.value = true;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) async {
      currentPosition = position;
      middlePointOfScreenOnMap = LatLng(latitude.value, longitude.value);
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(latitude.value, longitude.value),
            zoom: 18.0,
          ),
        ),
      );
      await getAddress();
      loading.value = false;
    }).catchError((e) {
      loading.value = false;
      print(" error ->  $e");
    });
  }

  Future getAddress() async {
    try {
      final List<Placemark> p = await placemarkFromCoordinates(currentPosition.latitude, currentPosition.longitude);
      log('getRecentLocation getAddress : $p');
      final Placemark place = p[0];

      currentAddress.value = "${place.subLocality}, ${place.locality}, ${place.postalCode}";
    } catch (e) {
      print(e);
    }
  }

  Future getCurrentAddress() async {
    try {
      final List<Placemark> p = await placemarkFromCoordinates(currentPosition.latitude, currentPosition.longitude);
      log('getRecentLocation getCurrentAddress : $p');
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(currentPosition.latitude, currentPosition.longitude),
            zoom: 18.0,
          ),
        ),
      );
      final Placemark place = p[0];
      currentAddress.value = "${place.subLocality}, ${place.locality}, ${place.postalCode}";
    } catch (e) {
      print(e);
    }
  }

  Future<void> getClaimRewardsPageCount() async {
    try {
      loading.value = true;
      final GetClaimRewardsPageCountModel? getClaimRewardsPageCountModel =
          await locationRepository.getClaimRewardsPageCount(middlePointOfScreenOnMap?.latitude ?? 0.0, middlePointOfScreenOnMap?.longitude ?? 0.0);
      storesCount.value = getClaimRewardsPageCountModel?.storesCount ?? 0;
      totalCashBack.value = getClaimRewardsPageCountModel?.totalCashBack ?? 0;
      loading.value = false;
    } catch (e) {
      loading.value = false;
    }
  }

  Future<void> getClaimRewardsPageData() async {
    final GetClaimRewardsModel? getClaimRewardsModel =
        await locationRepository.getClaimRewardsPageData(middlePointOfScreenOnMap?.latitude ?? 0.0, middlePointOfScreenOnMap?.longitude ?? 0.0);
    allStores.clear();
    allStores.addAll(getClaimRewardsModel?.stores ?? []);
  }

  Future<void> replaceCustomerAddress(addressModel) async {
    await locationRepository.replaceCustomerAddress(addressModel);
  }

  Future<void> deleteCustomerAddress(String id) async {
    await locationRepository.deleteCustomerAddress(id);
  }

  Future<void> addCustomerAddress(
      {required String address,
      required String title,
      required double lat,
      required double lng,
      String? house,
      String? apartment,
      String? directionToReach}) async {
    try {
      await locationRepository.addCustomerAddress(
        lat: lat,
        lng: lng,
        address: address,
        title: title,
        house: house,
        apartment: apartment,
        directionToReach: directionToReach,
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> addMultipleStoreToWallet() async {
    try {
      List<Map<String, dynamic>> data = [];

      for (var allStoresList in allStores) {
        num offer = allStoresList.defaultWelcomeOffer!;
        final today = DateTime.now();
        if (allStoresList.promotionWelcomeOfferStatus == 'active') {
          // if (allStoresList.promotionWelcomeOfferDate!.startDate!.isBefore(today) &&
          //     allStoresList.promotionWelcomeOfferDate!.endDate!.isAfter(today)) {
          // }
          offer = allStoresList.promotionWelcomeOffer!;
        }
        if (allStoresList.flag == 'true') {
          data.add({
            'store': allStoresList.sId,
            'balance': offer,
            'lat': currentPosition.latitude,
            'lng': currentPosition.longitude,
          });
        }
      }
      await locationRepository.addMultipleStoreToWallet(currentPosition.latitude, currentPosition.longitude);
    } catch (e) {
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
}
