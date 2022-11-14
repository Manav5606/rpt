import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:customer_app/app/data/repository/my_wallet_repository.dart';
import 'package:get/get.dart';

import '../data/model/my_wallet_model.dart';

class MyWalletController extends GetxController {
  Rx<GetAllWalletByCustomer?> myWalletModel = GetAllWalletByCustomer()
      .obs; //to get the all data from query including subData
  Rx<WalletData> myWallet = WalletData().obs; //to get the only values in data
  Rx<GetAllWalletTransactionByCustomer?> myWalletTransactionModel =
      GetAllWalletTransactionByCustomer().obs;
  Rx<Transaction> transactionData = Transaction().obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxString storeId = ''.obs;
  // LatLng latLng = LatLng(0.0, 0.0);
  RxBool isLoading = false.obs;
  RxBool isTransactionLoading = false.obs;

  // final _walletsTransaction = <GetAllWalletTransactionByCustomer>[].obs;

  // apicall() async {
  //   await getAllWalletByCustomer();
  //   await getAllWalletTransactionByCustomer(storeId: storeId.string);
  // }

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
}
