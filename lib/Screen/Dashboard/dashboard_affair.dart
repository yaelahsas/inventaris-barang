import 'package:flutter/material.dart';
import 'package:inventaris_barang/Screen/Barang%20Masuk/componen/app_bar.dart';
import 'package:inventaris_barang/Screen/Dashboard/componen/body_affair.dart';

class DashboarAffair extends StatelessWidget {
  const DashboarAffair({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarBarang(judul: "Dashboard Affair"),
      body: BodyAffair(),
    );
  }
}
