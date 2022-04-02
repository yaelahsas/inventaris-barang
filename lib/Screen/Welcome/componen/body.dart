import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inventaris_barang/Api/login.dart';
import 'package:inventaris_barang/Screen/Dashboard/dashboard_affair.dart';
import 'package:inventaris_barang/Screen/Signup/signup_screen.dart';
import 'package:inventaris_barang/constants.dart';

class BodySignin extends StatefulWidget {
  const BodySignin({Key? key}) : super(key: key);

  @override
  State<BodySignin> createState() => _BodySigninState();
}

class _BodySigninState extends State<BodySignin> {
  AuthApi? result;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

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
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
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
                    margin:
                        const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                    child: TextField(
                      controller: _emailController,
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
                    margin:
                        const EdgeInsets.only(bottom: 15, left: 20, right: 20),
                    child: TextField(
                      controller: _passwordController,
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
                        setState(() {
                          isLoading = true;
                        });
                        AuthApi.loginAPI(
                                _emailController.text, _passwordController.text)
                            .then((value) {
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
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const DashboarAffair()));
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
                          setState(() {
                            isLoading = false;
                          });
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
                    padding: const EdgeInsets.only(top: 20),
                    child: const Text("Atau"),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      child: const Text("Daftar"),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUp()));
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
