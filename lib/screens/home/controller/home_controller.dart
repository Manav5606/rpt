import 'dart:developer';

import 'package:customer_app/app/data/provider/hive/hive.dart';
import 'package:customer_app/app/data/provider/hive/hive_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:customer_app/app/controller/add_location_controller.dart';
import 'package:customer_app/app/data/model/address_model.dart';
import 'package:customer_app/app/data/model/user_model.dart';
import 'package:customer_app/app/data/repository/hive_repository.dart';
import 'package:customer_app/app/ui/pages/chat/chat_controller.dart';
import 'package:customer_app/app/ui/pages/search/controller/exploreContoller.dart';
import 'package:customer_app/data/models/category_model.dart';
import 'package:customer_app/screens/addcart/controller/addcart_controller.dart';
import 'package:customer_app/screens/home/models/GetAllCartsModel.dart';
import 'package:customer_app/screens/home/models/homeFavStoreModel.dart';
import 'package:customer_app/screens/home/models/homePageRemoteConfigModel.dart';
import 'package:customer_app/screens/home/service/home_service.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../controllers/userViewModel.dart';

class HomeController extends GetxController {
  Rx<GetHomePageFavoriteShops?> getHomePageFavoriteShopsModel =
      GetHomePageFavoriteShops().obs;
  Rx<HomePageRemoteConfigData?> homePageRemoteConfigModel =
      HomePageRemoteConfigData().obs;
  Rx<GetAllCartsModel?> getAllCartsModel = GetAllCartsModel().obs;
  RxBool isLoading = false.obs;
  RxBool isAllCartLoading = false.obs;
  // RxString userAddress = ''.obs;
  // RxString userAddressTitle = ''.obs;
  // RxBool checkPermission = true.obs;

  int pageNumber = 1;
  bool isPageAvailable = true;
  RxBool isPageLoading = false.obs;
  int remoteConfigPageNumber = 1;
  bool isRemoteConfigPageAvailable = true;
  bool isRemoteConfigPageLoading = false;
  RxBool isRemoteConfigPageLoading1 = false.obs;
  RxList<HomeFavModel> homePageFavoriteShopsList = <HomeFavModel>[].obs;
  RxList<Data> storeDataList = <Data>[].obs;
  final HiveRepository hiveRepository = HiveRepository();
  UserModel? userModel;
  final ScrollController homePageFavoriteShopsScrollController =
      ScrollController();
  final ScrollController remoteConfigScrollController = ScrollController();
  late CategoryModel keywordValue;
  final AddLocationController _addLocationController = Get.find();

  Future<void> getAllCartsData() async {
    try {
      isAllCartLoading.value = true;
      getAllCartsModel.value = await HomeService.getAllCartsData();
      getAllCartsModel.refresh();
      isAllCartLoading.value = false;
    } catch (e, st) {
      isAllCartLoading.value = false;
    }
  }

  Future<void> getHomePageFavoriteShops() async {
    if (!isPageAvailable || isPageLoading.value) {
      return;
    }
    try {
      isPageLoading.value = true;
      getHomePageFavoriteShopsModel.value =
          await HomeService.getHomePageFavoriteShops(pageNumber: pageNumber);
      if (getHomePageFavoriteShopsModel.value!.data!.isNotEmpty &&
          !(getHomePageFavoriteShopsModel.value!.data!.length < 10)) {
        isPageAvailable = true;
        pageNumber++;
      } else {
        isPageAvailable = false;
      }
      isPageLoading.value = false;
      homePageFavoriteShopsList.refresh();
      getHomePageFavoriteShopsModel.refresh();
      homePageFavoriteShopsList
          .addAll(getHomePageFavoriteShopsModel.value?.data ?? []);
    } catch (e) {
      print(e);
    } finally {
      isPageLoading.value = false;
    }
  }

  Future<void> homePageRemoteConfigData({
    required String keyword,
    required bool productFetch,
    required String keywordHelper,
    required String id,
  }) async {
    if (!isRemoteConfigPageAvailable || isRemoteConfigPageLoading) {
      return;
    }
    try {
      isRemoteConfigPageLoading = true;
      isRemoteConfigPageLoading1.value = true;
      homePageRemoteConfigModel.value =
          await HomeService.homePageRemoteConfigData(
              keyword, productFetch, keywordHelper, id, remoteConfigPageNumber);

      if (homePageRemoteConfigModel.value!.data!.isNotEmpty &&
          !(homePageRemoteConfigModel.value!.data!.length < 10)) {
        isRemoteConfigPageAvailable = true;
        remoteConfigPageNumber++;
      } else {
        isRemoteConfigPageAvailable = false;
      }
      storeDataList.addAll(homePageRemoteConfigModel.value?.data ?? []);
      isRemoteConfigPageLoading1.value = true;
    } catch (e) {
      print(e);
    } finally {
      isRemoteConfigPageLoading = false;
      isRemoteConfigPageLoading1.value = false;
    }
  }

  @override
  void onInit() async {
    super.onInit();
    isLoading.value = true;
    // Get.put(MyAccountController(MyAccountRepository(), HiveRepository()));
    Get.put(AddLocationController());
    Get.put(ExploreController());
    // getUserLocation();
    // await checkLocationPermission();
    await apiCall();
    Get.put(ChatController());
    isLoading.value = false;
    userModel = hiveRepository.getCurrentUser();
  }

  apiCall() async {
    await getHomePageFavoriteShops();
    await getAllCartsData();
    homePageFavoriteShopsScrollController.addListener(() {
      double maxScroll =
          homePageFavoriteShopsScrollController.position.maxScrollExtent;
      double currentScroll =
          homePageFavoriteShopsScrollController.position.pixels;
      double delta = MediaQuery.of(Get.context!).size.height * 0.05;
      if (maxScroll - currentScroll <= delta) {
        getHomePageFavoriteShops();
      }
    });
    remoteConfigScrollController.addListener(() {
      double maxScroll = remoteConfigScrollController.position.maxScrollExtent;
      double currentScroll = remoteConfigScrollController.position.pixels;
      double delta = MediaQuery.of(Get.context!).size.height * 0.10;
      if (maxScroll - currentScroll <= delta) {
        homePageRemoteConfigData(
          keywordHelper: keywordValue.keywordHelper,
          id: keywordValue.id,
          productFetch: keywordValue.isProductAvailable,
          keyword: keywordValue.name,
        );
      }
    });
  }

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

  Future<bool> checkLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    bool localcheckPermission =
        serviceEnabled && await Permission.location.isGranted;
    if (localcheckPermission) {
      Position position = await Geolocator.getCurrentPosition();
      final box = Boxes.getCommonBox();
      box.put(HiveConstants.LATITUDE, "${position.latitude}");
      box.put(HiveConstants.LONGITUDE, "${position.longitude}");
      final List<Placemark> p =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      log('p :$p');
      _addLocationController.userAddress.value =
          '${p.first.street ?? ''}, ${p.first.name ?? ''}, ${p.first.subLocality ?? ''}, ${p.first.locality ?? ''}, ${p.first.administrativeArea ?? ''}, ${p.first.postalCode ?? ''}.';
      // _addLocationController.userAddressTitle.value =
      //     '${p.first.subLocality ?? ''} ${p.first.locality ?? ''}';
      UserViewModel.setLocation(LatLng(position.latitude, position.longitude));
      isPageAvailable = true;
    } else {
      // await getUserLocation();
    }
    return localcheckPermission;
  }

// testing of categories on given data
  List<CategoryModel> category = [
    CategoryModel(
        id: "61f960000a984e3d1c8f9ecb",
        name: "Fruits and Veg",
        title: " Fruits and Veg stores Near you",
        subtitle: "new",
        keywordHelper: "business_type",
        image: "assets/images/Fresh.png",
        isProductAvailable: true),
    CategoryModel(
        id: "61f95fcd0a984e3d1c8f9ec9",
        name: "Grocery",
        subtitle: "new",
        title: " Grocery stores Near you",
        keywordHelper: "business_type",
        image: "assets/images/groceryImage.png",
        isProductAvailable: true),
    CategoryModel(
        id: "625cc6c0c30c356c00c6a9bb",
        name: "Meat and Eggs",
        title: " Meat stores Near you",
        subtitle: "new",
        keywordHelper: "business_type",
        image: "assets/images/Nonveg.png",
        isProductAvailable: true),
    CategoryModel(
        id: "",
        name: "30 mins",
        title: " Delivery within 30 mins",
        subtitle: "new",
        keywordHelper: "",
        image: "assets/images/Pickup.png",
        isProductAvailable: false),
    CategoryModel(
        id: "63a689eff5416c5c5b0ab0a4",
        name: "petfood",
        title: " Pet food stores Near you",
        subtitle: "",
        keywordHelper: "business_type",
        image: "assets/images/petfood.png",
        isProductAvailable: true),
    CategoryModel(
        id: "63a68a03f5416c5c5b0ab0a5",
        name: "medics",
        title: "Medics stores near you",
        subtitle: "new",
        keywordHelper: "business_type",
        image: "assets/images/Medics.png",
        isProductAvailable: true),
  ];
}
