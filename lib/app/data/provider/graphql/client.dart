import 'package:customer_app/app/utils/app_constants.dart';
import 'package:graphql/client.dart';

class GraphqlConfig {
  static getClient(String? token) {
    HttpLink link = HttpLink(
      AppConstants.server,
      defaultHeaders: token == null
          ? {}
          : <String, String>{
              'Authorization': 'Authorization $token',
            },
    );
    GraphQLClient cc = GraphQLClient(link: link, cache: GraphQLCache());
    return cc;
  }
}
