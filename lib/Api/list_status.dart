import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:inventaris_barang/Api/url.dart';

class ListStatus {
  bool? success;
  String? message;
  List<Status>? data;

  ListStatus({this.success, this.message, this.data});

  ListStatus.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Status>[];
      json['data'].forEach((v) {
        data!.add(new Status.fromJson(v));
      });
    }
  }

  @override
  String toString() {
    return 'ListStatus{data: $data}';
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

  static Future<List<Status>> getStatus() async {
    Uri apiUrl = Uri.parse(Url.web + "status");

    var hasil = await http.get(apiUrl);
    var result = jsonDecode(hasil.body);

    List<dynamic> listHasil = (result as Map<String, dynamic>)['data'];
    List<Status> datas = [];
    for (var i = 0; i < listHasil.length; i++) {
      datas.add(Status.fromJson(listHasil[i]));
    }
    return datas;
  }
}

class Status {
  int? id;
  String? namaStatus;

  Status({this.id, this.namaStatus});

  Status.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaStatus = json['nama_status'];
  }

  @override
  String toString() {
    return 'Status{id: $id, namaStatus: $namaStatus}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_status'] = this.namaStatus;
    return data;
  }
}
