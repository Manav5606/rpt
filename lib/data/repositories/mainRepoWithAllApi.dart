import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:logger/logger.dart';

import 'package:customer_app/config/gqlConfig.dart';
import 'package:customer_app/controllers/userViewModel.dart';
import 'package:customer_app/data/models/mixed/productModel.dart';
import 'package:customer_app/data/models/user_model.dart';

import 'new_main_api.dart';

class MainRepo {
  static var logger = Logger();

  static Future<List<StoreModel>?> getAllNearestStore() async {
    /// gets all nearest restaurant based on users current location
    /// the user choose/ selected on the map in the beginning
    const queryGetNearestStoreByCustomer = r'''
  query($lat: Float $lng: Float){
    getNearestStoreByCustomer(lat: $lat lng: $lng){
      error
      msg
      data{
        _id
        name
        businesstype{
          _id
          name
        }
        address{re
          address
          location{
            lat
            lng
          }
        }
        logo
        default_cashback
        default_welcome_offer
        promotion_cashback
        promotion_welcome_offer
      }
    }
  }
  ''';
    try {
      final variables = {
        'lat': UserViewModel.currentLocation.value.latitude,
        'lng': UserViewModel.currentLocation.value.longitude
      };

      print(variables);

      GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);
      QueryResult result = await client.query(QueryOptions(
          document: gql(queryGetNearestStoreByCustomer), variables: variables));
      logger.i(result.data);
      return [];
      // return List<StoreModel>.from(result.data['getNearestStoreByCustomer']['data'].map((x) => StoreModel.fromJson(x)));
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<List<StoreModel>?> getAllLinkedStores() async {
    /// get all linked store where the user and store
    /// has a wallet connection
    const queryGetAllLinkedStoresByCustomer = r'''
  query{
    getAllLinkedStoresByCustomer{
      error
      msg
      data{
        _id
        name
        businesstype{
          _id
          name
        }
        address{
          address
          location{
            lat
            lng
          }
        }
        logo
        default_cashback
        default_welcome_offer
        promotion_cashback
        promotion_welcome_offer
      }
    }
  }
  ''';

    try {
      GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);
      QueryResult result = await client.query(QueryOptions(
        document: gql(queryGetAllLinkedStoresByCustomer),
      ));
      return List<StoreModel>.from(result.data!['getAllLinkedStoresByCustomer']
              ['data']
          .map((x) => StoreModel.fromJson(x)));
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<List<ProductModel>?> getAllProducts() async {
    /// gets all products of the nearest restaurants based on the current
    /// location the user choose/ selected on the map in the beginning
    const queryGetAllProductsByCustomer = r'''
  query($lat: Float $lng: Float){
    getAllProductsByCustomer(lat: $lat lng: $lng){
      error
      msg
      data{
        _id
        name
        logo
        catalog{
          name
          _id
          img
        }
        mrp
        selling_price
        cashback
        cashback_percentage
        details
        status
      }
    }
  }
  ''';

    try {
      GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);
      QueryResult result = await client.query(QueryOptions(
          document: gql(queryGetAllProductsByCustomer),
          variables: {
            'lat': UserViewModel.currentLocation.value.latitude,
            'lng': UserViewModel.currentLocation.value.longitude
          }));
      return List<ProductModel>.from(result.data!['getAllProductsByCustomer']
              ['data']
          .map((x) => ProductModel.fromJson(x)));
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<List<ProductModel>?> getAllCashBackProductsOfOneRestaurant(
      String storeID) async {
    /// sending a store id will return all the product with cashBack offer
    const queryGetAllCashBackProducts = r'''
  query($storeID: ID){
    getAllCashbackProducts(store: $storeID){
      error
      msg
      data{
        _id
          name
          logo
          catalog{
            name
            _id
            img
          }
          mrp
          selling_price
          cashback
          cashback_percentage
          details
          status
      }
    }
  }
  ''';
    try {
      GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);
      QueryResult result = await client.query(QueryOptions(
          document: gql(queryGetAllCashBackProducts),
          variables: {'storeID': storeID}));
      return List<ProductModel>.from(result.data!['getAllCashbackProducts']
              ['data']
          .map((x) => ProductModel.fromJson(x)));
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<List<StoreModel>?> getAllNotLinkedStores() async {
    /// get all not linked store where the user and store
    /// has not yet created a wallet connection
    const queryGetAllNotLinkedStoresByCustomer = r'''
  query($lat: Float $lng: Float){
    getNearestStoresNotIntoWallet(lat: $lat lng: $lng){
      error
      msg
      data{
        _id
        name
        businesstype{
          _id
          name
        }
        address{
          address
          location{
            lat
            lng
          }
        }
        logo
        default_cashback
        default_welcome_offer
        promotion_cashback
        promotion_welcome_offer
      }
    }
  }
  ''';

    try {
      GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);
      QueryResult result = await client.query(QueryOptions(
          document: gql(queryGetAllNotLinkedStoresByCustomer),
          variables: {
            'lat': UserViewModel.currentLocation.value.latitude,
            'lng': UserViewModel.currentLocation.value.longitude
          }));
      return List<StoreModel>.from(result.data!['getNearestStoresNotIntoWallet']
              ['data']
          .map((x) => StoreModel.fromJson(x)));
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<UserModel?> getCustomerInfoWithToken(String token) async {
    /// get all the info of the customer by sending the token
    /// al ready getting all the info when signing in just in case
    const queryGetCustomerInfoWithToken = r'''
  query($token: String){
    verifyCustomerToken(token: $token){
      error
      msg
      token
      data{
        _id
        first_name
        last_name
        mobile
        email
        firebase_token
        addresses{
          address
          location{
            lat
            lng
          }
          status
        }
        balance
        logo
        date_of_birth
        male_or_female
      }
    }
  }
  ''';
    try {
      GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);
      QueryResult result = await client.query(QueryOptions(
          document: gql(queryGetCustomerInfoWithToken),
          variables: {
            'token': token,
          }));
      return UserModel.fromJson(result.data!['addStoreByLocation']['error']);
    } catch (e) {
      print(e.toString());
      // return true;
      return null;
    }
  }

  static Future<bool> addSingleStoreToWallet(String storeID) async {
    /// adds a single restaurant balance to his own wallet
    /// if the store has promotion welcome offer add that
    /// otherwise add the default
    const mutateAddSingleStoreToWallet = r'''
  mutation($id: ID $balance: Float){
    addSingleStore(store: $id balance:$balance){
      error
      msg
    }
  }
  ''';
    const queryGetOneRestaurantWelcomeOffer = r'''
  query($id: ID){
    getOneStore(_id: $id){
      error
      msg
      data{
        promotion_welcome_offer_status
        promotion_welcome_offer
        default_welcome_offer
      }
    }
  }
  ''';
    try {
      double balance;
      GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);

      QueryResult result1 = await client.query(QueryOptions(
          document: gql(queryGetOneRestaurantWelcomeOffer),
          variables: {'id': storeID}));

      if (result1.data!['getOneStore']['data']
              ['promotion_welcome_offer_status'] ==
          'active') {
        balance =
            result1.data!['getOneStore']['promotion_welcome_offer'].toDouble();
      } else {
        balance =
            result1.data!['getOneStore']['default_welcome_offer'].toDouble();
      }

      QueryResult result2 = await client.mutate(MutationOptions(
          document: gql(mutateAddSingleStoreToWallet),
          variables: {'id': storeID, 'balance': balance}));

      logger.i(result2);

      return result2.data!['addSingleStore']['error'];
    } catch (e) {
      print(e.toString());
      return true;
    }
  }

  static updateCustomerInfo(
      {String? firstName,
      String? lastName,
      String? email,
      String? image,
      String? dob,
      String? gender}) async {
    ///update customer information
    ///as it turns out if you send something empty it will become empty
    ///and if you dont send it will become null
    ///so gotta send everything
    const mutateUpdateCustomerInfo = r'''
      mutation($firstName: String $lastName: String $email:String $image:String $dob:String $gender:String){
          updateCustomerInformation(customerInput:{
            first_name: $firstName
            last_name: $lastName
            email: $email
            logo: $image
            date_of_birth: $dob
            male_or_female: $gender
            address:{
              address: "address address"
              location:{
                lat: 22.3636
                lng: 12.3344
              }}
          }){
            error
            msg
          }
        }
  ''';

    Map<String, dynamic> variables = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "image": image,
      "dob": dob,
      "gender": gender
    };

    try {
      GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);
      QueryResult result2 = await client.mutate(MutationOptions(
          document: gql(mutateUpdateCustomerInfo), variables: variables));

      logger.i(result2.data);
      return result2.data;
    } catch (e) {
      print(e.toString());
      return true;
    }
  }
}
