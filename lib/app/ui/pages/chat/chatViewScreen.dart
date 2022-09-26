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

  static screenLoading() => loading.value = !loading.value;

  @override
  Widget build(BuildContext context) {
    return Obx(() => IsScreenLoading(
          screenLoading: loading.value,
          child: StreamChannel(
              channel: channel!,
              child: Scaffold(
                appBar: ChannelHeader(
                  showTypingIndicator: true,
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
                //   title: StreamBuilder<Map<String, dynamic>>(
                //     stream: channel!.extraDataStream,
                //     initialData: channel!.extraData,
                //     builder: (context, snapshot) {
                //       String title;
                //       if (snapshot.data!['name'] == null &&
                //           channel!.state!.members.length == 2) {
                //         final otherMember = channel!.state!.members.firstWhere(
                //             (member) =>
                //                 member.user!.id != UserViewModel.user.value.id);
                //         title = otherMember.user!.name;
                //       } else {
                //         title = snapshot.data!['name'] ?? channel!.id;
                //       }

                //       return Text(
                //         titleName ?? title.trim().capitalize!,
                //         style: TextStyle(color: AppConst.black),
                //       );
                //     },
                //   ),
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
                      // systemMessageBuilder: (context, Message) {
                      //   return Text("hiiiiii");
                      // },
                      messageBuilder:
                          (context, details, messageList, defaultImpl) {
                        return defaultImpl.copyWith(
                          showUserAvatar: defaultImpl.message.silent
                              ? (DisplayWidget.hide)
                              : (DisplayWidget.show),
                          showUsername:
                              defaultImpl.message.silent ? false : true,
                          showTimestamp:
                              defaultImpl.message.silent ? false : true,
                          showFlagButton:
                              defaultImpl.message.silent ? false : true,
                          showPinButton:
                              defaultImpl.message.silent ? false : true,
                          showEditMessage:
                              defaultImpl.message.silent ? false : true,
                          showCopyMessage:
                              defaultImpl.message.silent ? false : true,
                          showDeleteMessage:
                              defaultImpl.message.silent ? false : true,
                          showReactions:
                              defaultImpl.message.silent ? false : true,

                          // shape of the message
                          // shape:
                          //     Border.all(style: BorderStyle.none),
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
                        // IconButton.copyWith(
                        //   color: Colors.black, // command button color
                        //   focusColor: Colors.red,
                        //   icon: Icon(
                        //       Icons.flash_on_rounded), //  command button icon
                        // );
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
