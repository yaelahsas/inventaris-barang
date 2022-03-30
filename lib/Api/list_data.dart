import 'dart:convert';

import 'package:http/http.dart' as http;

class ListData {
  late int id;
  late String name;
  late int year;
  late String color;
  late String pantone_value;

  ListData(
      {required this.id,
      required this.name,
      required this.year,
      required this.color,
      required this.pantone_value});

  factory ListData.resultData(Map<String, dynamic> json) {
    return ListData(
        id: json['id'],
        name: json['name'],
        year: json['year'],
        color: json['color'],
        pantone_value: json['pantone_value']);
  }
  @override
  String toString() {
    return 'ListData{id: $id, name: $name, year: $year, color: $color, pantone_value: $pantone_value}';
  }

  static Future<List<ListData>> connectToAPI() async {
    Uri apiUrl = Uri.parse("https://reqres.in/api/unknown");

    var hasil = await http.get(apiUrl);
    var result = jsonDecode(hasil.body);

    List<dynamic> listHasil = (result as Map<String, dynamic>)['data'];
    List<ListData> datas = [];
    for (var i = 0; i < listHasil.length; i++) {
      datas.add(ListData.resultData(listHasil[i]));
    }
    return datas;
  }
}
