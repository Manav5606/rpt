import 'package:customer_app/app/data/serivce/dynamic_link_service.dart';
import 'package:get/get.dart';

class DynamicLinkHelper {
  static void init() {
    Get.lazyPut<DynamicLinkService>(() => DynamicLinkService());

    final DynamicLinkService _dynamicLinkService = Get.find<DynamicLinkService>();
    _dynamicLinkService.retrieveDynamicLink();
  }
}
