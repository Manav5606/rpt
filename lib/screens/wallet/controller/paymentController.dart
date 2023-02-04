import 'package:customer_app/app/data/model/order_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:customer_app/app/data/provider/hive/hive_constants.dart';
import 'package:customer_app/app/ui/pages/search/models/get_near_me_page_data.dart';
import 'package:customer_app/app/ui/pages/search/models/GetStoreDataModel.dart';
import 'package:customer_app/app/ui/pages/search/models/recentProductsData.dart';
import 'package:customer_app/app/ui/pages/search/service/exploreService.dart';
import 'package:customer_app/models/getRedeemCashStorePageDataModel.dart';
import 'package:customer_app/models/redeem_model.dart';
import 'package:customer_app/screens/wallet/wallet_service.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';

import '../../../app/ui/common/alret.dart';

class PaymentController extends GetxController {
  RxBool isSelectedWallet = false.obs;
  RxBool isSelectedCard = false.obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingStoreData = false.obs;
  RxString searchText = ''.obs;
  Rx<GetNearMePageData?> getNearMePageDataModel = GetNearMePageData().obs;
  Rx<GetRedeemCashInStorePageData?> getRedeemCashInStorePageData =
      GetRedeemCashInStorePageData().obs;
  Rx<RedeemCashInStorePageData> redeemCashInStorePageDataIndex =
      RedeemCashInStorePageData().obs;
  TextEditingController searchController = TextEditingController();
  // Rx<RedeemBalanceModel?> redeemBalanceModel = RedeemBalanceModel().obs;
  // final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  // final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Rx<OrderData?> orderModel = OrderData().obs;

  RxString amountText = ''.obs;
  LatLng latLng = LatLng(0.0, 0.0);
  Rx<GetStoreDataModel?> getStoreDataModel = GetStoreDataModel().obs;
  RxList<RecentProductsData> scanRecentProductList = <RecentProductsData>[].obs;

  Future<void> getRedeemCashInStorePage() async {
    try {
      isLoading.value = true;
      getRedeemCashInStorePageData.value =
          await WalletService.getRedeemCashInStorePageData(latLng);
      isLoading.value = false;
    } catch (e, st) {
      isLoading.value = false;
    }
  }

  Future<void> getScanReceiptPageNearMeStoresData() async {
    try {
      isLoading.value = true;
      getRedeemCashInStorePageData.value =
          await WalletService.getScanReceiptPageNearMeStoresData(latLng);
      getRedeemCashInStorePageData.refresh();
      isLoading.value = false;
    } catch (e, st) {
      isLoading.value = false;
    }
  }

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

  Future<OrderData?> redeemBalance(
      {required String storeId, required double amount}) async {
    try {
      isLoading.value = true;
      orderModel.value =
          await WalletService.redeemBalance(storeId: storeId, amount: amount);
      isLoading.value = false;
      orderModel.refresh();
    } catch (e, st) {
      isLoading.value = false;
    }
  }

  Future<void> setScanNearDataProduct(RecentProductsData data) async {
    final userBox = Hive.box(HiveConstants.GET_SCAN_NEAR_PAGE_DATA_PRODUCT);
    userBox.add(data);
    scanRecentProductList.value = List<RecentProductsData>.from(userBox.values);
  }

  Future<void> getScanNearDataProduct() async {
    final userBox = Hive.box(HiveConstants.GET_SCAN_NEAR_PAGE_DATA_PRODUCT);
    scanRecentProductList.value = List<RecentProductsData>.from(userBox.values);
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    getScanNearDataProduct();
  }
}
