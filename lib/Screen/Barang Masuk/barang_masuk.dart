import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inventaris_barang/Api/list_data.dart';
import 'package:inventaris_barang/Screen/Barang%20Masuk/componen/app_bar.dart';
import 'package:inventaris_barang/Screen/Barang%20Masuk/tambah_barang_masuk.dart';
import 'package:inventaris_barang/constants.dart';

class BarangMasuk extends StatefulWidget {
  const BarangMasuk({Key? key}) : super(key: key);

  @override
  State<BarangMasuk> createState() => _BarangMasukState();
}

class _BarangMasukState extends State<BarangMasuk> {
  int _currentSortColumn = 0;
  bool _isAscending = true;
  late List<ListData> _listData = [];
  late List<ListData> _listDataFiltered = [];
  TextEditingController _searchController = TextEditingController();
  String _searchResult = '';

  @override
  void initState() {
    super.initState();
    ListData.connectToAPI().then((value) {
      _listData = value;
      _listDataFiltered = _listData;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarBarang(judul: "Barang Masuk"),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        margin: EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: Icon(Icons.search),
                title: TextField(
                    controller: _searchController,
                    decoration: new InputDecoration(
                        hintText: 'Search', border: InputBorder.none),
                    onChanged: (value) {
                      setState(() {
                        _searchResult = value;
                        _listDataFiltered = _listData
                            .where((user) => user.name.contains(_searchResult))
                            .toList();
                      });
                    }),
                trailing: IconButton(
                  icon: Icon(Icons.cancel),
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
                      label: Text('Id'),
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
                              return a.id.compareTo(b.id);
                            } else {
                              return b.id.compareTo(a.id);
                            }
                          });
                        });
                      }),
                  DataColumn(
                      label: Text('Name'),
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
                              return a.name.compareTo(b.name);
                            } else {
                              return b.name.compareTo(a.name);
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
                        DataCell(Container(
                            width: size.width,
                            child: Text(_listDataFiltered[i].name))),
                      ],
                      onSelectChanged: (value) {
                        // Kirim Data Ke Screen Lain
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TambahBarangMasuk(data: _listDataFiltered[i]),
                            ));
                      },
                    ),
                ]),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: kPrimaryColor,
        child: Icon(Icons.add),
      ),
      backgroundColor: Colors.white,
    );
  }
}
