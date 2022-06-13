import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inventaris_barang/Api/scan.dart';

import 'package:inventaris_barang/Screen/Dashboard/componen/body_petugas.dart';
import 'package:inventaris_barang/Screen/Dashboard/info_barang.dart';
import 'package:inventaris_barang/Screen/Welcome/welcome_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;

import '../../Api/list_barang.dart';

class DashboarPetugas extends StatelessWidget {
  const DashboarPetugas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Petugas'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.qr_code,
              color: Colors.white,
            ),
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
          IconButton(
              icon: const Icon(
                Icons.logout_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: ((context) => WelcomeScreen())));
              }),
        ],
      ),
      body: const BodyPetugas(),
    );
  }
}
