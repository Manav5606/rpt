import 'dart:developer';

import 'package:customer_app/app/constants/app_constants.dart';
import 'package:customer_app/app/data/provider/graphql/queries.dart';
import 'package:customer_app/app/data/provider/graphql/request.dart';
import 'package:customer_app/app/ui/pages/search/models/GetStoreDataModel.dart';
import 'package:customer_app/app/ui/pages/search/models/getCartId_model.dart';
import 'package:customer_app/models/addcartmodel.dart';

class MoreStoreService {
  static Future<GetStoreDataModel?> getStoreData(String id) async {
    try {
      final result = await GraphQLRequest.query(query: GraphQLQueries.getOrderOnlinePageProductsData, variables: {
        'store': id,
      });
      if (result['error'] == false) {
        final GetStoreDataModel _getStoreDataModel = GetStoreDataModel.fromJson(result);
        return _getStoreDataModel;
      }
    } catch (e, st) {
      log("$e , $st");
      rethrow;
    }
  }

  static Future<GetCartIDModel?> getcartID(String id) async {
    final result = await GraphQLRequest.query(query: GraphQLQueries.getcartID, variables: {
      'store': id,
    });
    log('getCartIDModel result :$result');
    final GetCartIDModel getCartIDModel = GetCartIDModel.fromJson(result['data']);
    return getCartIDModel;
  }

  static Future<AddToCartModel?> addToCart({
    var product,
    required String store_id,
    required String cart_id,
    required bool increment,
    required int index,
  }) async {
    try {
      log('product :${product.toJson()}');

      final variables = {
        'store_id': store_id,
        'product': product,
        'increment': increment,
        'index': index,
        if (cart_id.isNotEmpty) 'cart_id': cart_id,
      };
      if (cart_id.isEmpty) {
        Constants.isAbleToCallApi = true;
      }
      final result =
          await GraphQLRequest.query(query: cart_id.isNotEmpty ? GraphQLQueries.addToCartWithId : GraphQLQueries.addToCart, variables: variables);
      log("result: ${result}");
      if (result['error'] == false) {
        final AddToCartModel addToCartModel = AddToCartModel.fromJson(result['data']);
        return addToCartModel;
      }
    } catch (e, st) {
      log("addToCart $e , $st");
      rethrow;
    }
  }


  static Future<AddToCartModel?> addToCartInventory({
    var inventory,
    required String store_id,
    required String cart_id,
  }) async {
    try {
      log('inventory :${inventory.toJson()}');

      final variables = {
        'store_id': store_id,
        'inventory': inventory,
        if (cart_id.isNotEmpty) 'cart_id': cart_id,
      };
      final result =
          await GraphQLRequest.query(query: cart_id.isNotEmpty ? GraphQLQueries.addToCartInventoryWithCartID : GraphQLQueries.addToCartInventory, variables: variables);
      log("result: ${result}");
      if (result['error'] == false) {
        final AddToCartModel addToCartModel = AddToCartModel.fromJson(result['data']);
        return addToCartModel;
      }
    } catch (e, st) {
      log("addToCart $e , $st");
      rethrow;
    }
  }
}
