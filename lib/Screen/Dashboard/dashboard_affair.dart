import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inventaris_barang/Api/list_barang.dart';
import 'package:inventaris_barang/Api/list_rekap.dart';
import 'package:inventaris_barang/Api/scan.dart';
import 'package:inventaris_barang/Screen/Barang/barang_keluar.dart';
import 'package:inventaris_barang/Screen/Dashboard/componen/body_affair.dart';
import 'package:inventaris_barang/Screen/Dashboard/info_barang.dart';
import 'package:inventaris_barang/Screen/Laporan/laporan_barang.dart';
import 'package:inventaris_barang/Screen/Laporan/laporan_bulan.dart';
import 'package:inventaris_barang/Screen/Rekap%20Barang/rekap_barang.dart';
import 'package:inventaris_barang/Screen/Rekap%20Barang/rekap_list_nama.dart';
import 'package:inventaris_barang/Screen/Riwayat%20Barang/riwayat_barang.dart';
import 'package:inventaris_barang/Screen/Welcome/welcome_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:google_fonts/google_fonts.dart';

import '../Barang/barang_masuk.dart';

class DashboarAffair extends StatelessWidget {
  const DashboarAffair({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [AppBar(), Body()],
            ),
          ),
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                    return const BarangKeluar();
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
                      "assets/checklist.png",
                      height: 120,
                      width: 120,
                    ),
                    Text("Barang Keluar",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ]),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const LaporanBulan();
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
                      "assets/report.png",
                      height: 120,
                      width: 120,
                    ),
                    Text("Laporan",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ]),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const RekapListNama();
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
                      "assets/rinse.png",
                      height: 120,
                      width: 120,
                    ),
                    Text("Rekap",
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

class AppBar extends StatefulWidget {
  const AppBar({Key? key}) : super(key: key);

  @override
  State<AppBar> createState() => _AppBarState();
}

class _AppBarState extends State<AppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 88, left: 20, right: 20),
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.shade600,
            Colors.blue.shade300,
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Hallo, Sastra\nSelamat Pagi',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontFamily: GoogleFonts.poppins().fontFamily)),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white30,
              borderRadius: BorderRadius.circular(30),
            ),
            child: IconButton(
              icon: Icon(Icons.qr_code_scanner_outlined),
              color: Colors.white,
              onPressed: () async {
                Map<Permission, PermissionStatus> statuses = await [
                  Permission.camera,
                  Permission.storage,
                ].request();
                if (statuses[Permission.camera]!.isPermanentlyDenied) {
                  Fluttertoast.showToast(
                      msg: "Aplikasi tidak dapat mengakses kamera",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  openAppSettings();
                }
                if (statuses[Permission.camera]!.isGranted) {
                  String? cameraScanResult = await scanner.scan();
                  if (cameraScanResult != null) {
                    var a = cameraScanResult;
                    ScanData.scan(a).then((hasil) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InfoBarang(data: hasil.data!),
                          ));
                    });
                  }
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
