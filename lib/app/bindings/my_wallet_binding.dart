import 'package:customer_app/app/controller/my_wallet_controller.dart';
import 'package:get/get.dart';

class MyWalletBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyWalletController>(() => MyWalletController());
  }
}
