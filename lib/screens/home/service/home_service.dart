import 'dart:developer';

import 'package:customer_app/app/constants/app_constants.dart';
import 'package:customer_app/app/data/provider/graphql/queries.dart';
import 'package:customer_app/app/data/provider/graphql/request.dart';
import 'package:customer_app/screens/home/models/GetAllCartsModel.dart';
import 'package:customer_app/screens/home/models/homeFavStoreModel.dart';
import 'package:customer_app/screens/home/models/homePageRemoteConfigModel.dart';

import '../../../controllers/userViewModel.dart';

class HomeService {
  static Future<GetAllCartsModel?> getAllCartsData() async {
    try {
      final result = await GraphQLRequest.query(
          query: GraphQLQueries.getAllCartData, variables: {});
      if (result['error'] == false) {
        Constants.isAbleToCallApi = false;
        final GetAllCartsModel _getAllCartsModel =
            GetAllCartsModel.fromJson(result);
        return _getAllCartsModel;
      }
    } catch (e, st) {
      log("$e , $st");
      rethrow;
    }
  }

  static Future<GetHomePageFavoriteShops?> getHomePageFavoriteShops(
      {required int pageNumber}) async {
    try {
      final result = await GraphQLRequest.query(
          query: GraphQLQueries.getHomePageFavoriteShops,
          variables: {
            'lat': UserViewModel.currentLocation.value.latitude,
            'lng': UserViewModel.currentLocation.value.longitude,
            'pageNumber': pageNumber,
          });
      if (result['error'] == false) {
        final GetHomePageFavoriteShops _getHomePageFavoriteShops =
            GetHomePageFavoriteShops.fromJson(result);
        return _getHomePageFavoriteShops;
      }
    } catch (e, st) {
      log("  $e , $st");
      rethrow;
    }
  }

  static Future<HomePageRemoteConfigData?> homePageRemoteConfigData(
      String keyword,
      bool productFetch,
      String keywordHelper,
      String id,
      int pageNumber) async {
    try {
      final result = await GraphQLRequest.query(
          query: GraphQLQueries.homePageRemoteConfigData,
          variables: {
            '_id': id,
            'keyword': keyword,
            'product_fetch': productFetch,
            'lat': UserViewModel.currentLocation.value.latitude,
            'lng': UserViewModel.currentLocation.value.longitude,
            'pageNumber': pageNumber,
          });
      // log('result : $result');
      if (result['error'] == false) {
        final HomePageRemoteConfigData _homePageRemoteConfigModel =
            HomePageRemoteConfigData.fromJson(result);
        return _homePageRemoteConfigModel;
      }
    } catch (e, st) {
      log("  $e , $st");
      rethrow;
    }
  }
}
