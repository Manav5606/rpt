import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:get/get.dart';

import '../../../constants/app_const.dart';
import '../../../constants/string_resources.dart';
import '../../../data/repositories/mainRepoWithAllApi.dart';
import '../../../data/repositories/new_main_api.dart';
import '../../../main.dart';
import '../../../widgets/copied/confirm_dialog.dart';
import '../../view/purchased_products_screen.dart';

class TheBossCameraScreen extends StatefulWidget {
  final StoreModel? storeModel;
  final bool isWithStore;

  TheBossCameraScreen({this.storeModel, this.isWithStore = false});

  // late List<CameraDescription> cameras;

  @override
  _TheBossCameraScreenState createState() => _TheBossCameraScreenState();
}

class _TheBossCameraScreenState extends State<TheBossCameraScreen>
    with WidgetsBindingObserver {
  late CameraController controller;

  RxBool flashOn = false.obs;
  RxBool longReceipt = false.obs;
  RxBool camLoading = false.obs;
  RxList images = <File>[].obs;

  @override
  void initState() {
    flashOn.value = false;
    longReceipt.value = false;
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
          subTitle: "You haven't clicked any photo of your bill.",
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
    return WillPopScope(
      onWillPop: handleBackPressed,
      child: Scaffold(
        backgroundColor: AppConst.black,
        appBar: AppBar(
          backgroundColor: AppConst.black,
          iconTheme: IconThemeData(color: AppConst.white),
          title: Text(
            StringResources.cameraViewAppBarTitle,
            style: TextStyle(
                fontFamily: 'Stag',
                fontWeight: FontWeight.w500,
                fontSize: SizeUtils.horizontalBlockSize * 5),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Obx(() {
                if (longReceipt.value) {
                  return _buildFlashController();
                } else {
                  return SizedBox();
                }
              }),
              Expanded(
                child: CameraPreview(controller),
              ),
              _buildCameraButtons()
            ],
          ),
        ),
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

  void onDone() {
    if (widget.isWithStore) {
      Get.toNamed(AppRoutes.MyCartScreen, arguments: images);
    } else {
      Get.off(
          PurchasedProductsScreen(
              storeModel: widget.storeModel, isWithStore: widget.isWithStore),
          arguments: images);
    }
  }

  _buildCameraButtons() => Column(
        children: [
          SizedBox(height: 8),
          GestureDetector(
            onTap: () {},
            child: Text(
              StringResources.cameraViewBtnAddLater,
              style: TextStyle(
                  fontSize: SizeUtils.horizontalBlockSize * 4,
                  fontFamily: 'open',
                  fontWeight: FontWeight.w600,
                  color: AppConst.white),
            ),
          ),
          Container(
            color: AppConst.black,
            // height: 100,
            width: Get.width,
            child: Row(
              // mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(() => SizedBox(
                    height: 100,
                    width: 50,
                    child: longReceipt.value
                        ? Stack(
                            children: [
                              Positioned.fill(
                                child: Container(
                                  margin: const EdgeInsets.only(top: 12.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppConst.white, width: 1.0)),
                                  child: images.length > 0
                                      ? Image.file(
                                          images.last,
                                          fit: BoxFit.fill,
                                        )
                                      : SizedBox.expand(),
                                ),
                              ),
                              Positioned(
                                top: 0.0,
                                right: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppConst.kPrimaryColor),
                                  padding: EdgeInsets.all(6),
                                  child: Text(
                                    '${images.length}',
                                    style: TextStyle(
                                        color: AppConst.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            ],
                          )
                        : _buildFlashController())),
                photoClickButton(),
                LongBillButton(),
              ],
            ),
          ),
        ],
      );

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

                      if (!longReceipt.value) {
                        //if its not long receipt directly move customer to purchase screen/
                        onDone();
                      }
                    } catch (e) {
                      Get.showSnackbar(GetBar(
                          title: "Error",
                          message: "Photo of this bill couldn't be taken"));
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

  Widget LongBillButton() {
    return Obx(() => longReceipt.value
        ? InkWell(
            onTap: (images.length > 0) ? onDone : null,
            borderRadius: BorderRadius.circular(6),
            child: Container(
              width: 70.0,
              height: 40.0,
              decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: AppConst.white),
                  borderRadius: BorderRadius.circular(12.0)),
              child: Center(
                child: Text(
                  'Done',
                  style: AppConst.header2.copyWith(color: AppConst.white),
                ),
              ),
            ),
          )
        : Column(
            children: [
              IconButton(
                onPressed: () {
                  longReceipt.value = !longReceipt.value;
                },
                icon: Icon(
                  Icons.receipt_long_rounded,
                  color: AppConst.white,
                  size: SizeUtils.horizontalBlockSize * 7,
                ),
              ),
              Text(
                StringResources.cameraViewBtnLongBill,
                style: TextStyle(
                    color: AppConst.white,
                    fontSize: SizeUtils.horizontalBlockSize * 3,
                    fontFamily: 'open',
                    fontWeight: FontWeight.w600),
              )
            ],
          ));
  }
}
