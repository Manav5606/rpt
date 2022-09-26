import 'package:customer_app/app/controller/add_location_controller.dart';
import 'package:get/get.dart';

class NewLocationScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddLocationController());
  }
}