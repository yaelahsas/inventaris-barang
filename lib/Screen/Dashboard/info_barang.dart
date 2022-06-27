import 'package:flutter/material.dart';

import '../../Api/scan.dart';

class InfoBarang extends StatefulWidget {
  const InfoBarang({Key? key, required this.data}) : super(key: key);
  final Data data;

  @override
  State<InfoBarang> createState() => _InfoBarangState();
}

class _InfoBarangState extends State<InfoBarang> {
  DateTime time = DateTime.now();
  final TextEditingController _cName = TextEditingController();
  final TextEditingController _cNameGanti = TextEditingController();
  final TextEditingController _cId = TextEditingController();
  final TextEditingController _cNamaDivisi = TextEditingController();
  final TextEditingController _cNamaSpesifikasi = TextEditingController();
  final TextEditingController _cTanggal = TextEditingController();
  final TextEditingController _cKodeQr = TextEditingController();
  final TextEditingController _cKodeQrGanti = TextEditingController();
  final TextEditingController _cStatus = TextEditingController();
  final TextEditingController _cPIC = TextEditingController();
  final TextEditingController _cJAM = TextEditingController();

  String date = '';

  @override
  void initState() {
    super.initState();

    _cId.text = widget.data.id.toString();
    _cName.text = widget.data.namaBarang!;
    _cNamaDivisi.text = widget.data.namaDivisi!;
    _cNamaSpesifikasi.text = widget.data.spesifikasi!;
    _cTanggal.text = widget.data.tanggal!;
    _cKodeQr.text = widget.data.kodeQrcode!;
    _cStatus.text = widget.data.namaStatus!;
    _cKodeQrGanti.text = widget.data.kodeQrcodeTambahan!;
    _cNameGanti.text = widget.data.namaBarangTambahan!;
    _cPIC.text = widget.data.name_pic!;
    _cJAM.text = widget.data.jam!;
  }

  @override
  void dispose() {
    super.dispose();
    _cId.dispose();
    _cName.dispose();
    _cNamaDivisi.dispose();
    _cNamaSpesifikasi.dispose();
    _cTanggal.dispose();
    _cKodeQr.dispose();
    _cStatus.dispose();
    _cNameGanti.dispose();
    _cKodeQrGanti.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Info Barang"),
      ),
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
                  readOnly: true,
                  controller: _cTanggal,
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
              TextFormField(
                  readOnly: true,
                  controller: _cKodeQr,
                  decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.greenAccent, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.0),
                      ),
                      hintText: 'qr',
                      labelText: 'Kode QR')),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                  readOnly: true,
                  controller: _cStatus,
                  decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.greenAccent, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.0),
                      ),
                      hintText: 'status',
                      labelText: 'Status')),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                  readOnly: true,
                  controller: _cNameGanti,
                  decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.greenAccent, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.0),
                      ),
                      hintText: 'barang ganti',
                      labelText: 'Barang ganti')),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                  readOnly: true,
                  controller: _cKodeQrGanti,
                  decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.greenAccent, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.0),
                      ),
                      hintText: 'qr',
                      labelText: 'Kode QR Barang Ganti')),
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
                      hintText: 'pic',
                      labelText: 'Nama PIC')),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                  readOnly: true,
                  controller: _cJAM,
                  decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.greenAccent, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.0),
                      ),
                      hintText: 'jam',
                      labelText: 'Jam')),
            ],
          ),
        )),
      ),
    );
  }
}
