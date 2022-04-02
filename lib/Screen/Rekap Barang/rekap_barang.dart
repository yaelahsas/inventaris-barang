import 'package:flutter/material.dart';

import '../../constants.dart';

class RekapBarang extends StatelessWidget {
  const RekapBarang({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rekap Barang"),
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
                onPressed: () {},
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
                onPressed: () {},
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
                onPressed: () {},
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
                onPressed: () {},
                child: const Text("Rekapan barang ganti baru"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
