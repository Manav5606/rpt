import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/app_constants.dart';
import 'package:customer_app/app/ui/pages/search/controller/exploreContoller.dart';
import 'package:customer_app/app/ui/pages/stores/chatOrder/chatorder_service.dart';
import 'package:customer_app/screens/home/controller/home_controller.dart';
import 'package:customer_app/screens/home/models/GetAllCartsModel.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../screens/more_stores/morestore_controller.dart';

class ChatOrderController extends GetxController {
  Rx<Carts?> cartIndex = Carts().obs;
  Rx<Carts?> cart = Carts().obs;
  RxInt quntity = 0.obs;
  RxBool isQuantityUpdated = false.obs;
  RxInt selectUnitIndex = 0.obs;
  RxString oldItem = ''.obs;
  RxString Oldlogo = ''.obs;
  RxString imagePath = ''.obs;
  RxString logo = ''.obs;
  RxInt oldQuntity = 0.obs;
  final TextEditingController itemController = TextEditingController();
  RxBool isLoading = false.obs;
  RxBool isEdit = false.obs;
  RxString IsEditId = "".obs;
  List<String> quntityList = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10'
  ];
  List<String> unitList = ['kg', 'ml'];
  final ExploreController _exploreController = Get.find();
  final MoreStoreController _moreStoreController = Get.find();
  bool isNewStore = false;
  final HomeController _homeController = Get.find();
  final ImagePicker _picker = ImagePicker();
  File? file;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void setValue(bool _isNewStore) {
    log('setValue');
    isNewStore = _isNewStore;
    if (!isNewStore) {
      cartIndex.value = _exploreController.cartIndex.value;
      cartIndex.value?.totalItemsCount?.value =
          _exploreController.totalItemCount.value;
    } else {
      if (cartIndex.value == null) {
        cartIndex.value =
            Carts(store: Store(), totalItemsCount: 0.obs, sId: '');
      }
      if (cartIndex.value?.store == null) {
        cartIndex.value?.store = Store();
      }
      if (cartIndex.value?.totalItemsCount?.value == null) {
        cartIndex.value?.totalItemsCount = 0.obs;
      }
      if (cartIndex.value?.sId == null) {
        cartIndex.value?.sId = '';
      }
      if (cartIndex.value?.rawItems == null) {
        cartIndex.value?.rawItems = [];
      }
      cartIndex.value?.store?.name =
          _moreStoreController.getStoreDataModel.value?.data?.store?.name ?? '';
      cartIndex.value?.store?.logo =
          _moreStoreController.getStoreDataModel.value?.data?.store?.logo ?? '';
      cartIndex.value?.store?.sId =
          _moreStoreController.getStoreDataModel.value?.data?.store?.sId ?? '';
      cartIndex.value?.store?.storeType = _moreStoreController
              .getStoreDataModel.value?.data?.store?.storeType ??
          '';
      cartIndex.value?.totalItemsCount?.value =
          _moreStoreController.getCartIDModel.value?.totalItemsCount ?? 0;
      log('cartIndex.value?.totalItemsCount?.value : ${cartIndex.value?.totalItemsCount?.value}');
      cartIndex.value?.sId = _moreStoreController.getCartIDModel.value?.sId;
      cartIndex.value?.rawItems =
          _moreStoreController.getCartIDModel.value?.rawitems;
    }
  }

  Future<void> addToCart({
    var rawItem,
    required String cartId,
    required bool isEdit,
    required String newValueItem,
    required String store_id,
  }) async {
    try {
      isLoading.value = true;
      cart.value = await ChatOrderService.addToCartRaw(
          rawItem: rawItem,
          cartId: cartId,
          isEdit: isEdit,
          store_id: store_id,
          newValueItem: newValueItem);
      print('cart.value :${cart.value?.toJson()}');
      cartIndex.value?.totalItemsCount?.value =
          cart.value?.totalItemsCount?.value ?? 0;
      cartIndex.value?.sId = cart.value?.sId ?? "";
      cartIndex.value?.rawItems = cart.value?.rawItems;
      print('cartIndex.value?.rawItems :${cartIndex.value?.toJson()}');
      if (!isNewStore) {
        _exploreController.totalItemCount.value =
            cart.value?.totalItemsCount?.value ?? 0;
      } else {
        _moreStoreController.getCartIDModel.value?.totalItemsCount =
            cart.value?.totalItemsCount?.value ?? 0;
        _moreStoreController.getCartIDModel.value?.totalItemsCount =
            cart.value?.totalItemsCount?.value ?? 0;
      }
      cartIndex.refresh();
      cart.refresh();
      isLoading.value = false;
    } catch (e, st) {
      isLoading.value = false;
    }
  }

  Future<void> imagePicker() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      file = File(image.path);
      imagePath.value = file!.path;
      log('file :${imagePath.value}');
    }
  }
}
