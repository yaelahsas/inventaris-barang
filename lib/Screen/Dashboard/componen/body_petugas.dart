import 'package:flutter/material.dart';
import 'package:inventaris_barang/Screen/Barang/barang_keluar.dart';
import 'package:inventaris_barang/Screen/Barang/barang_masuk.dart';
import 'package:inventaris_barang/Screen/Riwayat%20Barang/riwayat_barang.dart';
import 'package:inventaris_barang/constants.dart';

class BodyPetugas extends StatelessWidget {
  const BodyPetugas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
          primary: true,
          shrinkWrap: true,
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
            ),
          ],
        ),
      ),
    );
  }
}
