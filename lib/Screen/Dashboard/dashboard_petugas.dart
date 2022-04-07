import 'package:flutter/material.dart';
import 'package:inventaris_barang/Screen/Dashboard/componen/body_petugas.dart';

class DashboarPetugas extends StatelessWidget {
  const DashboarPetugas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard Petugas')),
      body: const BodyPetugas(),
    );
  }
}
