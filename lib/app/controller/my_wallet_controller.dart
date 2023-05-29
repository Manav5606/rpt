import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:customer_app/app/data/repository/my_wallet_repository.dart';
import 'package:get/get.dart';

import '../../data/models/category_model.dart';
import '../data/model/customer_wallet.dart';
import '../data/model/my_wallet_model.dart';

class MyWalletController extends GetxController {
  Rx<GetAllWalletByCustomer?> myWalletModel = GetAllWalletByCustomer()
      .obs; //to get the all data from query including subData
  Rx<GetAllWalletByCustomerByBusinessType?> myCustomerWalletModel =
      GetAllWalletByCustomerByBusinessType().obs;
  Rx<WalletData> myWallet = WalletData().obs; //to get the only values in data
  Rx<GetAllWalletTransactionByCustomer?> myWalletTransactionModel =
      GetAllWalletTransactionByCustomer().obs;
  Rx<Transaction> transactionData = Transaction().obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxString storeId = ''.obs;
  // LatLng latLng = LatLng(0.0, 0.0);
  RxBool isLoading = false.obs;
  RxBool isCustomerLoading = false.obs;
  RxBool isTransactionLoading = false.obs;

  // final _walletsTransaction = <GetAllWalletTransactionByCustomer>[].obs;

  // apicall() async {
  //   await getAllWalletByCustomer();
  //   await getAllWalletTransactionByCustomer(storeId: storeId.string);

  // }

  @override
  void onInit() async {
    super.onInit();
    // isCustomerLoading.value = true;
    // Get.put(MyAccountController(MyAccountRepository(), HiveRepository()));
    // await getAllWalletByCustomerByBusinessType();
    // isCustomerLoading.value = false;
  }

  Future<void> getAllWalletByCustomer() async {
    try {
      isLoading.value = true; //  usess of it
      log('hiiiiwallet Store$storeId');
      myWalletModel.value = await MyWalletRepository.getAllWalletByCustomer();
      log('hiiiiwalletAfterQuery Store$storeId');
      myWalletModel.refresh();
      // log("myWalletModel.valuemyWalletModel.value22:${myWalletModel.value?.data?.length ?? 'nullll'}");

      isLoading.value = false;
    } catch (e, st) {
      isLoading.value = false;
    }
  }

  Future<void> getAllWalletByCustomerByBusinessType() async {
    try {
      isCustomerLoading.value = true; //  usess of it
      log('hiiiiwallet Store$storeId');
      myCustomerWalletModel.value =
          await MyWalletRepository.getAllWalletByCustomerByBusinessType();
      log('hiiiiwalletAfterQuery Store$storeId');
      myCustomerWalletModel.refresh();
      // log("myWalletModel.valuemyWalletModel.value22:${myWalletModel.value?.data?.length ?? 'nullll'}");

      isCustomerLoading.value = false;
    } catch (e, st) {
      isCustomerLoading.value = false;
    }
  }

  Future<void> getAllWalletTransactionByCustomer(
      {required String? storeId}) async {
    try {
      isTransactionLoading.value = true;
      log('hiiii Store$storeId');

      myWalletTransactionModel.value =
          (await MyWalletRepository.getAllWalletTransactionByCustomer(storeId));
      log('hiiii2 Store$storeId');

      myWalletTransactionModel.refresh();
      // log("myWalletModel.value.data.1.name :${myWalletModel.value?.data?.length ?? 'nullll'}");

      isTransactionLoading.value = false;
    } catch (e, st) {
      isTransactionLoading.value = false;
    }
  }

  List<CategoryModel> category = [
    // CategoryModel(
    //     id: "61f960000a984e3d1c8f9ecb",
    //     name: "Fruits and Veg",
    //     title: "Fruits and Veg stores Near you",
    //     subtitle: "new",
    //     keywordHelper: "business_type",
    //     image: "assets/images/Fresh.png",
    //     isProductAvailable: true),
    CategoryModel(
        id: "61f95fcd0a984e3d1c8f9ec9",
        name: "Grocery",
        subtitle: "new",
        title: "Grocery stores Near you",
        keywordHelper: "business_type",
        image: "assets/images/groceryImage.png",
        isProductAvailable: true),
    CategoryModel(
        id: "625cc6c0c30c356c00c6a9bb",
        name: "Meat and Eggs",
        title: "Meat stores Near you",
        subtitle: "new",
        keywordHelper: "business_type",
        image: "assets/images/Nonveg.png",
        isProductAvailable: true),
    CategoryModel(
        id: "641ecc4ad9f0df5fa16d708d",
        name: "Dry Fruit Store",
        title: "Dry Fruits ",
        subtitle: "new",
        keywordHelper: "",
        image: "assets/images/dryfruits.png",
        isProductAvailable: true),
    CategoryModel(
        id: "63a689eff5416c5c5b0ab0a4",
        name: "petfood",
        title: "Pet food stores Near you",
        subtitle: "",
        keywordHelper: "business_type",
        image: "assets/images/petfood.png",
        isProductAvailable: true),
    CategoryModel(
        id: "63a68a03f5416c5c5b0ab0a5",
        name: "medics",
        title: "Medical stores Nearby you",
        subtitle: "new",
        keywordHelper: "business_type",
        image: "assets/images/Medics.png",
        isProductAvailable: true),
  ];
}
