import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:inventaris_barang/Api/url.dart';

class ListDivisi {
  bool? success;
  String? message;
  List<Divisi>? data;

  ListDivisi({this.success, this.message, this.data});

  ListDivisi.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Divisi>[];
      json['data'].forEach((v) {
        data!.add(Divisi.fromJson(v));
      });
    }
  }

  @override
  String toString() {
    return 'ListDivisi{data: $data}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static Future<List<Divisi>> getDivisi() async {
    Uri apiUrl = Uri.parse(Url.web + "divisi");

    var hasil = await http.get(apiUrl);
    var result = jsonDecode(hasil.body);

    List<dynamic> listHasil = (result as Map<String, dynamic>)['data'];
    List<Divisi> datas = [];
    for (var i = 0; i < listHasil.length; i++) {
      datas.add(Divisi.fromJson(listHasil[i]));
    }
    return datas;
  }
}

class Divisi {
  int? id;
  String? namaDivisi;
  String? namaBarang;
  String? jumlahBarang;
  String? createdAt;
  String? updatedAt;

  Divisi(
      {this.id,
      this.namaDivisi,
      this.namaBarang,
      this.jumlahBarang,
      this.createdAt,
      this.updatedAt});

  Divisi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaDivisi = json['nama_divisi'];
    namaBarang = json['nama_barang'];
    jumlahBarang = json['jumlah_barang'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nama_divisi'] = namaDivisi;
    data['nama_barang'] = namaBarang;
    data['jumlah_barang'] = jumlahBarang;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  @override
  String toString() {
    return 'Divisi{id: $id, namaDivisi: $namaDivisi, namaBarang: $namaBarang, jumlahBarang: $jumlahBarang, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
