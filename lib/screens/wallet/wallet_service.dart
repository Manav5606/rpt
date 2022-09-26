import 'dart:developer';

import 'package:customer_app/app/data/provider/graphql/queries.dart';
import 'package:customer_app/app/data/provider/graphql/request.dart';
import 'package:customer_app/app/ui/common/alret.dart';
import 'package:customer_app/models/getRedeemCashStorePageDataModel.dart';
import 'package:customer_app/models/redeem_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class WalletService {
  static Future<GetRedeemCashInStorePageData?> getRedeemCashInStorePageData(LatLng latLng) async {
    try {
      final result = await GraphQLRequest.query(query: GraphQLQueries.getRedeemCashInStorePageData, variables: {
        'lat': latLng.latitude, //UserViewModel.currentLocation.value.latitude,
        'lng': latLng.longitude, //UserViewModel.currentLocation.value.longitude
      });
      if (result['error'] == false) {
        final GetRedeemCashInStorePageData _getRedeemCashInStorePageData = GetRedeemCashInStorePageData.fromJson(result);
        return _getRedeemCashInStorePageData;
      }
    } catch (e, st) {
      log("$e , $st");
      rethrow;
    }
  }

  static Future<GetRedeemCashInStorePageData?> getScanReceiptPageNearMeStoresData(LatLng latLng) async {
    try {
      final result = await GraphQLRequest.query(query: GraphQLQueries.getScanReceiptPageNearMeStoresData, variables: {
        'lat': latLng.latitude, //UserViewModel.currentLocation.value.latitude,
        'lng': latLng.longitude, //UserViewModel.currentLocation.value.longitude
      });
      if (result['error'] == false) {
        final GetRedeemCashInStorePageData _getRedeemCashInStorePageData = GetRedeemCashInStorePageData.fromJson(result);
        return _getRedeemCashInStorePageData;
      }
    } catch (e, st) {
      log("$e , $st");
      rethrow;
    }
  }

  static Future<RedeemBalanceModel?> redeemBalance({required String storeId, required double amount}) async {
    try {
      final result = await GraphQLRequest.query(query: GraphQLQueries.redeemBalance, variables: {
        'store': storeId,
        'amount': amount,
      });
        final RedeemBalanceModel _redeemBalanceModel = RedeemBalanceModel.fromJson(result);
        return _redeemBalanceModel;
    } catch (e, st) {
      log("$e , $st");
      rethrow;
    }
  }
}
