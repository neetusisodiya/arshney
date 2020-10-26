import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:arshney/helper/AppPreferences.dart';
import 'package:arshney/helper/Network.dart';
import 'package:arshney/res.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ViewDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: "Personal"),
                Tab(text: "Family"),
              ],
            ),
            title: Text('Mr. Ramesh  Varshney'),
          ),
          body: TabBarView(
            children: [
              ViewProfile(),
              ViewParents(),
            ],
          ),
        ),
      ),
    );
  }
}

class ViewProfile extends StatefulWidget {
  @override
  _ViewProfileState createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  var userId,
      tvAddress = 'Address',
      tvName = "Name",
      tvState = 'State',
      tvCity = 'City',
      tvReferralCode = "Referral Code",
      tvPinCode = 'Pin Code',
      tvMobile = "Mobile";
  var userDp = 'default.png';

  SharedPreferences sharedPreferences;
  AppPreferences mAppPreferences = AppPreferences();

  @override
  void initState() {
    super.initState();
    // getUser();
  }

  getUser() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userDp = sharedPreferences.getString(AppPreferences.IMAGE);
      userId = sharedPreferences.getString(AppPreferences.ID);
      tvName = sharedPreferences.getString(AppPreferences.NAME);
      tvState = sharedPreferences.getString(AppPreferences.state);
      tvCity = sharedPreferences.getString(AppPreferences.city);
      tvPinCode = sharedPreferences.getString(AppPreferences.Pincode);
      tvMobile = sharedPreferences.getString(AppPreferences.CONTACT);
      tvAddress = sharedPreferences.getString(AppPreferences.Address);
    });
  }

  Future<void> setUser(context) async {
    Future<String> id = mAppPreferences.getStringValue(AppPreferences.ID);
    id.then((data) async {
      userId = data;
      var response =
          await http.post(Network.getUserProfile, body: {'user_id': userId});
      var message = jsonDecode(response.body);
      var userData = message["data"];
      String status = message['status'];
      if (status == 'true') {
        mAppPreferences.setStringValue(AppPreferences.NAME, userData['name']);
        mAppPreferences.setStringValue(
            AppPreferences.EMAIL_ID, userData['email']);
        mAppPreferences.setStringValue(
            AppPreferences.CONTACT, userData['contact']);
        mAppPreferences.setStringValue(AppPreferences.state, userData['state']);
        mAppPreferences.setStringValue(AppPreferences.city, userData['city']);
        mAppPreferences.setStringValue(
            AppPreferences.Pincode, userData['pincode']);
        mAppPreferences.setStringValue(
            AppPreferences.Address, userData['address']);
        mAppPreferences.setStringValue(
            AppPreferences.ReferralCode, userData['ref_code']);
        mAppPreferences.setStringValue(AppPreferences.IMAGE, userData['image']);
        Fluttertoast.showToast(msg: "Profile update successfully");
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: "Something went wrong");
      }
    }, onError: (e) {
      print(e);
    });
  }

  File _image;

  final startColor = Color(0xFFaa7ce4);
  final endColor = Color(0xFFe46792);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 15),
                child: new Column(children: <Widget>[
                  Align(
                    child: Container(
                        width: 130.0,
                        height: 130.0,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: _image == null
                                  ? new NetworkImage(
                                      Network.profileImagesUrl + userDp)
                                  : FileImage(_image),
                            ))),
                    alignment: Alignment.center,
                  ),
                  Divider(
                    height: 10,
                    indent: 13,
                  ),
                  Text(
                    "Name",
                    style: TextStyle(color: Colors.black54, fontSize: 20),
                  ),
                  Divider(
                    height: 10,
                    indent: 13,
                  ),
                  Text(
                    "Aadhar Card Number",
                    style: TextStyle(color: Colors.black54, fontSize: 20),
                  ),
                  Divider(
                    height: 10,
                    indent: 13,
                  ),
                  Text(
                    "Job Description",
                    style: TextStyle(color: Colors.black54, fontSize: 20),
                  ),
                  Divider(
                    height: 10,
                    indent: 13,
                  ),
                  Text(
                    "Male",
                    style: TextStyle(color: Colors.black54, fontSize: 20),
                  ),
                  Divider(
                    height: 10,
                    indent: 13,
                  ),
                  Text(
                    "Birth Place: Jaipur",
                    style: TextStyle(color: Colors.black54, fontSize: 20),
                  ),
                  Divider(
                    height: 10,
                    indent: 13,
                  ),
                  Text(
                    "Date Of Birth: 01/01/1995",
                    style: TextStyle(color: Colors.black54, fontSize: 20),
                  ),
                  Divider(
                    height: 10,
                    indent: 13,
                  ),
                  Text(
                    "Email",
                    style: TextStyle(color: Colors.black54, fontSize: 20),
                  ),
                  Divider(
                    height: 10,
                    indent: 13,
                  ),
                  Text(
                    "Mobile",
                    style: TextStyle(color: Colors.black54, fontSize: 20),
                  ),
                  Divider(
                    height: 10,
                    indent: 13,
                  ),
                  Text(
                    "Education",
                    style: TextStyle(color: Colors.black54, fontSize: 20),
                  ),
                  Divider(
                    height: 10,
                    indent: 13,
                  ),
                  Text(
                    "Blood Group",
                    style: TextStyle(color: Colors.black54, fontSize: 20),
                  ),
                  Divider(
                    height: 10,
                    indent: 13,
                  ),
                  Text(
                    "Current City",
                    style: TextStyle(color: Colors.black54, fontSize: 20),
                  ),
                  Divider(
                    height: 10,
                    indent: 13,
                  ),
                ]),
              ),
            )));
  }
}

class ViewParents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 15),
            child: new Column(children: <Widget>[
              Text(
                "Father Name",
                style: TextStyle(color: Colors.black54, fontSize: 20),
              ),
              Divider(
                height: 10,
                indent: 13,
              ),
              Text(
                "Mother Name",
                style: TextStyle(color: Colors.black54, fontSize: 20),
              ),
              Divider(
                height: 10,
                indent: 13,
              ),
              Text(
                "Children: 3",
                style: TextStyle(color: Colors.black54, fontSize: 20),
              ),
              Divider(
                height: 10,
                indent: 13,
              ),
              Text(
                "Brother 3",
                style: TextStyle(color: Colors.black54, fontSize: 20),
              ),
              Divider(
                height: 10,
                indent: 13,
              ),
              Text(
                "Grand Mother: Rukhman",
                style: TextStyle(color: Colors.black54, fontSize: 20),
              ),
              Divider(
                height: 10,
                indent: 13,
              ),
              Text(
                "Grandfather: Mahndar",
                style: TextStyle(color: Colors.black54, fontSize: 20),
              ),
              Divider(
                height: 10,
                indent: 13,
              ),
            ]),
          ),
        ));
  }
}

class HomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> with TickerProviderStateMixin {
  double screenSize;
  double screenRatio;
  AppBar appBar;
  List<Tab> tabList = List();
  TabController _tabController;

  @override
  void initState() {
    tabList.add(new Tab(
      text: 'Personal',
    ));
    tabList.add(new Tab(
      text: 'Family',
    ));
    _tabController = new TabController(vsync: this, length: tabList.length);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size.width;
    appBar = AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBar,
        body: Stack(
          children: <Widget>[
            new Positioned(
              child: Column(
                children: <Widget>[
                  Center(
                    child: Container(
                      child: CircleAvatar(
                        backgroundImage: new AssetImage(Res.boy),
                        backgroundColor: Colors.green,
                        radius: 100,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Text(
                            "Ranking: 8/10",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.pink),
                          ),
                          new Text('Mr. Ramesh Varshney ',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 18.0)),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.center,
                      ),
                    ),
                  ),
                ],
              ),
              width: screenSize,
              top: 20,
            ),
            new Positioned(
              width: screenSize,
              top: 280,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: new Column(
                  children: <Widget>[
                    new Container(
                      decoration: new BoxDecoration(
                          color: Theme.of(context).primaryColor),
                      child: new TabBar(
                          labelColor: Colors.white,
                          controller: _tabController,
                          indicatorColor: Colors.blueAccent,
                          indicatorSize: TabBarIndicatorSize.tab,
                          unselectedLabelColor: Colors.white,
                          tabs: tabList),
                    ),
                    new Container(
                      height: 20.0,
                      child: new TabBarView(
                          controller: _tabController,
                          children: [ViewParents(), ViewParents()]
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
