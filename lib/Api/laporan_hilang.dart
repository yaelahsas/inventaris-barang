import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inventaris_barang/Api/url.dart';

import 'list_barang.dart';

class ListLaporanHilang {
  bool? success;
  String? message;
  List<BarangHilang>? data;

  ListLaporanHilang({this.success, this.message, this.data});

  ListLaporanHilang.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <BarangHilang>[];
      json['data'].forEach((v) {
        data!.add(new BarangHilang.fromJson(v));
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

  static Future<ListLaporanHilang> postBarangHilang(
      String id, String tanggal, String jam, Data barangHilang) async {
    Uri apiUrl = Uri.parse(Url.web + "laporan/hilang/create");

    var result = await http.post(apiUrl, body: {
      'id_pic': id,
      // 'id_barang_pengganti': barangHilang.id.toString(),
      'tanggal_hilang': tanggal,
      'jam_hilang': jam,
      'id_divisi': barangHilang.idDivisi.toString(),
      'id_status_barang': "3",
      'id_barang': barangHilang.id.toString(),
    });
    var jsonResult = json.decode(result.body);
    return ListLaporanHilang.fromJson(jsonResult);
  }

  static Future<ListLaporanHilang> postBarangRusak(
      String id, String tanggal, String jam, Data barangHilang) async {
    Uri apiUrl = Uri.parse(Url.web + "laporan/rusak/create");

    var result = await http.post(apiUrl, body: {
      'id_pic': id,
      // 'id_barang_pengganti': barangHilang.id.toString(),
      'tanggal_rusak': tanggal,
      'jam_rusak': jam,
      'id_divisi': barangHilang.idDivisi.toString(),
      'id_status_barang': "1",
      'id_barang': barangHilang.id.toString(),
    });
    var jsonResult = json.decode(result.body);
    return ListLaporanHilang.fromJson(jsonResult);
  }

  static Future<List<BarangHilang>> barang_hilang() async {
    Uri apiUrl = Uri.parse(Url.web + "laporan/hilang");

    var hasil = await http.get(apiUrl);
    var result = jsonDecode(hasil.body);

    List<dynamic> listHasil = (result as Map<String, dynamic>)['data'];
    List<BarangHilang> datas = [];
    for (var i = 0; i < listHasil.length; i++) {
      datas.add(BarangHilang.fromJson(listHasil[i]));
    }
    return datas;
  }

  static Future<List<BarangHilang>> barang_rusak() async {
    Uri apiUrl = Uri.parse(Url.web + "laporan/rusak");

    var hasil = await http.get(apiUrl);
    var result = jsonDecode(hasil.body);

    List<dynamic> listHasil = (result as Map<String, dynamic>)['data'];
    List<BarangHilang> datas = [];
    for (var i = 0; i < listHasil.length; i++) {
      datas.add(BarangHilang.fromJson(listHasil[i]));
    }
    return datas;
  }

  static Future<List<BarangHilang>> barang_laporan() async {
    Uri apiUrl = Uri.parse(Url.web + "laporan");

    var hasil = await http.get(apiUrl);
    var result = jsonDecode(hasil.body);

    List<dynamic> listHasil = (result as Map<String, dynamic>)['data'];
    List<BarangHilang> datas = [];
    for (var i = 0; i < listHasil.length; i++) {
      datas.add(BarangHilang.fromJson(listHasil[i]));
    }
    return datas;
  }
}

class BarangHilang {
  int? id;
  String? namaStatus;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? namaDivisi;
  int? idPic;
  String? namaBarang;
  String? spesifikasi;
  String? tanggal;
  String? jam;
  String? fotoBarang;
  int? idDivisi;
  String? kodeQrcode;
  int? idStatusBarang;
  // Null? idBarangGanti;
  String? terima;
  int? idBarang;
  int? idBarangMasuk;
  int? idRekap;
  String? keterangan;

  BarangHilang(
      {this.id,
      this.namaStatus,
      this.createdAt,
      this.updatedAt,
      this.name,
      this.namaDivisi,
      this.idPic,
      this.namaBarang,
      this.spesifikasi,
      this.tanggal,
      this.jam,
      this.fotoBarang,
      this.idDivisi,
      this.kodeQrcode,
      this.idStatusBarang,
      // this.idBarangGanti,
      this.terima,
      this.idBarang,
      this.idBarangMasuk,
      this.idRekap,
      this.keterangan});

  BarangHilang.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaStatus = json['nama_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    namaDivisi = json['nama_divisi'];
    idPic = json['id_pic'];
    namaBarang = json['nama_barang'];
    spesifikasi = json['spesifikasi'];
    tanggal = json['tanggal'];
    jam = json['jam'];
    fotoBarang = json['foto_barang'];
    idDivisi = json['id_divisi'];
    kodeQrcode = json['kode_qrcode'];
    idStatusBarang = json['id_status_barang'];
    // idBarangGanti = json['id_barang_ganti'];
    terima = json['terima'];
    idBarang = json['id_barang'];
    idBarangMasuk = json['id_barang_masuk'];
    idRekap = json['id_rekap'];
    keterangan = json['keterangan'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_status'] = this.namaStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    data['nama_divisi'] = this.namaDivisi;
    data['id_pic'] = this.idPic;
    data['nama_barang'] = this.namaBarang;
    data['spesifikasi'] = this.spesifikasi;
    data['tanggal'] = this.tanggal;
    data['jam'] = this.jam;
    data['foto_barang'] = this.fotoBarang;
    data['id_divisi'] = this.idDivisi;
    data['kode_qrcode'] = this.kodeQrcode;
    data['id_status_barang'] = this.idStatusBarang;
    // data['id_barang_ganti'] = this.idBarangGanti;
    data['terima'] = this.terima;
    data['id_barang'] = this.idBarang;
    data['id_barang_masuk'] = this.idBarangMasuk;
    data['id_rekap'] = this.idRekap;
    data['keterangan'] = this.keterangan ?? "";
    return data;
  }
}
