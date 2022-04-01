import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:inventaris_barang/Api/url.dart';

class ListBarang {
  List<Data>? data;
  Data? dataScan;

  bool? success;
  String? message;
  ListBarang({this.data, this.success, this.message});

  ListBarang.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }
  ListBarang.scanFromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    dataScan = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
  @override
  String toString() {
    return 'ListBarang{data: $data}';
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

  Map<String, dynamic> scanToJson() {
    final Map<String, dynamic> scan = new Map<String, dynamic>();
    scan['success'] = this.success;
    scan['message'] = this.message;
    if (this.dataScan != null) {
      scan['data'] = this.dataScan!.toJson();
    }
    return scan;
  }

  static Future<List<Data>> connectToAPI() async {
    Uri apiUrl = Uri.parse(Url.web + "barang/masuk");

    var hasil = await http.get(apiUrl);
    var result = jsonDecode(hasil.body);

    List<dynamic> listHasil = (result as Map<String, dynamic>)['data'];
    List<Data> datas = [];
    for (var i = 0; i < listHasil.length; i++) {
      datas.add(Data.fromJson(listHasil[i]));
    }
    return datas;
  }

  static Future<ListBarang> scanData(String id) async {
    Uri apiUrl = Uri.parse(Url.web + "barang/masuk/" + id);

    var hasil = await http.get(apiUrl);
    var result = jsonDecode(hasil.body);
    return ListBarang.scanFromJson(result);
  }
}

class Data {
  int? id;
  String? namaStatus;
  String? createdAt;
  String? updatedAt;
  String? namaDivisi;
  String? namaBarang;
  String? spesifikasi;
  String? jumlahBarang;
  String? tanggalMasuk;
  int? idDivisi;
  String? kodeQrcode;
  int? idStatusBarang;

  Data(
      {this.id,
      this.namaStatus,
      this.createdAt,
      this.updatedAt,
      this.namaDivisi,
      this.namaBarang,
      this.spesifikasi,
      this.jumlahBarang,
      this.tanggalMasuk,
      this.idDivisi,
      this.kodeQrcode,
      this.idStatusBarang});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaStatus = json['nama_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    namaDivisi = json['nama_divisi'];
    namaBarang = json['nama_barang'];
    spesifikasi = json['spesifikasi'];
    jumlahBarang = json['jumlah_barang'];
    tanggalMasuk = json['tanggal_masuk'];
    idDivisi = json['id_divisi'];
    kodeQrcode = json['kode_qrcode'];
    idStatusBarang = json['id_status_barang'];
  }

  @override
  String toString() {
    return 'Data{id: $id, namaStatus: $namaStatus, createdAt: $createdAt, updatedAt: $updatedAt, namaDivisi: $namaDivisi, namaBarang: $namaBarang, spesifikasi: $spesifikasi, jumlahBarang: $jumlahBarang, tanggalMasuk: $tanggalMasuk, idDivisi: $idDivisi, kodeQrcode: $kodeQrcode, idStatusBarang: $idStatusBarang}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_status'] = this.namaStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['nama_divisi'] = this.namaDivisi;
    data['nama_barang'] = this.namaBarang;
    data['spesifikasi'] = this.spesifikasi;
    data['jumlah_barang'] = this.jumlahBarang;
    data['tanggal_masuk'] = this.tanggalMasuk;
    data['id_divisi'] = this.idDivisi;
    data['kode_qrcode'] = this.kodeQrcode;
    data['id_status_barang'] = this.idStatusBarang;
    return data;
  }
}
