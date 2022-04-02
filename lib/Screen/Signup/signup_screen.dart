import 'package:flutter/material.dart';
import 'package:inventaris_barang/Screen/Signup/componen/body.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BodySignup(),
    );
  }
}
