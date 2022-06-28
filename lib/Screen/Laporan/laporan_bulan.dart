import 'package:flutter/material.dart';
import 'package:inventaris_barang/Screen/Laporan/Barang%20Ganti/laporan_ganti.dart';
import 'package:inventaris_barang/Screen/Laporan/Barang%20Hilang/laporan_hilang.dart';
import 'package:inventaris_barang/Screen/Laporan/Barang%20Rusak/laporan_rusak.dart';
import 'package:inventaris_barang/Screen/Laporan/laporan_barang.dart';
import 'package:inventaris_barang/constants.dart';

class LaporanBulan extends StatelessWidget {
  const LaporanBulan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Laporan Barang"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LaporanRusak(),
                          ));
                    },
                    child: Text("Barang Rusak")),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LaporanGanti(),
                          ));
                    },
                    child: Text("Barang Ganti")),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LaporanHilang(),
                          ));
                    },
                    child: Text("Barang Hilang")),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                    onPressed: () {}, child: Text("Laporan Inventaris")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
