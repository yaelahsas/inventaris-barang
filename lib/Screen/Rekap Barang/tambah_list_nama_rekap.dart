import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:inventaris_barang/Api/list_nama_rekap.dart';
import 'package:inventaris_barang/constants.dart';

class RekapTambahNama extends StatefulWidget {
  const RekapTambahNama({Key? key}) : super(key: key);

  @override
  State<RekapTambahNama> createState() => _RekapTambahNamaState();
}

class _RekapTambahNamaState extends State<RekapTambahNama> {
  DateTime time = DateTime.now();
  final TextEditingController _cName = TextEditingController();
  final TextEditingController _cTanggal = TextEditingController();
  String date = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Nama Rekap"),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        height: MediaQuery.of(context).size.height,
        child: Form(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _cName,
              decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.greenAccent, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 1.0),
                  ),
                  hintText: 'Name',
                  labelText: 'Nama'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
                controller: _cTanggal,
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: time,
                    firstDate: DateTime(2015),
                    lastDate: DateTime(2100),
                  ).then((hasil) {
                    if (hasil == null) return;

                    date = DateFormat('yyyy-MM-dd').format(hasil);
                    _cTanggal.text = date;
                  });
                },
                decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.greenAccent, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1.0),
                    ),
                    hintText: 'masukkan tanggal',
                    labelText: 'Tanggal')),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                    textStyle: const TextStyle(fontSize: 20)),
                onPressed: () {
                  ListNamaRekap.tambahNamaRekap(
                    _cName.text,
                    _cTanggal.text,
                  ).then((value) => {
                        if (value.success == true)
                          {
                            Fluttertoast.showToast(
                                msg: value.message!,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: kPrimaryColor,
                                textColor: Colors.white,
                                fontSize: 16.0)
                          }
                        else
                          {
                            Fluttertoast.showToast(
                                msg: value.message!,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0)
                          }
                      });
                },
                child: const Text("Tambah"),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
