import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:inventaris_barang/Api/tambah_barang.dart';
import 'package:inventaris_barang/Screen/Barang/componen/app_bar.dart';
import 'package:inventaris_barang/constants.dart';

import '../../Api/list_barang.dart';

class TambahBarangKeluar extends StatefulWidget {
  const TambahBarangKeluar({Key? key, required this.data}) : super(key: key);

  final Data data;

  @override
  State<TambahBarangKeluar> createState() => _TambahBarangKeluarState();
}

class _TambahBarangKeluarState extends State<TambahBarangKeluar> {
  DateTime time = DateTime.now();
  final TextEditingController _cName = TextEditingController();
  final TextEditingController _cId = TextEditingController();
  final TextEditingController _cNamaDivisi = TextEditingController();
  final TextEditingController _cNamaSpesifikasi = TextEditingController();
  final TextEditingController _cTanggal = TextEditingController();
  // final TextEditingController _cJumlah = TextEditingController();
  String date = '';

  @override
  void initState() {
    super.initState();

    _cId.text = widget.data.id.toString();
    _cName.text = widget.data.namaBarang!;
    _cNamaDivisi.text = widget.data.namaDivisi!;
    _cNamaSpesifikasi.text = widget.data.spesifikasi!;
  }

  @override
  void dispose() {
    super.dispose();
    _cId.dispose();
    _cName.dispose();
    _cNamaDivisi.dispose();
    _cNamaSpesifikasi.dispose();
    _cTanggal.dispose();
    // _cJumlah.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const AppBarBarang(judul: "Tambah Barang Keluar"),
      body: SingleChildScrollView(
        child: Container(
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
                readOnly: true,
                decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.greenAccent, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1.0),
                    ),
                    hintText: 'Name',
                    labelText: 'Name'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                  controller: _cNamaSpesifikasi,
                  readOnly: true,
                  decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.greenAccent, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.0),
                      ),
                      hintText: 'Spesifikasi',
                      labelText: 'Spesifikasi')),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                  controller: _cNamaDivisi,
                  readOnly: true,
                  decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.greenAccent, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.0),
                      ),
                      hintText: 'Divisi',
                      labelText: 'Divisi')),
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
                      labelText: 'Tanggal Keluar')),
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
                    TambahBarang.barangKeluar(_cId.text, _cTanggal.text)
                        .then((hasil) {
                      if (hasil.success == true) {
                        Fluttertoast.showToast(
                            msg: hasil.message!,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: kPrimaryColor,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else {
                        Fluttertoast.showToast(
                            msg: hasil.message!,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    });
                  },
                  child: const Text("Tambah"),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
