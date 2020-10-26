import 'dart:ui';


import 'package:arshney/dialogs/SignDialog.dart';
import 'package:arshney/helper/AppPreferences.dart';
import 'package:arshney/helper/Palette.dart';
import 'package:arshney/ui/home_screen.dart';
import 'package:arshney/ui/profile_details.dart';
import 'package:flutter/material.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';

import '../res.dart';


class OtpScreenPage extends StatefulWidget {
//  final String userOtp;
  final String userMobile;
//  final Map<String, dynamic> h;

  OtpScreenPage(/*this.h, this.userOtp,*/ this.userMobile);

  @override
  _OtpScreenPageState createState() => _OtpScreenPageState();
}

class _OtpScreenPageState extends State<OtpScreenPage> {
  final mobileController = TextEditingController();
  var otpPin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: primaryColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0, //No shadow
      ),
      body: SafeArea(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  Res.appicon,
                  height: 120,
                  width: 120,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "We have send 6 digit otp to",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
                    child: new Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                '+91-' + widget.userMobile,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () => {Navigator.of(context).pop()},
                              child: Text(
                                'edit',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: PinEntryTextField(
                            fields: 6,
                            onSubmit: (String pin) {
                              AppPreferences appPref=AppPreferences();
                              appPref.setBooleanValue("isLogin", true);

                              Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (context) => HomeScreen()),
                                      (Route<dynamic> route) => false);
                             /* otpPin = pin;
                              matchOtp(pin);*/
                            }, // end onSubmit
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                            child: FlatButton(
                              onPressed: () {},
                              child: Text(
                                'Resend OTP',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  color: primaryColor,
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

 /* void matchOtp(String pin) {
    if (pin == widget.userOtp) {
      saveInSharedPref(widget.h);
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) => SignDialog(
                firstTitle: "OTP did not match",
                buttonRight: 'Try again',
                image: const IconData(0xe5cd, fontFamily: 'MaterialIcons'),
                color: Colors.red,
              ));
    }
  }*/

  AppPreferences mAppPreferences = AppPreferences();

  void saveInSharedPref(message) {
    mAppPreferences.setStringValue(AppPreferences.ID, message['id']);
    mAppPreferences.setStringValue(AppPreferences.NAME, message['name']);
    mAppPreferences.setStringValue(AppPreferences.EMAIL_ID, message['email']);
    mAppPreferences.setStringValue(AppPreferences.CONTACT, message['contact']);
    mAppPreferences.setStringValue(AppPreferences.state, message['state']);
    mAppPreferences.setStringValue(AppPreferences.city, message['city']);
    mAppPreferences.setStringValue(AppPreferences.Pincode, message['pincode']);
    mAppPreferences.setStringValue(
        AppPreferences.PASSWORD, message['password']);
    mAppPreferences.setStringValue(AppPreferences.Address, message['address']);
    mAppPreferences.setStringValue(AppPreferences.date, message['date']);
    mAppPreferences.setStringValue(AppPreferences.IMAGE, message['image']);
    mAppPreferences.setBooleanValue(AppPreferences.IS_LOGIN, true);
    mAppPreferences.setBooleanValue(AppPreferences.REMEMBER_ME, true);
    mAppPreferences.setStringValue(AppPreferences.CONTACT, message['contact']);

    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => ProfileDetails("")),
        (Route<dynamic> route) => false);
  }
}
