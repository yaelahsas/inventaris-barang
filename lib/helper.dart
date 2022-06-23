import 'package:shared_preferences/shared_preferences.dart';

class Helper {
  __constructor() {
    SharedPreferences.setMockInitialValues({});
  }

  void addBoolToSF(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogin', value);
  }

  void addStringToSF(String nama, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(nama, value);
  }

  void addIntToSF(String nama, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(nama, value);
  }

  getStringValuesSF(String nama) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString(nama);
    return stringValue;
  }

  getBoolValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool
    bool? boolValue = prefs.getBool('isLogin');
    return boolValue;
  }

  getIntValuesSF(String nama) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return int
    int? intValue = prefs.getInt(nama);
    return intValue;
  }
}
