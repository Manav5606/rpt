import 'package:customer_app/app/data/model/address_model.dart';
import 'package:customer_app/app/data/model/user_model.dart';
import 'package:customer_app/app/data/model/wallet_model.dart';
import 'package:customer_app/app/data/provider/hive/hive_constants.dart';
import 'package:customer_app/app/ui/pages/search/models/recentProductsData.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveHelper {
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(AddressModelAdapter());
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(CoordinateModelAdapter());
    Hive.registerAdapter(WalletAdapter());
    Hive.registerAdapter(RecentProductsDataAdapter());
    Hive.registerAdapter(RecentProductsDataModelAdapter());

    await openInitialBoxes();
  }

  static openInitialBoxes() async {
    await Hive.openBox<UserModel>(HiveConstants.USER_KEY);
    await Hive.openBox<String>('common');
    await Hive.openBox<bool>('commonBool');
    await Hive.openBox<String>(HiveConstants.ALL_WALLET_KEY);
    await Hive.openBox(HiveConstants.GET_NEAR_PAGE_DATA_PRODUCT);
    await Hive.openBox(HiveConstants.GET_SCAN_NEAR_PAGE_DATA_PRODUCT);
  }
}
