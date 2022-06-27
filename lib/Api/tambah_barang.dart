import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

import 'package:inventaris_barang/Api/url.dart';

class TambahBarang {
  late bool? success;
  late String? message;

  TambahBarang({this.success, this.message});

  TambahBarang.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    return data;
  }

  static Future<TambahBarang> barangMasuk(String id, String tanggal,
      String jumlah, String jam, String id_pic) async {
    Uri apiUrl = Uri.parse(Url.web + "barang/masuk/edit/" + id);

    var result = await http.post(apiUrl, body: {
      'tanggal_masuk': tanggal,
      'jumlah_barang': jumlah,
      'jam': jam,
      'id_pic': id_pic
    });
    var jsonResult = json.decode(result.body);
    return TambahBarang.fromJson(jsonResult);
  }

  static Future<TambahBarang> barangMasukBaru(
      String nama,
      String spesifikasi,
      String idBarang,
      String tanggal,
      String jumlah,
      String status_barang,
      String id_pic,
      String jam) async {
    Uri apiUrl = Uri.parse(Url.web + "barang/masuk/tambah");

    var result = await http.post(apiUrl, body: {
      'nama_barang': nama,
      'spesifikasi': spesifikasi,
      'id_barang': idBarang,
      'tanggal_masuk': tanggal,
      'jumlah_barang': jumlah,
      'id_status_barang': status_barang,
      'id_pic': id_pic,
      'jam': jam
    });
    var jsonResult = json.decode(result.body);
    return TambahBarang.fromJson(jsonResult);
  }

  static Future<TambahBarang> barangKeluar(String id, String tanggal) async {
    Uri apiUrl = Uri.parse(Url.web + "barang/keluar/edit/" + id);

    var result = await http.post(apiUrl, body: {
      'tanggal_keluar': tanggal,
    });
    var jsonResult = json.decode(result.body);
    return TambahBarang.fromJson(jsonResult);
  }
}
