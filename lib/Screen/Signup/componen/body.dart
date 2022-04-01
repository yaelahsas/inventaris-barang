import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inventaris_barang/Api/login.dart';

import '../../../constants.dart';

class BodySignup extends StatefulWidget {
  const BodySignup({Key? key}) : super(key: key);

  @override
  State<BodySignup> createState() => _BodySignupState();
}

class _BodySignupState extends State<BodySignup> {
  TextEditingController _cNama = TextEditingController();
  TextEditingController _cUsername = TextEditingController();
  TextEditingController _cPassword = TextEditingController();
  AuthApi? result;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
            Color.fromARGB(255, 228, 203, 187),
            Colors.white
          ])),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: const Text(
                "Daftar",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
              child: TextField(
                controller: _cNama,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  labelText: "Nama",
                  prefixIconColor: Colors.red,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
              child: TextField(
                controller: _cUsername,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  labelText: "Username",
                  prefixIconColor: Colors.red,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 15, left: 20, right: 20),
              child: TextField(
                controller: _cPassword,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.password),
                  labelText: "Password",
                  prefixIconColor: Colors.red,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                child: const Text("Daftar"),
                onPressed: () {
                  AuthApi.daftarAPI(
                          _cUsername.text, _cPassword.text, _cNama.text)
                      .then(
                    (value) {
                      result = value;
                      if (result?.success == true) {
                        Fluttertoast.showToast(
                            msg: result!.message!,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: kPrimaryColor,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             const DashboarAffair()));
                      } else {
                        Fluttertoast.showToast(
                            msg: result!.message!,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    textStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
