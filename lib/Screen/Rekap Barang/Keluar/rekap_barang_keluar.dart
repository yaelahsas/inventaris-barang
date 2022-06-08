import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inventaris_barang/Api/list_rekap.dart';
import 'package:inventaris_barang/Screen/Barang/componen/app_bar.dart';
import 'package:inventaris_barang/Screen/Rekap%20Barang/Keluar/tambah_rekap_keluar.dart';
import 'package:inventaris_barang/constants.dart';

class RekapBarangKeluar extends StatefulWidget {
  const RekapBarangKeluar({Key? key, required this.idRekap}) : super(key: key);
  final String idRekap;

  @override
  State<RekapBarangKeluar> createState() => _RekapBarangKeluarState();
}

class _RekapBarangKeluarState extends State<RekapBarangKeluar> {
  int _currentSortColumn = 0;
  bool _isAscending = true;
  late List<Rekap> _listData = [];
  late List<Rekap> _listDataFiltered = [];
  final TextEditingController _searchController = TextEditingController();
  String _searchResult = '';

  @override
  void initState() {
    super.initState();

    ListRekap.getRekap("5", widget.idRekap).then((value) {
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
        appBar: const AppBarBarang(judul: "Rekap Barang Keluar"),
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
                              .where(
                                  (user) => user.nama!.contains(_searchResult))
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
                                return a.nama!.compareTo(b.nama!);
                              } else {
                                return b.nama!.compareTo(a.nama!);
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
                              child: Text(_listDataFiltered[i].nama!))),
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
                          //       builder: (context) => TambahRekapBarangKeluar(
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
              return TambahRekapKeluar(
                idRekap: widget.idRekap,
              );
            })).then((value) {
              if (value) {
                ListRekap.getRekap("5", widget.idRekap).then((value) {
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
