import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:inventaris_barang/Api/list_divisi.dart';
import 'package:inventaris_barang/Api/tambah_barang.dart';
import 'package:inventaris_barang/Screen/Barang/componen/app_bar.dart';
import 'package:inventaris_barang/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Api/list_barang.dart';

class TambahBarangMasukBaru extends StatefulWidget {
  const TambahBarangMasukBaru({Key? key}) : super(key: key);

  @override
  State<TambahBarangMasukBaru> createState() => _TambahBarangMasukBaruState();
}

class _TambahBarangMasukBaruState extends State<TambahBarangMasukBaru> {
  DateTime time = DateTime.now();
  final TextEditingController _cName = TextEditingController();
  final TextEditingController _cNamaSpesifikasi = TextEditingController();
  final TextEditingController _cTanggal = TextEditingController();
  final TextEditingController _cJumlah = TextEditingController();
  String date = '';
  File? uploadimage;
  Data? ddBarang;
  Divisi? dropdownValue;
  List<Divisi>? spinnerItems;
  List<Data>? spBarang;

  @override
  void initState() {
    super.initState();

    ListDivisi.getDivisi().then((value) {
      spinnerItems = value;
      setState(() {});
    });
    ListBarang.barangAll().then((value) {
      spBarang = value;
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();

    _cName.dispose();
    // _cNamaDivisi.dispose();
    _cNamaSpesifikasi.dispose();
    _cTanggal.dispose();
    _cJumlah.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, true);
        return Future.value(false);
      },
      child: Scaffold(
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
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  // height: 14,
                  width: double.infinity,
                  child: Text(
                    "Pilih Barang",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: DropdownButton<Data>(
                      value: ddBarang,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.red, fontSize: 18),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (data) {
                        setState(() {
                          ddBarang = data;
                          _cName.text = data!.namaBarang.toString();
                          _cNamaSpesifikasi.text = data.spesifikasi.toString();
                        });
                      },
                      items: spBarang?.map((Data value) {
                        return DropdownMenuItem<Data>(
                            value: value,
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Text(value.kodeQrcode.toString() +
                                    " - " +
                                    value.namaBarang.toString())));
                      }).toList()),
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
                    readOnly: true,
                    controller: _cNamaSpesifikasi,
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
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: kPrimaryColor,
                        textStyle: const TextStyle(fontSize: 20)),
                    onPressed: () async {
                      var now = DateTime.now();
                      var jam = DateFormat('HH:mm:ss').format(now).toString();
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      TambahBarang.barangMasukBaru(
                              _cName.text,
                              _cNamaSpesifikasi.text,
                              ddBarang!.id.toString(),
                              _cTanggal.text,
                              _cJumlah.text,
                              '4',
                              prefs.getInt('id_pic').toString(),
                              jam)
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
      ),
    );
  }

  Future<void> chooseImage() async {
    var choosedimage = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 50);
    //set source: ImageSource.camera to get image from camera
    setState(() {
      File file = File(choosedimage!.path);
      uploadimage = file;
    });
  }
}
