import 'package:graphql_flutter/graphql_flutter.dart';

class GqlConfig {
  static const String BASE_URL = "https://backend.recipto.in";
  static const String BASE_URL_Upload = "https://backend.recipto.in";
  // "https://df26-2405-201-c039-70c2-4d94-3680-9bc0-d8a7.in.ngrok.io/graphql"; //

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
      'wss://backend.recipto.in/graphql',
      // "ws://df26-2405-201-c039-70c2-4d94-3680-9bc0-d8a7.in.ngrok.io/graphql",
      // 'ws://13.234.115.133:3000/graphql',
    );
    GraphQLClient cc = GraphQLClient(link: link, cache: GraphQLCache());
    return cc;
  }
}
