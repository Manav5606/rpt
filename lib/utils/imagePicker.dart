import 'dart:io';
//import 'package:dio/dio.dart';
import 'package:customer_app/config/gqlConfig.dart';
//import 'package:image_picker/image_picker.dart';

import 'package:permission_handler/permission_handler.dart';
/*
class ImageHelper {
  static Future<File?> pickImage(ImageSource source) async {
    if (await Permission.mediaLibrary.request().isGranted) {
      try {
        final pickedFile =
            await ImagePicker().getImage(source: source ?? ImageSource.gallery);
        if (pickedFile != null) {
          final File file = File(pickedFile.path);
          // final File croppedImage = await imageCropper(file);
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

  // static Future<File> imageCropper(File image) async{
  //   try{
  //     File croppedFile = await ImageCropper.cropImage(
  //         sourcePath: image.path,
  //         aspectRatioPresets: [
  //           CropAspectRatioPreset.square,
  //           CropAspectRatioPreset.ratio3x2,
  //           CropAspectRatioPreset.original,
  //           CropAspectRatioPreset.ratio4x3,
  //           CropAspectRatioPreset.ratio16x9
  //         ],
  //         androidUiSettings: AndroidUiSettings(
  //             toolbarTitle: 'Cropper',
  //             toolbarColor: AppConst.blue,
  //             toolbarWidgetColor: Colors.white,
  //             initAspectRatio: CropAspectRatioPreset.original,
  //             lockAspectRatio: false),
  //         iosUiSettings: IOSUiSettings(
  //           minimumAspectRatio: 1.0,
  //         )
  //     );
  //     return croppedFile;
  //   }catch(e){
  //     print(e.toString());
  //     return image;
  //   }
  // }

  static Future<String> uploadImage(File image) async {
    try {
      Dio dio = new Dio();
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(image.path, filename: fileName)
      });

      Response response =
          await dio.post("${GqlConfig.BASE_URL}/api/upload", data: formData);

      if (response.data['error']) {
        return 'https://www.denofgeek.com/wp-content/uploads/2019/02/mcu-1-iron-man.jpg';
      } else {
        return response.data['data']['img'];
      }
    } catch (e) {
      if (e.runtimeType == DioError) {
        DioError? error = e as DioError?;
        print(error!.response);
        print(error.message);
      } else {
        print(e.toString());
      }

      /// if somehow upload fails this is the fallback image url
      return 'https://www.denofgeek.com/wp-content/uploads/2019/02/mcu-1-iron-man.jpg';
    }
  }
}
*/
