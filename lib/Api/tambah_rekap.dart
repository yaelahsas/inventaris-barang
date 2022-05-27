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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    return data;
  }

  static Future<TambahRekap> barangMasuk(
      String nama,
      String inventaris,
      String spesifikasi,
      String tanggal,
      String jumlahAwal,
      String jumlahAkhir,
      String idDivisi,
      String idStatusBarang,
      String idRekap) async {
    Uri apiUrl = Uri.parse(Url.web + "rekap/tambah/masuk");

    var result = await http.post(apiUrl, body: {
      'nama': nama,
      'inventaris': inventaris,
      'spesifikasi': spesifikasi,
      'tanggal': tanggal,
      'jumlah_awal': jumlahAwal,
      'jumlah_akhir': jumlahAkhir,
      'id_divisi': idDivisi,
      'id_status_barang': idStatusBarang,
      'id_rekap': idRekap,
    }, headers: {
      'Connection': 'keep-alive',
    });
    var jsonResult = json.decode(result.body);
    return TambahRekap.fromJson(jsonResult);
  }
}
