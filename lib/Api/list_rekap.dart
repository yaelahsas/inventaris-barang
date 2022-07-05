import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:inventaris_barang/Api/url.dart';

class ListRekap {
  bool? success;
  String? message;
  List<Rekap>? data;

  ListRekap({this.success, this.message, this.data});

  ListRekap.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Rekap>[];
      json['data'].forEach((v) {
        data!.add(Rekap.fromJson(v));
      });
    }
  }

  static Future<List<Rekap>> getRekap(String id, String idRekap) async {
    Uri apiUrl = Uri.parse(Url.web + 'rekap/' + id + '/' + idRekap);

    var hasil = await http.get(apiUrl);
    var result = jsonDecode(hasil.body);

    List<dynamic> listHasil = (result as Map<String, dynamic>)['data'];
    List<Rekap> datas = [];
    for (var i = 0; i < listHasil.length; i++) {
      datas.add(Rekap.fromJson(listHasil[i]));
    }
    return datas;
  }

  @override
  String toString() {
    return 'ListRekap{data: $data}';
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
}

class Rekap {
  int? id;
  String? namaStatus;
  String? createdAt;
  String? updatedAt;
  String? namaDivisi;
  String? nama;
  // String? inventaris;
  String? spesifikasi;
  String? tanggal;
  // String? jumlahAwal;
  // String? jumlahAkhir;
  int? idDivisi;
  String? nama_barang;
  int? idStatusBarang;

  Rekap(
      {this.id,
      this.namaStatus,
      this.createdAt,
      this.updatedAt,
      this.namaDivisi,
      this.nama,
      // this.inventaris,
      this.spesifikasi,
      this.tanggal,
      // this.jumlahAwal,
      // this.jumlahAkhir,
      this.nama_barang,
      this.idDivisi,
      this.idStatusBarang});

  Rekap.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaStatus = json['nama_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    namaDivisi = json['nama_divisi'];
    nama = json['nama'];
    nama_barang = json['nama_barang'];
    // inventaris = json['inventaris'];
    spesifikasi = json['spesifikasi'];
    tanggal = json['tanggal'];
    // jumlahAwal = json['jumlah_awal'];
    // jumlahAkhir = json['jumlah_akhir'];
    idDivisi = json['id_divisi'];
    idStatusBarang = json['id_status_barang'];
  }

  @override
  String toString() {
    return 'Rekap{id: $id, namaStatus: $namaStatus, createdAt: $createdAt, updatedAt: $updatedAt, namaDivisi: $namaDivisi, nama: $nama, spesifikasi: $spesifikasi, tanggal: $tanggal,  idDivisi: $idDivisi, idStatusBarang: $idStatusBarang}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nama_status'] = namaStatus;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['nama_divisi'] = namaDivisi;
    data['nama'] = nama;
    data['nama_barang'] = nama_barang;
    // data['inventaris'] = inventaris;
    data['spesifikasi'] = spesifikasi;
    data['tanggal'] = tanggal;
    // data['jumlah_awal'] = jumlahAwal;
    // data['jumlah_akhir'] = jumlahAkhir;
    data['id_divisi'] = idDivisi;
    data['id_status_barang'] = idStatusBarang;
    return data;
  }
}
