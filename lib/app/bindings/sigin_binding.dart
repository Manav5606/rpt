import 'package:customer_app/app/controller/signInScreenController.dart';
import 'package:get/get.dart';

class SignInScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInScreenController());
  }
}