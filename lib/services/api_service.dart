import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:chatgpt_flutter/models/models_model.dart';
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

  static Future<dynamic> sendMessage(
      {required String message, required String model}) async {
    try {
      var response = await http.post(Uri.parse('$BASE_URL/completions'), body: {
        'models': model,
        'prompt': message,
        "max_tokens": 100,
      });
    } catch (e) {
      log('send message error ==> $e');
      rethrow;
    }
  }
}
