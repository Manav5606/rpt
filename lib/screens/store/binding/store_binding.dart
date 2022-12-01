import 'package:customer_app/screens/store/controller/store_controller.dart';
import 'package:get/get.dart';

class StoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(StoreController());
  }
}
