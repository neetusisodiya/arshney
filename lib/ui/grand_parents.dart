import 'package:arshney/helper/Palette.dart';
import 'package:arshney/ui/profile_details.dart';
import 'package:flutter/material.dart';

class GrandParentsScreen extends StatefulWidget {

  @override
  _GrandParentsScreenState createState() => _GrandParentsScreenState();
}

class _GrandParentsScreenState extends State<GrandParentsScreen> {  var fatherResult="Grand Father Name";
var motherResult= "Grand Mother Name";
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Align(
            child: Text(
            "Grand Parents Details" ,
              style: TextStyle(
                color: textColorWhite,
              ),
            ),
            alignment: Alignment.topLeft),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: iconColorWhite),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: primaryColor,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(20),
        child:SingleChildScrollView(
          child: Column(children: <Widget>[
            GestureDetector(
              child:    Text(
                motherResult,

                style: TextStyle(color: Colors.black54, fontSize: 15),

              ),
              onTap: () async {
                var   motherResult2 = await Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (BuildContext context) =>
                      new ProfileDetails("Grand Mother"),
                      fullscreenDialog: true,
                    ));
                setState(() {
                  motherResult=motherResult2;
                });

              },
            ),

            Divider(
              height: 15,
            ),
            GestureDetector(
              child:  Text(
                fatherResult,
                style: TextStyle(color: Colors.black54, fontSize: 15),

              ),
              onTap: () async {
                var   fatherResult2= await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                      new ProfileDetails("Grand Father"),
                    ));
                setState(() {
                  fatherResult=fatherResult2;
                });
              },
            ),
            Divider(
              height: 15,
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: ButtonTheme(
                  minWidth: 250.0,
                  height: 45.0,
                  child: RaisedButton(
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                            new GrandParentsScreen(),
                          ));
                      /*  if (_formKey.currentState.validate()) {
                                  checkForInternet(context);
                                }*/
                      //    Navigator.pushNamed(context, parentsScreens);
                    },
                    color: primaryColor,
                    child: Text(
                      'Add Address',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  )),
            ),
          ]),
        ),),
    );
  }
}
