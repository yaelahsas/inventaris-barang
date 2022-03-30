import 'dart:convert';

import 'package:http/http.dart' as http;

class LoginResult {
  String token;

  LoginResult({required this.token});

  factory LoginResult.fromJson(Map<String, dynamic> json) {
    return LoginResult(
      token: json['token'],
    );
  }

  static Future<LoginResult> connectToAPI(String email, String password) async {
    Uri apiUrl = Uri.parse("https://reqres.in/api/login");

    var result = await http.post(apiUrl, body: {
      'email': email,
      'password': password,
    });
    var jsonResult = json.decode(result.body);
    return LoginResult.fromJson(jsonResult);
  }
}
