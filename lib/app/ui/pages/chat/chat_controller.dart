import 'dart:developer';

import 'package:customer_app/app/controller/account_controller.dart';
import 'package:customer_app/app/data/model/active_order_model.dart';
import 'package:customer_app/app/data/model/order_model.dart';
import 'package:customer_app/app/data/model/user_model.dart';
import 'package:customer_app/app/data/repository/hive_repository.dart';
import 'package:customer_app/app/ui/pages/chat/chatRepo.dart';
import 'package:customer_app/app/ui/pages/chat/chatViewScreen.dart';
import 'package:customer_app/app/ui/pages/chat/chat_service.dart';
import 'package:customer_app/app/ui/pages/chat/getallStream_channel_model.dart';
import 'package:get/get.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatController extends GetxController {
  // Rx<GetAllStreamChatChannelById?> getAllStreamChatChannelByIdModel =
  //     GetAllStreamChatChannelById().obs;

  RxBool isLoading = false.obs;
  // final MyAccountController _accountController = Get.find();
  RxList<ActiveOrderData> chatList = <ActiveOrderData>[].obs;
  List<String> streamChatApiID = [];
  List<String> matchedId = [];
  List<String> chatNotStarted = [];
  UserModel? userModel;
  final HiveRepository hiveRepository = HiveRepository();
  List<Channel> messageList = [];
  List<Channel> noMessageList = [];

  // Future<void> getAllStreamChatChannelById() async {
  //   try {
  //     isLoading.value = true;
  //     getAllStreamChatChannelByIdModel.value =
  //         await ChatService.getAllStreamChatChannelById();
  //     for (var _element in getAllStreamChatChannelByIdModel.value?.data ?? []) {
  //       int index = _accountController.activeOrdersModel.value!.data!
  //           .indexWhere((element) => element.Id == _element.id);
  //       if (index != -1) {
  //         chatList
  //             .add(_accountController.activeOrdersModel.value!.data![index]);
  //         streamChatApiID.add(
  //             _accountController.activeOrdersModel.value!.data![index].Id ??
  //                 '');
  //       }
  //       log('chatList ${chatList.length}');
  //     }
  //     isLoading.value = false;
  //   } catch (e, st) {
  //     log('eee:$e st $st');
  //     isLoading.value = false;
  //   }
  // }

  Future<void> launchChat(String id, String name) async {
    try {
      isLoading.value = true;
      Get.to(ChattingScreen(
        channel: await ChatRepo.createOrJoinChat(id),
        titleName: name,
      ));
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print(e);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // getAllStreamChatChannelById();
    userModel = hiveRepository.getCurrentUser();
  }
}
