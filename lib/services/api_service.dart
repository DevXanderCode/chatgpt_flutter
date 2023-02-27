import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:chatgpt_flutter/models/chat_model.dart';
import 'package:chatgpt_flutter/models/models_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:chatgpt_flutter/constants/api_consts.dart';

class ApiService {
  static Future<List<ModelsModel>> getModels() async {
    try {
      var response = await http.get(Uri.parse('$BASE_URL/models'),
          headers: {"Authorization": "Bearer $API_KEY"});

      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse['error'] != null) {
        log('response error ==> ${jsonResponse['error']['message']}');

        throw HttpException(jsonResponse['error']['message']);
      }

      // print('reponse body $jsonResponse');
      List temp = [];

      for (var value in jsonResponse['data']) {
        temp.add(value);
        // print('temp ===>> ${value['id']}');
      }

      return ModelsModel.modelsFromSnapshot(temp);
    } catch (error) {
      log('get models error ==> $error');
      rethrow;
    }
  }

  static Future<List<ChatModel>> sendMessage(
      {required String message, required String modelId}) async {
    print('Send Message called model: $modelId, ====> message: $message');
    try {
      var response = await http.post(
        Uri.parse('$BASE_URL/completions'),
        headers: {
          "Authorization": "Bearer $API_KEY",
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          'model': modelId,
          'prompt': message,
          'max_tokens': 100,
        }),
      );

      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse['error'] != null) {
        if (kDebugMode) {
          print('response error ==> ${jsonResponse['error']['message']}');
        }

        throw HttpException(jsonResponse['error']['message']);
      }
      List<ChatModel> chatList = [];
      if (jsonResponse['choices'].length > 0) {
        // if (kDebugMode) {
        //   print(
        //     'jsonResponse[choice]text ===> ${jsonResponse['choices'][0]['text']}',
        //   );
        // }

        chatList = List.generate(
          jsonResponse['choices'].length,
          (index) => ChatModel(
            msg: jsonResponse['choices'][index]['text'],
            chatIndex: 1,
          ),
        );
      }

      if (kDebugMode) {
        print('Message reponse $chatList');
      }

      return chatList;
    } catch (e) {
      if (kDebugMode) {
        print('send message error ==> $e');
      }
      rethrow;
    }
  }
}
