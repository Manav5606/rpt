import 'package:customer_app/app/controller/add_location_controller.dart';
import 'package:customer_app/screens/home/controller/home_controller.dart';
import 'package:get/get.dart';

class HomeControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}