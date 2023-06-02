import 'package:customer_app/screens/wallet/controller/paymentController.dart';
import 'package:get/get.dart';

class PaymentControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PaymentController());
  }
}
