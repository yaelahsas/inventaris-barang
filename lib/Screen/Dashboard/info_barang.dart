import 'package:flutter/material.dart';
import 'package:inventaris_barang/Api/list_barang.dart';

class InfoBarang extends StatefulWidget {
  const InfoBarang({Key? key, required this.data}) : super(key: key);
  final Data data;

  @override
  State<InfoBarang> createState() => _InfoBarangState();
}

class _InfoBarangState extends State<InfoBarang> {
  DateTime time = DateTime.now();
  final TextEditingController _cName = TextEditingController();
  final TextEditingController _cId = TextEditingController();
  final TextEditingController _cNamaDivisi = TextEditingController();
  final TextEditingController _cNamaSpesifikasi = TextEditingController();
  final TextEditingController _cTanggal = TextEditingController();
  final TextEditingController _cJumlah = TextEditingController();
  String date = '';

  @override
  void initState() {
    super.initState();

    _cId.text = widget.data.id.toString();
    _cName.text = widget.data.namaBarang!;
    _cNamaDivisi.text = widget.data.namaDivisi!;
    _cNamaSpesifikasi.text = widget.data.spesifikasi!;
    _cTanggal.text = widget.data.tanggalMasuk!;
    _cJumlah.text = widget.data.jumlahBarang!;
  }

  @override
  void dispose() {
    super.dispose();
    _cId.dispose();
    _cName.dispose();
    _cNamaDivisi.dispose();
    _cNamaSpesifikasi.dispose();
    _cTanggal.dispose();
    _cJumlah.dispose();
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
                    labelText: 'Tanggal Keluar')),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
                readOnly: true,
                controller: _cJumlah,
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
          ],
        )),
      ),
    );
  }
}
