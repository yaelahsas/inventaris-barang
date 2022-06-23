import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventaris_barang/Api/scan.dart';

import 'package:inventaris_barang/Screen/Dashboard/componen/body_petugas.dart';
import 'package:inventaris_barang/Screen/Dashboard/info_barang.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPetugas extends StatelessWidget {
  const DashboardPetugas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [AppBar(), BodyPetugas()],
            ),
          ),
        ),
      ),
    );
  }
}

class AppBar extends StatefulWidget {
  const AppBar({Key? key}) : super(key: key);

  @override
  State<AppBar> createState() => _AppBarState();
}

class _AppBarState extends State<AppBar> {
  void _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nama = prefs.getString('nama')!;
      username = prefs.getString('username')!;
    });
  }

  late String nama, username;

  @override
  void initState() {
    super.initState();
    nama = "";
    username = "";
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 48, left: 20, right: 20),
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: 58,
                  width: 58,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: Image.asset('assets/logo.png')),
              SizedBox(width: 10),
              // InkWell(
              //   onTap: () {
              //     Navigator.push(context, MaterialPageRoute(builder: (context) {
              //       return WelcomeScreen();
              //     }));
              //   },
              //   child: Text(
              //     "PT. Sumber Alam Santoso Pratama",
              //     style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
              //   ),
              // )
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: (() {}),
                child: Text('Hallo, ' + nama + '\nSelamat Pagi',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: GoogleFonts.poppins().fontFamily)),
              ),
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
                                builder: (context) =>
                                    InfoBarang(data: hasil.data!),
                              ));
                        });
                      }
                    }
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
