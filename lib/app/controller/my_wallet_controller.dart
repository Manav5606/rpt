import 'dart:developer';

import 'package:customer_app/app/controller/add_location_controller.dart';
import 'package:flutter/material.dart';

import 'package:customer_app/app/data/repository/my_wallet_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
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
  RxDouble walletbalanceOfBusinessType = 0.0.obs;
  RxInt walletbalanceOfSignup = 0.obs;
  RxInt GroceryWalletAmount = 0.obs;
  RxInt DryFruitWalletAmount = 0.obs;
  RxInt NonvegWalletAmount = 0.obs;
  RxInt PetfoodWalletAmount = 0.obs;
  RxInt MedicsWalletAmount = 0.obs;
  RxBool isNonVegSelected = true.obs;
  RxBool isPetfoodSelected = true.obs;
  RxList<Stores> GroceryStores = <Stores>[].obs;
  RxList<Stores> DryFruitStores = <Stores>[].obs;
  RxList<Stores> NonVegStores = <Stores>[].obs;
  RxList<Stores> PetfoodStores = <Stores>[].obs;
  RxList<Stores> MedicsStores = <Stores>[].obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxString storeId = ''.obs;
  // LatLng latLng = LatLng(0.0, 0.0);
  RxBool isLoading = false.obs;
  RxBool isCustomerLoading = false.obs;
  RxBool isTransactionLoading = false.obs;
  final AddLocationController _addLocationController = Get.find();

  // final _walletsTransaction = <GetAllWalletTransactionByCustomer>[].obs;

  // apicall() async {
  //   await getAllWalletByCustomer();
  //   await getAllWalletTransactionByCustomer(storeId: storeId.string);

  // }

  @override
  void onInit() async {
    super.onInit();
    await getAllWalletByCustomer();
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
      isCustomerLoading.value = true;
      myCustomerWalletModel.value =
          await MyWalletRepository.getAllWalletByCustomerByBusinessType();
      myCustomerWalletModel.refresh();

      isCustomerLoading.value = false;
    } catch (e, st) {
      isCustomerLoading.value = false;
    }
  }

  int? updateBusinesstypeWallets() {
    GroceryWalletAmount.value = 0;
    NonvegWalletAmount.value = 0;
    PetfoodWalletAmount.value = 0;
    MedicsWalletAmount.value = 0;
    DryFruitWalletAmount.value = 0;
    _addLocationController.allWalletStores.clear();
    for (int i = 0; i < (myCustomerWalletModel.value?.data?.length ?? 7); i++) {
      String? id = myCustomerWalletModel.value?.data?[i].businessType?.sId;

      if (id == "61f95fcd0a984e3d1c8f9ec9") {
        GroceryWalletAmount.value = myCustomerWalletModel
                .value?.data?[i].totalWelcomeOfferByBusinessType ??
            0;
        dynamic storelist = myCustomerWalletModel.value?.data?[i].stores;

        for (int i = 0; i < (storelist?.length ?? 0); i++) {
          GroceryStores.add(storelist![i]);
          _addLocationController.allWalletStores.add(storelist[i]);
        }
      } else if (id == "625cc6c0c30c356c00c6a9bb") {
        NonvegWalletAmount.value = myCustomerWalletModel
                .value?.data?[i].totalWelcomeOfferByBusinessType ??
            0;
        dynamic storelist = myCustomerWalletModel.value?.data?[i].stores;

        for (int i = 0; i < (storelist?.length ?? 0); i++) {
          NonVegStores.add(storelist![i]);
          // _addLocationController.allWalletStores.add(storelist[i]);
        }
      } else if (id == "641ecc4ad9f0df5fa16d708d") {
        DryFruitWalletAmount.value = myCustomerWalletModel
                .value?.data?[i].totalWelcomeOfferByBusinessType ??
            0;
        dynamic storelist = myCustomerWalletModel.value?.data?[i].stores;

        for (int i = 0; i < (storelist?.length ?? 0); i++) {
          DryFruitStores.add(storelist![i]);
          _addLocationController.allWalletStores.add(storelist[i]);
        }
      } else if (id == "63a689eff5416c5c5b0ab0a4") {
        PetfoodWalletAmount.value = myCustomerWalletModel
                .value?.data?[i].totalWelcomeOfferByBusinessType ??
            0;
        dynamic storelist = myCustomerWalletModel.value?.data?[i].stores;

        for (int i = 0; i < (storelist?.length ?? 0); i++) {
          PetfoodStores.add(storelist![i]);
          // _addLocationController.allWalletStores.add(storelist[i]);
        }
      } else if (id == "63a68a03f5416c5c5b0ab0a5") {
        MedicsWalletAmount.value = myCustomerWalletModel
                .value?.data?[i].totalWelcomeOfferByBusinessType ??
            0;
        List<Stores>? storelist = myCustomerWalletModel.value?.data?[i].stores;

        for (int i = 0; i < (storelist?.length ?? 0); i++) {
          MedicsStores.add(storelist![i]);
          _addLocationController.allWalletStores.add(storelist[i]);
        }
      }
    }
    walletbalanceOfSignup.value = (GroceryWalletAmount.value +
        NonvegWalletAmount.value +
        DryFruitWalletAmount.value +
        PetfoodWalletAmount.value +
        MedicsWalletAmount.value);
    return walletbalanceOfSignup.value;
  }

  double StoreTotalWelcomeAmount() {
    List<num> walletamounts = [];
    for (int i = 0; i < (myWalletModel.value?.data?.length ?? 0); i++) {
      var eachStoreTotal =
          ((myWalletModel.value?.data![i].earnedCashback ?? 0) +
              (myWalletModel.value?.data![i].welcomeOffer ?? 0));
      walletamounts.add(eachStoreTotal);
    }

    var TotalWalletBalance = walletamounts.sum;
    walletbalanceOfBusinessType.value = double.parse("${TotalWalletBalance}");
    return walletbalanceOfBusinessType.value;
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
