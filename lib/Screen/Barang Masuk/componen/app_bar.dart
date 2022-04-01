import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class AppBarBarang extends StatelessWidget implements PreferredSizeWidget {
  const AppBarBarang({Key? key, required this.judul}) : super(key: key);
  final String judul;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(judul),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.qr_code,
            color: Colors.white,
          ),
          onPressed: () async {
            String? cameraScanResult = await scanner.scan();
            var a = jsonDecode(cameraScanResult!);
            // var hasil = Data.t(a);

            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => TambahBarangMasuk(data: hasil),
            //     ));
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50.0);
}
