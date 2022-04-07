import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:inventaris_barang/Api/url.dart';

class ListRiwayat {
  bool? success;
  String? message;
  List<Data>? data;

  ListRiwayat({this.success, this.message, this.data});

  ListRiwayat.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }
  @override
  String toString() {
    return 'ListRiwayat{data: $data}';
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

  static Future<List<Data>> getRiwayat() async {
    Uri apiUrl = Uri.parse(Url.web + "riwayat");

    var hasil = await http.get(apiUrl);
    var result = jsonDecode(hasil.body);

    List<dynamic> listHasil = (result as Map<String, dynamic>)['data'];
    List<Data> datas = [];
    for (var i = 0; i < listHasil.length; i++) {
      datas.add(Data.fromJson(listHasil[i]));
    }
    return datas;
  }
}

class Data {
  int? id;
  String? namaBarang;
  String? spesifikasi;
  String? jumlahBarang;
  String? tanggal;
  int? idDivisi;
  int? idStatusBarang;
  String? createdAt;
  String? updatedAt;
  String? namaStatus;
  String? namaDivisi;

  Data(
      {this.id,
      this.namaBarang,
      this.spesifikasi,
      this.jumlahBarang,
      this.tanggal,
      this.idDivisi,
      this.idStatusBarang,
      this.createdAt,
      this.updatedAt,
      this.namaStatus,
      this.namaDivisi});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaBarang = json['nama_barang'];
    spesifikasi = json['spesifikasi'];
    jumlahBarang = json['jumlah_barang'];
    tanggal = json['tanggal'];
    idDivisi = json['id_divisi'];
    idStatusBarang = json['id_status_barang'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    namaStatus = json['nama_status'];
    namaDivisi = json['nama_divisi'];
  }

  @override
  String toString() {
    return 'Data{id: $id, namaBarang: $namaBarang, spesifikasi: $spesifikasi, jumlahBarang: $jumlahBarang, tanggal: $tanggal, idDivisi: $idDivisi, idStatusBarang: $idStatusBarang, createdAt: $createdAt, updatedAt: $updatedAt, namaStatus: $namaStatus, namaDivisi: $namaDivisi}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nama_barang'] = namaBarang;
    data['spesifikasi'] = spesifikasi;
    data['jumlah_barang'] = jumlahBarang;
    data['tanggal'] = tanggal;
    data['id_divisi'] = idDivisi;
    data['id_status_barang'] = idStatusBarang;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['nama_status'] = namaStatus;
    data['nama_divisi'] = namaDivisi;
    return data;
  }
}
