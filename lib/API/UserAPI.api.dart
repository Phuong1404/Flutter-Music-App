import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:logging/logging.dart';
import 'package:music_app/API/StaticApi.config.dart';

class UserApi {
  final String Base_Url = ConfigApi().Base_Url;

  Future<Map> GetProfile(String Id) async {
    final Uri path = Uri.parse('$Base_Url/spotify/getprofile/$Id');
    final response = await get(path);
    if (response.statusCode == 200) {
      final result = await jsonDecode(response.body);

      return {
        "name": result['name'],
        "avatar": result['avatar'],
        "follow_count": result['follow_count'],
        "following_count": result['following_count'],
      };
    }
    return {"error": "Record Not Found"};
  }
}
