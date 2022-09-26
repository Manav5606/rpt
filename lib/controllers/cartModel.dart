import 'dart:io';
import 'package:get/get.dart';
import 'package:customer_app/data/models/mixed/productModel.dart';
import 'package:customer_app/data/repositories/new_main_api.dart';

class CartItemModel {
  static RxList<ProductModel> products = <ProductModel>[].obs;
  static RxList<RawProduct> rawItem = <RawProduct>[].obs;
  static RxList<File> images = <File>[].obs;
  static RxList<StoreModel> selectedStore = <StoreModel>[]
      .obs; //made it a list to keep the continuity among other lists
  static Rx<int> walletAmount = 0.obs;
}
