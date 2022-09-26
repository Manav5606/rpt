import 'dart:developer';

import 'package:customer_app/app/data/provider/graphql/queries.dart';
import 'package:customer_app/app/data/provider/graphql/request.dart';
import 'package:customer_app/app/ui/pages/search/models/GetProductsByNameModel.dart';
import 'package:customer_app/app/ui/pages/search/models/GetStoreDataModel.dart';
import 'package:customer_app/app/ui/pages/search/models/autoCompleteProductsByStoreModel.dart';
import 'package:customer_app/app/ui/pages/search/models/get_near_me_page_data.dart';
import 'package:customer_app/controllers/userViewModel.dart';
import 'package:customer_app/models/addcartmodel.dart';

class ExploreService {
  static Future<GetNearMePageData?> getNearMePageData(String searchText) async {
    try {
      final result = await GraphQLRequest.query(query: GraphQLQueries.getNearMePageData, variables: {
        'lat': UserViewModel.currentLocation.value.latitude,
        'lng': UserViewModel.currentLocation.value.longitude,
        'query': searchText,
      });
      if (result['error'] == false) {
        final GetNearMePageData _getHomePageFavoriteShops = GetNearMePageData.fromJson(result);
        return _getHomePageFavoriteShops;
      }
    } catch (e, st) {
      log("$e , $st");
      rethrow;
    }
  }

  static Future<GetProductsByName?> getProductsByName(String name) async {
    try {
      final result = await GraphQLRequest.query(query: GraphQLQueries.getProductsByName, variables: {
        'lat': UserViewModel.currentLocation.value.latitude,
        'lng': UserViewModel.currentLocation.value.longitude,
        'name': name,
      });
      if (result['error'] == false) {
        final GetProductsByName _getProductsByName = GetProductsByName.fromJson(result);
        return _getProductsByName;
      }
    } catch (e, st) {
      log("$e , $st");
      rethrow;
    }
  }

  static Future<AutoCompleteProductsByStoreModel?> getAutoCompleteProductsByStore({String name = '', String storeId = ''}) async {
    try {
      final result = await GraphQLRequest.query(query: GraphQLQueries.getAutoCompleteProductsByStore, variables: {
        'store': storeId,
        'query': name,
      });
      if (result['error'] == false) {
        final AutoCompleteProductsByStoreModel autoCompleteProductsByStoreModel = AutoCompleteProductsByStoreModel.fromJson(result);
        return autoCompleteProductsByStoreModel;
      }
    } catch (e, st) {
      log("$e , $st");
      rethrow;
    }
  }

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
        'cart_id': cart_id,
      };
      final result = await GraphQLRequest.query(query: GraphQLQueries.addToCartWithId, variables: variables);
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
