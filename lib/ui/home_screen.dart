
import 'package:arshney/helper/Palette.dart';
import 'package:arshney/helper/route_constant.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
            child: Text(
              "Hello, Name",
              style: TextStyle(
                color: textColorWhite,
              ),
            ),
            alignment: Alignment.topLeft),
        actions: [
          IconButton(
              icon:  Icon(Icons.edit, color: iconColorWhite),
              onPressed: () =>  Navigator.pushNamed(context, profileDetails)
          ),
        ],


        backgroundColor: primaryColor,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(20),
        child:Column(children: [
          Padding(
              padding: const EdgeInsets.all( 15),
              child: ButtonTheme(
                minWidth: 300.0,
                height: 45.0,
                child: RaisedButton(
                  color: primaryColor,
                  onPressed: () {
                    Navigator.pushNamed(context, viewProfile);
                  },
                  child: Text(
                    'View Profile',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              )),
        ],)
      ),
    );
  }
}
