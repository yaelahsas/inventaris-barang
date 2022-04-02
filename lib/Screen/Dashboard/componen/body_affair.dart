import 'package:flutter/material.dart';
import 'package:inventaris_barang/Screen/Barang%20Masuk/barang_masuk.dart';
import 'package:inventaris_barang/Screen/Rekap%20Barang/rekap_barang.dart';
import 'package:inventaris_barang/Screen/Riwayat%20Barang/riwayat_barang.dart';
import 'package:inventaris_barang/constants.dart';

class BodyAffair extends StatelessWidget {
  const BodyAffair({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: kPrimaryColor,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: GridView.count(
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          crossAxisCount: 2,
          shrinkWrap: true,
          primary: false,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const BarangMasuk();
                }));
              },
              child: Card(
                elevation: 4,
                margin: const EdgeInsets.all(10),
                child: Column(children: const [
                  Icon(
                    Icons.warehouse_rounded,
                    size: 120,
                    color: Colors.blueAccent,
                  ),
                  Text("Barang Masuk",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ]),
              ),
            ),
            Card(
              elevation: 4,
              margin: const EdgeInsets.all(10),
              child: Column(children: const [
                Icon(
                  Icons.exit_to_app_rounded,
                  size: 120,
                  color: Colors.blueAccent,
                ),
                Text("Barang Keluar",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ]),
            ),
            Card(
              elevation: 4,
              margin: const EdgeInsets.all(10),
              child: Column(children: const [
                Icon(
                  Icons.menu_book_rounded,
                  color: Colors.blueAccent,
                  size: 120,
                ),
                Text(
                  "Lihat Laporan",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ]),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const RekapBarang();
                }));
              },
              child: Card(
                elevation: 4,
                margin: const EdgeInsets.all(10),
                child: Column(children: const [
                  Icon(
                    Icons.bookmark_add_rounded,
                    color: Colors.blueAccent,
                    size: 120,
                  ),
                  Text("Rekap Barang",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ]),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const RiwayatBarang();
                }));
              },
              child: Card(
                elevation: 4,
                margin: const EdgeInsets.all(10),
                child: Column(children: const [
                  Icon(
                    Icons.history_edu_rounded,
                    size: 120,
                    color: Colors.blueAccent,
                  ),
                  Text("Riwayat Barang",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
