import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:inventaris_barang/Api/list_divisi.dart';
import 'package:inventaris_barang/Api/tambah_barang.dart';
import 'package:inventaris_barang/Screen/Barang/componen/app_bar.dart';
import 'package:inventaris_barang/constants.dart';

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

  Divisi? dropdownValue;
  List<Divisi>? spinnerItems;

  @override
  void initState() {
    super.initState();

    ListDivisi.getDivisi().then((value) {
      spinnerItems = value;
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();

    // _cName.dispose();
    // _cNamaDivisi.dispose();
    // _cNamaSpesifikasi.dispose();
    // _cTanggal.dispose();
    // _cJumlah.dispose();
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
                      labelText: 'Name'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
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
                    onPressed: () {
                      TambahBarang.barangMasukBaru(
                              _cName.text,
                              _cNamaSpesifikasi.text,
                              dropdownValue!.id.toString(),
                              _cTanggal.text,
                              _cJumlah.text)
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
}
