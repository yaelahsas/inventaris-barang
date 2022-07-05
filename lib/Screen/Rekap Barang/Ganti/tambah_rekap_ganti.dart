import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:inventaris_barang/Api/laporan_ganti.dart';
import 'package:inventaris_barang/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TambahRekapGanti extends StatefulWidget {
  const TambahRekapGanti({Key? key, required this.idRekap}) : super(key: key);
  final String idRekap;
  @override
  State<TambahRekapGanti> createState() => _TambahLaporanGantiState();
}

class _TambahLaporanGantiState extends State<TambahRekapGanti> {
  DateTime time = DateTime.now();
  final TextEditingController _cName = TextEditingController();

  final TextEditingController _cNamaDivisi = TextEditingController();

  final TextEditingController _cTanggal = TextEditingController();

  String date = '';
  BarangGanti? ddBarang;
  List<BarangGanti>? spBarang;
  BarangGantinya? ddBarangGantinya;
  List<BarangGantinya>? spBarangGantinya;
  _getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _cName.text = prefs.getString("username")!.toLowerCase();
    });
  }

  @override
  void initState() {
    super.initState();
    _getName();
    ListLaporanGanti.barang_inventaris().then((value) {
      spBarang = value;
      setState(() {});
    });
    ListLaporanGanti.barang_gantinya().then((value) {
      spBarangGantinya = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tambah")),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        height: MediaQuery.of(context).size.height,
        child: Form(
            child: SingleChildScrollView(
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
                    hintText: 'PIC',
                    labelText: 'PIC'),
              ),
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
                width: MediaQuery.of(context).size.width,
                child: DropdownButton<BarangGanti>(
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
                        _cNamaDivisi.text = data!.namaDivisi.toString();
                      });
                    },
                    items: spBarang?.map((BarangGanti value) {
                      return DropdownMenuItem<BarangGanti>(
                          value: value,
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Text(value.kodeQrcode.toString() +
                                  " - " +
                                  value.namaBarang.toString())));
                    }).toList()),
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
              const SizedBox(
                // height: 14,
                width: double.infinity,
                child: Text(
                  "Pilih Barang Ganti",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: DropdownButton<BarangGantinya>(
                    value: ddBarangGantinya,
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
                        ddBarangGantinya = data;
                      });
                    },
                    items: spBarangGantinya?.map((BarangGantinya value) {
                      return DropdownMenuItem<BarangGantinya>(
                          value: value,
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Text(value.kodeQrcode.toString() +
                                  " - " +
                                  value.namaBarang.toString())));
                    }).toList()),
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
                      labelText: 'Tanggal Masuk')),
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
                    ListLaporanGanti.postRekapGanti(
                            prefs.getInt('id_pic')!.toString(),
                            date,
                            jam,
                            ddBarang!,
                            ddBarangGantinya!,
                            widget.idRekap)
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
          ),
        )),
      ),
    );
  }
}
