import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginApi {
  bool? success;
  String? message;
  Data? data;

  LoginApi({this.success, this.message, this.data});

  LoginApi.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'LoginApi{success: $success, message: $message, data: $data}';
  }

  static Future<LoginApi> connectToAPI(String email, String password) async {
    Uri apiUrl = Uri.parse("http://10.46.1.25:80/ap/api/login");

    var result = await http.post(apiUrl, body: {
      'username': email,
      'password': password,
    });
    var jsonResult = json.decode(result.body);
    return LoginApi.fromJson(jsonResult);
  }
}

class Data {
  int? id;
  String? name;
  String? username;
  String? createdAt;
  String? updatedAt;

  Data({this.id, this.name, this.username, this.createdAt, this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  @override
  String toString() {
    return 'Data{id: $id, name: $name, username: $username, createdAt: $createdAt, updatedAt: $updatedAt}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
