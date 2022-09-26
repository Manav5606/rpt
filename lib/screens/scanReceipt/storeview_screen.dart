import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/ui/pages/stores/StoreViewProductList.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/scan_receipt/theBoss/view/TheBossCameraScreen.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../app/ui/pages/search/controller/exploreContoller.dart';

class ScanStoreViewScreen extends StatelessWidget {
  final ExploreController _exploreController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          actions: [
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  Get.to(() => TheBossCameraScreen(isWithStore: true));
                },
                child: Padding(
                  padding:
                      EdgeInsets.only(right: SizeUtils.horizontalBlockSize * 4),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppConst.grey,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeUtils.horizontalBlockSize * 3,
                          vertical: SizeUtils.verticalBlockSize * 0.5),
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          color: AppConst.black,
                          fontSize: SizeUtils.horizontalBlockSize * 4,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Orders",
                      style: TextStyle(
                          fontSize: SizeUtils.horizontalBlockSize * 7,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    height: SizeUtils.verticalBlockSize * 1,
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  StoreViewProductsList()
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () async {
                  await _exploreController.addItem();
                  Get.to(() => TheBossCameraScreen(isWithStore: true));
                },
                child: Container(
                  height: SizeUtils.verticalBlockSize * 7,
                  decoration: BoxDecoration(color: AppConst.kSecondaryColor),
                  child: Center(
                    child: Text(
                      "Continue",
                      style: TextStyle(
                          color: AppConst.white,
                          fontWeight: FontWeight.bold,
                          fontSize: SizeUtils.horizontalBlockSize * 5),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
