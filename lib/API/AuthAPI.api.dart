import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:logging/logging.dart';

import 'StaticApi.config.dart';

class AuthApi {
  final String Base_Url = ConfigApi().Base_Url;

  Future<Map> Login(String Username, String Password) async {
    try {
      final Uri path = Uri.parse('$Base_Url/spotify/login');
      final response = await post(path,
          headers: {
            "Access-Control-Allow-Origin": "*",
            'Content-Type': 'application/json',
            'Accept': '*/*'
          },
          body: jsonEncode({
            'username': Username,
            'password': Password,
            'db': 'DB_Spotify'
          }));
          print('00000000000');
      if (response.statusCode == 200) {
        final result = await jsonDecode(response.body);
        if (result['result']['Error'] == null) {
          return {"status_code": 200, "data": result['result']};
        } else {
          return {"status_code": 400, "error": result['result']['Error']};
        }
      } else {
        return {"status_code": 400, "error": "Login failed, please try again"};
      }
    } catch (e) {
      return {"status_code": 400, "error": "Login failed, please try again"};
    }
  }

  Future<Map> Signup(
      String Name, String Email, String Username, String Password) async {
    try {
      final Uri path = Uri.parse('$Base_Url/spotify/signup');
      final response = await post(path,
          headers: {
            "Access-Control-Allow-Origin": "*",
            'Content-Type': 'application/json',
            'Accept': '*/*'
          },
          body: jsonEncode({
            "name": Name,
            "username": Username,
            "password": Password,
            "email": Email
          }));
      if (response.statusCode == 200) {
        final result = await jsonDecode(response.body);
        if (result['result']['Error'] == null) {
          return {"status_code": 200, "data": result['result']};
        } else {
          return {"status_code": 400, "error": result['result']['Error']};
        }
      } else {
        return {"status_code": 400, "error": "Signup failed, please try again"};
      }
    } catch (e) {
      return {"status_code": 400, "error": "Signup failed, please try again"};
    }
  }

  Future<Map> Emailexist(String Email) async {
    try {
      final Uri path = Uri.parse('$Base_Url/spotify/checkemail');
      final response = await post(path,
          headers: {
            "Access-Control-Allow-Origin": "*",
            'Content-Type': 'application/json',
            'Accept': '*/*'
          },
          body: jsonEncode({"email": Email}));
      if (response.statusCode == 200) {
        final result = await jsonDecode(response.body);
        if (result['result']['Error'] == null) {
          return {"status_code": 200, "data": result['result']};
        } else {
          return {"status_code": 400, "error": result['result']['Error']};
        }
      } else {
        return {
          "status_code": 400,
          "error": "Có lỗi xảy ra trong quá trình hãy thực hiện lại"
        };
      }
    } catch (e) {
      return {
        "status_code": 400,
        "error": "Có lỗi xảy ra trong quá trình hãy thực hiện lại"
      };
    }
  }
}
