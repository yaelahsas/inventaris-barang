import 'package:flutter/material.dart';
import 'package:inventaris_barang/Screen/Barang%20Masuk/barang_masuk.dart';
import 'package:inventaris_barang/Screen/Dashboard/dashboard_affair.dart';
import 'package:inventaris_barang/Screen/Welcome/welcome_screen.dart';
import 'package:inventaris_barang/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventaris App',
      theme: ThemeData(
          primaryColor: kPrimaryColor, scaffoldBackgroundColor: Colors.white),
      home: BarangMasuk(),
      debugShowCheckedModeBanner: false,
    );
  }
}
