import 'package:flutter/material.dart';
import 'package:inventaris_barang/Api/list_data.dart';
import 'package:inventaris_barang/Screen/Barang%20Masuk/componen/app_bar.dart';
import 'package:inventaris_barang/constants.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';

class TambahBarangMasuk extends StatefulWidget {
  const TambahBarangMasuk({Key? key, required this.data}) : super(key: key);

  final ListData data;

  @override
  State<TambahBarangMasuk> createState() => _TambahBarangMasukState();
}

class _TambahBarangMasukState extends State<TambahBarangMasuk> {
  DateTime time = DateTime.now();
  TextEditingController _cName = TextEditingController();
  TextEditingController _cId = TextEditingController();

  @override
  void initState() {
    super.initState();
    print(widget.data.name);

    _cId.text = widget.data.id.toString();
    _cName.text = widget.data.name;
  }

  @override
  void dispose() {
    super.dispose();
    _cId.dispose();
    _cName.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarBarang(judul: "Tambah Barang Masuk"),
      body: Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          height: MediaQuery.of(context).size.height,
          child: Form(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _cId,
                readOnly: true,
                decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.greenAccent, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1.0),
                    ),
                    hintText: 'id',
                    labelText: 'id'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _cName,
                readOnly: true,
                decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.greenAccent, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1.0),
                    ),
                    hintText: 'Name',
                    labelText: 'Name'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(),
              const SizedBox(
                height: 10,
              ),
              TextFormField(),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: kPrimaryColor,
                      textStyle: const TextStyle(fontSize: 20)),
                  onPressed: () {
                    print(widget.data.id);
                  },
                  child: const Text("Tambah"),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
