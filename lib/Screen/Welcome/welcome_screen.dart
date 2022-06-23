import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Dashboard/dashboard_affair.dart';
import '../Dashboard/dashboard_petugas.dart';
import 'componen/body.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  _isLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      bool? login = prefs.getBool('isLogin');
      int? role = prefs.getInt('idRole');
      if (login! && role == 3) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DashboarAffair(),
          ),
        );
      } else {
        if (login && role == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DashboardPetugas(),
            ),
          );
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _isLogin();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BodySignin(),
    );
  }
}
