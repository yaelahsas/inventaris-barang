import 'package:http/http.dart' as http;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }

  static Future<TambahBarang> barangMasuk(
      String id, String tanggal, String jumlah) async {
    Uri apiUrl = Uri.parse(Url.web + "barang/masuk/edit/" + id);

    var result = await http.post(apiUrl, body: {
      'tanggal_masuk': tanggal,
      'jumlah_barang': jumlah,
    });
    var jsonResult = json.decode(result.body);
    return TambahBarang.fromJson(jsonResult);
  }

  static Future<TambahBarang> barangKeluar(
      String id, String tanggal, String jumlah) async {
    Uri apiUrl = Uri.parse(Url.web + "barang/masuk/edit/" + id);

    var result = await http.post(apiUrl, body: {
      'tanggal_masuk': tanggal,
      'jumlah_barang': jumlah,
    });
    var jsonResult = json.decode(result.body);
    return TambahBarang.fromJson(jsonResult);
  }
}
