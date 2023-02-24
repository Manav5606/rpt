import 'dart:developer';

import 'package:customer_app/app/controller/add_location_controller.dart';
import 'package:customer_app/app/data/model/order_model.dart' as order_model;
import 'package:customer_app/app/data/model/user_model.dart';
import 'package:customer_app/app/data/repository/hive_repository.dart';
import 'package:customer_app/app/ui/pages/search/models/getCartId_model.dart';
import 'package:customer_app/app/ui/pages/search/service/exploreService.dart';
import 'package:customer_app/app/ui/pages/stores/chatOrder/chatorder_service.dart';
import 'package:customer_app/models/addcartmodel.dart';
import 'package:customer_app/screens/addcart/models/cartLocation_model.dart';
import 'package:customer_app/screens/addcart/models/cartPageInfo_model.dart';
import 'package:customer_app/screens/addcart/models/create_razorpay_model.dart';
import 'package:customer_app/screens/addcart/models/getOrderConfirmModel.dart';
import 'package:customer_app/screens/addcart/models/weekday_model.dart';
import 'package:customer_app/screens/more_stores/morestore_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../app/ui/pages/search/models/GetStoreDataModel.dart'
    as getStoreDataModel;
import '../../home/models/GetAllCartsModel.dart';
import '../models/review_cart_model.dart';
import '../services/addcart_service.dart';

class AddCartController extends GetxController {
  RxBool pickedup = false.obs;
  RxBool onTabChange = false.obs;
  RxString selectAddress = ''.obs;
  RxString selectAddressHouse = ''.obs;
  RxString timeTitle = ''.obs;
  RxString timeZone = ''.obs;
  RxString timeTitleCustom = ''.obs;
  RxString timeZoneCustom = ''.obs;
  RxString deliveryMessage = ''.obs;
  RxString addTime = ''.obs;
  RxBool isLoading = false.obs;
  RxInt isPayNow = 0.obs;
  RxBool isPaymentDone = false.obs;
  UserModel? userModel;
  final HiveRepository hiveRepository = HiveRepository();
  RxInt currentSelectValue = 0.obs;
  RxInt currentSelectIndex = 0.obs;
  RxInt selectedDayIndex = 0.obs;
  RxInt selectedTimeIndex = (-1).obs;
  RxInt selectedTimeIndexForNextDay = (-1).obs;
  RxInt dayIndexForTimeSlot = 0.obs;
  RxInt selectTimeSheetIndex = 1.obs;
  RxInt selectDayIndex = 1.obs;
  RxInt totalValue = 0.obs;
  RxInt selectExpendTile = 0.obs;
  final currentDate = DateTime.now();
  final dayFormatter = DateFormat('MMMd');
  final dayNameFormatter = DateFormat('EEEE');
  final monthFormatter = DateFormat('MMM');
  RxBool isSelectFirstAddress = true.obs;
  RxBool isTodaySlotsAvailable = false.obs;
  RxBool isTomorrowSlotsAvailable = false.obs;
  Rx<Cart?> reviewCart = Cart().obs;
  RxString selectDay = ''.obs;
  RxString currentDay = ''.obs;
  RxString currentHour = ''.obs;
  RxString displayHour = ''.obs;
  RxString NextDaydisplayHour = ''.obs;
  RxString cartId = ''.obs;
  RxString selectPaymentMode = ''.obs;
  RxString selectWalletMode = 'yes'.obs;
  RxString totalCount = '0'.obs;
  Rx<Carts?> cart = Carts().obs;
  Rx<GetCartIDModel?> getCartIDModel = GetCartIDModel().obs;
  Rx<AddToCartModel?> addToCartModel = AddToCartModel().obs;
  Rx<Carts?> cartIndex = Carts().obs;

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

  // Rx<GetOrderConfirmPageData?> getCartPageInformationModel =
  //     GetOrderConfirmPageData().obs;
  Rx<CartLocationModel?> cartLocationModel = CartLocationModel().obs;
  Rx<order_model.OrderData?> orderModel = order_model.OrderData().obs;
  Rx<Store?> store = Store().obs;
  Rx<Slots?> timeSlots = Slots().obs;
  Rx<DayTimeSlots?> dayTimeSlots = DayTimeSlots().obs;

  Rx<CreateRazorpayResponse?> createRazorpayResponseModel =
      CreateRazorpayResponse().obs;
  Rx<Addresses?> selectAddressIndex = Addresses().obs;
  Rx<GetOrderConfirmPageData?> getOrderConfirmPageDataModel =
      GetOrderConfirmPageData().obs;
  RxList<DeliverySlots?> deliverySlots = <DeliverySlots>[].obs;
  RxList<Slots>? remainingSlotForDay = <Slots>[].obs;
  RxList<Slots>? nextDaySlots = <Slots>[].obs;
  final AddLocationController _addLocationController = Get.find();

  void getUserData() {
    if (hiveRepository.hasUser()) {
      userModel = hiveRepository.getCurrentUser();
    }
  }

  String formatDate() {
    try {
      remainingSlotForDay?.clear();
      remainingSlotForDay?.refresh();
      nextDaySlots?.clear();
      nextDaySlots?.refresh();
      DateTime date = DateTime.now();

      currentDay.value = date.weekday.toString();
      currentHour.value = date.hour.toString();
      if (currentDay.value == "7") {
        currentDay.value = "0";
      }
      var CurrentDaySlots = getOrderConfirmPageDataModel
          .value?.data?.deliverySlots?[int.parse(currentDay.value)].slots;

      var CurrentDayStatus = getOrderConfirmPageDataModel
          .value?.data?.deliverySlots?[int.parse(currentDay.value)].status;
      var NextDaySlots;
      var NextDaySlotsStatus;
      if (currentDay.value == "6") {
        NextDaySlots =
            getOrderConfirmPageDataModel.value?.data?.deliverySlots?[0].slots;
        NextDaySlotsStatus =
            getOrderConfirmPageDataModel.value?.data?.deliverySlots?[0].status;
      } else {
        NextDaySlots = getOrderConfirmPageDataModel
            .value?.data?.deliverySlots?[int.parse(currentDay.value) + 1].slots;
        NextDaySlotsStatus = getOrderConfirmPageDataModel.value?.data
            ?.deliverySlots?[int.parse(currentDay.value) + 1].status;
      }

      //get todays available slots
      if (CurrentDayStatus == true) {
        for (var slots in CurrentDaySlots!) {
          isTodaySlotsAvailable.value = true;

          if ((slots.startTime?.hour ?? 0) >
              int.parse(currentHour.value.toString())) {
            if (slots.status == true) {
              remainingSlotForDay?.add(slots);
            }
          }
        }
        //get tomorrows all slots
        if (NextDaySlotsStatus == true) {
          for (var slots in NextDaySlots!) {
            isTomorrowSlotsAvailable.value = true;
            if (slots.status == true) {
              nextDaySlots?.add(slots);
              nextDaySlots?.refresh();
            }
          }
        }
      }
//check for todays slots available or not
      if (CurrentDayStatus == true) {
        for (var slots in CurrentDaySlots!) {
          isTodaySlotsAvailable.value = true;
          //get latest available slot for delivery
          if ((slots.startTime?.hour ?? 0) >
              int.parse(currentHour.value.toString())) {
            remainingSlotForDay?.add(slots);
            displayHour.value = slots.startTime?.hour.toString() ?? "";
            if (int.parse(displayHour.value) >= 12) {
              displayHour.value = 'By ${int.parse(displayHour.value) - 12} PM';
            } else {
              displayHour.value = 'By ${int.parse(displayHour.value)} AM';
            }

            break;
          } else {
            currentDay.value = (date.weekday).toString();
            if (currentDay.value == "7") {
              currentDay.value = "0";
            }
            log('currentDay.value :${currentDay.value}');
            log('date.weekday.value :${date.weekday}');
            var timeData = CurrentDaySlots.first;

            displayHour.value =
                "Tomorrow, ${timeType(timeData.startTime?.hour.toString())}  -  ${timeType(timeData.endTime?.hour.toString())}";
          }
        }
      } else {
        displayHour.value = 'No slots available for Today';
        isTodaySlotsAvailable.value = false;
      }
//check for tomorrows slots available or not
      for (var slots in NextDaySlots!) {
        if (displayHour.value == 'No slots available for Today') {
          if (NextDaySlotsStatus == true) {
            isTomorrowSlotsAvailable.value = true;
            if ((NextDaySlotsStatus == true)

                // (slots.startTime?.hour ?? 0) >
                //   int.parse(currentHour.value.toString())

                ) {
              if (slots.status == true) {
                nextDaySlots?.add(slots);
                nextDaySlots?.refresh();
              }
              NextDaydisplayHour.value = slots.startTime?.hour.toString() ?? "";
              if (int.parse(NextDaydisplayHour.value) >= 12) {
                NextDaydisplayHour.value =
                    'By ${int.parse(NextDaydisplayHour.value) - 12} PM';
              } else {
                NextDaydisplayHour.value =
                    'By ${int.parse(NextDaydisplayHour.value)} AM';
              }
              // break;
            } else {
              currentDay.value = (date.weekday).toString();
              if (currentDay.value == "7") {
                currentDay.value = "0";
              }
              log('currentDay.value :${currentDay.value}');
              log('date.weekday.value :${date.weekday}');
              var timeData = CurrentDaySlots?.first;

              NextDaydisplayHour.value =
                  "Tomorrow, ${timeType(timeData?.startTime?.hour.toString())}  -  ${timeType(timeData?.endTime?.hour.toString())}";
            }
          } else {
            displayHour.value = 'No slots available for Today & Tomorrow';
            isTomorrowSlotsAvailable.value = false;
          }
        }
      }

      // getOrderConfirmPageDataModel
      //     .value?.data?.deliverySlots?[int.parse(currentDay.value)].slots
      //     ?.forEach((element) {
      //   if ((element.startTime?.hour ?? 0) >
      //       int.parse(currentHour.value.toString())) {
      //     displayHour.value = element.startTime?.hour.toString() ?? "";
      //     if (int.parse(displayHour.value) >= 12) {
      //       displayHour.value = 'By ${int.parse(displayHour.value) - 12} PM';
      //     } else {
      //       displayHour.value = 'By ${int.parse(displayHour.value)} AM';
      //     }
      //   } else {
      //     currentDay.value = (date.weekday).toString();
      //     if (currentDay.value == "7") {
      //       currentDay.value = "0";
      //     }
      //     log('currentDay.value :${currentDay.value}');
      //     log('date.weekday.value :${date.weekday}');
      //     var timeData = getOrderConfirmPageDataModel.value?.data
      //         ?.deliverySlots?[int.parse(currentDay.value)].slots?.first;

      //     displayHour.value =
      //         "Tomorrow, ${timeType(timeData?.startTime?.hour.toString())}  -  ${timeType(timeData?.endTime?.hour.toString())}";
      //   }
      // }
      // );

      log("displayHour.value===${displayHour.value}");
      return DateFormat('H').format(date).toString();
    } catch (e, st) {
      log('eeeeeeeeeee :$e stt $st');
      return '';
    }
  }

  String timeType(String? time) {
    if (int.parse(time!) >= 12) {
      return time = '${int.parse(time) - 12} PM';
    } else {
      return time = '${int.parse(time)} AM';
    }
  }

  Future<void> getReviewCartData({required String cartId}) async {
    try {
      isLoading.value = true;
      reviewCart.value = await AddCartService.getReviewCartData(cartId);
      totalCount.value =
          reviewCart.value?.data?.totalItemsCount.toString() ?? '';
      log('totalCount.value:${totalCount.value}');
      isLoading.value = false;
    } catch (e, st) {
      isLoading.value = false;
    }
  }

  // Future<void> getCartPageInformation({required String storeId}) async {
  //   try {
  //     isLoading.value = true;
  //     getOrderConfirmPageDataModel.value =
  //         await AddCartService.getCartPageInformation(storeId);
  //     deliverySlots.addAll(
  //         getOrderConfirmPageDataModel.value?.data?.deliverySlots ?? []);
  //     isLoading.value = false;
  //   } catch (e, st) {
  //     isLoading.value = false;
  //   }
  // }

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
      reviewCart.value?.data?.rawItems = cart.value?.rawItems;
      totalCount.value = cart.value?.totalItemsCount?.value.toString() ?? '';
      log('totalCount.value :${totalCount.value}');
      reviewCart.refresh();
      isLoading.value = false;
    } catch (e, st) {
      isLoading.value = false;
    }
  }

  Future<void> addToCartProduct({
    // var product,
    required String store_id,
    required String cart_id,
    required bool increment,
    required int index,
    required String name,
    required String sId,
    required int quntity,
  }) async {
    try {
      var products = ProductsClass(
        name: name,
        sId: sId,
        quantity: quntity.obs,
      );
      isLoading.value = true;
      addToCartModel.value = await ExploreService.addToCart(
          product: products,
          store_id: store_id,
          increment: increment,
          index: index,
          cart_id: cart_id);

      cartIndex.value?.totalItemsCount?.value =
          addToCartModel.value?.totalItemsCount ?? 0;
      cartIndex.refresh();
      isLoading.value = false;
    } catch (e, st) {
      isLoading.value = false;
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
      var products = ProductsClass(
        name: name,
        sId: sId,
        quantity: quntity.obs,
      );
      isLoading.value = true;
      getCartIDModel.value = await MoreStoreService.addToCartInventory(
        inventory: products,
        store_id: store_id,
        cart_id: cart_id,
      );
      // for (GetCartIdProducts allCartProducts
      //     in getCartIDModel.value?.products ?? []) {
      //   for (getStoreDataModel.MainProducts mainProducts
      //       in getStoreDataModel.value?.data?.mainProducts ?? []) {
      //     int index = (mainProducts.products ?? []).indexWhere(
      //         (mainProductsElement) =>
      //             mainProductsElement.sId == allCartProducts.sId);
      //     if (index != -1) {
      //       // getCartIDModel.value?.totalItemsCount =
      //       //     addToCartModel.value?.totalItemsCount;
      //       // totalItemsCount.value = addToCartModel.value?.totalItemsCount ?? 0;

      //       mainProducts.products?[index].quntity!.value =
      //           allCartProducts.quantity ?? 0;
      //       mainProducts.products?[index].isQunitityAdd!.value = true;
      //       // rawItemsList.value = getCartIDModel.value?.rawitems ?? []; //56
      //     }
      //   }
      // }
      getCartIDModel.refresh();
      log("addToCartInventory.addToCartModel ${getCartIDModel.toJson()}");
      isLoading.value = false;
    } catch (e, st) {
      isLoading.value = false;
    }
  }

  Future<void> getCartLocation(
      {required String storeId, required String cartId}) async {
    try {
      isLoading.value = true;
      cartLocationModel.value =
          await AddCartService.getCartLocation(storeId, cartId);
      isLoading.value = false;
    } catch (e, st) {
      isLoading.value = false;
    }
  }

  Future<void> selectCartLocation(
      {required String cardId, required Addresses? addresses}) async {
    try {
      isLoading.value = true;
      await AddCartService.selectCartLocation(cardId, addresses!);
      isLoading.value = false;
    } catch (e, st) {
      isLoading.value = false;
    }
  }

  Future<void> createRazorPayOrder(
      {required String storeId, required double amount}) async {
    try {
      isLoading.value = true;
      createRazorpayResponseModel.value =
          await AddCartService.createRazorPayOrder(
              storeId: storeId, amount: amount);
      isLoading.value = false;
    } catch (e, st) {
      isLoading.value = false;
    }
  }

  Future<void> finalPlaceOrder({
    required var store,
    required var rawItem,
    required var products,
    required var inventories,
    required double total,
    required double previous_total_amount,
    required double final_payable_amount,
    required String order_type,
    required String cartId,
    required String razorPayOrderId,
    required String razorPaySignature,
    required String razorPayPaymentId,
    required String address,
    required double walletAmount,
    required double lat,
    required double lng,
    required int packagingFee,
    // required int bill_discount_offer_amount,
    // required int bill_discount_offer_target,
    // required int omit_bill_amount,
    required int deliveryFee,
    required bool pickedup,
    // required bool bill_discount_offer_status,
    required var deliveryTimeSlot,
  }) async {
    try {
      isLoading.value = true;
      orderModel.value = await AddCartService.finalPlaceOrder(
          store: store,
          cartId: cartId,
          rawItem: rawItem,
          products: products,
          inventories: inventories,
          total: total,
          previous_total_amount: previous_total_amount,
          order_type: order_type,
          razorPayOrderId: razorPayOrderId,
          razorPaySignature: razorPaySignature,
          razorPayPaymentId: razorPayPaymentId,
          final_payable_amount: final_payable_amount,
          address: address,
          walletAmount: walletAmount,
          lat: lat,
          lng: lng,
          packagingFee: packagingFee,
          // bill_discount_offer_amount: bill_discount_offer_amount,
          // bill_discount_offer_status: bill_discount_offer_status,
          // bill_discount_offer_target: bill_discount_offer_target,
          // omit_bill_amount: omit_bill_amount,
          deliveryFee: deliveryFee,
          deliveryTimeSlot: deliveryTimeSlot,
          pickedup: pickedup);
      isLoading.value = false;
    } catch (e, st) {
      isLoading.value = false;
      // return false;
    }
  }

  Future<void> postOrderCustomerCollectAmount({
    required String razorPayOrderId,
    required String razorPaySignature,
    required String razorPayPaymentId,
    required String orderId,
  }) async {
    try {
      isLoading.value = true;
      orderModel.value = await AddCartService.postOrderCustomerCollectAmount(
        razorPayOrderId: razorPayOrderId,
        razorPaySignature: razorPaySignature,
        razorPayPaymentId: razorPayPaymentId,
        orderId: orderId,
      );
      isLoading.value = false;
    } catch (e, st) {
      isLoading.value = false;
      // return false;
    }
  }

  Future<bool> placeOrderActive({
    required String store,
    required String razorPayOrderId,
    required String razorPaySignature,
    required String razorPayPaymentId,
  }) async {
    try {
      isLoading.value = true;
      var temp = await AddCartService.placeOrderActive(
        storeId: store,
        razorPayOrderId: razorPayOrderId,
        razorPaySignature: razorPaySignature,
        razorPayPaymentId: razorPayPaymentId,
      );
      isLoading.value = false;
      return temp;
    } catch (e, st) {
      isLoading.value = false;
      return false;
    }
  }

  Future<void> getOrderConfirmPageData(
      {required String storeId,
      required bool pickedup,
      required double distance,
      required int walletAmount,
      var products,
      var inventories}) async {
    try {
      isLoading.value = true;

      getOrderConfirmPageDataModel.value =
          await AddCartService.getOrderConfirmPageData(
              storeId: storeId,
              pickedup: pickedup,
              distance: distance,
              walletAmount: 0,
              products: products,
              inventories: inventories);
      getOrderConfirmPageDataModel.refresh();
      // deliverySlots.addAll(getOrderConfirmPageDataModel.value?.data?.deliverySlots ?? []);
      isLoading.value = false;
    } catch (e, st) {
      isLoading.value = false;
    }
  }

  RxList<WeekDay> weekDayList = <WeekDay>[].obs;

  void getNextSevenDays() {
    weekDayList.clear();
    for (int i = 0; i < 7; i++) {
      final date = currentDate.add(Duration(days: i));
      weekDayList.add(
        WeekDay(
            day: dayNameFormatter.format(date),
            date: dayFormatter.format(date),
            value:
                (dayNameFormatter.format(date) == 'Sunday') ? 0 : date.weekday),
      );
    }
    selectDay.value = weekDayList[selectedDayIndex.value].day ?? '';
    dayIndexForTimeSlot.value = weekDayList[selectedDayIndex.value].value ?? 0;
  }

  void SelectedAddressForCart() {
    //Select the lat lng from user location
    final userlocation = cartLocationModel.value?.addresses;

    var deliveryAddLat;
    var deliveryAddLng;

    if (userlocation != null && (userlocation.length) > 0) {
      for (var i = 0; i < userlocation.length; i++) {
        if (_addLocationController.latitude.value ==
            userlocation[i].location?.lat) {
          deliveryAddLat = userlocation[i].address;

          break;
        }
      }

      for (var i = 0; i < userlocation.length; i++) {
        if (_addLocationController.longitude.value ==
            userlocation[i].location?.lng) {
          deliveryAddLng = userlocation[i].address;

          break;
        }
      }
    }
    // if (Lngpresent == true && Latpresent == true) {}
    if ((deliveryAddLat != null && deliveryAddLng != null) &&
        (deliveryAddLat == deliveryAddLng)) {
      selectAddress.value = deliveryAddLng;
      _addLocationController.userAddress.value = deliveryAddLng;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUserData();
    getNextSevenDays();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}

class ProductsClass {
  String? sId;

  String? name;

  RxInt? quantity = 0.obs;

  ProductsClass({
    this.sId,
    this.name,
    this.quantity,
  });

  ProductsClass.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];

    name = json['name'];

    quantity?.value = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;

    data['name'] = this.name;

    data['quantity'] = this.quantity?.value;

    return data;
  }
}
