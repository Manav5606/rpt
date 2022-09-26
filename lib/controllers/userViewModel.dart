import 'package:customer_app/app/data/model/user_model.dart';
import 'package:customer_app/app/data/provider/hive/hive.dart';
import 'package:customer_app/app/data/provider/hive/hive_constants.dart';
import 'package:customer_app/screens/authentication/repository/change_address.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserViewModel extends GetxController {
  static var userStatus = UserStatus.LOGGED_OUT.obs;

  static changeUserStatus(UserStatus status) => userStatus.value = status;

  static var user = UserModel().obs;

  static setUser(UserModel data) {
    user.value = data;
    final box = Boxes.getUserBox();
    box.put(HiveConstants.USER_KEY, data);
  }

  static var token = ''.obs;
  static var streamToken = ''.obs;
  static var bonus = ''.obs;
  static var signupFlag = false.obs;
  static var referFlag = false.obs;
  static var referId = ''.obs;

  static setToken(String data) {
    token.value = data;
    final box = Boxes.getCommonBox();
    box.put(HiveConstants.USER_TOKEN, data);
  }

  static setStreamToken(String data) {
    streamToken.value = data;
    final box = Boxes.getCommonBox();
    box.put(HiveConstants.STREAM_TOKEN, data);
  }
  static setBonus(String data) {
    bonus.value = data;
    final box = Boxes.getCommonBox();
    box.put(HiveConstants.BONUS, data);
  }

  static setSignupFlag(bool data) {
    signupFlag.value = data;
    final box = Boxes.getCommonBoolBox();
    box.put(HiveConstants.SIGNUP_FLAG, data);
  }

  static setReferFlag(bool data) {
    referFlag.value = data;
    final box = Boxes.getCommonBoolBox();
    box.put(HiveConstants.REFER_FLAG, data);
  }

  static setRefferralCode(String data) {
    referId.value = data;
    final box = Boxes.getCommonBox();
    box.put(HiveConstants.REFERID, data);
  }

  static var currentLocation = LatLng(0.0, 0.0).obs;

  static setLocation(LatLng latLng, [String? id]) {
    currentLocation.value = latLng;
    if (id != null) {
      ChangeAddressRepo.changeAddress(id);
    }
  }

  static saveUserToLocal(UserModel user) {
    final box = Boxes.getUserBox();
    box.put(HiveConstants.USER_KEY, user);
  }

  static var locationIndex = 0.obs;

  static setLocationIndex(int data) => locationIndex.value = data;
}

enum UserStatus { LOGGED_OUT, LOGGED_IN }
