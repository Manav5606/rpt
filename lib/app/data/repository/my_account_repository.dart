import 'dart:developer';

import 'package:customer_app/app/data/model/order_model.dart';
import 'package:customer_app/app/data/model/user_model.dart';
import 'package:customer_app/app/data/model/wallet_model.dart';
import 'package:customer_app/app/data/provider/graphql/queries.dart';
import 'package:customer_app/app/data/provider/graphql/request.dart';
import 'package:customer_app/app/data/provider/hive/hive.dart';
import 'package:customer_app/app/data/provider/hive/hive_constants.dart';
import 'package:customer_app/app/ui/common/alret.dart';
import 'package:customer_app/controllers/userViewModel.dart';

class MyAccountRepository {
  Future<UserModel?> getCurrentUser() async {
    final box = Boxes.getCommonBox();
    final token = box.get(HiveConstants.USER_TOKEN);
    final result = await GraphQLRequest.query(
        query: GraphQLQueries.verifyUserToken,
        variables: {
          'token': token,
        });
    if (result['error'] == false) {
      final user = UserModel.fromJson(result['data']);
      UserViewModel.setUser(user);
      return user;
    } else {
      Alert.error(result['msg']);
      return null;
    }
  }

  Future<List<Wallet>?> getAllWallet() async {
    final result = await GraphQLRequest.query(
        query: GraphQLQueries.getAllWalletByCustomer,
        variables: {
          'lat': UserViewModel.currentLocation.value.latitude, //12.9716,
          'lng': UserViewModel.currentLocation.value.longitude, // 77.5946,
        });

    if (result['error'] == false) {
      final items =
          List.from(result['data']).map((e) => Wallet.fromJson(e)).toList();
      return items;
    } else {
      Alert.error(result['msg']);
      return null;
    }
  }

  static Future<OrderModel?> getAllActiveOrders() async {
    try {
      final result = await GraphQLRequest.query(
          query: GraphQLQueries.getAllActiveOrders, variables: {},isLogOff: true);
      if (result['error'] == false) {
        final OrderModel _getAllActiveOrders = OrderModel.fromJson(result);
        return _getAllActiveOrders;
      }
    } catch (e, st) {
      log("$e , $st");
      rethrow;
    }
  }

  static Future<String> getGenerateReferCode() async {
    try {
      final result = await GraphQLRequest.query(
          query: GraphQLQueries.generateReferCode, variables: {},isLogOff: true);
      return result['data'];
    } catch (e, st) {
      log("$e , $st");
      rethrow;
    }
  }

  static Future<OrderModel?> getAllOrders() async {
    try {
      final result = await GraphQLRequest.query(
          query: GraphQLQueries.getAllOrders, variables: {},isLogOff: true);
      if (result['error'] == false) {
        final OrderModel _getAllOrders = OrderModel.fromJson(result);
        return _getAllOrders;
      }
    } catch (e, st) {
      log("$e , $st");
      rethrow;
    }
  }
}
