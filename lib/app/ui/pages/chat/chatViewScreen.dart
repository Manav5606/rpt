import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/controller/add_location_controller.dart';
import 'package:customer_app/app/ui/pages/chat/freshchat_controller.dart';
import 'package:customer_app/screens/more_stores/all_offers_listview.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/constants/app_const.dart';
import 'package:customer_app/controllers/userViewModel.dart';

import 'package:customer_app/widgets/screenLoader.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChattingScreen extends StatelessWidget {
  final Channel? channel;
  final String? titleName;
  final freshChatController _freshChat = Get.find();

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
                  backgroundColor: AppConst.green,
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
                          color: AppConst.white,
                          fontFamily: 'MuseoSans',
                          fontSize: (SizerUtil.deviceType == DeviceType.tablet)
                              ? 11.sp
                              : 13.sp,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                        ),
                      );
                    },
                  ),
                  subtitle: Center(),
                  leading: IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(
                      Icons.arrow_back,
                      size: 3.h,
                      color: AppConst.white,
                    ),
                  ),
                  actions: [
                    InkWell(
                        highlightColor: AppConst.highLightColor,
                        onTap: () async {
                          _freshChat.initState();
                          await _freshChat.showChatConversation(
                              "Face issue with store chat \n");
                        },
                        child: Container(
                          width: 15.w,
                          child: Center(
                              child: Icon(
                            Icons.help_outline_outlined,
                            color: AppConst.white,
                            size: 2.8.h,
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
                    // PopupMenuButton(
                    //   icon: Icon(
                    //     Icons.more_vert,
                    //     color: AppConst.grey,
                    //   ),
                    //   onSelected: (value) async {
                    //     screenLoading();
                    //     if (value == 'clear') {
                    //       await channel!.truncate();
                    //     } else {
                    //       await channel!.delete();
                    //       Get.back();
                    //     }
                    //     screenLoading();
                    //   },
                    //   itemBuilder: (_) => [
                    //     PopupMenuItem(
                    //       value: 'clear',
                    //       child: Text('Clear chat'),
                    //     ),
                    //     PopupMenuItem(
                    //       value: 'block',
                    //       child: Text('Block user'),
                    //     ),
                    //   ],
                    // ),
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
                    Expanded(
                        child: MessageListView(
                      // systemMessageBuilder: (BuildContext, Message) {
                      //   return Container();
                      // },
                      showFloatingDateDivider: false,
                      // headerBuilder: (context) {
                      //   return Padding(
                      //     padding: EdgeInsets.symmetric(
                      //       horizontal: 5.w,
                      //     ),
                      //     child: Column(
                      //       mainAxisSize: MainAxisSize.min,
                      //       children: [
                      //         SizedBox(
                      //           height: 2.h,
                      //         ),
                      //         DispalyStoreLogo(
                      //           bottomPadding: 2,
                      //           logo:
                      //               channel?.extraData['store_logo'].toString(),
                      //         ),
                      //         // Container(
                      //         //     height: 6.h,
                      //         //     width: 12.w,
                      //         //     decoration: BoxDecoration(
                      //         //       shape: BoxShape.circle,
                      //         //       color: AppConst.black,
                      //         //     ),
                      //         //     child: Center(
                      //         //       child: Text(
                      //         //         // defaultImpl.message.user?.name
                      //         //         //         .substring(0, 1) ??
                      //         //         'S',
                      //         //         style: TextStyle(
                      //         //           color: Colors.white,
                      //         //           fontSize:
                      //         //               SizeUtils.horizontalBlockSize * 5,
                      //         //           fontFamily: 'MuseoSans',
                      //         //           fontWeight: FontWeight.w700,
                      //         //         ),
                      //         //       ),
                      //         //     )),

                      //         Text(
                      //             "${channel?.extraData['store_name'] ?? Storename}",
                      //             textAlign: TextAlign.center,
                      //             style: TextStyle(
                      //               fontFamily: 'MuseoSans',
                      //               color: AppConst.black,
                      //               fontSize:
                      //                   SizeUtils.horizontalBlockSize * 3.8,
                      //               fontWeight: FontWeight.w700,
                      //               fontStyle: FontStyle.normal,
                      //             )),
                      //         SizedBox(
                      //           height: 0.5.h,
                      //         ),
                      //         // Text(
                      //         //     "NSL Centrum Mall, KPHB Colony, Phase 5, Kukatpally, Hyderabad, Telangana",
                      //         //     textAlign: TextAlign.center,
                      //         //     style: TextStyle(
                      //         //       fontFamily: 'MuseoSans',
                      //         //       color: AppConst.grey,
                      //         //       fontSize:
                      //         //           SizeUtils.horizontalBlockSize * 3.2,
                      //         //       fontWeight: FontWeight.w500,
                      //         //       fontStyle: FontStyle.normal,
                      //         //     ))
                      //       ],
                      //     ),
                      //   );
                      // },
                      messageBuilder:
                          (context, details, messageList, defaultImpl) {
                        return defaultImpl.copyWith(
                          padding: EdgeInsets.only(left: 2.w, right: 2.w),
                          borderSide: BorderSide(
                            width: 0.4,
                            color: (defaultImpl
                                        .message.user?.extraData['userType'] ==
                                    "customer")
                                ? AppConst.veryLightGrey //Color(0xffeceaff)
                                : AppConst.grey,
                          ),
                          borderRadiusGeometry: BorderRadius.circular(12),

                          // userAvatarBuilder: (BuildContext, user) {
                          //   return (defaultImpl.message.user?.role == "admin")
                          //       ? Padding(
                          //           padding: EdgeInsets.only(bottom: 5.h),
                          //           child: Icon(
                          //             Icons.notifications_none,
                          //             color: AppConst.grey,
                          //             size: 3.h,
                          //           ),
                          //         )
                          //       : Padding(
                          //           padding: EdgeInsets.only(bottom: 1.h),
                          //           child: Container(
                          //               height: 4.h,
                          //               width: 8.w,
                          //               decoration: BoxDecoration(
                          //                 shape: BoxShape.circle,
                          //                 color: (defaultImpl.message.user
                          //                             ?.extraData['userType'] ==
                          //                         "customer")
                          //                     ? AppConst.green
                          //                     : Colors.amber,
                          //               ),
                          //               child: (defaultImpl.message.user
                          //                           ?.extraData['userType'] ==
                          //                       "customer")
                          //                   ? Center(
                          //                       child: Icon(
                          //                         Icons.person,
                          //                         color: AppConst.white,
                          //                       ),
                          //                     )
                          //                   : Center(
                          //                       child: Text(
                          //                         defaultImpl.message.user?.name
                          //                                 .substring(0, 1) ??
                          //                             '',
                          //                         style: TextStyle(
                          //                           color: Colors.white,
                          //                           fontSize: SizeUtils
                          //                                   .horizontalBlockSize *
                          //                               4.5,
                          //                           fontFamily: 'MuseoSans',
                          //                           fontWeight: FontWeight.w500,
                          //                         ),
                          //                       ),
                          //                     )),
                          //         );
                          // },

                          showUserAvatar:
                              (defaultImpl.message.user?.role == "admin")
                                  ? (DisplayWidget.gone)
                                  : (DisplayWidget.gone),
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
                          showEditMessage: false,
                          // (defaultImpl.message.user?.role == "admin")
                          //     ? false
                          //     : true,
                          showCopyMessage:
                              (defaultImpl.message.user?.role == "admin")
                                  ? false
                                  : true,
                          showDeleteMessage:
                              (defaultImpl.message.user?.role == "admin")
                                  ? false
                                  : true,
                          showReactions: false,
                          // (defaultImpl.message.user?.role == "admin")
                          //     ? false
                          //     : true,

                          // shape of the message
                          shape: (defaultImpl.message.user?.role == "admin")
                              ? Border.all(style: BorderStyle.none)
                              : null,

                          // username and storeId
                          textPadding: EdgeInsets.symmetric(
                              vertical: 1.5.h, horizontal: 3.w),

                          //text builder
                          textBuilder: (Context, Message) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                (Message.user?.role == "admin")
                                    ? DispalyStoreLogo(
                                        bottomPadding: 1,
                                        height: 2.h,
                                        logo: channel?.extraData['store_logo']
                                            .toString(),
                                      )
                                    : SizedBox(),
                                (Message.user?.role == "admin")
                                    ? Padding(
                                        padding: EdgeInsets.only(bottom: 0.h),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                                "Order ID: #${channel?.id?.substring(0, 10)}",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: 'MuseoSans',
                                                  color: AppConst.black,
                                                  fontSize:
                                                      (SizerUtil.deviceType ==
                                                              DeviceType.tablet)
                                                          ? 9.sp
                                                          : 10.sp,
                                                  fontWeight: FontWeight.w700,
                                                  fontStyle: FontStyle.normal,
                                                )),
                                          ],
                                        ),
                                      )
                                    : SizedBox(),
                                Row(
                                  mainAxisSize: (Message.user?.role == "admin")
                                      ? MainAxisSize.max
                                      : MainAxisSize.min,
                                  mainAxisAlignment:
                                      (Message.user?.role == "admin")
                                          ? MainAxisAlignment.start
                                          : MainAxisAlignment.start,
                                  children: [
                                    (Message.user?.role == "admin")
                                        ? Flexible(
                                            child: RichText(
                                                textAlign: TextAlign.start,
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                      text:
                                                          "List of products in Order\n",
                                                      style: TextStyle(
                                                        fontFamily: 'MuseoSans',
                                                        color: AppConst.black,
                                                        fontSize: (SizerUtil
                                                                    .deviceType ==
                                                                DeviceType
                                                                    .tablet)
                                                            ? 8.5.sp
                                                            : 9.5.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                      )),
                                                  TextSpan(
                                                      text: DisplaybulletedList(
                                                              Message.text ??
                                                                  "")
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontFamily: 'MuseoSans',
                                                        color:
                                                            AppConst.darkGrey,
                                                        fontSize: (SizerUtil
                                                                    .deviceType ==
                                                                DeviceType
                                                                    .tablet)
                                                            ? 8.sp
                                                            : 9.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                      ))
                                                ])),
                                          )
                                        : Flexible(
                                            child: Text(Message.text ?? "",
                                                textAlign:
                                                    // (Message.user?.role == "admin")
                                                    //     ? TextAlign.center
                                                    //     :
                                                    TextAlign.start,
                                                style:
                                                    //  (Message.user?.role ==
                                                    //         "admin")
                                                    //     ? TextStyle(
                                                    //         fontFamily: 'MuseoSans',
                                                    //         color: AppConst.grey,
                                                    //         fontSize: (SizerUtil
                                                    //                     .deviceType ==
                                                    //                 DeviceType.tablet)
                                                    //             ? 8.sp
                                                    //             : 9.sp,
                                                    //         fontWeight: FontWeight.w500,
                                                    //         fontStyle: FontStyle.normal,
                                                    //       )
                                                    // :
                                                    TextStyle(
                                                  fontFamily: 'MuseoSans',
                                                  color: AppConst.black,
                                                  fontSize:
                                                      (SizerUtil.deviceType ==
                                                              DeviceType.tablet)
                                                          ? 8.5.sp
                                                          : 9.5.sp,
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle: FontStyle.normal,
                                                ))),
                                  ],
                                ),
                              ],
                            );
                          },
                          messageTheme: (defaultImpl.message.user?.role ==
                                  "admin")
                              ? MessageThemeData(
                                  messageBackgroundColor:
                                      Color(0xfff3f3f5) //Color(0xffeceaff)
                                  ,
                                  messageTextStyle: TextStyle(
                                    fontFamily: 'MuseoSans',
                                    color: AppConst.grey,
                                    fontSize: (SizerUtil.deviceType ==
                                            DeviceType.tablet)
                                        ? 8.sp
                                        : 9.sp,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                  ))
                              : MessageThemeData(
                                  messageBackgroundColor: (defaultImpl.message
                                              .user?.extraData['userType'] ==
                                          "customer")
                                      ? Color(0xffEEEFF9) //Color(0xffeceaff)
                                      : AppConst.white,
                                  messageTextStyle: TextStyle(
                                    fontFamily: 'MuseoSans',
                                    color: AppConst.black,
                                    fontSize: (SizerUtil.deviceType ==
                                            DeviceType.tablet)
                                        ? 8.5.sp
                                        : 9.5.sp,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                  ),
                                  createdAtStyle: TextStyle(
                                    color: AppConst.grey,
                                    fontSize: (SizerUtil.deviceType ==
                                            DeviceType.tablet)
                                        ? 8.sp
                                        : 9.sp,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'MuseoSans',
                                  ),
                                ),
                        );
                      },
                    )),
                    MessageInput(
                      // attachmentButtonBuilder: (context, defaultActionButton) {
                      //   return defaultActionButton.copyWith(
                      //     constraints: BoxConstraints(minWidth: 8.w),
                      //     color: AppConst.green, // attachment color
                      //     icon: Icon(
                      //       Icons.attachment_outlined,
                      //     ), // attachment icon
                      //     iconSize: 3.2.h,
                      //   );
                      // },

                      showCommandsButton: false,

                      commandButtonBuilder: (context, IconButton) {
                        return Center(); // it will remove the instants commands options
                      },
                      actionsLocation: ActionsLocation.left,
                      sendButtonLocation: SendButtonLocation.outside,

                      // disableAttachments: true,

                      activeSendButton: Padding(
                        padding: EdgeInsets.only(left: 2.w, right: 2.w),
                        child: Icon(
                          Icons.send,
                          color: AppConst.green,
                          size: 3.2.h,
                        ),
                      ),
                      idleSendButton: Padding(
                        padding: EdgeInsets.only(left: 2.w, right: 2.w),
                        child: Icon(
                          Icons.send,
                          color: AppConst.grey,
                          size: 3.2.h,
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ));
  }

  DisplaybulletedList(String message) {
    var items = message.split(",");

    var itemlists = [];
    for (int i = 0; i < (items.length); i++) {
      itemlists.add("\u2022 ${items[i]}.\n");
    }
    return itemlists.join();
  }
}
