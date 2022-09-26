import 'dart:developer';

import 'package:customer_app/app/data/provider/graphql/queries.dart';
import 'package:customer_app/app/data/provider/graphql/request.dart';
import 'package:customer_app/app/ui/pages/chat/getallStream_channel_model.dart';

class ChatService {
  static Future<GetAllStreamChatChannelById?> getAllStreamChatChannelById() async {
    try {
      final result = await GraphQLRequest.query(query: GraphQLQueries.getAllStreamChatChannelById, variables: {});
      if (result['error'] == false) {
        final GetAllStreamChatChannelById getAllStreamChatChannelById = GetAllStreamChatChannelById.fromJson(result);
        return getAllStreamChatChannelById;
      }
    } catch (e, st) {
      log("$e , $st");
      rethrow;
    }
  }
}
