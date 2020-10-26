import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static final String IS_LOGIN = "IS_LOGIN";
  static final String PASSWORD = "PASSWORD";
  static final String EMAIL_ID = "EMAIL_ID";
  static final String REMEMBER_ME = "REMEMBER_ME";
  static final String Address = "address";
  static final String Pincode = "pincode";
  static final String state = "state";
  static final String city = "city";
  static final String date = "date";
  static final String ID = "ID";
  static final String NAME = "NAME";
  static final String IMAGE = "image";
  static final String CONTACT = "CONTACT";
  static final String EMAIL = "EMAIL_ID";
  static final String ReferralCode = "ReferralCode";

  final String ACCESS_TOKEN = "ACCESS_TOKEN";

  Future<void> setAuthToken(String auth_token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(this.ACCESS_TOKEN, auth_token);
  }

  Future<bool> getBooleanValue(String key) async {
    bool value1;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(key)) {
      value1 = prefs.getBool(key);
    } else {
      value1 = false;
    }
    return value1;
  }

  Future<String> getAuthToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String auth_token;
    auth_token = pref.getString(this.ACCESS_TOKEN) ?? null;
    return auth_token;
  }

  Future<String> getStringValue(String key) async {
    String returnString;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    returnString = prefs.getString(key);
    return returnString;
  }

  Future<void> setStringValue(String Key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(Key, value);
  }

  Future<void> setBooleanValue(String Key, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(Key, value);
  }
}
