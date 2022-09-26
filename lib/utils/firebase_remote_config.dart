import 'package:firebase_remote_config/firebase_remote_config.dart';

class FirebaseRemoteConfigUtils {
  static final FirebaseRemoteConfigUtils _configUtils = FirebaseRemoteConfigUtils._internal();

  factory FirebaseRemoteConfigUtils() {
    return _configUtils;
  }

  FirebaseRemoteConfigUtils._internal();

  static const String homeScreenTempData = 'getOrderOnlinePageProductsData';

  static final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  static String get homeScreenTempString => _remoteConfig.getString(homeScreenTempData);

  Future<void> initMethod() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(fetchTimeout: const Duration(seconds: 1), minimumFetchInterval: const Duration(seconds: 0)),
    );
    await _remoteConfig.fetchAndActivate();
  }
}
