import 'package:chatgpt_flutter/models/chat_model.dart';
import 'package:chatgpt_flutter/providers/models_provider.dart';
import 'package:chatgpt_flutter/services/api_service.dart';
import 'package:flutter/material.dart';

class ChatProvider with ChangeNotifier {
  List<ChatModel> chatList = [];

  List<ChatModel> get getChatList {
    return chatList;
  }

  void addUserMessage({required String msg}) {
    chatList.add(
      ChatModel(
        msg: msg,
        chatIndex: 0,
      ),
    );
    notifyListeners();
  }

  Future<void> sendMessageAndGetAnswers(
      {required String msg, required String chosenModelId}) async {
    chatList.addAll(
      await ApiService.sendMessage(
        message: msg,
        modelId: chosenModelId,
      ),
    );
    notifyListeners();
  }
}
