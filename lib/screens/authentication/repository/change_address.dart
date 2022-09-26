import 'dart:developer';

import 'package:customer_app/app/data/provider/graphql/queries.dart';
import 'package:customer_app/app/data/provider/graphql/request.dart';

class ChangeAddressRepo {
  static Future<void> changeAddress(String id) async {
    try {
      final result = await GraphQLRequest.query(query: GraphQLQueries.changeCustomerAddress, variables: {
        'id': id,
      });
      log("result------${result}");
    } catch (e, st) {
      log("$e , $st");
      rethrow;
    }
  }
}
