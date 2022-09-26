import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:customer_app/config/gqlConfig.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageHelper {
  static Future<File?> pickImage(ImageSource source) async {
    if (await Permission.mediaLibrary.request().isGranted) {
      try {
        final pickedFile = await ImagePicker().getImage(source: source);
        if (pickedFile != null) {
          final File file = File(pickedFile.path);
          return file;
        } else {
          return null;
        }
      } catch (e) {
        print(e.toString());
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<String> uploadImage(File image) async {
    try {
      Dio dio = Dio();
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap({"file": await MultipartFile.fromFile(image.path, filename: fileName)});
      Response response = await dio.post("${GqlConfig.BASE_URL_Upload}/api/upload", data: formData);
      if (response.data['error']) {
        return 'https://www.denofgeek.com/wp-content/uploads/2019/02/mcu-1-iron-man.jpg';
      } else {
        return response.data['data']['img'];
      }
    } catch (e) {
      print(e.toString());
      return 'https://www.denofgeek.com/wp-content/uploads/2019/02/mcu-1-iron-man.jpg';
    }
  }
}
