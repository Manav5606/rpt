import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/controllers/userViewModel.dart';

import 'package:customer_app/widgets/screenLoader.dart';
import 'package:freshchat_sdk/freshchat_sdk.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChattingScreen extends StatelessWidget {
  final Channel? channel;
  final String? titleName;

  ChattingScreen({Key? key, @required this.channel, this.titleName})
      : super(key: key);

  static RxBool loading = false.obs;
  // List<File>? images;

  static screenLoading() => loading.value = !loading.value;
  @override
  // void initState() {
  //   images = Get.arguments;
  // }

  @override
  Widget build(BuildContext context) {
    return Obx(() => IsScreenLoading(
          screenLoading: loading.value,
          child: StreamChannel(
              channel: channel!,
              child: Scaffold(
                appBar: ChannelHeader(
                  showTypingIndicator: true,
                  title: StreamBuilder<Map<String, dynamic>>(
                    stream: channel!.extraDataStream,
                    initialData: channel!.extraData,
                    builder: (context, snapshot) {
                      String title;
                      if (snapshot.data!['store_name'] == null &&
                          channel!.state!.members.length == 2) {
                        final otherMember = channel!.state!.members.firstWhere(
                            (member) =>
                                member.user!.id != UserViewModel.user.value.id);
                        title = otherMember.user!.name;
                      } else {
                        title = snapshot.data!['store_name'] ?? channel!.id;
                      }

                      return Text(
                        titleName ?? title.trim().capitalize!,
                        style: TextStyle(
                            color: AppConst.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.5.sp),
                      );
                    },
                  ),
                  subtitle: Center(),
                  leading: IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(
                      Icons.arrow_back,
                      color: AppConst.black,
                    ),
                  ),
                  actions: [
                    PopupMenuButton(
                      icon: Icon(
                        Icons.more_vert,
                        color: AppConst.grey,
                      ),
                      onSelected: (value) async {
                        screenLoading();
                        if (value == 'clear') {
                          await channel!.truncate();
                        } else {
                          await channel!.delete();
                          Get.back();
                        }
                        screenLoading();
                      },
                      itemBuilder: (_) => [
                        PopupMenuItem(
                          value: 'clear',
                          child: Text('Clear chat'),
                        ),
                        PopupMenuItem(
                          value: 'block',
                          child: Text('Block user'),
                        ),
                      ],
                    ),
                  ],
                ),
                //     AppBar(
                //   // elevation: 0,
                //   // title: Text(
                //   //   "Chats",
                //   //   style: TextStyle(
                //   //       fontSize: 14.sp,
                //   //       color: AppConst.black,
                //   //       fontWeight: FontWeight.bold),
                //   // ),
                //   leading: IconButton(
                //     onPressed: () => Get.back(),
                //     icon: Icon(
                //       Icons.arrow_back,
                //       color: AppConst.black,
                //     ),
                //   ),
                //   centerTitle: true,
                // title: StreamBuilder<Map<String, dynamic>>(
                //   stream: channel!.extraDataStream,
                //   initialData: channel!.extraData,
                //   builder: (context, snapshot) {
                //     String title;
                //     if (snapshot.data!['name'] == null &&
                //         channel!.state!.members.length == 2) {
                //       final otherMember = channel!.state!.members.firstWhere(
                //           (member) =>
                //               member.user!.id != UserViewModel.user.value.id);
                //       title = otherMember.user!.name;
                //     } else {
                //       title = snapshot.data!['name'] ?? channel!.id;
                //     }

                //     return Text(
                //       titleName ?? title.trim().capitalize!,
                //       style: TextStyle(color: AppConst.black),
                //     );
                //   },
                // ),
                //   actions: [
                //     PopupMenuButton(
                //       icon: Icon(
                //         Icons.more_vert,
                //         color: AppConst.grey,
                //       ),
                //       onSelected: (value) async {
                //         screenLoading();
                //         if (value == 'clear') {
                //           await channel!.truncate();
                //         } else {
                //           await channel!.delete();
                //           Get.back();
                //         }
                //         screenLoading();
                //       },
                //       itemBuilder: (_) => [
                //         PopupMenuItem(
                //           value: 'clear',
                //           child: Text('Clear chat'),
                //         ),
                //         PopupMenuItem(
                //           value: 'block',
                //           child: Text('Block user'),
                //         ),
                //       ],
                //     ),
                //   ],
                // ),
                body: Column(
                  children: [
                    Expanded(child: MessageListView(
                      // systemMessageBuilder: (BuildContext, Message) {
                      //   return Container();
                      // },

                      messageBuilder:
                          (context, details, messageList, defaultImpl) {
                        return defaultImpl.copyWith(
                          // messageTheme: MessageThemeData(
                          //   messageTextStyle:
                          //      TextStyle(fontWeight: FontWeight.bold),
                          // ),
                          // padding: EdgeInsets.only(left: 0,),
                          userAvatarBuilder: (BuildContext, user) {
                            return (defaultImpl.message.user?.role == "admin")
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        left: 10.w, bottom: 2.5.h),
                                    child: Icon(
                                      Icons.chat_bubble_outline,
                                      color: AppConst.grey,
                                    ),
                                  )
                                : Padding(
                                    padding: EdgeInsets.only(bottom: 1.h),
                                    child: CircleAvatar(
                                      backgroundColor: (defaultImpl
                                                  .message.user?.extraData[0] ==
                                              "customer")
                                          ? AppConst.kSecondaryColor
                                          : AppConst.kSecondaryColor,
                                      child: Icon(
                                        Icons.person,
                                        color: AppConst.white,
                                      ),
                                      // Text(defaultImpl.message.user?.name
                                      //         .substring(0, 1) ??
                                      //     '')
                                    ),
                                  );
                          },
                          // textPadding:
                          //     (defaultImpl.message.user?.role == "admin")
                          //         ? EdgeInsets.only(left: 10.w)
                          //         : EdgeInsets.symmetric(
                          //             horizontal: 3.w, vertical: 1.h),

                          showUserAvatar:
                              (defaultImpl.message.user?.role == "admin")
                                  ? (DisplayWidget.show)
                                  : (DisplayWidget.hide),
                          showUsername: false,
                          // (defaultImpl.message.user?.role == "admin")
                          //     ? false
                          //     : (messageList.)
                          //         ? false
                          //         : true,
                          showTimestamp:
                              (defaultImpl.message.user?.role == "admin")
                                  ? false
                                  : true,
                          showFlagButton:
                              (defaultImpl.message.user?.role == "admin")
                                  ? false
                                  : true,
                          showPinButton:
                              (defaultImpl.message.user?.role == "admin")
                                  ? false
                                  : true,
                          showEditMessage:
                              (defaultImpl.message.user?.role == "admin")
                                  ? false
                                  : true,
                          showCopyMessage:
                              (defaultImpl.message.user?.role == "admin")
                                  ? false
                                  : true,
                          showDeleteMessage:
                              (defaultImpl.message.user?.role == "admin")
                                  ? false
                                  : true,
                          showReactions:
                              (defaultImpl.message.user?.role == "admin")
                                  ? false
                                  : true,

                          // shape of the message
                          shape: (defaultImpl.message.user?.role == "admin")
                              ? Border.all(style: BorderStyle.none)
                              : null,

                          // username and storeId

                          // messageTheme: MessageThemeData(
                          //     messageBackgroundColor: Colors.red),
                        );
                      },
                    )),
                    MessageInput(
                      attachmentButtonBuilder: (context, defaultActionButton) {
                        return defaultActionButton.copyWith(
                          color: Colors.black, // attachment color
                          // icon: Icon(Icons.camera_alt), // attachment icon
                        );
                      },

                      commandButtonBuilder: (context, IconButton) {
                        return Center(); // it will remove the instants commands options
                      },
                      actionsLocation: ActionsLocation.leftInside,
                      sendButtonLocation: SendButtonLocation.inside,
                      // disableAttachments: true,
                    )
                  ],
                ),
              )),
        ));
  }
}
