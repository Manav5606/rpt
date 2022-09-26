import 'package:get/get.dart';

class CartController extends GetxController {
  RxInt? items = 0.obs;

  void increment() {
    items!.value += 1;
  }

  void decrement() {
    items!.value -= 1;
  }
}
