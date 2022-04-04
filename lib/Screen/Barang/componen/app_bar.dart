import 'package:flutter/material.dart';
import 'package:inventaris_barang/Api/list_barang.dart';
import 'package:qrscan/qrscan.dart' as scanner;

import '../tambah_barang_masuk.dart';

class AppBarBarang extends StatelessWidget implements PreferredSizeWidget {
  const AppBarBarang({Key? key, required this.judul}) : super(key: key);
  final String judul;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(judul),
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.qr_code,
            color: Colors.white,
          ),
          onPressed: () async {
            String? cameraScanResult = await scanner.scan();
            var a = cameraScanResult!;
            ListBarang.scanData(a).then((hasil) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        TambahBarangMasuk(data: hasil.dataScan!),
                  ));
            });
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}
