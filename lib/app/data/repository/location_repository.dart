import 'dart:developer';

import 'package:customer_app/app/controller/add_location_controller.dart';
import 'package:customer_app/app/data/model/getClaimRewardsPageCount_model.dart';
import 'package:customer_app/app/data/model/get_claim_rewards_model.dart';
import 'package:customer_app/app/data/provider/graphql/queries.dart';
import 'package:customer_app/app/data/provider/graphql/request.dart';
import 'package:customer_app/app/data/repository/hive_repository.dart';
import 'package:customer_app/app/data/repository/my_account_repository.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/screens/addcart/controller/addcart_controller.dart';
import 'package:customer_app/widgets/snack.dart';
import 'package:get/get.dart';

import '../model/address_model.dart';

class LocationRepository {
  final HiveRepository hiveRepository = HiveRepository();

  Future<GetClaimRewardsModel?> getClaimRewardsPageData(
      double lat, double lng) async {
    final result = await GraphQLRequest.query(
        query: GraphQLQueries.getClaimRewardsPageData,
        variables: {
          'lat': lat,
          'lng': lng,
        });
    if (result['error'] == false) {
      final GetClaimRewardsModel getClaimRewardsModel =
          GetClaimRewardsModel.fromJson(result['data']);
      return getClaimRewardsModel;
    } else {
      return null;
    }
  }

  Future<GetClaimRewardsPageCountModel?> getClaimRewardsPageCount(
      double lat, double lng) async {
    final result = await GraphQLRequest.query(
        query: GraphQLQueries.getClaimRewardsPageCount,
        variables: {
          'lat': lat,
          'lng': lng,
        });
    if (result['error'] == false) {
      log("getClaimRewardsPageCount--->$result");
      final GetClaimRewardsPageCountModel getClaimRewardsPageCountModel =
          GetClaimRewardsPageCountModel.fromJson(result['data']);
      return getClaimRewardsPageCountModel;
    } else {
      log("getClaimRewardsPageCount--->$result");
      return null;
    }
  }

  Future<void> addMultipleStoreToWallet(double lat, double lng) async {
    final result = await GraphQLRequest.query(
        query: GraphQLQueries.addMultipleStoreToWalletNew,
        variables: {
          'lat': lat,
          'lng': lng,
        });
    if (result['error'] == false) {
      log("getClaimRewardsPageCount--->$result");
    } else {
      return null;
    }
  }

  Future<void> replaceCustomerAddress(AddressModel addressModel) async {
    Map<String, dynamic> variables = {
      'id': addressModel.id,
      'address': addressModel.address,
      'title': addressModel.title,
      'house': addressModel.house,
      'aparment': addressModel.apartment,
      'direction_to_reach': addressModel.directionReach,
      'lat': addressModel.location?.lat,
      'lng': addressModel.location?.lng
    };

    final result = await GraphQLRequest.query(
        query: GraphQLQueries.replaceCustomerAddress, variables: variables);
    log("replaceCustomerAddress--->$result");
    if (result['error'] == false) {
    } else {
      return null;
    }
  }

  Future<void> deleteCustomerAddress(String id) async {
    Map<String, dynamic> variables = {
      'id': id,
    };
    final result = await GraphQLRequest.query(
        query: GraphQLQueries.deleteCustomerAddress, variables: variables);
    log("deleteCustomerAddress--->$result");
    if (result['error'] == false) {
    } else {
      return null;
    }
  }

  Future<void> addCustomerAddress(
      {required String address,
      required String title,
      required double lat,
      required double lng,
      String? house,
      String? apartment,
      String? directionToReach,
      String? page}) async {
    print("$address, $title, $lat, $lng");
    try {
      Map<String, dynamic> variables = {
        'address': address,
        'title': title,
        'house': house,
        'apartment': apartment,
        'direction_to_reach': directionToReach,
        'lat': lat,
        'lng': lng
      };
      final result = await GraphQLRequest.query(
          query: GraphQLQueries.addCustomerAddress, variables: variables);
      await MyAccountRepository().getCurrentUser();
      if (result['error'] == false) {
        switch (page) {
          case 'explore':
            return BackToExplore();
          case 'scan':
            return BackToScan();
          case 'redeem':
            return BackToRedeem();
          case 'review':
            return BackTocartView();

          case 'home':
            return BackToHome();

          default:
            return BackToHome();
        }

        // await MyAccountRepository().getCurrentUser();
        // Get.offAllNamed(AppRoutes.BaseScreen);
      } else if (result['error'] == true &&
          result["msg"] == "Customer Address Already Available") {
        await Snack.bottom('Add Location', result["msg"]);
        await MyAccountRepository().getCurrentUser();
        await Future.delayed(Duration(seconds: 2))
            .whenComplete(() => Get.offAllNamed(AppRoutes.BaseScreen));
      } else {
        await Snack.bottom('Add Location Error', result["msg"]);
        await Future.delayed(Duration(seconds: 2))
            .whenComplete(() => Get.offNamed(AppRoutes.NewLocationScreen));
      }
    } catch (e) {
      print("Error --- >$e");
    }
  }

  void BackTocartView() {
    Get.offNamed(AppRoutes.CartReviewScreen, arguments: {"addressAdd": true});
  }

  void BackToHome() {
    Get.offAllNamed(AppRoutes.BaseScreen);
  }

  void BackToExplore() {
    Get.offNamed(AppRoutes.ExploreScreen);
  }

  void BackToScan() {
    Get.offAllNamed(AppRoutes.ScanRecipetSearch);
  }

  void BackToRedeem() {
    Get.offAllNamed(AppRoutes.LoyaltyCardScreen);
  }
}
