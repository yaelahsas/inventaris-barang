import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inventaris_barang/Api/url.dart';

class ScanData {
  bool? success;
  String? message;
  Data? data;

  ScanData({this.success, this.message, this.data});

  ScanData.fromJson(Map<String, dynamic> json) {
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

  static Future<ScanData> scan(String id) async {
    Uri apiUrl = Uri.parse(Url.web + "barang/masuk/" + id);

    var hasil = await http.get(apiUrl);
    var result = jsonDecode(hasil.body);
    return ScanData.fromJson(result);
  }
}

class Data {
  int? id;
  String? namaStatus;
  String? createdAt;
  String? updatedAt;
  String? namaDivisi;
  String? namaBarang;
  String? namaBarangTambahan;
  String? spesifikasi;
  String? tanggal;
  int? idDivisi;
  String? kodeQrcode;
  String? kodeQrcodeTambahan;
  int? idStatusBarang;

  Data(
      {this.id,
      this.namaStatus,
      this.createdAt,
      this.updatedAt,
      this.namaDivisi,
      this.namaBarang,
      this.namaBarangTambahan,
      this.spesifikasi,
      this.tanggal,
      this.idDivisi,
      this.kodeQrcode,
      this.kodeQrcodeTambahan,
      this.idStatusBarang});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaStatus = json['nama_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    namaDivisi = json['nama_divisi'];
    namaBarang = json['nama_barang'];
    namaBarangTambahan = json['nama_barang_tambahan'];
    spesifikasi = json['spesifikasi'];
    tanggal = json['tanggal'];
    idDivisi = json['id_divisi'];
    kodeQrcode = json['kode_qrcode'];
    kodeQrcodeTambahan = json['kode_qrcode_tambahan'];
    idStatusBarang = json['id_status_barang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_status'] = this.namaStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['nama_divisi'] = this.namaDivisi;
    data['nama_barang'] = this.namaBarang;
    data['nama_barang_tambahan'] = this.namaBarangTambahan;
    data['spesifikasi'] = this.spesifikasi;
    data['tanggal'] = this.tanggal;
    data['id_divisi'] = this.idDivisi;
    data['kode_qrcode'] = this.kodeQrcode;
    data['kode_qrcode_tambahan'] = this.kodeQrcodeTambahan;
    data['id_status_barang'] = this.idStatusBarang;
    return data;
  }
}
