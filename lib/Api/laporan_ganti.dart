import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:inventaris_barang/Api/url.dart';

class ListLaporanGanti {
  bool? success;
  String? message;
  List<BarangGanti>? data;
  List<BarangGantinya>? dataGanti;

  ListLaporanGanti({this.success, this.message, this.data});
  ListLaporanGanti.fromJsonGantinya(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      dataGanti = <BarangGantinya>[];
      json['data'].forEach((v) {
        dataGanti!.add(new BarangGantinya.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJsonGanti() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.dataGanti != null) {
      data['data'] = this.dataGanti!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  ListLaporanGanti.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <BarangGanti>[];
      json['data'].forEach((v) {
        data!.add(new BarangGanti.fromJson(v));
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

  static Future<List<BarangGanti>> barang_ganti() async {
    Uri apiUrl = Uri.parse(Url.web + "laporan/ganti");

    var hasil = await http.get(apiUrl);
    var result = jsonDecode(hasil.body);

    List<dynamic> listHasil = (result as Map<String, dynamic>)['data'];
    List<BarangGanti> datas = [];
    for (var i = 0; i < listHasil.length; i++) {
      datas.add(BarangGanti.fromJson(listHasil[i]));
    }
    return datas;
  }

  static Future<List<BarangGanti>> barang_inventaris() async {
    Uri apiUrl = Uri.parse(Url.web + "laporan/ganti/inventaris");

    var hasil = await http.get(apiUrl);
    var result = jsonDecode(hasil.body);

    List<dynamic> listHasil = (result as Map<String, dynamic>)['data'];
    List<BarangGanti> datas = [];
    for (var i = 0; i < listHasil.length; i++) {
      datas.add(BarangGanti.fromJson(listHasil[i]));
    }
    return datas;
  }

  static Future<List<BarangGantinya>> barang_gantinya() async {
    Uri apiUrl = Uri.parse(Url.web + "laporan/ganti/barang");

    var hasil = await http.get(apiUrl);
    var result = jsonDecode(hasil.body);

    List<dynamic> listHasil = (result as Map<String, dynamic>)['data'];
    List<BarangGantinya> datas = [];
    for (var i = 0; i < listHasil.length; i++) {
      datas.add(BarangGantinya.fromJson(listHasil[i]));
    }
    return datas;
  }

  static Future<ListLaporanGanti> postBarangGanti(String id, String tanggal,
      String jam, BarangGanti barangLama, BarangGantinya barangBaru) async {
    Uri apiUrl = Uri.parse(Url.web + "laporan/ganti/create");

    var result = await http.post(apiUrl, body: {
      'id_pic': id,
      'id_barang_pengganti': barangBaru.id.toString(),
      'tanggal_ganti': tanggal,
      'jam_ganti': jam,
      'id_divisi': barangLama.idDivisi.toString(),
      'id_status_barang': "2",
      'id_barang': barangLama.id.toString(),
      'status_barang_lama': barangLama.namaStatus,
      'kode_qrcode_baru': barangBaru.kodeQrcode
    });
    var jsonResult = json.decode(result.body);
    return ListLaporanGanti.fromJson(jsonResult);
  }
}

class BarangGanti {
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
  String? terima;
  int? idBarang;
  int? idBarangMasuk;

  BarangGanti(
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
      this.terima,
      this.idBarang,
      this.idBarangMasuk});

  BarangGanti.fromJson(Map<String, dynamic> json) {
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
    terima = json['terima'];
    idBarang = json['id_barang'];
    idBarangMasuk = json['id_barang_masuk'];
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
    data['terima'] = this.terima;
    data['id_barang'] = this.idBarang;
    data['id_barang_masuk'] = this.idBarangMasuk;
    return data;
  }
}

class BarangGantinya {
  int? id;
  String? namaStatus;
  String? createdAt;
  String? updatedAt;
  String? name;
  int? idPic;
  String? namaBarang;
  String? spesifikasi;
  String? tanggal;
  String? jam;
  String? fotoBarang;
  String? kodeQrcode;
  int? idStatusBarang;
  String? terima;

  BarangGantinya(
      {this.id,
      this.namaStatus,
      this.createdAt,
      this.updatedAt,
      this.name,
      this.idPic,
      this.namaBarang,
      this.spesifikasi,
      this.tanggal,
      this.jam,
      this.fotoBarang,
      this.kodeQrcode,
      this.idStatusBarang,
      this.terima});

  BarangGantinya.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaStatus = json['nama_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    idPic = json['id_pic'];
    namaBarang = json['nama_barang'];
    spesifikasi = json['spesifikasi'];
    tanggal = json['tanggal'];
    jam = json['jam'];
    fotoBarang = json['foto_barang'];
    kodeQrcode = json['kode_qrcode'];
    idStatusBarang = json['id_status_barang'];
    terima = json['terima'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_status'] = this.namaStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    data['id_pic'] = this.idPic;
    data['nama_barang'] = this.namaBarang;
    data['spesifikasi'] = this.spesifikasi;
    data['tanggal'] = this.tanggal;
    data['jam'] = this.jam;
    data['foto_barang'] = this.fotoBarang;
    data['kode_qrcode'] = this.kodeQrcode;
    data['id_status_barang'] = this.idStatusBarang;
    data['terima'] = this.terima;
    return data;
  }
}
