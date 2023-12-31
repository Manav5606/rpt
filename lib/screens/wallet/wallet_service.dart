import 'dart:developer';

import 'package:customer_app/app/data/model/order_model.dart';
import 'package:customer_app/app/data/provider/graphql/queries.dart';
import 'package:customer_app/app/data/provider/graphql/request.dart';
import 'package:customer_app/app/ui/common/alret.dart';
import 'package:customer_app/models/getRedeemCashStorePageDataModel.dart';
import 'package:customer_app/models/redeem_model.dart';
import 'package:customer_app/utils/firebas_crashlyatics.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class WalletService {
  static Future<GetRedeemCashInStorePageData?> getRedeemCashInStorePageData(
      LatLng latLng) async {
    try {
      final result = await GraphQLRequest.query(
          query: GraphQLQueries.getRedeemCashInStorePageData,
          variables: {
            'lat':
                latLng.latitude, //UserViewModel.currentLocation.value.latitude,
            'lng': latLng
                .longitude, //UserViewModel.currentLocation.value.longitude
          });
      if (result['error'] == false) {
        final GetRedeemCashInStorePageData _getRedeemCashInStorePageData =
            GetRedeemCashInStorePageData.fromJson(result);
        return _getRedeemCashInStorePageData;
      }
    } catch (e, st) {
      ReportCrashes().reportRecorderror(e);
      ReportCrashes()
          .reportErrorCustomKey("getRedeemCashInStorePageData", "$e");
      log("$e , $st");
      rethrow;
    }
  }

  static Future<GetRedeemCashInStorePageData?>
      getScanReceiptPageNearMeStoresData(LatLng latLng) async {
    try {
      final result = await GraphQLRequest.query(
          query: GraphQLQueries.getScanReceiptPageNearMeStoresData,
          variables: {
            'lat':
                latLng.latitude, //UserViewModel.currentLocation.value.latitude,
            'lng': latLng
                .longitude, //UserViewModel.currentLocation.value.longitude
          });
      if (result['error'] == false) {
        final GetRedeemCashInStorePageData _getRedeemCashInStorePageData =
            GetRedeemCashInStorePageData.fromJson(result);
        return _getRedeemCashInStorePageData;
      }
    } catch (e, st) {
      ReportCrashes().reportRecorderror(e);
      ReportCrashes()
          .reportErrorCustomKey("getScanReceiptPageNearMeStoresData", "$e");
      log("$e , $st");
      rethrow;
    }
  }

  static Future<OrderData?> redeemBalance(
      {required String storeId,
      required double amount,
      required double billAmount}) async {
    try {
      final result = await GraphQLRequest.query(
          query: GraphQLQueries.redeemBalance,
          variables: {
            'store': storeId,
            'amount': amount,
            "bill_amount": billAmount
          });
      if (result['error'] == false) {
        final OrderData _getAllRefunds = OrderData.fromJson(result['data']);
        return _getAllRefunds;
      }
    } catch (e, st) {
      ReportCrashes().reportRecorderror(e);
      ReportCrashes().reportErrorCustomKey("redeemBalance", "$e");
      log("$e , $st");
      rethrow;
    }
  }
}
