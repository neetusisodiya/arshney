import 'package:arshney/helper/Palette.dart';
import 'package:arshney/language/app_translations.dart';
import 'package:arshney/language/app_translations_delegate.dart';
import 'package:arshney/language/application.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';

import '../res.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final mobileController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,backgroundColor: Colors.white,

      body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 100,
              ),
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
                   AppTranslations.of(context).text("title_select_language"),
               /* "Login",*/
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Enter your mobile number\nWe will send you otp to verify',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: textColorGrey, fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
                child: new Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all( 15),
                      child: Container(
                        height: 45,
                        child: TextFormField(
                          controller: mobileController,
                          decoration: const InputDecoration(
                            contentPadding:
                            EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                            hintText: 'Mobile Number',
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(16, 230, 187, 10)),
                            ),
                            hintStyle: TextStyle(color: Colors.black54),
                          ),
                          style: TextStyle(color: Colors.black54),
                          maxLength: 10,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all( 15),
                        child: ButtonTheme(
                          minWidth: 300.0,
                          height: 45.0,
                          child: RaisedButton(
                            color: primaryColor,
                            onPressed: () {
                              String mobile = mobileController.text.toString();
                              if (mobile.isNotEmpty) {
                                if (mobile.length != 10) {
                                  final snackBar = SnackBar(
                                      content:
                                      Text('Mobile number must be 10 digits'));
                                  _scaffoldKey.currentState.showSnackBar(snackBar);
                                } else {
                                  sendOTP(mobile);
                                }
                              } else {
                                final snackBar =
                                SnackBar(content: Text("Enter Phone Number"));
                                _scaffoldKey.currentState.showSnackBar(snackBar);
                              }
                            },
                            child: Text(
                              'Continue',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Future sendOTP(String mobile) async {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => OtpScreenPage(/*rest, rest['otp'],*/ mobile)),
    );
    bool result = await DataConnectionChecker().hasConnection;
/*
    if (result == true) {
      CustomProgress.showProgress(context);
      var data = {
        'mobile_no': mobile,
      };
      var requestFromServer =
      await http.post(Network.forgetPasswordAPI, body: data);
      var jsonData = jsonDecode(requestFromServer.body);
      var message = jsonData['status'];
      if (message == "true") {
        var rest = jsonData['data'];
        print(rest['otp']);

        CustomProgress.showProgress(context);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OtpScreenPage(rest, rest['otp'], mobile)),
        );
      }
    } else {
      showAlertDialog(context, mobile);
    }
*/
  }

  showAlertDialog(BuildContext context, String mobile) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("Retry"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
        if (mobile != null) {
          sendOTP(mobile);
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Oops!!"),
      content: Text("You don't have an active internet connection"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
