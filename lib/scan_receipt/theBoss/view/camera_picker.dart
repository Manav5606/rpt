import 'dart:io';

import 'package:camera/camera.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/ui/pages/chat/chatViewScreen.dart';
import 'package:customer_app/app/ui/pages/stores/storedetailscreen.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/main.dart';
import 'package:customer_app/widgets/backButton.dart';
import 'package:customer_app/widgets/copied/confirm_dialog.dart';
import 'package:customer_app/widgets/imagePicker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../../../data/repositories/main_repo.dart';

class CameraPicker extends StatefulWidget {
  Channel? channel;

  CameraPicker({this.channel});

  @override
  State<CameraPicker> createState() => _CameraPickerState();
}

class _CameraPickerState extends State<CameraPicker>
    with WidgetsBindingObserver {
  late CameraController controller;

  RxBool flashOn = false.obs;

  RxBool camLoading = false.obs;
  RxList images = <File>[].obs;

  @override
  void initState() {
    flashOn.value = false;

    camLoading.value = false;
    images.clear();
    //always in portrait mode

    controller = CameraController(
      cameras[0],
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    controller.initialize().then((_) {
      controller.setFlashMode(FlashMode.off);
      if (!mounted) return;
      setState(() {});
    });
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
  }

  void setFlash(bool value) {
    flashOn.value = value;
    controller.setFlashMode(flashOn.value ? FlashMode.torch : FlashMode.off);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    //todo: possible case of error here.
    // App state changed before we got the chance to initialize.
    if (controller == null || !controller.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      if (controller != null) {
        setFlash(false);
      }
      controller.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (controller != null) {
        onNewCameraSelected(controller.description);
      }
    }

    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    if (controller != null) {
      controller.dispose();
    }
    super.dispose();
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }
    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    controller = cameraController;

    // If the controller is updated then update the UI.

    cameraController.addListener(() {
      if (mounted) setState(() {});
      if (cameraController.value.hasError) {
        MainRepo.logger.e(cameraController.value.errorDescription);
      }
    });

    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      MainRepo.logger.e(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  Future<bool> handleBackPressed() async {
    if (images.length == 0) {
      SeeyaConfirmDialog(
          title: "Are you sure?",
          subTitle: "You haven't clicked any photo yet.",
          onCancel: () => Get.back(),
          onConfirm: () {
            //exit the dialog;
            Get.back();
            //exit this screen
            Get.back();
          }).show(context);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConst.black,
      // appBar: AppBar(backgroundColor: AppConst.transparent),
      body: SafeArea(
        child: Stack(children: [
          Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CameraPreview(controller),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildFlashController(),
                    photoClickButton(),
                    SizedBox(
                      height: 10.h,
                      width: 10.w,
                    )
                    // _buildCameraButtons()
                  ],
                ),
              )
            ],
          ),
          BackButtonCircle(),
        ]),
      ),
    );
  }

  _buildFlashController() {
    return Obx(() => GestureDetector(
          onTap: () => setFlash(!flashOn.value),
          child: Container(
            height: 44.0,
            width: 44.0,
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              !flashOn.value ? Icons.flash_off_rounded : Icons.flash_on_rounded,
              color: AppConst.white,
              size: SizeUtils.horizontalBlockSize * 7,
            ),
          ),
        ));
  }

  void onDone() async {
    // List<String> imageLinks = [];
    // for (File image in images) {
    //   imageLinks.add(await ImageHelper.uploadImage(image));
    // }
    // await channel!.sendImage(AttachmentFile(size: 20, path: imageLinks[0]
    //     // "/data/user/0/com.recipto.customer_app/cache/CAP150287181574112682.jpg"
    //     ));
    Get.back();
  }

  Widget photoClickButton() {
    return Obx(() => SizedBox(
          height: 70,
          width: 70,
          child: InkWell(
            onTap: (!camLoading.value)
                ? () async {
                    camLoading.value = !camLoading.value;

                    try {
                      XFile image;
                      image = await controller.takePicture();

                      File file = File(image.path);
                      images.add(file);

                      onDone();
                    } catch (e) {
                      Get.showSnackbar(GetBar(
                          title: "Error", message: "Photo couldn't be taken"));
                    } finally {
                      camLoading.value = !camLoading.value;
                    }
                  }
                : null,
            child: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppConst.white, width: 2)),
              child: camLoading.value
                  ? CircularProgressIndicator()
                  : Container(
                      height: 70,
                      width: 70,
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: AppConst.white),
                    ),
            ),
          ),
        ));
  }
}
