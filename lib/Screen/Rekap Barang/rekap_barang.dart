import 'package:flutter/material.dart';
import 'package:inventaris_barang/Screen/Rekap%20Barang/Hilang/rekap_barang_hilang.dart';
import 'package:inventaris_barang/Screen/Rekap%20Barang/Keluar/rekap_barang_keluar.dart';
import 'package:inventaris_barang/Screen/Rekap%20Barang/Masuk/rekap_barang_masuk.dart';
import 'package:inventaris_barang/Screen/Rekap%20Barang/rekap_pdf.dart';

import '../../constants.dart';
import 'Ganti/rekap_barang_ganti.dart';

class RekapBarang extends StatelessWidget {
  const RekapBarang({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rekap Barang"),
        actions: [
          IconButton(
            icon: const Icon(Icons.print_rounded),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return RekapPdf(
                  idRekap: id,
                );
              }));
            },
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: const Center(
                child: Text(
                  "Pilih Jenis Rekapan",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                    textStyle: const TextStyle(fontSize: 20)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RekapBarangMasuk(idRekap: id),
                      ));
                },
                child: const Text("Rekapan barang masuk"),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                    textStyle: const TextStyle(fontSize: 20)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RekapBarangKeluar(idRekap: id),
                      ));
                },
                child: const Text("Rekapan barang keluar"),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                    textStyle: const TextStyle(fontSize: 20)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RekapBarangHilang(idRekap: id),
                      ));
                },
                child: const Text("Rekapan barang hilang"),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                    textStyle: const TextStyle(fontSize: 20)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RekapBarangGanti(idRekap: id),
                      ));
                },
                child: const Text("Rekapan barang ganti baru"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
