import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:inventaris_barang/Api/url.dart';

class Role {
  bool? success;
  String? message;
  List<Roles>? data;

  Role({this.success, this.message, this.data});

  Role.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Roles>[];
      json['data'].forEach((v) {
        data!.add(new Roles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static Future<List<Roles>> getRole() async {
    Uri apiUrl = Uri.parse(Url.web + "role");

    var hasil = await http.get(apiUrl);
    var result = jsonDecode(hasil.body);

    List<dynamic> listHasil = (result as Map<String, dynamic>)['data'];
    List<Roles> datas = [];
    for (var i = 0; i < listHasil.length; i++) {
      datas.add(Roles.fromJson(listHasil[i]));
    }
    return datas;
  }
}

class Roles {
  int? id;
  String? namaRole;
  String? createdAt;
  String? updatedAt;

  Roles({this.id, this.namaRole, this.createdAt, this.updatedAt});

  Roles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaRole = json['nama_role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_role'] = this.namaRole;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
