import 'package:graphql_flutter/graphql_flutter.dart';

class GqlConfig {
  static const String BASE_URL = "http://192.168.96.1:3000";
  static const String BASE_URL_Upload = "https://backend.recipto.in";

  static getClient([String? token]) {
    HttpLink link = HttpLink(
      // 'http://192.168.96.1:3000/graphql',
      // '$BASE_URL/graphql',
      // 'http://recipto.in:3000/graphql',
      '$BASE_URL/graphql',
      defaultHeaders: <String, String>{
        'Authorization': 'Authorization $token',
      },
    );
    GraphQLClient cc = GraphQLClient(link: link, cache: GraphQLCache());
    return cc;
  }

  static getSocket() {
    WebSocketLink link = WebSocketLink(
      // 'ws://10.0.2.2:3000/graphql',
      'ws://13.234.115.133:3000/graphql',
    );
    GraphQLClient cc = GraphQLClient(link: link, cache: GraphQLCache());
    return cc;
  }
}
