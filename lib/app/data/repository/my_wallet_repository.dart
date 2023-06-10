import 'dart:developer';
import 'package:customer_app/app/data/model/my_wallet_model.dart';

import 'package:customer_app/app/data/provider/graphql/queries.dart';
import 'package:customer_app/app/data/provider/graphql/request.dart';
import 'package:customer_app/controllers/userViewModel.dart';
import 'package:customer_app/utils/firebas_crashlyatics.dart';

import '../model/customer_wallet.dart';

class MyWalletRepository {
  static Future<GetAllWalletByCustomer?> getAllWalletByCustomer() async {
    try {
      final result = await GraphQLRequest.query(
          query: GraphQLQueries.getAllWalletByCustomer,
          variables: {
            // 'lat': 12.96980, // UserViewModel.currentLocation.value.latitude,
            // 'lng': 77.74996 //UserViewModel.currentLocation.value.longitude,

            'lat': UserViewModel.currentLocation.value.latitude, //12.96980,
            'lng': UserViewModel.currentLocation.value.longitude, //77.74996 ,
          });
      log('result getAllWalletByCustomer: $result');
      if (result['error'] == false) {
        final GetAllWalletByCustomer _getAllWalletByCustomer =
            GetAllWalletByCustomer.fromJson(result);

        // log('_getAllWalletByCustomer :${_getAllWalletByCustomer.toJson()}');
        return _getAllWalletByCustomer;
      }
    } catch (e, st) {
      ReportCrashes().reportRecorderror(e);
      ReportCrashes().reportErrorCustomKey("getAllWalletByCustomer", "$e");
      log("$e , $st");
      rethrow; // konw more about it
    }
  }

  static Future<GetAllWalletByCustomerByBusinessType?>
      getAllWalletByCustomerByBusinessType() async {
    try {
      final result = await GraphQLRequest.query(
          query: GraphQLQueries.getAllWalletByCustomerByBusinessType,
          variables: {
            'lat': UserViewModel
                .currentLocation.value.latitude, // 17.487541708927512,
            'lng': UserViewModel
                .currentLocation.value.longitude, //78.39534625411034,
          });
      log('result getAllWalletByCustomerByBusinessType: $result');
      if (result['error'] == false) {
        final GetAllWalletByCustomerByBusinessType
            _getAllWalletByCustomerByBusinessType =
            GetAllWalletByCustomerByBusinessType.fromJson(result);

        // log('_getAllWalletByCustomer :${_getAllWalletByCustomer.toJson()}');
        return _getAllWalletByCustomerByBusinessType;
      }
    } catch (e, st) {
      ReportCrashes().reportRecorderror(e);
      ReportCrashes()
          .reportErrorCustomKey("getAllWalletByCustomerByBusinessType", "$e");
      log("$e , $st");
      rethrow; // konw more about it
    }
  }

  static Future<GetAllWalletTransactionByCustomer?>
      getAllWalletTransactionByCustomer(String? storeId) async {
    try {
      final result = await GraphQLRequest.query(
          query: GraphQLQueries.getAllWalletTransactionByCustomer,
          variables: {
            'store': storeId
            // '611e3008b745524a64428a31'
          });
      // log("_getAllWalletTransactionByCustomer result : ${result}");
      if (result['error'] == false) {
        final GetAllWalletTransactionByCustomer
            _getAllWalletTransactionByCustomer =
            GetAllWalletTransactionByCustomer.fromJson(result);

        // log('_getAllWalletByCustomer :${_getAllWalletTransactionByCustomer.toJson()}');
        return _getAllWalletTransactionByCustomer;
      }
    } catch (e, st) {
      ReportCrashes().reportRecorderror(e);
      ReportCrashes()
          .reportErrorCustomKey("getAllWalletTransactionByCustomer", "$e");
      log("$e , $st");
      rethrow;
    }
  }

  static Future<bool?> updateWalletStatusByCustomer(
      String? storeId, bool? status) async {
    try {
      final result = await GraphQLRequest.query(
          query: GraphQLQueries.updateWalletStatusByCustomer,
          variables: {'store_id': storeId, "status": status});

      if (result['error'] == false) {
        return result['error'];
      } else {
        return result['error'];
      }
    } catch (e, st) {
      ReportCrashes().reportRecorderror(e);
      ReportCrashes().reportErrorCustomKey("deactivateWallet", "$e");
      log("$e , $st");
      rethrow;
    }
  }
}
