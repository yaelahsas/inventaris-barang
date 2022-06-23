import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventaris_barang/Screen/Barang/barang_masuk.dart';
import 'package:inventaris_barang/Screen/Riwayat%20Barang/riwayat_barang.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Welcome/welcome_screen.dart';

class BodyPetugas extends StatefulWidget {
  const BodyPetugas({Key? key}) : super(key: key);

  @override
  State<BodyPetugas> createState() => _BodyState();
}

class _BodyState extends State<BodyPetugas> {
  void _setLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool('isLogin', false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 10,
            left: 20,
            right: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Dashboard",
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () {
                  _setLogin();
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return WelcomeScreen();
                  }));
                },
                child: Text(
                  "Logout",
                  style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: double.infinity,
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 4,
                  margin: EdgeInsets.all(10),
                  child: Column(children: [
                    Image.asset(
                      "assets/correct.png",
                      height: 120,
                      width: 120,
                    ),
                    Text("Barang Masuk",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 4,
                  margin: const EdgeInsets.all(10),
                  child: Column(children: [
                    Image.asset(
                      "assets/clock.png",
                      height: 120,
                      width: 120,
                    ),
                    Text("Riwayat",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ]),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
