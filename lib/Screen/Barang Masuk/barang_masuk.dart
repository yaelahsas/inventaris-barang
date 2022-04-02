import 'package:flutter/material.dart';
import 'package:inventaris_barang/Api/list_barang.dart';
import 'package:inventaris_barang/Screen/Barang%20Masuk/componen/app_bar.dart';
import 'package:inventaris_barang/Screen/Barang%20Masuk/tambah_barang_masuk.dart';
import 'package:inventaris_barang/Screen/Barang%20Masuk/tambah_barang_masuk_baru.dart';
import 'package:inventaris_barang/constants.dart';

class BarangMasuk extends StatefulWidget {
  const BarangMasuk({Key? key}) : super(key: key);

  @override
  State<BarangMasuk> createState() => _BarangMasukState();
}

class _BarangMasukState extends State<BarangMasuk> {
  int _currentSortColumn = 0;
  bool _isAscending = true;
  late List<Data> _listData = [];
  late List<Data> _listDataFiltered = [];
  final TextEditingController _searchController = TextEditingController();
  String _searchResult = '';

  @override
  void initState() {
    super.initState();

    ListBarang.connectToAPI().then((value) {
      _listData = value;
      _listDataFiltered = _listData;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        return Future.value(false);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const AppBarBarang(judul: "Barang Masuk"),
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
              DataTable(
                  showCheckboxColumn: false,
                  columnSpacing: 38,
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
                        label: const Text('Name'),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TambahBarangMasuk(
                                    data: _listDataFiltered[i]),
                              ));
                        },
                      ),
                  ]),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const TambahBarangMasukBaru();
            })).then((value) {
              if (value) {
                ListBarang.connectToAPI().then((value) {
                  _listData = value;
                  _listDataFiltered = _listData;
                  setState(() {});
                });
              }
            });
          },
          backgroundColor: kPrimaryColor,
          child: const Icon(Icons.add),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
