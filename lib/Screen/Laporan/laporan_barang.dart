import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inventaris_barang/Api/url.dart';
import 'package:inventaris_barang/constants.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

class LaporanBarang extends StatefulWidget {
  const LaporanBarang({Key? key}) : super(key: key);

  @override
  State<LaporanBarang> createState() => _LaporanBarangState();
}

class _LaporanBarangState extends State<LaporanBarang> {
  ReceivePort _port = ReceivePort();
  _aw() async {}
  @override
  initState() {
    super.initState();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
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
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        // dispose();
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Laporan"),
          actions: [
            IconButton(
              color: kPrimaryLightColor,
              icon: Icon(Icons.file_download),
              onPressed: () {
                _downloadPdf();
              },
            ),
          ],
        ),
        body: Container(
            color: kPrimaryColor,
            child: SfPdfViewer.network(Url.web + 'laporan')),
      ),
    );
  }

  void _downloadPdf() async {
    var status = await Permission.storage.status;
    if (status.isGranted) {
      final baseDir = await getExternalStorageDirectory();
      final String url = Url.web + 'laporan/download';
      final taskId = await FlutterDownloader.enqueue(
        url: url,
        fileName: "Laporan.pdf",
        savedDir: baseDir!.path,
        showNotification: true,
        openFileFromNotification: true,
      );
    }
  }
}
