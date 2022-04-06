import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inventaris_barang/Api/list_rekap.dart';
import 'package:inventaris_barang/Screen/Barang/componen/app_bar.dart';
import 'package:inventaris_barang/Screen/Rekap%20Barang/Ganti/tambah_rekap_ganti.dart';
import 'package:inventaris_barang/Screen/Rekap%20Barang/Masuk/tambah_rekap_masuk.dart';
import 'package:inventaris_barang/constants.dart';

class RekapBarangGanti extends StatefulWidget {
  const RekapBarangGanti({Key? key}) : super(key: key);

  @override
  State<RekapBarangGanti> createState() => _RekapBarangGantiState();
}

class _RekapBarangGantiState extends State<RekapBarangGanti> {
  int _currentSortColumn = 0;
  bool _isAscending = true;
  late List<Rekap> _listData = [];
  late List<Rekap> _listDataFiltered = [];
  final TextEditingController _searchController = TextEditingController();
  String _searchResult = '';

  @override
  void initState() {
    super.initState();

    ListRekap.getRekap("2").then((value) {
      if (value.length == 0) {
        Fluttertoast.showToast(
            msg: "Data tidak ditemukan",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
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
        appBar: const AppBarBarang(judul: "Rekap Barang Ganti"),
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
                                  user.inventaris!.contains(_searchResult))
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
                  columnSpacing: 30,
                  sortColumnIndex: _currentSortColumn,
                  sortAscending: _isAscending,
                  headingTextStyle: MaterialStateTextStyle.resolveWith(
                      (states) => const TextStyle(color: kPrimaryLightColor)),
                  headingRowColor: MaterialStateProperty.resolveWith(
                      (states) => kPrimaryColor),
                  columns: [
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
                                return a.inventaris!.compareTo(b.inventaris!);
                              } else {
                                return b.inventaris!.compareTo(a.inventaris!);
                              }
                            });
                          });
                        }),
                    DataColumn(
                        label: const Text('Jumlah'),
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
                                return a.jumlahAwal!.compareTo(b.jumlahAwal!);
                              } else {
                                return b.jumlahAwal!.compareTo(a.jumlahAwal!);
                              }
                            });
                          });
                        }),
                    DataColumn(
                        label: const Text('Tanggal'),
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
                                return a.tanggal!.compareTo(b.tanggal!);
                              } else {
                                return b.tanggal!.compareTo(a.tanggal!);
                              }
                            });
                          });
                        }),
                    DataColumn(
                        label: const Text('Keterangan'),
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
                                return a.namaStatus!.compareTo(b.namaStatus!);
                              } else {
                                return b.namaStatus!.compareTo(a.namaStatus!);
                              }
                            });
                          });
                        }),
                  ],
                  rows: [
                    for (var i = 0; i < _listDataFiltered.length; i++)
                      DataRow(
                        cells: [
                          DataCell(SizedBox(
                              child: Text(_listDataFiltered[i].inventaris!))),
                          DataCell(SizedBox(
                              child: Text(_listDataFiltered[i].jumlahAwal!))),
                          DataCell(SizedBox(
                              child: Text(_listDataFiltered[i].tanggal!))),
                          DataCell(SizedBox(
                              child: Text(_listDataFiltered[i].namaStatus!))),
                        ],
                        onSelectChanged: (value) {
                          // Kirim Data Ke Screen Lain
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => TambahRekapBarangHilang(
                          //           data: _listDataFiltered[i]),
                          //     ));
                        },
                      ),
                  ]),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const TambahRekapGanti();
            })).then((value) {
              if (value) {
                ListRekap.getRekap("2").then((value) {
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
