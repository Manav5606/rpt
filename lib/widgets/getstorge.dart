import 'package:flutter/material.dart';
import 'package:customer_app/app/ui/pages/location_picker/address_model.dart';
import 'package:get_storage/get_storage.dart';

class AppSharedPreference {
  static final _getStorage = GetStorage();

  static const _recentAddress = 'RECENT_ADDRESS';

  static void setRecentAddress(List<RecentAddressDetails> data) {
    List<Map> tempRecentMap = [];
    List<RecentAddressDetails> tempRecentList = [];
    if (getRecentAddressHasData) {
      List<RecentAddressDetails> mapString = AppSharedPreference.getRecentAddress;
      tempRecentList.addAll(mapString);
    }
    tempRecentList.addAll(data);
    print("setRecentAddress SET : ${data.length}");
    for (var element in data) {
      tempRecentMap.add(element.toJson());
    }
    _getStorage.write(_recentAddress, tempRecentMap);
  }

  static List<RecentAddressDetails> get getRecentAddress {
    List<RecentAddressDetails> tmpRecentList = [];
    print("setRecentAddress GET :");
    List<dynamic> _getRecentAddress = _getStorage.read(_recentAddress);
    for (var element in _getRecentAddress) {
      tmpRecentList.add(RecentAddressDetails.fromJson(element));
    }
    print("setRecentAddress GET element: ${tmpRecentList.length}");
    return tmpRecentList;
  }

  static bool get getRecentAddressHasData => _getStorage.hasData(_recentAddress);

  static void clear() => _getStorage.erase();
}
