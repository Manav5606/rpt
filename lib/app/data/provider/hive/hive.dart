import 'package:customer_app/app/data/model/user_model.dart';
import 'package:customer_app/app/data/model/wallet_model.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<UserModel> getUserBox() => Hive.box<UserModel>('user');
  static Box<String> getCommonBox() => Hive.box<String>('common');
  static Box<bool> getCommonBoolBox() => Hive.box<bool>('commonBool');
  static Box<List<Wallet>> getWalletBox() => Hive.box<List<Wallet>>('all_wallets');
}
