import 'dart:developer';

import 'package:customer_app/app/data/model/order_model.dart' as order_model;
import 'package:customer_app/app/ui/pages/search/models/GetProductsByNameModel.dart';
import 'package:customer_app/screens/addcart/models/cartLocation_model.dart';
import 'package:customer_app/screens/addcart/models/cartPageInfo_model.dart';
import 'package:customer_app/screens/addcart/models/create_razorpay_model.dart';
import 'package:customer_app/screens/addcart/models/getOrderConfirmModel.dart';

import '../../../app/data/provider/graphql/queries.dart';
import '../../../app/data/provider/graphql/request.dart';
import '../../home/models/GetAllCartsModel.dart';
import '../models/review_cart_model.dart';

class AddCartService {
  static Future<Cart?> getReviewCartData(String cartId) async {
    try {
      final result = await GraphQLRequest.query(
          query: GraphQLQueries.reviewCart,
          variables: {
            'cart_id': cartId,
          });
      log("result------${result}");
      if (result['error'] == false) {
        final Cart _reviewCart = Cart.fromJson(result);
        return _reviewCart;
      }
    } catch (e, st) {
      log("$e , $st");
      rethrow;
    }
  }

// //change remove  the query
//   static Future<GetOrderConfirmPageData?> getCartPageInformation(
//       String storeId) async {
//     try {
//       final result = await GraphQLRequest.query(
//           query: GraphQLQueries.getCartPageInformation,
//           variables: {
//             'store_id': storeId,
//           });
//       log("getCartPageInformation------${result}");
//       // if (result['error'] == false) {
//       final GetOrderConfirmPageData getCartPageInformation =
//           GetOrderConfirmPageData.fromJson(result);
//       return getCartPageInformation;
//       // }
//     } catch (e, st) {
//       log("$e , $st");
//       rethrow;
//     }
//   }

  static Future<CartLocationModel?> getCartLocation(
      String storeId, String cartId) async {
    try {
      final result = await GraphQLRequest.query(
          query: GraphQLQueries.getCartLocation,
          variables: {
            'store_id': storeId,
            'cart_id': cartId,
          });
      log("getCartLocation------${result}");
      if (result['error'] == false) {
        final CartLocationModel cartLocationModel =
            CartLocationModel.fromJson(result);
        log("cartLocationModel------${cartLocationModel.toJson()}");
        return cartLocationModel;
      }
    } catch (e, st) {
      log("getCartLocation $e , $st");
      rethrow;
    }
  }

  static Future<void> selectCartLocation(
      String cardId, Addresses addresses) async {
    try {
      log('addresses : ${addresses.toJson()}');
      final result = await GraphQLRequest.query(
          query: GraphQLQueries.selectCartLocation,
          variables: {
            'cart_id': cardId,
            'address': addresses,
          });
      log("selectCartLocation------${result}");
    } catch (e, st) {
      log("selectCartLocation $e , $st");
      rethrow;
    }
  }

  static Future<GetOrderConfirmPageData?> getOrderConfirmPageData(
      {required String storeId,
      required double distance,
      required int walletAmount,
      required bool pickedup,
      var products,
      var inventories}) async {
    try {
      final variables = {
        'store': storeId,
        "pickedup": pickedup,
        'products': List.from(products.map((Products e) => e.toJson())),
        'distance': distance,
        'wallet_amount': walletAmount,
        'inventories': List.from(inventories.map((Products e) => e.toJson())),
      };
      final result = await GraphQLRequest.query(
          query: GraphQLQueries.getOrderConfirmPageData, variables: variables);
      if (result['error'] == false) {
        final GetOrderConfirmPageData getOrderConfirmPageData =
            GetOrderConfirmPageData.fromJson(result);
        return getOrderConfirmPageData;
      }
    } catch (e, st) {
      log("$e , $st");
      rethrow;
    }
  }

  static Future<CreateRazorpayResponse?> createRazorPayOrder(
      {required String storeId, required double amount}) async {
    try {
      final variables = {
        'store_id': storeId,
        'amount': amount,
      };
      final result = await GraphQLRequest.query(
          query: GraphQLQueries.createRazorPayOrder, variables: variables);
      if (result['error'] == false) {
        final CreateRazorpayResponse createRazorpayResponse =
            CreateRazorpayResponse.fromJson(result['data']);
        return createRazorpayResponse;
      }
    } catch (e, st) {
      log("$e , $st");
      rethrow;
    }
  }

  static Future<order_model.OrderData> finalPlaceOrder({
    required store,
    required var rawItem,
    required var products,
    required var inventories,
    required double total,
    required double previous_total_amount,
    required double final_payable_amount,
    required String order_type,
    required String cartId,
    required String razorPayOrderId,
    required String razorPaySignature,
    required String razorPayPaymentId,
    required String address,
    required double walletAmount,
    required double lat,
    required double lng,
    required int packagingFee,
    // required int bill_discount_offer_amount,
    // required int bill_discount_offer_target,
    // required int omit_bill_amount,
    // required bool bill_discount_offer_status,
    required int deliveryFee,
    required var deliveryTimeSlot,
    required bool pickedup,
  }) async {
    try {
      final variables = {
        'order_type': "online",
        'products': List.from(products.map((e) => e.toJson())),
        'rawitems': List.from(rawItem.map((e) => e.toJson())),
        'inventories': List.from(inventories.map((e) => e.toJson())),
        'order_type': order_type,
        'storeId': store,
        'total': total,
        'delivery_slot': deliveryTimeSlot?.toJson(),
        // 'cashback': store.earnedCashback?.toInt() ?? 0,
        'wallet_amount': walletAmount,
        'razor_signature': razorPaySignature,
        'razor_order_id': razorPayOrderId,
        'razor_payment_id': razorPayPaymentId,
        'packaging_fee': packagingFee,
        'delivery_fee': deliveryFee,
        // "bill_discount_offer_amount": bill_discount_offer_amount,
        // "bill_discount_offer_status": bill_discount_offer_status,
        // "bill_discount_offer_target": bill_discount_offer_target,
        // "omit_bill_amount": omit_bill_amount,
        'address': address,
        'lat': lat,
        'lng': lng,
        'cartID': cartId,
        'pickedup': pickedup,
        'final_payable_amount': final_payable_amount,
        'previous_total_amount': previous_total_amount
      };
      final result = await GraphQLRequest.query(
          query: GraphQLQueries.finalPlaceOrder, variables: variables);
      if (result['error'] == false) {
        final order_model.OrderData _getAllActiveOrders =
            order_model.OrderData.fromJson(result['data']);
        return _getAllActiveOrders;
      }
      return result['error'];
    } catch (e, st) {
      log("$e , $st");
      rethrow;
    }
  }

  static Future<bool> placeOrderActive({
    required String storeId,
    required String razorPayOrderId,
    required String razorPaySignature,
    required String razorPayPaymentId,
  }) async {
    try {
      final variables = {
        '_id': storeId,
        'razor_signature': razorPaySignature,
        'razor_order_id': razorPayOrderId,
        'razor_payment_id': razorPayPaymentId,
      };
      final result = await GraphQLRequest.query(
          query: GraphQLQueries.placeOrderActive, variables: variables);

      return result['error'];
    } catch (e, st) {
      log("$e , $st");
      rethrow;
    }
  }
}
