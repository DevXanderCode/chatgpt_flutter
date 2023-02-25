import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:chatgpt_flutter/constants/api_consts.dart';

class ApiService {
  static Future<void> getModels() async {
    try {
      var response = await http.get(Uri.parse('$BASE_URL/modelsaa'),
          headers: {"Authorization": "Bearer $API_KEY"});

      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse['error'] != null) {
        if (kDebugMode) {
          print('response error ==> ${jsonResponse['error']['message']}');
        }
        throw HttpException(jsonResponse['error']['message']);
      }
      if (kDebugMode) {
        print('reponse body $jsonResponse');
      }
    } catch (error) {
      if (kDebugMode) {
        print('get models error ==> $error');
      }
    }
  }
}
