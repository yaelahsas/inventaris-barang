import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inventaris_barang/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../Api/url.dart';

class LaporanGantiPdf extends StatefulWidget {
  const LaporanGantiPdf({Key? key}) : super(key: key);

  @override
  State<LaporanGantiPdf> createState() => _RekapPdfState();
}

class _RekapPdfState extends State<LaporanGantiPdf> {
  final ReceivePort _port = ReceivePort();

  @override
  initState() {
    super.initState();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      DownloadTaskStatus status = data[1];
      if (status == DownloadTaskStatus.complete) {
        Fluttertoast.showToast(
            msg: "Download Selesai",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (status == DownloadTaskStatus.failed) {
        Fluttertoast.showToast(
            msg: "Download Gagal",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    super.dispose();
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Laporan"),
          actions: [
            IconButton(
              color: kPrimaryLightColor,
              icon: const Icon(Icons.file_download),
              onPressed: () {
                // _downloadPdf();
              },
            ),
          ],
        ),
        body: Container(
          color: kPrimaryColor,
          child: SfPdfViewer.network(Url.laporan + "cetak_barang_ganti"),
        ));
  }

  // void _downloadPdf() async {
  // var status = await Permission.storage.status;
  // if (status.isGranted) {
  //   final baseDir = await getExternalStorageDirectory();
  //   final String url = Url.web + 'rekap/download/' + widget.idRekap;
  //   final String url2 = Url.web + 'rekap/excel/' + widget.idRekap;

  //   final taskId = await FlutterDownloader.enqueue(
  //     url: url,
  //     fileName: "Rekap.pdf",
  //     savedDir: baseDir!.path,
  //     showNotification: true,
  //     openFileFromNotification: true,
  //   );
  //   final taskId2 = await FlutterDownloader.enqueue(
  //     url: url2,
  //     fileName: "Rekap_excel.xlsx",
  //     savedDir: baseDir.path,
  //     showNotification: true,
  //     openFileFromNotification: true,
  //   );
  // } else {
  //   await Permission.storage.request();
  // }
  // }
}
