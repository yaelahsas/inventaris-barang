import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:inventaris_barang/Api/url.dart';

class TambahRekap {
  bool? success;
  String? message;

  TambahRekap({this.success, this.message});

  TambahRekap.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }

  static Future<TambahRekap> barangMasuk(
      String nama,
      String inventaris,
      String spesifikasi,
      String tanggal,
      String jumlah_awal,
      String jumlah_akhir,
      String id_divisi,
      String id_status_barang) async {
    Uri apiUrl = Uri.parse(Url.web + "rekap/tambah/masuk");

    var result = await http.post(apiUrl, body: {
      'nama': nama,
      'inventaris': inventaris,
      'spesifikasi': spesifikasi,
      'tanggal': tanggal,
      'jumlah_awal': jumlah_awal,
      'jumlah_akhir': jumlah_akhir,
      'id_divisi': id_divisi,
      'id_status_barang': id_status_barang
    }, headers: {
      'Connection': 'keep-alive',
    });
    var jsonResult = json.decode(result.body);
    return TambahRekap.fromJson(jsonResult);
  }
}
