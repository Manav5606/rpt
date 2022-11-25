import 'dart:developer';
import 'package:customer_app/app/data/model/active_order_model.dart';
import 'package:customer_app/app/data/repository/my_account_repository.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:customer_app/app/data/model/order_model.dart';
import 'package:customer_app/app/data/model/user_model.dart';
import 'package:customer_app/app/data/model/wallet_model.dart';
import 'package:customer_app/app/data/provider/hive/hive.dart';
import 'package:customer_app/app/data/provider/hive/hive_constants.dart';
import 'package:customer_app/app/data/repository/hive_repository.dart';
import 'package:customer_app/app/data/serivce/dynamic_link_service.dart';
import 'package:customer_app/app/utils/image_util.dart';
import 'package:get/get.dart';

class MyAccountController extends GetxController {
  final MyAccountRepository remote;
  final HiveRepository local;
  RxString selectDay = ''.obs;
  RxString currentDay = ''.obs;
  RxString currentHour = ''.obs;
  RxString displayHour = ''.obs;
  RxString referCode = ''.obs;
  RxInt selectIndex = 0.obs;

  MyAccountController(this.remote, this.local);

  // final dynamicLinkSercive = Get.find<DynamicLinkService>();
  final FlutterShareMe flutterShareMe = FlutterShareMe();
  final _user = UserModel().obs;

  set user(value) => this._user.value = value;

  UserModel get user => this._user.value;
  final _wallets = <Wallet>[].obs;

  set wallets(value) => this._wallets.value = value;

  List<Wallet> get wallets => this._wallets;

  // final _activeOrders = OrderModel().obs;
  Rx<OrderModel?> allOrdersModel = OrderModel().obs;
  Rx<ActiveOrderModel?> activeOrdersModel = ActiveOrderModel().obs;

  // Rx<ActiveOrderData> activeOrders = ActiveOrderData().obs;
  // final _allOrders = OrderModel().obs;
  RxBool isOrderloading = false.obs;
  RxBool isActiveOrderloading = false.obs;

  // set activeOrders(value) => this._activeOrders.value = value;
  // set allOrders(value) => this._allOrders.value = value;
  // OrderModel get activeOrders => this._activeOrders.value;
  // OrderModel get allOrders => this._allOrders.value;

  getUserData() {
    if (local.hasUser()) {
      //this.user = local.getCurrentUser();
      remote.getCurrentUser().then((value) => this.user = value);
    } else {}
    // if (local.hasUser()) {
    //this.user = local.getCurrentUser();
    remote.getCurrentUser().then((value) => this.user = value);
    // } else {}
  }

  getAllWallets() {
    if (local.hasWallets()) {
      return this.wallets = local.getWallets();
    } else {
      remote.getAllWallet().then((value) {
        final box = Boxes.getWalletBox();
        box.put(HiveConstants.ALL_WALLET_KEY, value!);
        this.wallets = value;
      });
    }
  }

  formatDate() {
    if (activeOrdersModel.value?.data?[selectIndex.value].deliverySlot?.day !=
        null) {
      DateTime date = DateTime.now();
      currentDay.value = date.weekday.toString();
      currentHour.value = date.hour.toString();
      if (currentDay.value == "7") {
        currentDay.value = "0";
      }
      if (currentDay.value ==
          activeOrdersModel.value?.data?[selectIndex.value].deliverySlot?.day
              .toString()) {
        displayHour.value = activeOrdersModel
                .value!.data?[selectIndex.value].deliverySlot?.startTime?.hour
                .toString() ??
            "";
        var endtime = activeOrdersModel
                .value!.data?[selectIndex.value].deliverySlot?.endTime?.hour
                .toString() ??
            "";
        if (int.parse(displayHour.value) >= 12) {
          displayHour.value =
              'Today ${int.parse(displayHour.value) - 12} PM - ${int.parse(endtime) - 12} PM ';
        } else {
          displayHour.value =
              'Today ${int.parse(displayHour.value)} AM - ${int.parse(endtime) - 12} AM';
        }
      } else {
        displayHour.value = activeOrdersModel
                .value!.data?[selectIndex.value].deliverySlot?.startTime?.hour
                .toString() ??
            "";
        var endtime = activeOrdersModel
                .value!.data?[selectIndex.value].deliverySlot?.endTime?.hour
                .toString() ??
            "";
        if (int.parse(displayHour.value) >= 12) {
          displayHour.value =
              '${orderStatus(currentDay.value)} ${int.parse(displayHour.value) - 12} PM - ${int.parse(endtime) - 12} PM ';
        } else {
          displayHour.value =
              '${orderStatus(currentDay.value)} ${int.parse(displayHour.value)} AM - ${int.parse(endtime) - 12} AM';
        }
      }
    } else {
      return "Delivery slot not define";
    }
    log('dfknreg fgfrg');
  }

  String orderStatus(currentDay) {
    switch (currentDay) {
      case '0':
        return 'Sunday';
      case '1':
        return 'Monday';
      case '2':
        return 'Tuesday';
      case '3':
        return 'Wednesday';
      case '4':
        return "Thursday";
      case '5':
        return "Friday";
      case '6':
        return "Saturday";
      default:
        return '0';
    }
  }

  shareToWhatsApp() async {
    final link = await DynamicLinkService().createDynamicLink(referCode.value);
    final image = await getImageFileFromAssets("images/account_banner.png");
    print("getImageFileFromAssets | asset path: ${image.path}");
    flutterShareMe.shareToWhatsApp(
        msg: "My earned balance is 300. You can join and earn also \n $link",
        imagePath: image.path);
  }

  shareToSystem() async {
    final link = await DynamicLinkService().createDynamicLink(referCode.value);
    flutterShareMe.shareToSystem(
        msg: "My earned balance is 300. You can join and earn also \n $link");
  }

  getActiveOrders() async {
    try {
      isActiveOrderloading.value = true;

      activeOrdersModel.value = await MyAccountRepository.getAllActiveOrders();
      log('activeordershere : ${activeOrdersModel.value?.data?.length}');
      activeOrdersModel.refresh();

      isActiveOrderloading.value = false;
    } catch (e, st) {
      isActiveOrderloading.value = false;
    }
    // MyAccountRepository.getAllActiveOrders()
    //     .then((value) => this.activeOrders = value);
  }

  Future<void> getOrders() async {
    try {
      isOrderloading.value = true;

      allOrdersModel.value = await MyAccountRepository.getAllOrders();
      log('allordershere : ${allOrdersModel.value?.data?.length}');
      allOrdersModel.refresh();

      isOrderloading.value = false;
    } catch (e, st) {
      isOrderloading.value = false;
    }
    // MyAccountRepository.getAllOrders().then((value) => this.allOrders = value);
  }

  Future<void> getGenerateReferCode() async {
    referCode.value = await MyAccountRepository.getGenerateReferCode();
    log('referCode :${referCode.value}');
  }

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    // getActiveOrders();
    // getOrders();
    await getGenerateReferCode();
  }
}
