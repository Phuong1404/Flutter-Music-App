import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:logging/logging.dart';

class AuthApi {
  final String Base_Url = 'http://localhost:8888';

  Future<Map> GetProfile(String Id) async {
    final Uri path = Uri.parse('$Base_Url/spotify/getprofile/$Id');
    final response = await post(path, headers: {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*'
    });
    if (response.statusCode == 200) {
      
    }
  }
}
