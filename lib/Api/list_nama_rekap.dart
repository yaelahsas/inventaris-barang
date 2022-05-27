import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inventaris_barang/Api/url.dart';

class ListNamaRekap {
  bool? success;
  String? message;
  List<Nama>? data;

  ListNamaRekap({this.success, this.message, this.data});

  ListNamaRekap.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Nama>[];
      json['data'].forEach((v) {
        data!.add(new Nama.fromJson(v));
      });
    }
  }
  ListNamaRekap.message(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
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

  static Future<List<Nama>> getList() async {
    Uri apiUrl = Uri.parse(Url.web + "rekap/list");

    var hasil = await http.get(apiUrl);
    var result = jsonDecode(hasil.body);

    List<dynamic> listHasil = (result as Map<String, dynamic>)['data'];
    List<Nama> datas = [];
    for (var i = 0; i < listHasil.length; i++) {
      datas.add(Nama.fromJson(listHasil[i]));
    }
    return datas;
  }

  static Future<ListNamaRekap> tambahNamaRekap(
      String nama, String tanggal) async {
    Uri apiUrl = Uri.parse(Url.web + "rekap/nama");

    var result = await http.post(apiUrl, body: {
      'nama': nama,
      'tanggal': tanggal,
    });
    var jsonResult = json.decode(result.body);
    return ListNamaRekap.message(jsonResult);
  }
}

class Nama {
  int? id;
  String? namaRekap;
  String? tanggal;

  Nama({this.id, this.namaRekap, this.tanggal});

  Nama.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaRekap = json['nama_rekap'];
    tanggal = json['tanggal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_rekap'] = this.namaRekap;
    data['tanggal'] = this.tanggal;
    return data;
  }
}
