import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Api/list_riwayat.dart';
import '../../constants.dart';

class RiwayatBarang extends StatefulWidget {
  const RiwayatBarang({Key? key}) : super(key: key);

  @override
  State<RiwayatBarang> createState() => _RiwayatBarangState();
}

class _RiwayatBarangState extends State<RiwayatBarang> {
  int _currentSortColumn = 0;
  bool _isAscending = true;
  late List<Data> _listData = [];
  late List<Data> _listDataFiltered = [];
  final TextEditingController _searchController = TextEditingController();
  String _searchResult = '';

  @override
  void initState() {
    super.initState();

    ListRiwayat.getRiwayat().then((value) {
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("Riwayat Barang")),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: const Center(
                child: Text(
                  "Riwayat Barang Keluar Masuk",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
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
                            .where((user) => user.namaBarang!
                                .toLowerCase()
                                .contains(_searchResult))
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
                scrollDirection: Axis.horizontal,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                        showCheckboxColumn: false,
                        columnSpacing: 30,
                        // sortColumnIndex: _currentSortColumn,
                        // sortAscending: _isAscending,
                        headingTextStyle: MaterialStateTextStyle.resolveWith(
                            (states) =>
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
                                      return a.namaBarang!
                                          .compareTo(b.namaBarang!);
                                    } else {
                                      return b.namaBarang!
                                          .compareTo(a.namaBarang!);
                                    }
                                  });
                                });
                              }),
                          DataColumn(label: const Text('Tanggal')),
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
                                      return a.jumlahBarang!
                                          .compareTo(b.jumlahBarang!);
                                    } else {
                                      return b.jumlahBarang!
                                          .compareTo(a.jumlahBarang!);
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
                                      return a.namaStatus!
                                          .compareTo(b.namaStatus!);
                                    } else {
                                      return b.namaStatus!
                                          .compareTo(a.namaStatus!);
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
                                    // width: MediaQuery.of(context).size.width,
                                    child: Text(
                                        _listDataFiltered[i].namaBarang!))),
                                DataCell(Text(_listDataFiltered[i].tanggal!)),
                                DataCell(Text(_listDataFiltered[i]
                                    .jumlahBarang!
                                    .toString())),
                                DataCell(
                                    Text(_listDataFiltered[i].namaStatus!)),
                              ],
                              onSelectChanged: (value) {
                                // Kirim Data Ke Screen Lain
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) =>
                                //           TambahBarangMasuk(data: _listDataFiltered[i]),
                                //     ));
                              },
                            ),
                        ]),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
