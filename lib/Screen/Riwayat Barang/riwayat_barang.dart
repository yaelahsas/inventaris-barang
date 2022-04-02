import 'package:flutter/material.dart';

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
            Expanded(
              child: ListView(
                children: [
                  DataTable(
                      showCheckboxColumn: false,
                      columnSpacing: 38,
                      // sortColumnIndex: _currentSortColumn,
                      // sortAscending: _isAscending,
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
                                    return a.inventaris!
                                        .compareTo(b.inventaris!);
                                  } else {
                                    return b.inventaris!
                                        .compareTo(a.inventaris!);
                                  }
                                });
                              });
                            }),
                        DataColumn(label: const Text('Tanggal')),
                        DataColumn(label: const Text('Jumlah')),
                      ],
                      rows: [
                        for (var i = 0; i < _listDataFiltered.length; i++)
                          DataRow(
                            cells: [
                              DataCell(
                                  Text(_listDataFiltered[i].id.toString())),
                              DataCell(SizedBox(
                                  // width: MediaQuery.of(context).size.width,
                                  child:
                                      Text(_listDataFiltered[i].inventaris!))),
                              DataCell(Text(_listDataFiltered[i].tanggal!)),
                              DataCell(Text(_listDataFiltered[i]
                                  .jumlahAkhir!
                                  .toString())),
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
                      ])
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
