import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:customer_app/app/controller/add_location_controller.dart';
import 'package:customer_app/app/data/model/get_claim_rewards_model.dart';
import 'package:customer_app/constants/app_const.dart';

import 'package:get/get.dart';

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
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            statusBarColor: AppConst.kSecondaryColor,
          ),
          backgroundColor: AppConst.kSecondaryColor,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
            ),
            color: AppConst.white,
            splashRadius: 25,
          ),
          actions: [
            Center(
              child: GestureDetector(
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
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Save'),
                ),
              ),
            ),
          ],
        ),
        body: ListView.separated(
          itemCount: _addLocationController.allStores.length,
          itemBuilder: (BuildContext context, int index) {
            final Stores store = _addLocationController.allStores[index];
            return OfferCard(
              stores: store,
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider();
          },
        ),
      ),
    );
  }
}
