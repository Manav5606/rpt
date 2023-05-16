import 'dart:developer';
import 'dart:io';

import 'package:customer_app/app/ui/pages/chat/chat_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:customer_app/app/constants/responsive.dart';
import 'package:customer_app/app/ui/pages/chat/freshchat_controller.dart';
import 'package:customer_app/app/ui/pages/chat/freshchat_controller.dart';
import 'package:customer_app/app/ui/pages/chat/freshchat_sdk.dart';
import 'package:customer_app/app/ui/pages/chat/freshchat_user.dart';
import 'package:customer_app/constants/app_const.dart';

import 'package:customer_app/routes/app_list.dart';
import 'package:customer_app/theme/styles.dart';
import 'package:customer_app/widgets/all_chatview.dart';
import 'package:customer_app/widgets/nochatview.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

// class ChatView extends StatelessWidget {
//   ChatView({Key? key}) : super(key: key);
//   final ChatController _chatController = Get.put(ChatController());
//   final freshChatController _freshChat = Get.put(freshChatController());
//   @override
//   Widget build(BuildContext context) {
//     return
//         //  Scaffold(
//         // key: _freshChat.scaffoldKey,
//         // appBar: AppBar(
//         //   title: Text(
//         //     'Start chatting ',
//         //     style: TextStyle(color: AppConst.black),
//         //   ),
//         // ),
//         // floatingActionButton: FloatingActionButton(
//         // onPressed: () async {
//         //   _freshChat.initState();
//         //   await _freshChat.showChatConversation();
//         // },
//         //   tooltip: 'Chat',
//         //   child: Icon(Icons.chat),
//         // ),
//         // );

//         AllChats();
//     // nochats();
//   }
// }

class nochats extends StatelessWidget {
  const nochats({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            minimum: EdgeInsets.only(
                top: SizeUtils.horizontalBlockSize * 3.82,
                left: SizeUtils.horizontalBlockSize * 2.55,
                right: SizeUtils.horizontalBlockSize * 2.55),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                  height: SizeUtils.horizontalBlockSize * 15,
                  decoration: BoxDecoration(color: Colors.white, boxShadow: []),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Chats",
                          style: AppStyles.STORE_NAME_STYLE,
                        ),
                        InkWell(
                            onTap: () => Get.toNamed(AppRoutes.HelpSupport),
                            child: Text(
                              "Support",
                              style: TextStyle(
                                  color: AppConst.kPrimaryColor,
                                  fontSize: SizeUtils.horizontalBlockSize * 4),
                            ))
                      ])),
              Expanded(child: NoChatView())
            ])));
  }
}

// void handleFreshchatNotification(Map<String, dynamic> message) async {
//   if (await Freshchat.isFreshchatNotification(message)) {
//     print("is Freshchat notification");
//     Freshchat.handlePushNotification(message);
//   }
// }

// Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
//   print("Inside background handler");
//   await Firebase.initializeApp();
//   handleFreshchatNotification(message.data);
// }

// class MyChatPage extends StatefulWidget {
//   MyChatPage({Key? key, this.title}) : super(key: key);

//   final String? title;
//   @override
//   _MyChatPageState createState() => _MyChatPageState();
// }

// class _MyChatPageState extends State<MyChatPage> {
//   int _counter = 0;
//   final GlobalKey<ScaffoldState>? _scaffoldKey = new GlobalKey<ScaffoldState>();

//   void registerFcmToken() async {
//     if (Platform.isAndroid) {
//       String? token = await FirebaseMessaging.instance.getToken();
//       print("FCM Token is generated $token");
//       Freshchat.setPushRegistrationToken(token!);
//     }
//   }

//   void restoreUser(BuildContext context) {
//     var externalId, restoreId, obtainedRestoreId;
//     var alert = AlertDialog(
//       scrollable: true,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
//       title: Text(
//         "Identify/Restore User",
//         textDirection: TextDirection.ltr,
//         style: TextStyle(fontFamily: 'OpenSans-Regular'),
//       ),
//       content: Form(
//         child: Column(
//           children: [
//             TextFormField(
//                 autofocus: true,
//                 decoration: InputDecoration(
//                   hintText: "External ID",
//                 ),
//                 onChanged: (val) {
//                   setState(() {
//                     externalId = val;
//                   });
//                 }),
//             TextFormField(
//                 autofocus: true,
//                 decoration: InputDecoration(
//                   hintText: "Restore ID",
//                 ),
//                 onChanged: (val) {
//                   setState(() {
//                     restoreId = val;
//                   });
//                 }),
//           ],
//         ),
//       ),
//       actions: <Widget>[
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: <Widget>[
//             MaterialButton(
//               elevation: 10.0,
//               child: Text(
//                 "Identify/Restore",
//                 textDirection: TextDirection.ltr,
//               ),
//               onPressed: () {
//                 setState(
//                   () {
//                     Freshchat.identifyUser(
//                         externalId: externalId, restoreId: restoreId);
//                     Navigator.of(context, rootNavigator: true).pop(context);
//                   },
//                 );
//               },
//             ),
//             MaterialButton(
//               elevation: 10.0,
//               child: Text(
//                 "Cancel",
//                 textDirection: TextDirection.ltr,
//               ),
//               onPressed: () {
//                 setState(() {
//                   Navigator.of(context, rootNavigator: true).pop(context);
//                 });
//               },
//             ),
//           ],
//         ),
//       ],
//     );
//     showDialog(
//         context: context,
//         builder: (context) {
//           return alert;
//         });
//   }

//   void notifyRestoreId(var event) async {
//     FreshchatUser user = await Freshchat.getUser;
//     String? restoreId = user.getRestoreId();
//     if (restoreId != null) {
//       Clipboard.setData(new ClipboardData(text: restoreId));
//     }
//     _scaffoldKey!.currentState!.showSnackBar(
//         new SnackBar(content: new Text("Restore ID copied: $restoreId")));
//   }

//   void getUserProps(BuildContext context) {
//     final _userInfoKey = new GlobalKey<FormState>();
//     String? key, value;
//     var alert = AlertDialog(
//       scrollable: true,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
//       title: Text(
//         "Custom User Properties:",
//         textDirection: TextDirection.ltr,
//         style: TextStyle(fontFamily: 'OpenSans-Regular'),
//       ),
//       content: Form(
//         key: _userInfoKey,
//         child: Column(
//           children: [
//             TextFormField(
//                 autofocus: true,
//                 decoration: InputDecoration(
//                   hintText: "Key",
//                 ),
//                 onChanged: (val) {
//                   setState(() {
//                     key = val;
//                   });
//                 }),
//             TextFormField(
//                 autofocus: true,
//                 decoration: InputDecoration(
//                   hintText: "Value",
//                 ),
//                 onChanged: (val) {
//                   setState(() {
//                     value = val;
//                   });
//                 }),
//           ],
//         ),
//       ),
//       actions: <Widget>[
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: <Widget>[
//             MaterialButton(
//               elevation: 10.0,
//               child: Text(
//                 "Add Properties",
//                 textDirection: TextDirection.ltr,
//               ),
//               onPressed: () {
//                 setState(() {
//                   Map map = {key: value};
//                   Freshchat.setUserProperties(map);
//                 });
//               },
//             ),
//             MaterialButton(
//               elevation: 10.0,
//               child: Text(
//                 "Cancel",
//                 textDirection: TextDirection.ltr,
//               ),
//               onPressed: () {
//                 setState(() {
//                   Navigator.of(context, rootNavigator: true).pop(context);
//                 });
//               },
//             ),
//           ],
//         ),
//       ],
//     );
//     showDialog(
//         context: context,
//         builder: (context) {
//           return alert;
//         });
//   }

//   void sendMessageApi(BuildContext context) {
//     final _userInfoKey = new GlobalKey<FormState>();
//     String? conversationTag, message;
//     var alert = AlertDialog(
//       scrollable: true,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
//       title: Text(
//         "Send Message API",
//         textDirection: TextDirection.ltr,
//         style: TextStyle(fontFamily: 'OpenSans-Regular'),
//       ),
//       content: Form(
//         key: _userInfoKey,
//         child: Column(
//           children: [
//             TextFormField(
//                 autofocus: true,
//                 decoration: InputDecoration(
//                   hintText: "Conversation Tag",
//                 ),
//                 onChanged: (val) {
//                   setState(() {
//                     conversationTag = val;
//                   });
//                 }),
//             TextFormField(
//                 autofocus: true,
//                 decoration: InputDecoration(
//                   hintText: "Message",
//                 ),
//                 onChanged: (val) {
//                   setState(() {
//                     message = val;
//                   });
//                 }),
//           ],
//         ),
//       ),
//       actions: <Widget>[
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: <Widget>[
//             MaterialButton(
//               elevation: 10.0,
//               child: Text(
//                 "Send Message",
//                 textDirection: TextDirection.ltr,
//               ),
//               onPressed: () {
//                 setState(
//                   () {
//                     Freshchat.sendMessage(conversationTag!, message!);
//                     Navigator.of(context, rootNavigator: true).pop(context);
//                   },
//                 );
//               },
//             ),
//             MaterialButton(
//               elevation: 10.0,
//               child: Text(
//                 "Cancel",
//                 textDirection: TextDirection.ltr,
//               ),
//               onPressed: () {
//                 setState(() {
//                   Navigator.of(context, rootNavigator: true).pop(context);
//                 });
//               },
//             ),
//           ],
//         ),
//       ],
//     );
//     showDialog(
//         context: context,
//         builder: (context) {
//           return alert;
//         });
//   }

//   static const String APP_ID = "942ba118-79b9-4be7-bdfa-00b4b49522e8",
//       APP_KEY = "6b9a4433-5a91-4105-a4d6-e48eedee2ef9",
//       DOMAIN = "msdk.in.freshchat.com";

//   void initState() {
//     super.initState();
//     Freshchat.init(APP_ID, APP_KEY, DOMAIN);

//     /**
//      * This is the Firebase push notification server key for this sample app.
//      * Please save this in your Freshchat account to test push notifications in Sample app.
//      *
//      * Server key: Please refer support documentation for the server key of this sample app.
//      *
//      * Note: This is the push notification server key for sample app. You need to use your own server key for testing in your application
//      */
//     var restoreStream = Freshchat.onRestoreIdGenerated;
//     var restoreStreamSubsctiption = restoreStream.listen((event) {
//       print("Restore ID Generated: $event");
//       notifyRestoreId(event);
//     });

//     // FreshchatUser user = new FreshchatUser(
//     //     "6263f7e2f91bba7f87fcadba", "724f87b8-bac3-498c-b511-6661ad7b8f1a");

//     // FreshchatUser freshchatUser = new FreshchatUser(
//     //     "6263f7e2f91bba7f87fcadba", "724f87b8-bac3-498c-b511-6661ad7b8f1a");
//     // freshchatUser.setFirstName("test1");
//     // Freshchat.setUser(freshchatUser);

//     var unreadCountStream = Freshchat.onMessageCountUpdate;
//     unreadCountStream.listen((event) {
//       print("Have unread messages: $event");
//     });

//     var userInteractionStream = Freshchat.onUserInteraction;
//     userInteractionStream.listen((event) {
//       print("User interaction for Freshchat SDK");
//     });

//     if (Platform.isAndroid) {
//       registerFcmToken();
//       FirebaseMessaging.instance.onTokenRefresh
//           .listen(Freshchat.setPushRegistrationToken);

//       Freshchat.setNotificationConfig(notificationInterceptionEnabled: true);
//       var notificationInterceptStream = Freshchat.onNotificationIntercept;
//       notificationInterceptStream.listen((event) {
//         print("Freshchat Notification Intercept detected");
//         Freshchat.openFreshchatDeeplink(event["url"]);
//       });

//       FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//         var data = message.data;
//         handleFreshchatNotification(data);
//         print("Notification Content: $data");
//       });
//       FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
//     }
//   }

//   Future<void> _incrementCounter() async {
//     FreshchatUser user = await Freshchat.getUser;
//     var restoreId = user.getRestoreId();

//     log("restoreIdddddd:$restoreId");
//     log("i am  in conversation ");
//     FreshchatUser freshchatUser =
//         new FreshchatUser("6263f7e2f91bba7f87fcadba", restoreId);
//     //customerId  == externalId  hint
//     freshchatUser.setFirstName("test2");
//     Freshchat.setUser(freshchatUser);

//     // FreshchatUser user = await Freshchat.getUser;

//     // var restoreId = user.getRestoreId();
//     // log("restoreIdddddd:$restoreId");
//     Freshchat.identifyUser(
//         externalId: "6263f7e2f91bba7f87fcadba", restoreId: restoreId);
//     setState(() {
//       Freshchat.showConversations();
//       Freshchat.showFAQ();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         key: _scaffoldKey,
//         appBar: AppBar(
//           title: Text('Freshchat Flutter Demo'),
//         ),
//         // body: Builder(
//         //   builder: (context) => GridView.count(
//         //     crossAxisCount: 2,
//         //     children: List.generate(6, (index) {
//         //       switch (index) {
//         //         case 0:
//         //           return GestureDetector(
//         //               child: Container(
//         //                 decoration: BoxDecoration(border: Border.all(width: 1)),
//         //                 child: Padding(
//         //                     padding: EdgeInsets.fromLTRB(0, 70, 0, 0),
//         //                     child: Text(
//         //                       "FAQs",
//         //                       style: Theme.of(context).textTheme.headline5,
//         //                       textAlign: TextAlign.center,
//         //                     )),
//         //               ),
//         //               onTap: () {
//         //                 Freshchat.showFAQ(
//         //                     showContactUsOnFaqScreens: true,
//         //                     showContactUsOnAppBar: true,
//         //                     showFaqCategoriesAsGrid: true,
//         //                     showContactUsOnFaqNotHelpful: true);
//         //               });
//         //           break;
//         //         case 1:
//         //           return GestureDetector(
//         //               child: Container(
//         //                 decoration: BoxDecoration(border: Border.all(width: 1)),
//         //                 child: Padding(
//         //                     padding: EdgeInsets.fromLTRB(0, 70, 0, 0),
//         //                     child: Text(
//         //                       "Unread Count",
//         //                       style: Theme.of(context).textTheme.headline5,
//         //                       textAlign: TextAlign.center,
//         //                     )),
//         //               ),
//         //               onTap: () async {
//         //                 var unreadCountStatus =
//         //                     await Freshchat.getUnreadCountAsync;
//         //                 int count = unreadCountStatus['count'];
//         //                 String status = unreadCountStatus['status'];
//         //                 final snackBar = SnackBar(
//         //                   content: Text(
//         //                       "Unread Message Count: $count  Status: $status"),
//         //                 );
//         //                 Scaffold.of(context).showSnackBar(snackBar);
//         //               });
//         //           break;
//         //         case 2:
//         //           return GestureDetector(
//         //               child: Container(
//         //                 decoration: BoxDecoration(border: Border.all(width: 1)),
//         //                 child: Padding(
//         //                     padding: EdgeInsets.fromLTRB(0, 70, 0, 0),
//         //                     child: Text(
//         //                       "Reset User",
//         //                       style: Theme.of(context).textTheme.headline5,
//         //                       textAlign: TextAlign.center,
//         //                     )),
//         //               ),
//         //               onTap: () {
//         //                 Freshchat.resetUser();
//         //               });
//         //           break;
//         //         case 3:
//         //           return GestureDetector(
//         //               child: Container(
//         //                 decoration: BoxDecoration(border: Border.all(width: 1)),
//         //                 child: Padding(
//         //                     padding: EdgeInsets.fromLTRB(0, 70, 0, 0),
//         //                     child: Text(
//         //                       "Restore User",
//         //                       style: Theme.of(context).textTheme.headline5,
//         //                       textAlign: TextAlign.center,
//         //                     )),
//         //               ),
//         //               onTap: () {
//         //                 restoreUser(context);
//         //               });
//         //           break;
//         //         case 4:
//         //           return GestureDetector(
//         //               child: Container(
//         //                 decoration: BoxDecoration(border: Border.all(width: 1)),
//         //                 child: Padding(
//         //                     padding: EdgeInsets.fromLTRB(0, 70, 0, 0),
//         //                     child: Text(
//         //                       "Set User Properties",
//         //                       style: Theme.of(context).textTheme.headline5,
//         //                       textAlign: TextAlign.center,
//         //                     )),
//         //               ),
//         //               onTap: () {
//         //                 getUserProps(context);
//         //               });
//         //           break;
//         //         case 5:
//         //           return GestureDetector(
//         //               child: Container(
//         //                 decoration: BoxDecoration(border: Border.all(width: 1)),
//         //                 child: Padding(
//         //                     padding: EdgeInsets.fromLTRB(0, 70, 0, 0),
//         //                     child: Text(
//         //                       "Send Message",
//         //                       style: Theme.of(context).textTheme.headline5,
//         //                       textAlign: TextAlign.center,
//         //                     )),
//         //               ),
//         //               onTap: () {
//         //                 sendMessageApi(context);
//         //               });
//         //           break;
//         //         default:
//         //           return Center(
//         //             child: Text(
//         //               'Item $index',
//         //               style: Theme.of(context).textTheme.headline5,
//         //             ),
//         //           );
//         //           break;
//         //       }
//         //     }),
//         //   ),
//         // ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: _incrementCounter,
//           tooltip: 'Chat',
//           child: Icon(Icons.chat),
//         ),
//       ),
//     );
//   }
// }
