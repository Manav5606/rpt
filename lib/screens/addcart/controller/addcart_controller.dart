import 'dart:developer';

import 'package:customer_app/app/data/model/order_model.dart' as order_model;
import 'package:customer_app/app/data/model/user_model.dart';
import 'package:customer_app/app/data/repository/hive_repository.dart';
import 'package:customer_app/app/ui/pages/stores/chatOrder/chatorder_service.dart';
import 'package:customer_app/screens/addcart/models/cartLocation_model.dart';
import 'package:customer_app/screens/addcart/models/cartPageInfo_model.dart';
import 'package:customer_app/screens/addcart/models/create_razorpay_model.dart';
import 'package:customer_app/screens/addcart/models/getOrderConfirmModel.dart';
import 'package:customer_app/screens/addcart/models/weekday_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
  RxInt dayIndexForTimeSlot = 0.obs;
  RxInt selectTimeSheetIndex = 1.obs;
  RxInt totalValue = 0.obs;
  RxInt selectExpendTile = 0.obs;
  final currentDate = DateTime.now();
  final dayFormatter = DateFormat('MMMd');
  final dayNameFormatter = DateFormat('EEEE');
  final monthFormatter = DateFormat('MMM');
  RxBool isSelectFirstAddress = true.obs;
  Rx<Cart?> reviewCart = Cart().obs;
  RxString selectDay = ''.obs;
  RxString currentDay = ''.obs;
  RxString currentHour = ''.obs;
  RxString displayHour = ''.obs;
  RxString cartId = ''.obs;
  RxString selectPaymentMode = ''.obs;
  RxString selectWalletMode = 'yes'.obs;
  RxString totalCount = '0'.obs;
  Rx<Carts?> cart = Carts().obs;
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

  void getUserData() {
    if (hiveRepository.hasUser()) {
      userModel = hiveRepository.getCurrentUser();
    }
  }

  String formatDate() {
    try {
      DateTime date = DateTime.now();

      currentDay.value = date.weekday.toString();
      currentHour.value = date.hour.toString();
      if (currentDay.value == "7") {
        currentDay.value = "0";
      }
      getOrderConfirmPageDataModel
          .value?.data?.deliverySlots?[int.parse(currentDay.value)].slots
          ?.forEach((element) {
        if ((element.startTime?.hour ?? 0) >
            int.parse(currentHour.value.toString())) {
          displayHour.value = element.startTime?.hour.toString() ?? "";
          if (int.parse(displayHour.value) >= 12) {
            displayHour.value = 'By ${int.parse(displayHour.value) - 12} PM';
          } else {
            displayHour.value = 'By ${int.parse(displayHour.value)} AM';
          }
        } else {
          currentDay.value = (date.weekday).toString();
          if (currentDay.value == "7") {
            currentDay.value = "0";
          }
          log('currentDay.value :${currentDay.value}');
          log('date.weekday.value :${date.weekday}');
          var timeData = getOrderConfirmPageDataModel.value?.data
              ?.deliverySlots?[int.parse(currentDay.value)].slots?.first;

          displayHour.value =
              "Tomorrow, ${timeType(timeData?.startTime?.hour.toString())}  -  ${timeType(timeData?.endTime?.hour.toString())}";
        }
      });

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
  }) async {
    try {
      isLoading.value = true;
      cart.value = await ChatOrderService.addToCartRaw(
          rawItem: rawItem,
          cartId: cartId,
          isEdit: isEdit,
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
    required int deliveryFee,
    required bool pickedup,
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
          order_type: order_type,
          razorPayOrderId: razorPayOrderId,
          razorPaySignature: razorPaySignature,
          razorPayPaymentId: razorPayPaymentId,
          address: address,
          walletAmount: walletAmount,
          lat: lat,
          lng: lng,
          packagingFee: packagingFee,
          deliveryFee: deliveryFee,
          deliveryTimeSlot: deliveryTimeSlot,
          pickedup: pickedup);
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
      required double distance,
      required double walletAmount,
      var products,
      var inventories}) async {
    try {
      isLoading.value = true;
      getOrderConfirmPageDataModel.value =
          await AddCartService.getOrderConfirmPageData(
              storeId: storeId,
              distance: distance,
              walletAmount: walletAmount,
              products: products,
              inventories: inventories);

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
