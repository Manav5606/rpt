import 'dart:developer';
import 'dart:io';

import 'package:customer_app/app/ui/pages/chat/freshchat_controller.dart';
import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/screens/more_stores/all_offers_listview.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/controller/account_controller.dart';
import 'package:customer_app/app/ui/pages/chat/ChatView.dart';
import 'package:customer_app/app/ui/pages/chat/chatViewScreen.dart';
import 'package:customer_app/app/ui/pages/chat/chat_controller.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/screens/history/history_screen.dart';
import 'package:customer_app/widgets/chatting_screen_custom.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class AllChats extends StatefulWidget {
  AllChats({Key? key}) : super(key: key);

  @override
  State<AllChats> createState() => _AllChatsState();
}

class _AllChatsState extends State<AllChats> {
  final ChatController _controller = Get.find();
  final MyAccountController _MyController = Get.find();
  final freshChatController _freshChat = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _freshChat.scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppConst.darkGreen,
            statusBarIconBrightness: Brightness.light),
        backgroundColor: AppConst.darkGreen,
        title: Text(
          "Chats   ",
          style: TextStyle(
              fontSize: SizeUtils.horizontalBlockSize * 5,
              fontFamily: 'MuseoSans',
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
              color: AppConst.white),
        ),
        // leading: GestureDetector(
        //   onTap: () {
        //     Get.toNamed(AppRoutes.BaseScreen);
        //   },
        //   child: Icon(
        //     Icons.close_rounded,
        //     size: 3.h,
        //   ),
        // ),
        actions: [
          InkWell(
              highlightColor: AppConst.highLightColor,
              onTap: () async {
                _freshChat.initState();
                await _freshChat
                    .showChatConversation("Face issue with store chat \n");
              },
              child: Container(
                width: 15.w,
                child: Center(
                    child: Icon(
                  Icons.help_outline_outlined,
                  color: AppConst.white,
                  size: 3.5.h,
                )
                    // Text(
                    //   "HELP",
                    //   style: TextStyle(
                    //       fontSize: SizeUtils.horizontalBlockSize * 4,
                    //       fontWeight: FontWeight.bold,
                    //       color: AppConst.black,
                    //       fontFamily: "MuseoSans",
                    //       letterSpacing: 0.5),
                    // ),
                    ),
              ))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   "Chats",
            //   style: TextStyle(
            //     fontSize: SizeUtils.horizontalBlockSize * 6,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // SizedBox(
            //   height: 0.5.h,
            // ),
            // GestureDetector(
            //   onTap: () {},
            //   child: Container(
            //     height: 3.5.h,
            //     width: MediaQuery.of(context).size.width,
            //     color: AppConst.veryLightGrey,
            //     child: Text(
            //       "Start chat with stores",
            //       style: TextStyle(fontSize: SizeUtils.horizontalBlockSize * 5),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 1.h,
            ),

            /// Dont remove  comment code utils this line is here
            // Expanded(
            //   child: Container(
            //     color: Colors.red,
            //     child: ChannelsBloc(
            //       child: ChannelListView(
            //         pullToRefresh: false,
            //         filter: Filter.and([
            //           Filter.equal('type', 'messaging'),
            //           Filter.in_('members', ['60d1a57f0d9c919a19251eb5']),
            //         ]),
            //         emptyBuilder: (_) => Center(
            //           child: Text('You have no chats, start a chat with a customer'),
            //         ),
            //         sort: [SortOption('last_message_at')],
            //         channelPreviewBuilder: (_, channel) => StreamBuilder<Map<String, dynamic>>(
            //           stream: channel.extraDataStream,
            //           initialData: channel.extraData,
            //           builder: (_, snapshot) {
            //             log('channel.state!.messages :${channel.state!.messages.length}');
            //             log('channel.id ${channel.id}');
            //             // if (_controller.streamChatApiID.contains(channel.id)) {
            //             //   if (channel.state!.messages.length > 0) {
            //             //     if (!_controller.messageList.contains(channel)) {
            //             //       _controller.messageList.add(channel);
            //             //     }
            //             //   } else {
            //             //     if (_controller.noMessageList.any((element) => element.id != channel.id)) {
            //             //       _controller.noMessageList.add(channel);
            //             //     }
            //             //   }
            //             //   log("messageList :${_controller.messageList.length}");
            //             //   log("noMessageList :${_controller.noMessageList.length}");
            //             //   _controller.matchedId.add(channel.id!);
            //             // }
            //             log('channel.state!.messages :${channel.state!.messages}');
            //             return  Text('${snapshot.data!['name'] ?? channel.id}');
            //           },
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            Expanded(
              child: ChannelsBloc(
                child: ChannelListView(
                  limit: 20,
                  // pagination: PaginationParams(limit: 20),
                  filter: Filter.and([
                    Filter.equal('type', 'messaging'),
                    Filter.in_('members', [
                      "${_MyController.user.id}",
                    ]), //60d1a57f0d9c919a19251eb5
                  ]),

                  /// making sure the chats only the user is in is shown
                  // filter: {
                  //   'members': {
                  //     '\$in': [StoreViewModel.store.value.id]
                  //   }
                  // },
                  /// when there is no chat builds this
                  emptyBuilder: (_) => Center(
                      child: EmptyHistoryPage(
                          icon: Icons.chat,
                          text1: "You have no chats,",
                          text2: " place a order to start the chat with store",
                          text3: "")
                      // Text('You have no chats, start a chat with a customer'),
                      ),

                  /// custom channel preview
                  channelPreviewBuilder: (_, channel) => Padding(
                    /// last message of the chat
                    padding: EdgeInsets.only(bottom: 5),

                    /// or typing status
                    child: StreamBuilder(
                      /// chat message status builder
                      initialData: channel.state!.unreadCount,
                      stream: channel.state!.unreadCountStream,
                      builder: (context, snapshot) {
                        return TypingIndicator(
                          channel: channel,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: AppConst.grey),
                          alternativeWidget: StreamBuilder<List<Message>>(
                            stream: channel.state!.messagesStream,
                            initialData: channel.state!.messages,
                            builder: (context, snapshot) {
                              final lastMessage = snapshot.data?.lastWhere(
                                (m) => m.shadowed != true,
                                // orElse: () =>
                                //     null!, // show an error null check operator used on null value
                              );
                              if (lastMessage == null) {
                                return SizedBox();
                              }

                              var text = lastMessage.text;
                              final utcTime =
                                  DateTime.fromMicrosecondsSinceEpoch(
                                      lastMessage
                                          .createdAt.microsecondsSinceEpoch);
                              final localTime = utcTime.toLocal();
                              if (lastMessage.isDeleted) {
                                text = 'This message was deleted.';
                              } else if (lastMessage.attachments != null) {
                                final prefix = lastMessage.attachments
                                    .map((e) {
                                      if (e.type == 'image') {
                                        return '📷';
                                      } else if (e.type == 'video') {
                                        return '🎬';
                                      } else if (e.type == 'giphy') {
                                        return 'GIF';
                                      }
                                      return null;
                                    })
                                    .where((e) => e != null)
                                    .join(' ');
                                log('channel.state!.messages :${channel.state!.messages}');
                                log('lastMessage.text :${lastMessage.toJson()}');

                                text = '$prefix ${lastMessage.text ?? ''}';
                              }

                              return GestureDetector(
                                onTap: () {
                                  Get.to(ChattingScreen(
                                    channel: channel,
                                  ));
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 1.h),
                                  child: Container(
                                    // color: Colors.yellow,
                                    child: Row(
                                      children: [
                                        // Padding(
                                        //   padding: EdgeInsets.only(bottom: 4.h),
                                        //   child: Container(
                                        //     height: 5.h,
                                        //     width: 12.w,
                                        //     decoration: BoxDecoration(
                                        //       color: AppConst.kSecondaryColor,
                                        //       shape: BoxShape.circle,
                                        //       border: Border.all(width: 0.1),
                                        //       boxShadow: [
                                        //         BoxShadow(
                                        //           color: AppConst.black
                                        //               .withOpacity(0.1),
                                        //           offset: Offset(
                                        //             0,
                                        //             1.h,
                                        //           ),
                                        //           blurRadius: 1.h,
                                        //           spreadRadius: 1.0,
                                        //         ),
                                        //       ],
                                        //     ),
                                        //     child: Center(
                                        //       child: (channel.extraData[
                                        //                           "store_name"]
                                        //                       .toString() ==
                                        //                   null ||
                                        //               channel.extraData[
                                        //                           "store_name"]
                                        //                       .toString() ==
                                        //                   "")
                                        //           ? Icon(
                                        //               Icons.person,
                                        //               size: 4.h,
                                        //               color: AppConst.white,
                                        //             )
                                        //           : Text(
                                        //               channel
                                        //                   .extraData["store_name"]
                                        //                   .toString()[0],
                                        //               style: TextStyle(
                                        //                   color: AppConst.white,
                                        //                   fontSize: 13.sp),
                                        //             ),
                                        //     ),
                                        //   ),
                                        //   //  CircleAvatar(),
                                        // ),
                                        DispalyStoreLogo(
                                          bottomPadding: 0,
                                          height: 6.5,
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 67.w,
                                                      child: Text(
                                                          channel.extraData[
                                                                      "store_name"]
                                                                  ?.toString() ??
                                                              "store_name is not gettting ",
                                                          //  user.extraData["email"]?.stringValue ?? ""
                                                          // "Store Name",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'MuseoSans',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontStyle: FontStyle
                                                                  .normal,
                                                              fontSize: SizeUtils
                                                                      .horizontalBlockSize *
                                                                  3.8,
                                                              color: AppConst
                                                                  .black)),
                                                    ),
                                                    Text(
                                                        DateFormat()
                                                            // .add_yMMMMEEEEd()
                                                            .add_Hm()
                                                            .format(localTime),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'MuseoSans',
                                                          color: AppConst.grey,
                                                          fontSize: SizeUtils
                                                                  .horizontalBlockSize *
                                                              3.5,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                        )),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 0.5.h,
                                                ),
                                                // Text(
                                                //     "${channel.extraData["order_ID"]?.toString() ?? ""}",
                                                //     overflow:
                                                //         TextOverflow.ellipsis,
                                                //     style: TextStyle(
                                                //       fontFamily: 'MuseoSans',
                                                //       color: AppConst.grey,
                                                //       fontSize: SizeUtils
                                                //               .horizontalBlockSize *
                                                //           3.8,
                                                //       fontWeight: FontWeight.w500,
                                                //       fontStyle: FontStyle.normal,
                                                //     )),
                                                // SizedBox(
                                                //   height: 0.5.h,
                                                // ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      width: 70.w,
                                                      // height: 3.h,
                                                      child: Text(text!,
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: SizeUtils
                                                                      .horizontalBlockSize *
                                                                  3.5,
                                                              fontFamily:
                                                                  'MuseoSans',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              color: AppConst
                                                                  .grey)),
                                                    ),
                                                    (channel.state!
                                                                .unreadCount >
                                                            0)
                                                        ? Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    3),
                                                            decoration: BoxDecoration(
                                                                color: AppConst
                                                                    .green,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20)),
                                                            child: Text(
                                                                " ${channel.state!.unreadCount} ",
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'MuseoSans',
                                                                  color: AppConst
                                                                      .white,
                                                                  fontSize:
                                                                      SizeUtils
                                                                              .horizontalBlockSize *
                                                                          3.5,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .normal,
                                                                )),
                                                          )
                                                        : SizedBox(),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  sort: [SortOption('last_message_at')],
                ),
              ),
            ),
            // Flexible(
            //   child: ListView.separated(
            //     shrinkWrap: true,
            //     itemCount: _controller.chatList.length,
            //     itemBuilder: (context, index) {
            //       return chat_box_field(
            //           "A",
            //           "${_controller.chatList[index].sId ?? ''}",
            //           "Hii forget to add chesse!", () async {
            //         // Get.to(ChatScreen());
            //         //
            //         // Get.to(
            //         //   ChattingScreen(
            //         //     channel: await ChatRepo.createOrJoinChat(_controller.userModel?.id ?? '', '62ab44955db33dcc5a726e97'),
            //         //   ),
            //         // );
            //       });
            //     },
            //     separatorBuilder: (BuildContext context, int index) {
            //       return Divider(color: AppConst.black);
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  GestureDetector chat_box_field(String CircleLetter, String name,
      String message, GestureTapCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              child: Text(CircleLetter),
              radius: 2.h,
            ),
            SizedBox(
              width: 3.w,
            ),
            RichText(
              text: TextSpan(
                text: name,
                style: TextStyle(
                    fontSize: SizeUtils.horizontalBlockSize * 4.5,
                    color: AppConst.black),
                children: <TextSpan>[
                  TextSpan(text: '\n'),
                  TextSpan(
                      text: DateFormat('hh:mm a').format(DateTime.now()),
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: ' \n${message}'),
                ],
              ),
            ),
            ChannelsBloc(
              child: ChannelListView(
                pagination: PaginationParams(limit: 20),

                /// making sure the chats only the user is in is shown
                // filter: {
                //   'members': {
                //     '\$in': [StoreViewModel.store.value.id]
                //   }
                // },
                /// when there is no chat builds this
                emptyBuilder: (_) => Center(
                  child:
                      Text('You have no chats, start a chat with a customer'),
                ),

                /// custom channel preview
                channelPreviewBuilder: (_, channel) => Padding(
                  /// last message of the chat
                  padding: EdgeInsets.only(bottom: 5),

                  /// or typing status
                  child: StreamBuilder(
                    /// chat message status builder
                    initialData: channel.state!.unreadCount,
                    stream: channel.state!.unreadCountStream,
                    builder: (context, snapshot) {
                      return TypingIndicator(
                        channel: channel,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: AppConst.grey),
                        alternativeWidget: StreamBuilder<List<Message>>(
                          stream: channel.state!.messagesStream,
                          initialData: channel.state!.messages,
                          builder: (context, snapshot) {
                            final lastMessage = snapshot.data?.lastWhere(
                              (m) => m.shadowed != true,
                              orElse: () => null!,
                            );
                            if (lastMessage == null) {
                              return SizedBox();
                            }

                            var text = lastMessage.text;
                            if (lastMessage.isDeleted) {
                              text = 'This message was deleted.';
                            } else if (lastMessage.attachments != null) {
                              final prefix = lastMessage.attachments
                                  .map((e) {
                                    if (e.type == 'image') {
                                      return '📷';
                                    } else if (e.type == 'video') {
                                      return '🎬';
                                    } else if (e.type == 'giphy') {
                                      return 'GIF';
                                    }
                                    return null;
                                  })
                                  .where((e) => e != null)
                                  .join(' ');

                              text = '$prefix ${lastMessage.text ?? ''}';
                            }

                            return Text(text!,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: AppConst.grey));
                          },
                        ),
                      );
                    },
                  ),
                ),
                sort: [SortOption('last_message_at')],
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppConst.grey,
              size: 3.h,
            ),
          ],
        ),
      ),
    );
  }
}
