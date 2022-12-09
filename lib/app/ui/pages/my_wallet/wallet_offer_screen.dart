import 'package:customer_app/app/constants/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:customer_app/app/controller/add_location_controller.dart';
import 'package:customer_app/app/data/model/get_claim_rewards_model.dart';
import 'package:customer_app/constants/app_const.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'widgets/offer_card.dart';

class WalletOfferScreen extends StatelessWidget {
  final AddLocationController _addLocationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: AppConst.white,
              statusBarIconBrightness: Brightness.dark),
          // backgroundColor: Color(0xff005b41),
          title: Row(
            children: [
              SizedBox(
                width: 5.w,
              ),
              SizedBox(
                height: 3.5.h,
                child: Image(
                  image: AssetImage(
                    'assets/images/Redeem.png',
                  ),
                ),
              ),
              SizedBox(
                width: 4.w,
              ),
              Text("Select Wallets",
                  style: TextStyle(
                    fontFamily: 'MuseoSans',
                    color: AppConst.black,
                    fontSize: SizeUtils.horizontalBlockSize * 4.5,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  )),
              Spacer(),
              GestureDetector(
                onTap: () async {
                  if (_addLocationController.storesCount.value !=
                      _addLocationController.updatedStoresCount.value) {
                    try {
                      await _addLocationController.addMultipleStoreToWallet();
                      Get.back();
                    } catch (e) {
                      Get.back();
                    }
                  }
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Text('Save',
                      style: TextStyle(
                        fontFamily: 'MuseoSans',
                        color: AppConst.black,
                        fontSize: SizeUtils.horizontalBlockSize * 4.5,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      )),
                ),
              ),
            ],
          ),
          // actions: [
          //   Center(
          //     child: GestureDetector(
          //       onTap: () async {
          //         if (_addLocationController.storesCount.value !=
          //             _addLocationController.updatedStoresCount.value) {
          //           try {
          //             await _addLocationController.addMultipleStoreToWallet();
          //             Get.back();
          //           } catch (e) {
          //             Get.back();
          //           }
          //         }
          //       },
          //       child: Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Text('Save'),
          //       ),
          //     ),
          //   ),
          // ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
                child: Text(
                    "The cashback you have earned from each stores are shown below. ",
                    style: TextStyle(
                      fontFamily: 'MuseoSans',
                      color: AppConst.black,
                      fontSize: SizeUtils.horizontalBlockSize * 4,
                      fontWeight: FontWeight.w300,
                      fontStyle: FontStyle.normal,
                    )),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: _addLocationController.allStores.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Stores store =
                        _addLocationController.allStores[index];
                    return OfferCard(
                      stores: store,
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      child: Container(height: 1, color: AppConst.grey),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
