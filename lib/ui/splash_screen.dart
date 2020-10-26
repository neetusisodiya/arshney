import 'dart:async';

import 'package:arshney/helper/AppPreferences.dart';
import 'package:arshney/helper/route_constant.dart';
import 'package:arshney/language/application.dart';
import 'package:flutter/material.dart';

import '../res.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    mAppPreferences
        .getBooleanValue("isLogin")
        .then((value) =>

        getLogin(value)
    );
  }

  AppPreferences mAppPreferences = AppPreferences();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.all(50),
            child: new Image.asset(Res.appicon),
          )),
    );
  }

  void getLogin( bool isLogin) {
    mAppPreferences.getStringValue("language").then((value) {
      String lang=value;

      print(lang.toString());
      print(isLogin);
      if (lang != null) {
        application.onLocaleChanged(Locale(lang));
        if (isLogin != null) {
          //  Navigator.pushNamedAndRemoveUntil(context, signIn, (route) => false);

          Navigator.of(context)
              .pushNamedAndRemoveUntil(signIn, (Route<dynamic> route) => false);
        } else {
          // Navigator.pushNamedAndRemoveUntil(context, langScreen, (route) => false);
          Navigator.of(context).pushNamedAndRemoveUntil(
              langScreen, (Route<dynamic> route) => false);
        }
      } else {
        //  Navigator.pushNamedAndRemoveUntil(context, langScreen, (route) => false);
        Navigator.of(context).pushNamedAndRemoveUntil(
            langScreen, (Route<dynamic> route) => false);
      }
    });

  }

}
