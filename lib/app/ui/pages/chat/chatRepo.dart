import 'dart:developer';

import 'package:customer_app/app/constants/app_constants.dart';
import 'package:customer_app/controllers/userViewModel.dart';
import 'package:stream_chat/stream_chat.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

// class ChatRepo {
//   static Future<Channel> createOrJoinChat(String userID) async {
//     log('userID :$userID ');

//     final channel = Constants.client.channel('messaging',
//         id: UserViewModel.user.value.id! + userID,
//         extraData: {
//           'name':
//               '${UserViewModel.user.value.firstName} ${UserViewModel.user.value.lastName}',
//           'image': UserViewModel.user.value.logo,
//           'userType': 'customer',
//           'members': [UserViewModel.user.value.id, userID]
//         });

//     log('click on GROCERYOFFLINE 000 $userID');
//     ChannelState channelState = await channel.create();
//     log('click on GROCERYOFFLINE 111 $channelState');
//     await channel.watch();
//     log('click on GROCERYOFFLINE 222');
//     return channel;
//   }
// }

class ChatRepo {
  static Future<Channel> createOrJoinChat(
    String orderId,
  ) async {
    // log('userID :$userID , orderId $orderId');

    final channel =
        Constants.client.channel('messaging', id: orderId, extraData: {
      'members': [
        orderId,
      ]
    });

    // log('click on GROCERYOFFLINE 000 $userID');
    ChannelState channelState = await channel.create();
    log('click on GROCERYOFFLINE 111 $channelState');
    await channel.watch();
    log('click on GROCERYOFFLINE 222');
    return channel;
  }
}
