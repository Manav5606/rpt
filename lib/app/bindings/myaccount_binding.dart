import 'package:customer_app/app/controller/account_controller.dart';
import 'package:customer_app/app/data/repository/hive_repository.dart';
import 'package:customer_app/app/data/repository/my_account_repository.dart';

import 'package:get/get.dart';

class MyAccountBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyAccountController>(
        () => MyAccountController(MyAccountRepository(), HiveRepository()));
  }
}
