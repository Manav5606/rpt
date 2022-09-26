import 'dart:io';

import 'package:flutter/services.dart';
import 'package:customer_app/utils/permission_util.dart';
import 'package:path_provider/path_provider.dart';

Future<File> getImageFileFromAssets(String path) async {
  print("getImageFileFromAssets | asset path: assets/$path");

  final byteData = await rootBundle.load('assets/$path');

  final permisssion = await requestPermission();
  if (!permisssion) {
    throw Error.safeToString("Permission Deniaied");
  }
  final file = File('${(await getApplicationDocumentsDirectory()).path}/banner.png');
  file.create();

  if (file.existsSync()) {
    print("getImageFileFromAssets | file exists: ${file.existsSync()}");
  }

  await file.writeAsBytes(byteData.buffer
      .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  return file;
}
