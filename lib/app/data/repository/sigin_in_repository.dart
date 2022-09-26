import 'dart:developer';

import 'package:customer_app/app/data/model/user_model.dart';
import 'package:customer_app/app/data/model/wallet_model.dart';
import 'package:customer_app/app/data/provider/graphql/queries.dart';
import 'package:customer_app/app/data/provider/graphql/request.dart';
import 'package:customer_app/app/ui/common/alret.dart';
import 'package:customer_app/controllers/userViewModel.dart';

class SignInRepository {
  Future<UserModel?> customerLoginOrSignUp(String phoneNumber) async {
    try {
      final result = await GraphQLRequest.query(query: GraphQLQueries.customerLoginOrSignUp, variables: {
        'mobile': "+91" + phoneNumber,
      });

      log(phoneNumber);
      if (result['error'] == false) {
        log('signup :  ${result['signup']}');
        UserViewModel.setToken(result['token']);
        UserViewModel.setStreamToken(result['streamChatToken']);
        UserViewModel.setSignupFlag(result['signup']);
        final UserModel userModel = UserModel.fromJson(result['data']);
        return userModel;
      } else {
        Alert.error(result['msg']);
        return null;
      }
    } catch (e, st) {
      log('customerLoginOrSignUp :$e $st');
    }
  }

  static Future<bool> updateCustomerInformation(String firstname, String lastname, String email) async {
    final result = await GraphQLRequest.query(query: GraphQLQueries.updateCustomerInformation, variables: {
      'first_name': firstname,
      'last_name': lastname,
      'email': email,
    });
    if (result['error'] == false) {
      return true;
    } else {
      Alert.error(result['msg']);
      return false;
    }
  }

  Future<List<Wallet>?> getAllWallet() async {
    final result = await GraphQLRequest.query(query: GraphQLQueries.getAllWalletByCustomer, variables: {
      'lat': UserViewModel.currentLocation.value.latitude,
      'lng': UserViewModel.currentLocation.value.longitude,
      // 'lat': 12.9716,
      // 'lng': 77.5946,
    });
    log('result is:-->>>$result');
    if (result['error'] == false) {
      final items = List.from(result['data']).map((e) => Wallet.fromJson(e)).toList();
      log('result is List:-->>>$items');
      return items;
    } else {
      Alert.error(result['msg']);
      return null;
    }
  }
}
