import 'dart:developer';

import 'package:customer_app/app/data/provider/hive/hive.dart';
import 'package:customer_app/app/data/provider/hive/hive_constants.dart';
import 'package:customer_app/controllers/userViewModel.dart';
import 'package:customer_app/widgets/custom_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/app_constants.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/ui/common/alret.dart';
import 'package:customer_app/app/ui/pages/search/models/autoCompleteProductsByStoreModel.dart';
import 'package:customer_app/app/ui/pages/search/models/getCartId_model.dart';
import 'package:customer_app/app/ui/pages/search/service/exploreService.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/models/addcartmodel.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/screens/home/controller/home_controller.dart';
import 'package:customer_app/screens/more_stores/morestore_service.dart';
import 'package:customer_app/widgets/custom_popupmenu.dart';
import 'package:get/get.dart';

import '../../app/ui/pages/search/models/GetStoreDataModel.dart';
import '../home/models/GetAllCartsModel.dart';

class MoreStoreController extends GetxController {
  RxBool isLoadingStoreData = false.obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingGetProducts = false.obs;
  RxString storeId = ''.obs;
  Rx<GetStoreDataModel?> getStoreDataModel = GetStoreDataModel().obs;
  Rx<GetCartIDModel?> getCartIDModel = GetCartIDModel().obs;

  // Rx<GetCartIDModel?> getCartIDModel = GetCartIDModel().obs;
  Rx<AddToCartModel?> addToCartModel = AddToCartModel().obs;
  final HomeController homeController = Get.find();
  Rx<AutoCompleteProductsByStoreModel?> autoCompleteProductsByStoreModel = AutoCompleteProductsByStoreModel().obs;
  TextEditingController storeSearchController = TextEditingController();
  RxString storeSearchText = ''.obs;
  RxList<RawItems> rawItemsList = <RawItems>[].obs;
  RxInt totalItemsCount = 0.obs;

  Future<void> getStoreData({required String id, bool isScanFunction = false, String businessId = '', bool isNeedToNevigate = true}) async {
    try {
      addToCartModel.value?.sId = '';
      isLoadingStoreData.value = true;
      // await homeController.getAllCartsData();
      getStoreDataModel.value = await MoreStoreService.getStoreData(id);
      try {
        getCartIDModel.value = await MoreStoreService.getcartID(id);
      } catch (e) {
        print(e);
      }
      String? cartId = '';
      for (Carts item in homeController.getAllCartsModel.value?.carts ?? []) {
        // int indexCartId = 0;
        // indexCartId = (homeController.getAllCartsModel.value?.carts ?? [])
        //     .indexWhere((element) => element.store?.sId == getStoreDataModel.value?.data?.store?.sId);
        // if (indexCartId != -1) {
        //   cartId = homeController.getAllCartsModel.value?.carts?[indexCartId].sId; //56
        //   rawItemsList.value = homeController.getAllCartsModel.value?.carts?[indexCartId].rawItems ?? []; //56
        // }
        if (getCartIDModel.value?.sId != null) {
          addToCartModel.value?.sId = getCartIDModel.value?.sId;
          for (GetCartIdProducts allCartProducts in getCartIDModel.value?.products ?? []) {
            for (MainProducts mainProducts in getStoreDataModel.value?.data?.mainProducts ?? []) {
              int index = (mainProducts.products ?? []).indexWhere((mainProductsElement) => mainProductsElement.sId == allCartProducts.sId);
              if (index != -1) {
                addToCartModel.value?.totalItemsCount = getCartIDModel.value?.totalItemsCount ?? 0;
                totalItemsCount.value = getCartIDModel.value?.totalItemsCount ?? 0;
                mainProducts.products?[index].quntity!.value = allCartProducts.quantity ?? 0;
                mainProducts.products?[index].isQunitityAdd!.value = true;
                rawItemsList.value = getCartIDModel.value?.rawitems ?? []; //56
              }
            }
          }
          // if (getCartIDModel.value?.sId == cartId) {
          //   addToCartModel.value?.sId = cartId;
          //   for (AllCartProducts allCartProducts in item.products ?? []) {
          //     for (MainProducts mainProducts in getStoreDataModel.value?.data?.mainProducts ?? []) {
          //       int index = (mainProducts.products ?? []).indexWhere((mainProductsElement) => mainProductsElement.sId == allCartProducts.sId);
          //       if (index != -1) {
          //         addToCartModel.value?.totalItemsCount = getCartIDModel.value?.totalItemsCount ?? 0;
          //         mainProducts.products?[index].quntity!.value = allCartProducts.quantity ?? 0;
          //         mainProducts.products?[index].isQunitityAdd!.value = true;
          //       }
          //     }
          //   }
          // } else if (getCartIDModel.value?.sId != cartId) {
          //   addToCartModel.value?.sId = getCartIDModel.value?.sId;
          //   for (GetCartIdProducts allCartProducts in getCartIDModel.value?.products ?? []) {
          //     for (MainProducts mainProducts in getStoreDataModel.value?.data?.mainProducts ?? []) {
          //       int index = (mainProducts.products ?? []).indexWhere((mainProductsElement) => mainProductsElement.sId == allCartProducts.sId);
          //       if (index != -1) {
          //         addToCartModel.value?.totalItemsCount = getCartIDModel.value?.totalItemsCount ?? 0;
          //         mainProducts.products?[index].quntity!.value = allCartProducts.quantity ?? 0;
          //         mainProducts.products?[index].isQunitityAdd!.value = true;
          //       }
          //     }
          //   }
          // }
        } else {
          addToCartModel.value?.totalItemsCount = getCartIDModel.value?.totalItemsCount ?? 0;
          totalItemsCount.value = getCartIDModel.value?.totalItemsCount ?? 0;
        }
      }
      getStoreDataModel.refresh();
      if (isNeedToNevigate) {
        bool isGrocery = Constants.grocery == businessId;
        await Get.toNamed(AppRoutes.MoreStoreProductScreen, arguments: {'isGrocery': isGrocery});
        if (Constants.isAbleToCallApi) await homeController.getAllCartsData();
      }
      isLoadingStoreData.value = false;
    } catch (e, st) {
      Alert.error('product not available try different product');
      isLoadingStoreData.value = false;
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
      log("_moreStoreController.cart_id $cart_id");
      addToCartModel.value =
          await MoreStoreService.addToCart(product: product, store_id: store_id, increment: increment, index: index, cart_id: cart_id);
      for (GetCartIdProducts allCartProducts in addToCartModel.value?.products ?? []) {
        for (MainProducts mainProducts in getStoreDataModel.value?.data?.mainProducts ?? []) {
          int index = (mainProducts.products ?? []).indexWhere((mainProductsElement) => mainProductsElement.sId == allCartProducts.sId);
          if (index != -1) {
            getCartIDModel.value?.totalItemsCount = addToCartModel.value?.totalItemsCount;
            totalItemsCount.value = addToCartModel.value?.totalItemsCount ?? 0;

            mainProducts.products?[index].quntity!.value = allCartProducts.quantity ?? 0;
            mainProducts.products?[index].isQunitityAdd!.value = true;
            rawItemsList.value = getCartIDModel.value?.rawitems ?? []; //56
          }
        }
      }

      log("_moreStoreController.addToCartModel ${addToCartModel.toJson()}");
      isLoading.value = false;
    } catch (e, st) {
      isLoading.value = false;
    }
  }

  Future<void> getAutoCompleteProductsByStore({required String name, required String storeId}) async {
    try {
      isLoadingGetProducts.value = true;
      getCartIDModel.value = await MoreStoreService.getcartID(storeId);
      log('getCartIDModel.value :${getCartIDModel.value?.toJson()}');
      autoCompleteProductsByStoreModel.value = await ExploreService.getAutoCompleteProductsByStore(name: name, storeId: storeId);
      if (autoCompleteProductsByStoreModel.value != null) {
        for (Products inventories in autoCompleteProductsByStoreModel.value?.data?.inventories ?? []) {
          int index = (getCartIDModel.value?.inventories ?? []).indexWhere((mainProductsElement) {
            return mainProductsElement.sId == inventories.sId;
          });
          if (index != -1) {
            inventories.quntity?.value = getCartIDModel.value?.inventories?[index].quantity ?? 0;
            inventories.isQunitityAdd!.value = true;
          }
        }
        for (Products products in autoCompleteProductsByStoreModel.value?.data?.products ?? []) {
          int index = (getCartIDModel.value?.products ?? []).indexWhere((mainProductsElement) {
            return mainProductsElement.sId == products.sId;
          });
          if (index != -1) {
            products.quntity?.value = getCartIDModel.value?.products?[index].quantity ?? 0;
            products.isQunitityAdd!.value = true;
          }
        }
      }
      isLoadingGetProducts.value = false;
    } catch (e, st) {
      isLoadingGetProducts.value = false;
    }
  }

  Future<void> addToCartInventory({
    required String store_id,
    required String cart_id,
    required String name,
    required String sId,
    required int quntity,
  }) async {
    try {
      Products products = Products(
        name: name,
        sId: sId,
        quntity: quntity.obs,
      );
      isLoading.value = true;
      addToCartModel.value = await MoreStoreService.addToCartInventory(
        inventory: products,
        store_id: store_id,
        cart_id: cart_id,
      );
      for (GetCartIdProducts allCartProducts in addToCartModel.value?.products ?? []) {
        for (MainProducts mainProducts in getStoreDataModel.value?.data?.mainProducts ?? []) {
          int index = (mainProducts.products ?? []).indexWhere((mainProductsElement) => mainProductsElement.sId == allCartProducts.sId);
          if (index != -1) {
            getCartIDModel.value?.totalItemsCount = addToCartModel.value?.totalItemsCount;
            totalItemsCount.value = addToCartModel.value?.totalItemsCount ?? 0;

            mainProducts.products?[index].quntity!.value = allCartProducts.quantity ?? 0;
            mainProducts.products?[index].isQunitityAdd!.value = true;
            rawItemsList.value = getCartIDModel.value?.rawitems ?? []; //56
          }
        }
      }
      addToCartModel.refresh();
      log("addToCartInventory.addToCartModel ${addToCartModel.toJson()}");
      isLoading.value = false;
    } catch (e, st) {
      isLoading.value = false;
    }
  }

  List<String> quntityList = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];

  Widget dropDown(inventory, String sId, bool isProduct) {
    return Obx(
      () => CustomPopMenu(
        title: 'Quantity',
        child: Align(
          alignment: Alignment.topRight,
          child: Container(
            height: SizeUtils.horizontalBlockSize * 8,
            width: SizeUtils.horizontalBlockSize * 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppConst.grey,
            ),
            child: inventory.isQunitityAdd?.value == true && inventory.quntity!.value != 0
                ? Center(
                    child: Text("${inventory.quntity!.value}",
                        style: TextStyle(
                          color: AppConst.white,
                          fontSize: SizeUtils.horizontalBlockSize * 4,
                        )),
                  )
                : Icon(
                    Icons.add,
                    color: AppConst.white,
                  ),
          ),
        ),
        list: quntityList,
        onSelected: (value) async {
          inventory.quntity!.value = value;
          if (inventory.quntity!.value == 0) {
            inventory.isQunitityAdd?.value = false;
          }
          if (!isProduct) {
            await addToCartInventory(
              cart_id: addToCartModel.value?.sId ?? '',
              store_id: inventory.store?.sId ?? '',
              name: inventory.name ?? '',
              sId: inventory.sId ?? '',
              quntity: inventory.quntity.value ?? 0,
            );
          } else {
            await addToCart(
                store_id: inventory.store?.sId ?? '', index: 0, increment: true, cart_id: addToCartModel.value?.sId ?? '', product: inventory);
            // await getStoreData(id: inventory.store?.sId ?? '', isNeedToNevigate: false);
          }

          log('product :${inventory.name}');
        },
      ),
    );
  }

  Widget shoppingItem(inventory) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeUtils.horizontalBlockSize * 5),
        color: AppConst.grey,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: SizeUtils.verticalBlockSize * 1),
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _decrementButton(inventory),
              Text(
                '${inventory.quntity!.value}',
                style: TextStyle(fontSize: SizeUtils.horizontalBlockSize * 5, fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              _incrementButton(inventory),
            ],
          ),
        ),
      ),
    );
  }

  Widget _incrementButton(inventory) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppConst.white,
        ),
        child: Icon(
          Icons.add,
          color: AppConst.grey,
        ),
      ),
      onTap: () async {
        inventory.isQunitityAdd?.value = false;
        inventory.quntity!.value++;
        await Future.delayed(Duration(seconds: 2)).whenComplete(() => inventory.isQunitityAdd?.value = true);
        // addItem(products);
      },
    );
  }

  Widget _decrementButton(inventory) {
    return GestureDetector(
      onTap: () async {
        inventory.isQunitityAdd?.value = false;
        inventory.quntity!.value--;
        await Future.delayed(Duration(seconds: 2)).whenComplete(() => inventory.isQunitityAdd?.value = true);
        // addItem(products);
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppConst.white,
        ),
        child: Icon(
          Icons.remove,
          color: AppConst.grey,
        ),
      ),
    );
  }

  @override
  onInit() {
    // TODO: implement onInit
    super.onInit();
    // getAndSetData();
  }

  Future<void> getAndSetData() async {
    await Future.delayed(Duration(seconds: 1));
    final box = Boxes.getCommonBoolBox();
    final box2 = Boxes.getCommonBox();
    final flag = box.get(HiveConstants.REFER_FLAG);
    final flag2 = box2.get(HiveConstants.BONUS);
    if (flag ?? false) {
      _showBounsDialog(flag2 ?? '');
      final box = Boxes.getCommonBox();
      final flag = box.get(HiveConstants.REFERID);
      if (flag?.isNotEmpty ?? false) {
        bool isStore = flag?.contains("Store") ?? false;
        if (isStore) {
          _showStoreDialog(flag ?? '');
        }
      }
    }
  }

  void _showStoreDialog(String flag) {
    UserViewModel.setReferFlag(false);
    showDialog(
      barrierDismissible: true,
      context: Get.context!,
      builder: (BuildContext context) {
        return CustomDialog(
          title: 'Store',
          content: "Click on store button for go to store",
          buttontext: 'Store Button',
          onTap: () async {
            await getStoreData(id: flag);
            UserViewModel.setReferFlag(false);
          },
        );
      },
    );
  }

  void _showBounsDialog(flag2) {
    UserViewModel.setReferFlag(false);
    showDialog(
      barrierDismissible: true,
      context: Get.context!,
      builder: (BuildContext context) {
        return CustomDialog(
          title: 'Bouns',
          content: "You get reward $flag2",
          buttontext: 'Ok',
          onTap: () async {
            Get.back();
            UserViewModel.setReferFlag(false);
          },
        );
      },
    );
  }
}
