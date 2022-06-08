import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:inventaris_barang/Api/list_divisi.dart';
import 'package:inventaris_barang/Api/list_status.dart';
import 'package:inventaris_barang/Api/tambah_rekap.dart';
import 'package:inventaris_barang/Screen/Barang/componen/app_bar.dart';
import 'package:inventaris_barang/constants.dart';

import '../../../Api/list_barang.dart';

class TambahRekapKeluar extends StatefulWidget {
  const TambahRekapKeluar({Key? key, required this.idRekap}) : super(key: key);
  final String idRekap;
  @override
  State<TambahRekapKeluar> createState() => _TambahRekapKeluarState();
}

class _TambahRekapKeluarState extends State<TambahRekapKeluar> {
  DateTime time = DateTime.now();
  final TextEditingController _cInventaris = TextEditingController();
  final TextEditingController _cSpesifikasi = TextEditingController();
  final TextEditingController _cJumlahAwal = TextEditingController();
  final TextEditingController _cJumlahAkhir = TextEditingController();
  final TextEditingController _cPIC = TextEditingController();

  Divisi? dropdownValue;
  Data? ddBarang;

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
    ListBarang.connectToAPI().then((value) {
      spBarang = value;
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();

    _cInventaris.dispose();
    _cSpesifikasi.dispose();
    _cJumlahAwal.dispose();
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
                  controller: _cInventaris,
                  decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.greenAccent, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.0),
                      ),
                      hintText: 'Name',
                      labelText: 'Inventaris'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                    controller: _cSpesifikasi,
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
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: DropdownButton<Divisi>(
                      value: dropdownValue,
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
                          dropdownValue = data;
                        });
                      },
                      items: spinnerItems?.map((Divisi value) {
                        return DropdownMenuItem<Divisi>(
                            value: value,
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Text(value.namaDivisi!)));
                      }).toList()),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
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
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: kPrimaryColor,
                        textStyle: const TextStyle(fontSize: 20)),
                    onPressed: () {
                      TambahRekap.barangMasuk(
                              _cPIC.text,
                              _cInventaris.text,
                              _cSpesifikasi.text,
                              DateFormat('yyyy-MM-dd').format(time),
                              dropdownValue!.id.toString(),
                              "5",
                              widget.idRekap,
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
