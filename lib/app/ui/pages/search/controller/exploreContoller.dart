import 'dart:async';
import 'dart:developer';

import 'package:customer_app/app/data/model/order_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/app_constants.dart';
import 'package:customer_app/app/data/provider/hive/hive_constants.dart';
import 'package:customer_app/app/ui/common/alret.dart';
import 'package:customer_app/app/ui/pages/search/models/GetProductsByNameModel.dart';
import 'package:customer_app/app/ui/pages/search/models/GetStoreDataModel.dart';
import 'package:customer_app/app/ui/pages/search/models/autoCompleteProductsByStoreModel.dart';
import 'package:customer_app/app/ui/pages/search/models/getCartId_model.dart';
import 'package:customer_app/app/ui/pages/search/models/get_near_me_page_data.dart';
import 'package:customer_app/app/ui/pages/search/models/recentProductsData.dart';
import 'package:customer_app/app/ui/pages/search/service/exploreService.dart';
import 'package:customer_app/models/addcartmodel.dart';
import 'package:customer_app/screens/home/controller/home_controller.dart';
import 'package:customer_app/screens/home/models/GetAllCartsModel.dart';
import 'package:customer_app/screens/more_stores/morestore_controller.dart';
import 'package:customer_app/screens/more_stores/morestore_service.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:customer_app/screens/home/models/homePageRemoteConfigModel.dart'
    as eox;

import 'package:customer_app/screens/home/service/home_service.dart';

import '../../../../../routes/app_list.dart';

class ExploreController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isClick = false.obs;
  RxBool isLoadingGetProducts = false.obs;
  RxBool isRemoteConfigPageLoading1 = false.obs;
  RxBool isLoadingSubmit = false.obs;
  RxBool isLoadingStoreData = false.obs;
  RxBool isLoadingAddData = false.obs;

  int remoteConfigPageNumber = 1;

  Rx<eox.HomePageRemoteConfigData?> homePageRemoteConfigModel1 =
      eox.HomePageRemoteConfigData().obs;
  Rx<GetNearMePageData?> getNearMePageDataModel = GetNearMePageData().obs;
  Rx<AddToCartModel?> addToCartModel = AddToCartModel().obs;
  Rx<GetProductsByName?> getProductsByNameModel = GetProductsByName().obs;
  Rx<GetStoreDataModel?> getStoreDataModel = GetStoreDataModel().obs;
  Rx<Carts?> cartIndex = Carts().obs;
  TextEditingController searchController = TextEditingController();
  TextEditingController storeSearchController = TextEditingController();
  TextEditingController dummySearchController = TextEditingController();
  Rx<GetCartIDModel?> getCartIDModel = GetCartIDModel().obs;
  Rx<OrderData?> orderModel = OrderData().obs;
  RxString searchText = ''.obs;
  RxString storeSearchText = ''.obs;
  RxString currentDay = ''.obs;
  RxString currentHour = ''.obs;
  RxString displayHour = ''.obs;
  RxString amountText = ''.obs;
  RxList<eox.Data> storeDataList = <eox.Data>[].obs;
  RxList<RecentProductsData> recentProductList = <RecentProductsData>[].obs;
  RxList<StoreModelProducts> addCartProduct = <StoreModelProducts>[].obs;
  RxInt totalValue = 0.obs;
  RxDouble actual_cashback = 0.0.obs;
  RxInt totalItemCount = 0.obs;
  Timer? timer;

  Future<void> getNearMePageData({required String searchText}) async {
    try {
      isLoading.value = true;
      getNearMePageDataModel.value =
          await ExploreService.getNearMePageData(searchText);
      isLoading.value = false;
    } catch (e, st) {
      isLoading.value = false;
    }
  }

  Future<void> addToCart({
    var product,
    required String store_id,
    required String cart_id,
    required bool increment,
    required int index,
  }) async {
    try {
      isLoading.value = true;
      addToCartModel.value = await ExploreService.addToCart(
          product: product,
          store_id: store_id,
          increment: increment,
          index: index,
          cart_id: cart_id);
      totalItemCount.value = addToCartModel.value?.totalItemsCount ?? 0;
      cartIndex.value?.totalItemsCount?.value = totalItemCount.value;
      cartIndex.refresh();
      isLoading.value = false;
    } catch (e, st) {
      isLoading.value = false;
    }
  }

  final RecentProductsDataModel recentProductsDataModel =
      RecentProductsDataModel();

  Future<void> setNearDataProduct(RecentProductsData data) async {
    final userBox = Hive.box(HiveConstants.GET_NEAR_PAGE_DATA_PRODUCT);

    userBox.add(data);
    var recent = recentProductList.length;
    log("recent: $recent");
    recentProductList.value = List<RecentProductsData>.from(userBox.values);
  }

  Future<void> DeleteNearDataProduct() async {
    final userBox = Hive.box(HiveConstants.GET_NEAR_PAGE_DATA_PRODUCT);

    userBox.clear();

    recentProductList.value = List<RecentProductsData>.from(userBox.values);
  }

  Future<void> getNearDataProduct() async {
    final userBox = Hive.box(HiveConstants.GET_NEAR_PAGE_DATA_PRODUCT);
    recentProductList.value = List<RecentProductsData>.from(userBox.values);
  }

  Future<void> getProductsByName({required String name}) async {
    try {
      isLoadingGetProducts.value = true;
      getProductsByNameModel.value =
          await ExploreService.getProductsByName(name);
      isLoadingGetProducts.value = false;
    } catch (e, st) {
      isLoadingGetProducts.value = false;
    }
  }

  Future<void> getStoreData(
      {required String id, bool isScanFunction = false}) async {
    try {
      isLoadingStoreData.value = true;
      getStoreDataModel.value = await ExploreService.getStoreData(id);

      if (isScanFunction == true) {
        Get.toNamed(AppRoutes.ScanStoreViewScreen);
      }

      if (isScanFunction != true) {
        try {
          getCartIDModel.value = await MoreStoreService.getcartID(id);
        } catch (e) {
          print(e);
        }

        if (getCartIDModel.value?.sId != null) {
          for (GetCartIdProducts allCartProducts
              in getCartIDModel.value?.products ?? []) {
            for (MainProducts mainProducts
                in getStoreDataModel.value?.data?.mainProducts ?? []) {
              int index = (mainProducts.products ?? []).indexWhere(
                  (mainProductsElement) =>
                      mainProductsElement.sId == allCartProducts.sId);
              if (index != -1) {
                cartIndex.value?.totalItemsCount?.value =
                    getCartIDModel.value?.totalItemsCount ?? 0;
                totalItemCount.value =
                    getCartIDModel.value?.totalItemsCount ?? 0;
                mainProducts.products?[index].quntity!.value =
                    allCartProducts.quantity ?? 0;
                mainProducts.products?[index].isQunitityAdd!.value = true;
              }
            }
          }
        }
        // log('getCartIDModel.value?.sId 00');
        // log('getCartIDModel.value?.sId  : ${getCartIDModel.value?.sId} :cartIndex.value?.sId :${cartIndex.value?.sId}');
        // if (getCartIDModel.value?.sId == cartIndex.value?.sId) {
        //   for (AllCartProducts allCartProducts in cartIndex.value?.products ?? []) {
        //     log('getCartIDModel.value?.sId allCartProducts : ${allCartProducts.toJson()}');
        //     for (MainProducts mainProducts in getStoreDataModel.value?.data?.mainProducts ?? []) {
        //       log('getCartIDModel.value?.sId mainProducts : ${mainProducts.toJson()}');
        //       int index = (mainProducts.products ?? []).indexWhere((mainProductsElement) => mainProductsElement.sId == allCartProducts.sId);
        //       if (index != -1) {
        //         log("allCartProducts.quantity  :${allCartProducts.quantity}");
        //         mainProducts.products?[index].quntity!.value = allCartProducts.quantity ?? 0;
        //         log("products.quantity  :${mainProducts.products?[index].quntity!.value}");
        //         mainProducts.products?[index].isQunitityAdd!.value = true;
        //       }
        //     }
        //   }
        //   log("cartIndex.value?.totalItemsCount?.value ?? 0 :${cartIndex.value?.totalItemsCount?.value ?? 0}");
        //   totalItemCount.value = cartIndex.value?.totalItemsCount?.value ?? 0;
        // } else if (getCartIDModel.value?.sId != cartIndex.value?.sId) {
        //   log('getCartIDModel.value?.sId 02 :');
        //   cartIndex.value?.sId = getCartIDModel.value?.sId;
        //   for (GetCartIdProducts allCartProducts in getCartIDModel.value?.products ?? []) {
        //     for (MainProducts mainProducts in getStoreDataModel.value?.data?.mainProducts ?? []) {
        //       int index = (mainProducts.products ?? []).indexWhere((mainProductsElement) => mainProductsElement.sId == allCartProducts.sId);
        //       if (index != -1) {
        //         cartIndex.value?.totalItemsCount?.value = getCartIDModel.value?.totalItemsCount ?? 0;
        //         totalItemCount.value = getCartIDModel.value?.totalItemsCount ?? 0;
        //         mainProducts.products?[index].quntity!.value = allCartProducts.quantity ?? 0;
        //         mainProducts.products?[index].isQunitityAdd!.value = true;
        //       }
        //     }
        //   }
        // }
        else {
          log('getCartIDModel.value?.sId 03 :');
          addToCartModel.value?.totalItemsCount =
              getCartIDModel.value?.totalItemsCount ?? 0;
        }

        // for (AllCartProducts allCartProducts in cartIndex.value?.products ?? []) {
        //   for (MainProducts mainProducts in getStoreDataModel.value?.data?.mainProducts ?? []) {
        //     int index = (mainProducts.products ?? []).indexWhere((mainProductsElement) => mainProductsElement.sId == allCartProducts.sId);
        //     if (index != -1) {
        //       mainProducts.products?[index].quntity!.value = allCartProducts.quantity ?? 0;
        //       mainProducts.products?[index].isQunitityAdd!.value = true;
        //       print("Match Item index: $index products: ${allCartProducts.quantity} ");
        //     }
        //   }
        // }
        getStoreDataModel.refresh();
        isLoadingStoreData.value = false;
        final HomeController _homeController = Get.find();
        bool isGrocery = true;
        await Get.toNamed(AppRoutes.StoreScreen,
            arguments: {'isGrocery': isGrocery});
        // if (Constants.isAbleToCallApi) await _homeController.getAllCartsData();
      }
      isLoadingStoreData.value = false;
    } catch (e, st) {
      Alert.error('product not available try different product');
      isLoadingStoreData.value = false;
    }
  }

  String formatDate() {
    DateTime date = DateTime.now();

    currentDay.value = date.weekday.toString();
    currentHour.value = date.hour.toString();
    if (currentDay.value == "7") {
      currentDay.value = "0";
    }
    getStoreDataModel
        .value?.data?.store?.deliverySlots?[int.parse(currentDay.value)].slots
        ?.forEach((element) {
      if ((element.startTime?.hour ?? 0) >
          int.parse(currentHour.value.toString())) {
        displayHour.value = element.startTime?.hour.toString() ?? "";
        if (int.parse(displayHour.value) >= 12) {
          displayHour.value = '${int.parse(displayHour.value) - 12} PM';
        } else {
          displayHour.value = '${int.parse(displayHour.value)} AM';
        }
      }
    });

    return DateFormat('H').format(date).toString();
  }

  Future<void> addItem() async {
    try {
      isLoadingAddData.value = true;
      getStoreDataModel.value?.data?.mainProducts!.forEach((mainProducts) {
        mainProducts.products!.forEach((products) {
          addCartProduct.add(products);
          int isExists = addCartProduct.indexWhere((element) {
            return element.quntity == products.quntity;
          });
          if (isExists != -1) {
            int isExists = addCartProduct.indexWhere((element) {
              return element.sId == products.sId;
            });
            if (isExists == -1) {
              addCartProduct.add(products);
            } else {
              addCartProduct[isExists].quntity = products.quntity;
              if (addCartProduct[isExists].quntity!.value <= 0) {
                addCartProduct.removeAt(isExists);
              }
            }
          }
        });
      });
      total();
      isLoadingAddData.value = false;
    } catch (e) {
      print(e);
      isLoadingAddData.value = false;
    }
  }

  total() {
    totalValue.value = 0;
    actual_cashback.value = 0.0;
    log('addCartProduct :${addCartProduct.length}');
    actual_cashback.value =
        getStoreDataModel.value?.data?.store?.actual_cashback?.toDouble() ??
            0.0;
    addCartProduct.forEach((element) {
      log('addCartProduct element):${element.toJson()}');
      totalValue.value = totalValue.value +
          (element.cashback! * element.quntity!.value).toInt();
      log('addCartProduct totalValue.value):${totalValue.value}');
    });
  }

  Future<void> homePageRemoteConfigData1(
      // {
      // required String keyword,
      // required bool productFetch,
      // required String keywordHelper,
      // required String id,
      // }
      ) async {
    try {
      isRemoteConfigPageLoading1.value = true;
      homePageRemoteConfigModel1.value =
          await HomeService.homePageRemoteConfigData("", true, "Catalog",
              "625cff9aaf81283a247966b5", remoteConfigPageNumber);

      if (homePageRemoteConfigModel1.value!.data!.isNotEmpty &&
          !(homePageRemoteConfigModel1.value!.data!.length < 10)) {
        isRemoteConfigPageLoading1.value = true;
        remoteConfigPageNumber++;
      } else {
        isRemoteConfigPageLoading1.value = false;
      }
      storeDataList.addAll(homePageRemoteConfigModel1.value?.data ?? []);
    } catch (e) {
      print(e);
    } finally {
      isRemoteConfigPageLoading1.value = false;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getNearDataProduct();
  }
}
