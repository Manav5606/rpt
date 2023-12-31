import 'dart:developer';
import 'dart:io';

import 'package:customer_app/app/data/model/order_model.dart';
import 'package:customer_app/app/data/provider/graphql/queries.dart';
import 'package:customer_app/app/data/provider/graphql/request.dart';
import 'package:customer_app/controllers/userViewModel.dart';
import 'package:customer_app/models/getRedeemCashStorePageDataModel.dart';
import 'package:customer_app/utils/firebas_crashlyatics.dart';
import 'package:customer_app/widgets/imagePicker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ScanRecipetService {
  static Future<OrderData?> placeOrderWithoutStore(
      {required List<File>? images,
      required double total,
      required LatLng latLng}) async {
    try {
      List<String> imageLinks = [];
      for (File image in images!) {
        imageLinks.add(await ImageHelper.uploadImage(image));
      }
      final variables = {
        'image': imageLinks[0],
        'total': total,
        'lat': latLng.latitude,
        'lng': latLng.longitude,
        'address': UserViewModel.user.value.addresses?[0].address ?? '',
      };
      final result = await GraphQLRequest.query(
          query: GraphQLQueries.placeOrder, variables: variables);
      if (result['error'] == false) {
        final OrderData _getAllReceipts = OrderData.fromJson(result['data']);
        return _getAllReceipts;
      }
    } catch (e, st) {
      ReportCrashes().reportRecorderror(e);
      ReportCrashes().reportErrorCustomKey("placeOrderWithoutStore", "$e");
      log('st : $st');

      rethrow;
    }
  }

  static Future<OrderData?> placeOrder(
      {required List<File>? images,
      required String? storeId,
      var products,
      required double total,
      required double cashback,
      required LatLng latLng}) async {
    try {
      List<String> imageLinks = [];
      for (File image in images!) {
        imageLinks.add(await ImageHelper.uploadImage(image));
      }
      final variables = {
        'image': imageLinks[0],
        'products': List.from(products.map((e) => e.toJson())),
        'storeId': storeId,
        'total': total,
        'cashback': cashback,
        'lat': latLng.latitude,
        'lng': latLng.longitude
      };
      final result = await GraphQLRequest.query(
          query: GraphQLQueries.placeOrderWithStore, variables: variables);
      if (result['error'] == false) {
        final OrderData _getAllReceipts = OrderData.fromJson(result['data']);
        return _getAllReceipts;
      }
    } catch (e, st) {
      ReportCrashes().reportRecorderror(e);
      ReportCrashes().reportErrorCustomKey("placeOrderWithStore", "$e");
      log('e  : $e ,stt $st');
      rethrow;
    }
  }
}
