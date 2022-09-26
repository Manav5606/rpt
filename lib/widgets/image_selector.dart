import 'dart:io';

import 'package:flutter/material.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/utils/ui_spacing_helper.dart';
//import 'package:image_picker/image_picker.dart';

class SelectImageSecondaryWidget extends StatelessWidget {
  final File? imageFile;
  final Function? onTap;
  final Function? onRemove;
  final double? size;

  SelectImageSecondaryWidget(
      {this.imageFile, this.onTap, this.onRemove, this.size: 120.0});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => this.onTap,
        child: (this.imageFile != null)
            ? Stack(
                children: [
                  Container(
                    height: size,
                    width: size,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: AppConst.white,
                        border:
                            Border.all(color: AppConst.lightGrey, width: 3.0),
                        boxShadow: [
                          BoxShadow(
                            color: AppConst.black.withOpacity(0.1),
                            blurRadius: 5.0,
                            offset: new Offset(0.0, 3.0),
                          )
                        ]),
                    child: (imageFile != null)
                        ? Image.file(
                            imageFile!,
                            fit: BoxFit.fill,
                            width: size,
                            height: size,
                          )
                        : Icon(Icons.camera, size: 24.0),
                  ),
                  Positioned(
                    right: 0.0,
                    child: GestureDetector(
                      onTap: () => onRemove,
                      child: Container(
                        height: 24.0,
                        width: 24.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.0),
                          color: AppConst.themePurple,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Icon(
                            Icons.close,
                            color: AppConst.white,
                            size: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Container(
                width: 160.0,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: AppConst.themePurple.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(2.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.camera_alt,
                        color: AppConst.themePurple, size: 24.0),
                    UISpacingHelper.horizontalSpace12,
                    Text(
                      "Share Photo",
                      style:
                          AppConst.body.copyWith(color: AppConst.themePurple),
                    )
                  ],
                ),
              ));
  }
}

void pickImage(BuildContext context,
    {Function(/*PickedFile*/)? onFileSelected}) async {
  showModalBottomSheet(
      backgroundColor: AppConst.white,
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: 200.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  /*   selectImage(ImageSource.camera).then((file) {
                    if (onFileSelected != null) {
                      onFileSelected(file!);
                    }
                  });*/
                },
                child: Container(
                  height: 90.0,
                  width: 90.0,
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppConst.lightGrey, width: 2.0),
                      borderRadius: BorderRadius.circular(100.0),
                      color: AppConst.white,
                      boxShadow: [
                        BoxShadow(
                          color: AppConst.black.withOpacity(0.1),
                          blurRadius: 5.0,
                          offset: new Offset(0.0, 3.0),
                        )
                      ]),
                  child: Center(
                      child: Icon(
                    Icons.camera_alt_rounded,
                    size: 45.0,
                    color: AppConst.lightGrey,
                  )),
                ),
              ),
              UISpacingHelper.horizontalSpace32,
              GestureDetector(
                onTap: () {
                  /*   selectImage(ImageSource.gallery).then((file) {
                    if (onFileSelected != null) {
                      onFileSelected(file!);
                    }
                  });*/
                },
                child: Container(
                  height: 90.0,
                  width: 90.0,
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppConst.lightGrey, width: 2.0),
                      borderRadius: BorderRadius.circular(100.0),
                      color: AppConst.white,
                      boxShadow: [
                        BoxShadow(
                          color: AppConst.black.withOpacity(0.1),
                          blurRadius: 5.0,
                          offset: new Offset(0.0, 3.0),
                        )
                      ]),
                  child: Center(
                      child: Icon(
                    Icons.image_rounded,
                    size: 45.0,
                    color: AppConst.lightGrey,
                  )),
                ),
              ),
            ],
          ),
        );
      });
}
/*
Future<PickedFile?> selectImage(ImageSource source) async {
  final ImagePicker _picker = ImagePicker();
  final PickedFile? _file = await _picker.getImage(source: source);
  return _file;
}
*/
