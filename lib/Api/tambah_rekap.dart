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
      String id_pic,
      String jam,
      String tanggal,
      // String idDivisi,
      String idStatusBarang,
      String idRekap,
      String id_barang_masuk) async {
    Uri apiUrl = Uri.parse(Url.web + "rekap/tambah/masuk");

    var result = await http.post(apiUrl, body: {
      'id_pic': id_pic,
      'jam': jam,
      'tanggal': tanggal,
      // 'id_divisi': idDivisi,
      'id_status_barang': idStatusBarang,
      'id_rekap': idRekap,
      'id_barang_masuk': id_barang_masuk,
    });
    var jsonResult = json.decode(result.body);
    return TambahRekap.fromJson(jsonResult);
  }
}
