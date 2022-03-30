import 'package:flutter/material.dart';
import 'package:inventaris_barang/Api/login_api.dart';
import 'package:inventaris_barang/Screen/Signup/signup_screen.dart';
import 'package:inventaris_barang/constants.dart';

class BodySignin extends StatefulWidget {
  const BodySignin({Key? key}) : super(key: key);

  @override
  State<BodySignin> createState() => _BodySigninState();
}

class _BodySigninState extends State<BodySignin> {
  LoginResult? result;
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
                "LOGIN",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
              child: TextField(
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
                autofocus: true,
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
              alignment: Alignment.bottomRight,
              margin: const EdgeInsets.only(right: 20),
              child: const Text(
                "Forgot Password?",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                child: const Text("Masuk"),
                onPressed: () {
                  LoginResult.connectToAPI("eve.holt@reqres.in", "cityslicka")
                      .then((value) {
                    result = value;
                    setState(() {});
                  });
                },
                style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    textStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold)),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text((result != null)
                  ? "Token = " + result!.token
                  : "Tidak Ada Data"),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                child: const Text("Daftar"),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SignUp()));
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
