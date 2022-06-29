import 'package:flutter/material.dart';
import 'package:inventaris_barang/Api/laporan_ganti.dart';
import 'package:inventaris_barang/Screen/Laporan/Barang%20Ganti/tambah_laporan_ganti.dart';

import '../../../Api/list_barang.dart';
import '../../../constants.dart';
import '../../Barang/tambah_barang_masuk.dart';
import 'laporan_ganti_pdf.dart';

class LaporanGanti extends StatefulWidget {
  const LaporanGanti({Key? key}) : super(key: key);

  @override
  State<LaporanGanti> createState() => _LaporanGantiState();
}

class _LaporanGantiState extends State<LaporanGanti> {
  int _currentSortColumn = 0;
  bool _isAscending = true;
  late List<BarangGanti> _listData = [];
  late List<BarangGanti> _listDataFiltered = [];
  final TextEditingController _searchController = TextEditingController();
  String _searchResult = '';

  @override
  void initState() {
    super.initState();
    //pertamakali dibuka android mengambil data dari web
    //menggunakan fungsi connectToAPI
    //dan jika sudah selesai dimasukkan kedalam variable _listData
    ListLaporanGanti.barang_ganti().then((value) {
      _listData = value;
      _listDataFiltered = _listData;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Laporan Ganti"),
        actions: [
          IconButton(
            icon: const Icon(Icons.print_rounded),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LaporanGantiPdf();
              }));
            },
          ),
        ],
      ),
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
                child: DataTable(
                    showCheckboxColumn: false,
                    columnSpacing: 38,
                    dataRowHeight: size.height * 0.1,
                    sortColumnIndex: _currentSortColumn,
                    sortAscending: _isAscending,
                    headingTextStyle: MaterialStateTextStyle.resolveWith(
                        (states) => const TextStyle(color: kPrimaryLightColor)),
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
                                  return a.namaBarang!.compareTo(b.namaBarang!);
                                } else {
                                  return b.namaBarang!.compareTo(a.namaBarang!);
                                }
                              });
                            });
                          }),
                    ],
                    rows: [
                      for (var i = 0; i < _listDataFiltered.length; i++)
                        DataRow(
                          cells: [
                            DataCell(Text(_listDataFiltered[i].id.toString())),
                            DataCell(SizedBox(
                                width: size.width,
                                child: Text(_listDataFiltered[i].namaBarang!))),
                          ],
                          onSelectChanged: (value) {
                            // Kirim Data Ke Screen Lain
                          },
                        ),
                    ]),
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
                builder: (context) => TambahLaporanGanti(),
              ));
        },
        child: Icon(Icons.add),
        backgroundColor: kPrimaryColor,
      ),
    );
  }
}
