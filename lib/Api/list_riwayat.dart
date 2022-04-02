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
        data!.add(new Data.fromJson(v));
      });
    }
  }
  @override
  String toString() {
    return 'ListRiwayat{data: $data}';
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

  static Future<List<Data>> getRiwayat() async {
    Uri apiUrl = Uri.parse(Url.web + "rekap");

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
  String? namaStatus;
  String? createdAt;
  String? updatedAt;
  String? namaDivisi;
  String? nama;
  String? inventaris;
  String? spesifikasi;
  String? tanggal;
  String? jumlahAwal;
  String? jumlahAkhir;
  int? idDivisi;
  int? idStatusBarang;

  Data(
      {this.id,
      this.namaStatus,
      this.createdAt,
      this.updatedAt,
      this.namaDivisi,
      this.nama,
      this.inventaris,
      this.spesifikasi,
      this.tanggal,
      this.jumlahAwal,
      this.jumlahAkhir,
      this.idDivisi,
      this.idStatusBarang});

  @override
  String toString() {
    return 'Data{id: $id, namaStatus: $namaStatus, createdAt: $createdAt, updatedAt: $updatedAt, namaDivisi: $namaDivisi, nama: $nama, inventaris: $inventaris, spesifikasi: $spesifikasi, tanggal: $tanggal, jumlahAwal: $jumlahAwal, jumlahAkhir: $jumlahAkhir, idDivisi: $idDivisi, idStatusBarang: $idStatusBarang}';
  }

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaStatus = json['nama_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    namaDivisi = json['nama_divisi'];
    nama = json['nama'];
    inventaris = json['inventaris'];
    spesifikasi = json['spesifikasi'];
    tanggal = json['tanggal'];
    jumlahAwal = json['jumlah_awal'];
    jumlahAkhir = json['jumlah_akhir'];
    idDivisi = json['id_divisi'];
    idStatusBarang = json['id_status_barang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_status'] = this.namaStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['nama_divisi'] = this.namaDivisi;
    data['nama'] = this.nama;
    data['inventaris'] = this.inventaris;
    data['spesifikasi'] = this.spesifikasi;
    data['tanggal'] = this.tanggal;
    data['jumlah_awal'] = this.jumlahAwal;
    data['jumlah_akhir'] = this.jumlahAkhir;
    data['id_divisi'] = this.idDivisi;
    data['id_status_barang'] = this.idStatusBarang;
    return data;
  }
}
