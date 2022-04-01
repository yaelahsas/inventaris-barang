import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:inventaris_barang/Api/tambah_barang.dart';
import 'package:inventaris_barang/Screen/Barang%20Masuk/componen/app_bar.dart';
import 'package:inventaris_barang/constants.dart';

import '../../Api/list_barang.dart';

class TambahBarangMasuk extends StatefulWidget {
  const TambahBarangMasuk({Key? key, required this.data}) : super(key: key);

  final Data data;

  @override
  State<TambahBarangMasuk> createState() => _TambahBarangMasukState();
}

class _TambahBarangMasukState extends State<TambahBarangMasuk> {
  DateTime time = DateTime.now();
  TextEditingController _cName = TextEditingController();
  TextEditingController _cId = TextEditingController();
  TextEditingController _cNamaDivisi = TextEditingController();
  TextEditingController _cNamaSpesifikasi = TextEditingController();
  TextEditingController _cTanggal = TextEditingController();
  TextEditingController _cJumlah = TextEditingController();
  String date = '';

  @override
  void initState() {
    super.initState();
    print(widget.data.namaBarang);

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const AppBarBarang(judul: "Tambah Barang Masuk"),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          height: MediaQuery.of(context).size.height,
          child: Form(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                controller: _cId,
                readOnly: true,
                decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.greenAccent, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1.0),
                    ),
                    hintText: 'id',
                    labelText: 'id'),
              ),
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
                      date = DateFormat.yMd().format(hasil);
                      _cTanggal.text = date;
                      setState() {}
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
              TextFormField(
                  controller: _cJumlah,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.greenAccent, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.0),
                      ),
                      hintText: '0',
                      labelText: 'Jumlah')),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: kPrimaryColor,
                      textStyle: const TextStyle(fontSize: 20)),
                  onPressed: () {
                    TambahBarang.barangMasuk(
                            _cId.text, _cTanggal.text, _cJumlah.text)
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
