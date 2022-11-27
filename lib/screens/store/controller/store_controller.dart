import 'package:customer_app/app/ui/common/alret.dart';
import 'package:customer_app/app/ui/pages/search/models/GetStoreDataModel.dart';
import 'package:customer_app/app/ui/pages/search/models/autoCompleteProductsByStoreModel.dart';
import 'package:customer_app/app/ui/pages/search/models/getCartId_model.dart';
import 'package:customer_app/models/addcartmodel.dart';
import 'package:customer_app/screens/home/controller/home_controller.dart';
import 'package:customer_app/screens/home/models/GetAllCartsModel.dart';
import 'package:customer_app/screens/more_stores/morestore_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class StoreController extends GetxController {
  RxBool isLoadingStoreData = false.obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingGetProducts = false.obs;
  Rx<GetStoreDataModel?> _storeDataModel = GetStoreDataModel().obs;
  GetStoreDataModel? get storeDataModel => _storeDataModel.value;
  set storeDataModel(GetStoreDataModel? value) {
    _storeDataModel.value = value;
  }

  Rx<GetCartIDModel?> getCartIDModel = GetCartIDModel().obs;

  Rx<AddToCartModel?> _cartItemsModel = AddToCartModel().obs;
  AddToCartModel? get cartItemsModel => _cartItemsModel.value;
  set cartItemsModel(AddToCartModel? value) {
    _cartItemsModel.value = value;
  }

  final HomeController homeController = Get.find();
  Rx<AutoCompleteProductsByStoreModel?> autoCompleteProductsByStoreModel =
      AutoCompleteProductsByStoreModel().obs;
  TextEditingController storeSearchController = TextEditingController();
  RxString storeSearchText = ''.obs;
  RxList<RawItems> rawItemsList = <RawItems>[].obs;
  RxInt _totalItemsCount = 0.obs;
  int get totalItemsCount => _totalItemsCount.value;
  set totalItemsCount(int? value) {
    _totalItemsCount.value = value ?? 0;
  }

  RxList<StoreModelProducts> searchDisplayList = <StoreModelProducts>[].obs;
  List<StoreModelProducts> allProducts = [];
  String storeId = "";

  @override
  Future<void> onInit() async {
    super.onInit();
    storeId = "62ecd65432b98125b880da75";
    await getStoreData(id: storeId, businessId: '');
    await getAllProducts();
  }

  getAllProducts() {
    for (MainProducts mainProducts
        in storeDataModel?.data?.mainProducts ?? []) {
      allProducts.addAll(mainProducts.products ?? []);
    }
    searchDisplayList.value = [...allProducts];
  }

  void search(String value) {
    if (value.isEmpty) {
      searchDisplayList.value = [...allProducts];
    }
    searchDisplayList.clear();
    allProducts.forEach((element) {
      if (element.name!.toLowerCase().contains(value.toLowerCase())) {
        searchDisplayList.add(element);
      }
    });
    refresh();
  }

  int getCartItems(String value) {
    for (GetCartIdProducts product in getCartIDModel.value?.products ?? []) {
      // print("incart ${value == product.sId}");
      if (value == product.sId) return product.quantity ?? 0;
    }
    return 0;
  }

  Future<void> getStoreData(
      {required String id,
      bool isScanFunction = false,
      String businessId = '',
      bool isNeedToNevigate = true}) async {
    try {
      cartItemsModel?.sId = '';
      isLoadingStoreData.value = true;

      storeDataModel = await MoreStoreService.getStoreData(id);
      try {
        getCartIDModel.value = await MoreStoreService.getcartID(id);
      } catch (e) {
        print(e);
      }

      if (getCartIDModel.value?.sId != null) {
        cartItemsModel?.sId = getCartIDModel.value?.sId;
        for (GetCartIdProducts allCartProducts
            in getCartIDModel.value?.products ?? []) {
          for (MainProducts mainProducts
              in storeDataModel?.data?.mainProducts ?? []) {
            int index =
                (mainProducts.products ?? []).indexWhere((mainProductsElement) {
              return mainProductsElement.sId == allCartProducts.sId;
            });

            if (index != -1) {
              cartItemsModel?.totalItemsCount =
                  getCartIDModel.value?.totalItemsCount ?? 0;
              totalItemsCount = cartItemsModel?.products?.length;

              // mainProducts.products?[index].quntity!.value =
              //     allCartProducts.quantity ?? 0;
              // mainProducts.products?[index].isQunitityAdd!.value = true;
              // rawItemsList.value = getCartIDModel.value?.rawitems ?? []; //56
            }
          }
        }
      } else {
        cartItemsModel?.totalItemsCount =
            getCartIDModel.value?.totalItemsCount ?? 0;
        totalItemsCount = cartItemsModel?.products?.length;
      }

      refresh();
      isLoadingStoreData.value = false;
    } catch (e, st) {
      Alert.error('product not available try different product');
      isLoadingStoreData.value = false;
    }
  }

  Future<void> addToCart(
      {required StoreModelProducts product, required int count}) async {
    try {
      product.quntity!.value = count;
      if (product.quntity!.value == 0) {
        product.isQunitityAdd?.value = false;
        print("remove call");
      }

      print("cart_id:: ${cartItemsModel?.sId}");

      isLoading.value = true;
      cartItemsModel = await MoreStoreService.addToCart(
          product: product,
          store_id: storeId,
          increment: true,
          index: 0,
          cart_id: cartItemsModel?.sId ?? '');

      totalItemsCount = cartItemsModel?.products?.length;
      print("cccc ==== ${cartItemsModel?.products?.length}");
      isLoading.value = false;
    } catch (e, st) {
      print(":::>>> $e");
      print("cccc ===e= ${cartItemsModel?.products?.length}");
      isLoading.value = false;
      isLoading.value = false;
    }
  }

  // Future<void> getAutoCompleteProductsByStore(
  //     {required String name, required String storeId}) async {
  //   try {
  //     isLoadingGetProducts.value = true;
  //     getCartIDModel.value = await MoreStoreService.getcartID(storeId);
  //     // log('getCartIDModel.value :${getCartIDModel.value?.toJson()}');
  //     autoCompleteProductsByStoreModel.value =
  //         await ExploreService.getAutoCompleteProductsByStore(
  //             name: name, storeId: storeId);
  //     if (autoCompleteProductsByStoreModel.value != null) {
  //       for (Products inventories
  //           in autoCompleteProductsByStoreModel.value?.data?.inventories ??
  //               []) {
  //         int index = (getCartIDModel.value?.inventories ?? [])
  //             .indexWhere((mainProductsElement) {
  //           return mainProductsElement.sId == inventories.sId;
  //         });
  //         if (index != -1) {
  //           inventories.quntity?.value =
  //               getCartIDModel.value?.inventories?[index].quantity ?? 0;
  //           inventories.isQunitityAdd!.value = true;
  //         }
  //       }
  //       for (Products products
  //           in autoCompleteProductsByStoreModel.value?.data?.products ?? []) {
  //         int index = (getCartIDModel.value?.products ?? [])
  //             .indexWhere((mainProductsElement) {
  //           return mainProductsElement.sId == products.sId;
  //         });
  //         if (index != -1) {
  //           products.quntity?.value =
  //               getCartIDModel.value?.products?[index].quantity ?? 0;
  //           products.isQunitityAdd!.value = true;
  //         }
  //       }
  //     }
  //     isLoadingGetProducts.value = false;
  //   } catch (e, st) {
  //     isLoadingGetProducts.value = false;
  //   }
  // }

  // Future<void> addToCartInventory({
  //   required String store_id,
  //   required String cart_id,
  //   required String name,
  //   required String sId,
  //   required int quntity,
  // }) async {
  //   try {
  //     Products products = Products(
  //       name: name,
  //       sId: sId,
  //       quntity: quntity.obs,
  //     );
  //     isLoading.value = true;
  //     cartItemsModel = await MoreStoreService.addToCartInventory(
  //       inventory: products,
  //       store_id: store_id,
  //       cart_id: cart_id,
  //     );
  //     for (GetCartIdProducts allCartProducts
  //         in cartItemsModel?.products ?? []) {
  //       for (MainProducts mainProducts
  //           in storeDataModel?.data?.mainProducts ?? []) {
  //         int index = (mainProducts.products ?? []).indexWhere(
  //             (mainProductsElement) =>
  //                 mainProductsElement.sId == allCartProducts.sId);
  //         if (index != -1) {
  //           getCartIDModel.value?.totalItemsCount =
  //               cartItemsModel?.totalItemsCount;
  //           totalItemsCount = cartItemsModel?.totalItemsCount ?? 0;

  //           mainProducts.products?[index].quntity!.value =
  //               allCartProducts.quantity ?? 0;
  //           mainProducts.products?[index].isQunitityAdd!.value = true;
  //           rawItemsList.value = getCartIDModel.value?.rawitems ?? []; //56
  //         }
  //       }
  //     }
  //     refresh();
  //     // log("addToCartInventory.addToCartModel ${cartItemsModel?.toJson()}");
  //     isLoading.value = false;
  //   } catch (e, st) {
  //     isLoading.value = false;
  //   }
  // }

  // Future<void> getAndSetData() async {
  //   await Future.delayed(Duration(seconds: 1));
  //   final box = Boxes.getCommonBoolBox();
  //   final box2 = Boxes.getCommonBox();
  //   final flag = box.get(HiveConstants.REFER_FLAG);
  //   final flag2 = box2.get(HiveConstants.BONUS);
  //   if (flag ?? false) {
  //     _showBounsDialog(flag2 ?? '');
  //     final box = Boxes.getCommonBox();
  //     final flag = box.get(HiveConstants.REFERID);
  //     if (flag?.isNotEmpty ?? false) {
  //       bool isStore = flag?.contains("Store") ?? false;
  //       if (isStore) {
  //         _showStoreDialog(flag ?? '');
  //       }
  //     }
  //   }
  // }

  // void _showStoreDialog(String flag) {
  //   UserViewModel.setReferFlag(false);
  //   showDialog(
  //     barrierDismissible: true,
  //     context: Get.context!,
  //     builder: (BuildContext context) {
  //       return CustomDialog(
  //         title: 'Store',
  //         content: "Click on store button for go to store",
  //         buttontext: 'Store Button',
  //         onTap: () async {
  //           await getStoreData(id: flag);
  //           UserViewModel.setReferFlag(false);
  //         },
  //       );
  //     },
  //   );
  // }

  // void _showBounsDialog(flag2) {
  //   UserViewModel.setReferFlag(false);
  //   showDialog(
  //     barrierDismissible: true,
  //     context: Get.context!,
  //     builder: (BuildContext context) {
  //       return CustomDialog(
  //         title: 'Bouns',
  //         content: "You get reward $flag2",
  //         buttontext: 'Ok',
  //         onTap: () async {
  //           Get.back();
  //           UserViewModel.setReferFlag(false);
  //         },
  //       );
  //     },
  //   );
  // }
}
