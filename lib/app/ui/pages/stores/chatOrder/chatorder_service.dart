import 'dart:developer';

import 'package:customer_app/app/data/provider/graphql/queries.dart';
import 'package:customer_app/app/data/provider/graphql/request.dart';
import 'package:customer_app/screens/home/models/GetAllCartsModel.dart';
import 'package:customer_app/utils/firebas_crashlyatics.dart';

class ChatOrderService {
  static Future<Carts?> addToCartRaw({
    var rawItem,
    required String cartId,
    required String newValueItem,
    required bool isEdit,
    required String store_id,
  }) async {
    try {
      log('rawItem :${rawItem.toJson()}');
      final variables = {
        'raw_item': rawItem,
        'cart_id': cartId,
        "store_id": store_id,
        if (newValueItem.isNotEmpty) 'newValueItem': newValueItem
      };
      final result = await GraphQLRequest.query(
          query: isEdit
              ? GraphQLQueries.addToCartEditRawItem
              : GraphQLQueries.addToCartNewRawItem,
          variables: variables);
      log("addToCartRaw : ${result}");
      if (result['error'] == false) {
        final Carts carts = Carts.fromJson(result['data']);
        return carts;
      }
    } catch (e, st) {
      ReportCrashes().reportRecorderror(e);
      ReportCrashes().reportErrorCustomKey("AddRawItemToCArt", "$e");
      log("addToCart $e , $st");
      rethrow;
    }
  }
}
