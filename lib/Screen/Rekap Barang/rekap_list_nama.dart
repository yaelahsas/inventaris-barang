import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inventaris_barang/Screen/Barang/componen/app_bar.dart';
import 'package:inventaris_barang/Screen/Rekap%20Barang/rekap_barang.dart';
import 'package:inventaris_barang/Screen/Rekap%20Barang/tambah_list_nama_rekap.dart';
import 'package:inventaris_barang/constants.dart';

import '../../Api/list_nama_rekap.dart';

class RekapListNama extends StatefulWidget {
  const RekapListNama({Key? key}) : super(key: key);

  @override
  State<RekapListNama> createState() => _RekapListNamaState();
}

class _RekapListNamaState extends State<RekapListNama> {
  int _currentSortColumn = 0;
  bool _isAscending = true;
  late List<Nama> _listData = [];
  late List<Nama> _listDataFiltered = [];
  final TextEditingController _searchController = TextEditingController();
  String _searchResult = '';

  @override
  void initState() {
    super.initState();

    ListNamaRekap.getList().then((value) {
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
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
        appBar: const AppBarBarang(judul: "List Rekap"),
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
                                  user.namaRekap!.contains(_searchResult))
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
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    SingleChildScrollView(
                      child: Container(
                        width: double.infinity,
                        child: DataTable(
                            showCheckboxColumn: false,
                            showBottomBorder: true,
                            sortColumnIndex: _currentSortColumn,
                            sortAscending: _isAscending,
                            headingTextStyle:
                                MaterialStateTextStyle.resolveWith((states) =>
                                    const TextStyle(color: kPrimaryLightColor)),
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
                                          return a.namaRekap!
                                              .compareTo(b.namaRekap!);
                                        } else {
                                          return b.namaRekap!
                                              .compareTo(a.namaRekap!);
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
                                          return a.tanggal!
                                              .compareTo(b.tanggal!);
                                        } else {
                                          return b.tanggal!
                                              .compareTo(a.tanggal!);
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
                                        child: Text(
                                            _listDataFiltered[i].namaRekap!))),
                                    DataCell(SizedBox(
                                        child: Text(
                                            _listDataFiltered[i].tanggal!))),
                                  ],
                                  onSelectChanged: (value) {
                                    // Kirim Data Ke Screen Lain
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => RekapBarang(
                                              id: _listDataFiltered[i]
                                                  .id
                                                  .toString()),
                                        ));
                                  },
                                ),
                            ]),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const RekapTambahNama();
            })).then((value) {
              if (value) {
                ListNamaRekap.getList().then((value) {
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
