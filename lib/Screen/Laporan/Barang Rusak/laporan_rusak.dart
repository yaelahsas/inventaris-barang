import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inventaris_barang/Api/laporan_ganti.dart';
import 'package:inventaris_barang/Screen/Laporan/Barang%20Ganti/tambah_laporan_ganti.dart';
import 'package:inventaris_barang/Screen/Laporan/Barang%20Hilang/tambah_laporan_hilang.dart';
import 'package:inventaris_barang/Screen/Laporan/Barang%20Rusak/tambah_laporan_rusak.dart';

import '../../../Api/laporan_hilang.dart';
import '../../../Api/list_barang.dart';
import '../../../constants.dart';
import '../../Barang/tambah_barang_masuk.dart';

class LaporanRusak extends StatefulWidget {
  const LaporanRusak({Key? key}) : super(key: key);

  @override
  State<LaporanRusak> createState() => _LaporanGantiState();
}

class _LaporanGantiState extends State<LaporanRusak> {
  int _currentSortColumn = 0;
  bool _isAscending = true;
  late List<BarangHilang> _listData = [];
  late List<BarangHilang> _listDataFiltered = [];
  final TextEditingController _searchController = TextEditingController();
  String _searchResult = '';

  @override
  void initState() {
    super.initState();
    //pertamakali dibuka android mengambil data dari web
    //menggunakan fungsi connectToAPI
    //dan jika sudah selesai dimasukkan kedalam variable _listData
    ListLaporanHilang.barang_rusak().then((value) {
      _listData = value;
      _listDataFiltered = _listData;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text("Laporan Rusak")),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        margin: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.search),
                title: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                        hintText: 'Search', border: InputBorder.none),
                    onChanged: (value) {
                      setState(() {
                        _searchResult = value;
                        _listDataFiltered = _listData
                            .where((user) =>
                                user.namaBarang!.contains(_searchResult))
                            .toList();
                      });
                    }),
                trailing: IconButton(
                  icon: const Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      _searchController.clear();
                      _searchResult = '';
                      _listDataFiltered = _listData;
                    });
                  },
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  width: size.width,
                  child: DataTable(
                      showCheckboxColumn: false,
                      columnSpacing: 38,
                      // dataRowHeight: size.height * 0.1,
                      sortColumnIndex: _currentSortColumn,
                      sortAscending: _isAscending,
                      headingTextStyle: MaterialStateTextStyle.resolveWith(
                          (states) =>
                              const TextStyle(color: kPrimaryLightColor)),
                      headingRowColor: MaterialStateProperty.resolveWith(
                          (states) => kPrimaryColor),
                      columns: [
                        DataColumn(
                            label: const Text('Id'),
                            numeric: true,
                            onSort: (index, _) {
                              setState(() {
                                _currentSortColumn = index;

                                if (_isAscending == true) {
                                  _isAscending = false;
                                } else {
                                  _isAscending = true;
                                }
                                _listData.sort((a, b) {
                                  if (_isAscending) {
                                    return a.id!.compareTo(b.id!);
                                  } else {
                                    return b.id!.compareTo(a.id!);
                                  }
                                });
                              });
                            }),
                        DataColumn(
                            label: const Text('Barang'),
                            onSort: (index, _) {
                              setState(() {
                                _currentSortColumn = index;

                                if (_isAscending == true) {
                                  _isAscending = false;
                                } else {
                                  _isAscending = true;
                                }
                                _listData.sort((a, b) {
                                  if (_isAscending) {
                                    return a.namaBarang!
                                        .compareTo(b.namaBarang!);
                                  } else {
                                    return b.namaBarang!
                                        .compareTo(a.namaBarang!);
                                  }
                                });
                              });
                            }),
                        DataColumn(label: Text("Ganti")),
                        DataColumn(label: Text("Perbaiki"))
                      ],
                      rows: [
                        for (var i = 0; i < _listDataFiltered.length; i++)
                          DataRow(
                            cells: [
                              DataCell(
                                  Text(_listDataFiltered[i].id.toString())),
                              DataCell(InkWell(
                                onTap: () {
                                  Fluttertoast.showToast(
                                      msg: _listDataFiltered[i].namaBarang!,
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: kPrimaryColor,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                },
                                child: SizedBox(
                                    child:
                                        Text(_listDataFiltered[i].namaBarang!)),
                              )),
                              DataCell(InkWell(
                                child: Icon(
                                  Icons.change_circle_outlined,
                                  color: Colors.blue,
                                ),
                              )),
                              DataCell(InkWell(
                                child: Icon(
                                  Icons.home_repair_service_outlined,
                                  color: Colors.green,
                                ),
                              ))
                            ],
                            onSelectChanged: (value) {
                              // Kirim Data Ke Screen Lain
                            },
                          ),
                      ]),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TambahLaporanRusak(),
              ));
        },
        child: Icon(Icons.add),
        backgroundColor: kPrimaryColor,
      ),
    );
  }
}
