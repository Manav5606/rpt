import 'package:customer_app/app/data/model/user_model.dart';
import 'package:customer_app/app/data/model/wallet_model.dart';
import 'package:customer_app/app/data/provider/hive/hive.dart';
import 'package:customer_app/app/data/provider/hive/hive_constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HiveRepository {
  bool hasUser() => Boxes.getUserBox().containsKey(HiveConstants.USER_KEY);

  UserModel getCurrentUser() {
    final box = Boxes.getUserBox();
    return box.get(HiveConstants.USER_KEY) ?? UserModel();
  }

  bool hasWallets() => Boxes.getUserBox().containsKey(HiveConstants.ALL_WALLET_KEY);

  List<Wallet> getWallets() {
    final box = Boxes.getWalletBox();
    return box.get(HiveConstants.ALL_WALLET_KEY)!;
  }

  var currentLocation = LatLng(0.0, 0.0);
}
