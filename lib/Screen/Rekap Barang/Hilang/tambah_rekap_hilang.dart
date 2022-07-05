import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:inventaris_barang/Api/list_barang.dart';
import 'package:inventaris_barang/Api/list_divisi.dart';
import 'package:inventaris_barang/Api/list_status.dart';
import 'package:inventaris_barang/Api/tambah_rekap.dart';
import 'package:inventaris_barang/Screen/Barang/barang_masuk.dart';
import 'package:inventaris_barang/Screen/Barang/componen/app_bar.dart';
import 'package:inventaris_barang/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Api/tambah_barang.dart';

class TambahRekapHilang extends StatefulWidget {
  const TambahRekapHilang({Key? key, required this.idRekap}) : super(key: key);
  final String idRekap;
  @override
  State<TambahRekapHilang> createState() => _TambahRekapHilangState();
}

class _TambahRekapHilangState extends State<TambahRekapHilang> {
  DateTime time = DateTime.now();
  final TextEditingController _cInventaris = TextEditingController();
  final TextEditingController _cSpesifikasi = TextEditingController();
  final TextEditingController _cDivisi = TextEditingController();
  final TextEditingController _cJumlahAkhir = TextEditingController();
  final TextEditingController _cPIC = TextEditingController();
  final TextEditingController _cTanggal = TextEditingController();

  Divisi? dropdownValue;
  Data? ddBarang;
  String date = '';
  Status? dropdownValueStatus;
  List<Divisi>? spinnerItems;
  List<Data>? spBarang;

  List<Status>? spinnerItemsStatus;

  @override
  void initState() {
    super.initState();
    print(DateFormat('yyyy-MM-dd').format(time));
    ListDivisi.getDivisi().then((value) {
      spinnerItems = value;
      setState(() {});
    });
    ListStatus.getStatus().then((value) {
      spinnerItemsStatus = value;
      setState(() {});
    });
    ListBarang.barang_keluar().then((value) {
      spBarang = value;

      setState(() {});
    });
    _getName();
  }

  _getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _cPIC.text = prefs.getString("username")!.toLowerCase();
    });
  }

  @override
  void dispose() {
    super.dispose();

    _cInventaris.dispose();
    _cSpesifikasi.dispose();
    _cDivisi.dispose();
    _cJumlahAkhir.dispose();
    _cPIC.dispose();
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
        appBar: const AppBarBarang(judul: "Tambah Barang Hilang"),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            height: MediaQuery.of(context).size.height,
            child: Form(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // const SizedBox(
                //   height: 10,
                // ),
                // TextFormField(
                //   controller: _cInventaris,
                //   decoration: const InputDecoration(
                //       focusedBorder: OutlineInputBorder(
                //         borderSide:
                //             BorderSide(color: Colors.greenAccent, width: 1.0),
                //       ),
                //       enabledBorder: OutlineInputBorder(
                //         borderSide: BorderSide(color: Colors.red, width: 1.0),
                //       ),
                //       hintText: 'Name',
                //       labelText: 'Inventaris'),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                // TextFormField(
                //     controller: _cSpesifikasi,
                //     decoration: const InputDecoration(
                //         focusedBorder: OutlineInputBorder(
                //           borderSide:
                //               BorderSide(color: Colors.greenAccent, width: 1.0),
                //         ),
                //         enabledBorder: OutlineInputBorder(
                //           borderSide: BorderSide(color: Colors.red, width: 1.0),
                //         ),
                //         hintText: 'Spesifikasi',
                //         labelText: 'Spesifikasi')),
                const SizedBox(
                  // height: 14,
                  width: double.infinity,
                  child: Text(
                    "Nama Barang",
                    textAlign: TextAlign.left,
                  ),
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
                          _cDivisi.text = data!.namaDivisi.toString();
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
                    controller: _cDivisi,
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
                    readOnly: true,
                    controller: _cPIC,
                    decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.greenAccent, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1.0),
                        ),
                        hintText: 'PIC',
                        labelText: 'PIC')),
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
                        labelText: 'Tanggal Rusak')),
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
                      TambahRekap.barangMasuk(
                              prefs.getInt('id_pic')!.toString(),
                              jam,
                              DateFormat('yyyy-MM-dd').format(time),
                              "3",
                              widget.idRekap.toString(),
                              ddBarang!.id.toString())
                          .then((value) => {
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
                      // TambahBarang.barangMasukBaru(
                      //     ddBarang!.namaBarang.toString(),
                      //     ddBarang!.spesifikasi.toString(),
                      //     dropdownValue!.id.toString(),
                      //     DateFormat('yyyy-MM-dd').format(time),
                      //     '1',
                      //     '2');
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
}
