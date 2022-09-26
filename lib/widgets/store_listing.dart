import 'package:flutter/material.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/data/repositories/new_main_api.dart';
import 'package:customer_app/widgets/store_shop_now_tile.dart';
import 'package:get/get.dart';

class FavStoreListing extends StatelessWidget {
  final List<StoreModel>? data;

  const FavStoreListing({Key? key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return data!.length > 0
        ? ListView.builder(
            itemCount: data!.length,
            itemBuilder: (BuildContext context, int index) {
              StoreModel _store = data![index];
              return GestureDetector(
                onTap: () {
//Get.to(() => StoreView(storeData: _store));
                },
                child: Column(
                  children: [
                    StoreShopNowTile(
                      title: _store.name,
                      image: _store.logo,
                      calculatedDistance: _store.calculated_distance,
                      defaultCashBack: _store.cashback,
                      walletAmount:
                          _store.customer_wallet_amount?.toString() ?? "0",
                      isInStore: _store.store_type == "instore",
                    ),
                    Divider(
                      color: AppConst.lightGrey,
                      thickness: 1,
                    ),
                  ],
                ),
              );
            })
        : Center(
            child: Text(
            'None available',
            style: AppConst.header2,
          ));
  }
}

class NearByStoreListing extends StatelessWidget {
  final List<StoreModel>? data;

  const NearByStoreListing({Key? key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return data!.length > 0
        ? ListView.builder(
            itemCount: data!.length,
            itemBuilder: (BuildContext context, int index) {
              StoreModel _store = data![index];
              return GestureDetector(
                onTap: () {
                  //       Get.to(() => TheBossCameraScreen(storeModel: _store));
                },
                child: Column(
                  children: [
                    StoreShopNowTile(
                      title: _store.name,
                      image: _store.logo,
                      calculatedDistance: _store.calculated_distance,
                      defaultCashBack: _store.cashback,
                      welcomeOffer: _store.welcomeOffer,
                      isInStore: _store.store_type == "instore",
                    ),
                    Divider(
                      color: AppConst.lightGrey,
                      thickness: 1,
                    ),
                  ],
                ),
              );
            })
        : Center(
            child: Text(
            'None available',
            style: AppConst.header2,
          ));
  }
}
