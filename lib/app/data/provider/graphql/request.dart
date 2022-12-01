import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:customer_app/app/data/provider/graphql/queries.dart';
import 'package:customer_app/app/data/provider/hive/hive.dart';
import 'package:customer_app/app/data/provider/hive/hive_constants.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/widgets/custom_alert_dialog.dart';
import 'package:get/get.dart';
import 'package:graphql/client.dart';

import 'client.dart';

class GraphQLRequest {
  static Future<dynamic> query({
    required GraphQLQuery query,
    required Map<String, dynamic> variables,
    bool isLogOff = false,
  }) async {
    final box = Boxes.getCommonBox();
    final token = box.get(HiveConstants.USER_TOKEN);
    log('token :$token');
    GraphQLClient client = GraphqlConfig.getClient(token);
    print("==> ${query.name}");
    final QueryOptions options = QueryOptions(
      document: gql(query.query),
      variables: variables,
    );
    final QueryResult result = await client.query(options);
    log("variables : $variables");
    // if (!isLogOff) log("result : $result");
    if (result.hasException) {
      return {
        'error': true,
        'msg': 'Connection failed'
      }; // handle the network failed with some 404 error and build ui for 404 error
    } else {
      if (result.data?[query.name]['msg'] == "Customer Login Required") {
        _showLogOutDialog();
      } else {
        return result.data?[query.name];
      }
    }
  }
}

void _showLogOutDialog() {
  showDialog(
    barrierDismissible: false,
    context: Get.context!,
    builder: (BuildContext context) {
      return CustomDialog(
        title: 'Session Expired',
        content: "Please login again to verify it's you.",
        buttontext: 'Got it',
        onTap: () {
          Get.offAllNamed(AppRoutes.Authentication);
        },
      );
    },
  );
}
