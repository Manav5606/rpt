import 'package:customer_app/config/gqlConfig.dart';
import 'package:customer_app/controllers/userViewModel.dart';
import 'package:customer_app/data/models/get_chat_orderList.dart';
import 'package:customer_app/widgets/snack.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GetChatOrderListRepo {
  static getCharOrder(String id) async {
    final _query =
        r'''
    query($store:ID){
  getChatOrderAutocompleteData(store: $store){
    error
    msg
    data{
      _id
      name
    }
  }
}''';

    try {
      final variables = {'store': id};

      GraphQLClient client = GqlConfig.getClient(UserViewModel.token.value);
      QueryResult result = await client
          .query(QueryOptions(document: gql(_query), variables: variables));

      bool loginError = result.data!['getChatOrderAutocompleteData']['error'];
      if (loginError) {
        Snack.top('Error', result.data!['getChatOrderAutocompleteData']['msg']);
      } else {
        return GetChatOrderAutocompleteData.fromJson(
            result.data!['getChatOrderAutocompleteData']);
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
