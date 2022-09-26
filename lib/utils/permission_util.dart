import 'package:permission_handler/permission_handler.dart';

Future<bool> requestPermission() async {
  await Permission.storage.request();
  if (await Permission.storage.request().isGranted) {
    return true;
  } else {
    return false;
  }
}
