import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:arshney/helper/AppPreferences.dart';
import 'package:arshney/helper/Network.dart';
import 'package:arshney/helper/Palette.dart';
import 'package:arshney/helper/route_constant.dart';
import 'package:arshney/res.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gender_selection/gender_selection.dart';
import 'package:group_button/group_button.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

const balbirGradient = LinearGradient(
    colors: [const Color(0xFFFF5F6d), const Color(0xFFFFC371)],
    tileMode: TileMode.clamp,
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    stops: [0.0, 1.0]);

class ProfileDetails extends StatefulWidget {
  final String name;

  ProfileDetails(this.name);

  @override
  _ProfileDetailsState createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  var userId,
      tvAddress = 'Address',
      tvName = "Name",
      tvState = 'State',
      tvCity = 'City',
      tvReferralCode = "Referral Code",
      tvPinCode = 'Pin Code',
      tvMobile = "Mobile";
  var userDp = 'default.png';
  TextEditingController nameController = TextEditingController();
  TextEditingController aadharController = TextEditingController();
  TextEditingController jobController = TextEditingController();

  final mobileController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final pincodeController = TextEditingController();
  final stateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final spouseController = TextEditingController();

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
      nameController.text = tvName;
      stateController.text = tvState;
      cityController.text = tvCity;
      pincodeController.text = tvPinCode;
      mobileController.text = tvMobile;
      addressController.text = tvAddress;
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

  Future<void> updateUser(BuildContext context) async {
    var name = nameController.text.toString();
    var pinCode = pincodeController.text.toString();
    var address = addressController.text.toString();
    var city = cityController.text.toString();
    var mobile = mobileController.text.toString();
    var state = stateController.text.toString();
    var data = {
      'name': name,
      'contact': mobile,
      'state': state,
      'city': city,
      'pincode': pinCode,
      'address': address,
      'id': userId,
      'prevFile': userDp
    };
    var response = await http.post(Network.updateProfileUrl, body: data);
    var message = jsonDecode(response.body);
    String status = message['status'];
    if (status == 'true') {
      setUser(context);
    } else {
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }

  File _image;
  final picker = ImagePicker();

  Future imageSelectorGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  Future imageSelectorCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  Education selectedEdu;
  Profession selectedProfession;
  List<Education> education = <Education>[
    Education('10th'),
    Education('12th'),
    Education('Graduation'),
    Education('Post Graduation')
  ];
  Income selectedIncome;
  List<Income> income = <Income>[
    Income('10000-20000'),
    Income('20000-30000'),
    Income('30000-40000'),
  ];
  List<Profession> profession = <Profession>[
    Profession('Student'),
    Profession('Private Job'),
    Profession('Govt. Job'),
    Profession('Business')
  ];

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Align(
            child: Text(
              widget.name == ""
                  ? "Enter Your Details"
                  : "Enter ${widget.name} Details",
              style: TextStyle(
                color: textColorWhite,
              ),
            ),
            alignment: Alignment.topLeft),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: iconColorWhite),
          onPressed: () =>  Navigator.pushNamed(context, viewProfile)
        ),

        backgroundColor: primaryColor,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 15),
              child: new Column(children: <Widget>[
                GestureDetector(
                  onTap: () => {dialogForImagePicker(context)},
                  child: Stack(
                    children: <Widget>[
                      new Container(
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
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: TextFormField(
                    controller: nameController,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                    keyboardType: TextInputType.text,
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Name can't' be empty";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: TextFormField(
                    controller: aadharController,
                    decoration: const InputDecoration(
                      labelText: 'Aadhar Card',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                    keyboardType: TextInputType.number,
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Aadhar can't' be empty";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                  child: dateWidget(context),
                ),
                Text("Select  your gender"),
                Divider(
                  height: 10,
                ),
                GroupButton(
                  isRadio: true,
                  spacing: 10,
                  onSelected: (index, isSelected) =>
                      print('$index button is selected'),
                  buttons: ["Male", "Female", "Others"],
                ),
                Divider(
                  height: 10,
                ),
                Text("Select  Your Marital Status"),
                Divider(
                  height: 10,
                ),
                GroupButton(
                  isRadio: true,
                  spacing: 10,
                  onSelected: (index, isSelected) =>
                      print('$index button is selected'),
                  buttons: ["Unmarried", "Married", "Widow", "Divorced"],
                ),
                GenderSelection(
                  size: 50,
                  maleImage: AssetImage(Res.boy),
                  femaleImage: AssetImage(Res.girl),
                  selectedGenderIconBackgroundColor: Colors.green,
                  selectedGenderIconColor: Colors.white,
                  linearGradient: balbirGradient,
                  onChanged: (Gender gender) {
                    print(gender.index);
                  },
                ),
                GenderSelection(
                  size: 50,
                  maleText: "Single",
                  femaleText: "Married",
                  maleImage: AssetImage(Res.stickman),
                  femaleImage: AssetImage(Res.couple),
                  selectedGenderIconBackgroundColor: Colors.green,
                  selectedGenderIconColor: Colors.white,
                  linearGradient: balbirGradient,
                  animationDuration: Duration(milliseconds: 400),
                  onChanged: (Gender gender) {
                    print(gender);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: TextFormField(
                    controller: spouseController,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      labelText: 'Spouse',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                    keyboardType: TextInputType.text,
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Name can't' be empty";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Divider(
                  height: 10,
                ),
                Container(
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          width: 1.0,
                          color: Colors.lightBlue,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                  width: double.infinity,
                  child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<Education>(
                              hint: Text("Select your highest education"),
                              value: selectedEdu,
                              items: education.map((Education user) {
                                return new DropdownMenuItem<Education>(
                                  value: user,
                                  child: new Text(user.name),
                                );
                              }).toList(),
                              onChanged: (Education newValue) => setState(() {
                                    selectedEdu = newValue;
                                  })))),
                ),
                Divider(
                  height: 15,
                ),
                Container(
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          width: 1.0,
                          color: Colors.lightBlue,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                  width: double.infinity,
                  child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<Profession>(
                              hint: Text("Select your Profession"),
                              value: selectedProfession,
                              items: profession.map((Profession user) {
                                return new DropdownMenuItem<Profession>(
                                  value: user,
                                  child: new Text(user.name),
                                );
                              }).toList(),
                              onChanged: (Profession newValue) => setState(() {
                                    selectedProfession = newValue;
                                  })))),
                ),
                Divider(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: TextFormField(
                    controller: jobController,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      labelText: 'Job Description',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                    keyboardType: TextInputType.text,
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Job Description can't' be empty";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Divider(
                  height: 10,
                ),
                Container(
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          width: 1.0,
                          color: Colors.lightBlue,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                  width: double.infinity,
                  child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<Income>(
                              hint: Text("Family Income"),
                              value: selectedIncome,
                              items: income.map((Income user) {
                                return new DropdownMenuItem<Income>(
                                  value: user,
                                  child: new Text(user.name),
                                );
                              }).toList(),
                              onChanged: (Income newValue) => setState(() {
                                    selectedIncome = newValue;
                                  })))),
                ),
                Divider(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: FocusScope(
                    node: new FocusScopeNode(
                      canRequestFocus: false,
                    ),
                    child: TextFormField(
                      controller: mobileController,
                      style: theme.textTheme.subtitle1.copyWith(
                        color: theme.disabledColor,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Mobile Number',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: 10,
                ),
                Text(
                  "Address",
                  style: TextStyle(color: Colors.black54, fontSize: 16),
                ),
                addressWidget(),
                Divider(
                  height: 20,
                ),
                Text(
                  "Ancestral place",
                  style: TextStyle(color: Colors.black54, fontSize: 16),
                ),
                addressWidget(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: ButtonTheme(
                      minWidth: 250.0,
                      height: 45.0,
                      child: RaisedButton(
                        onPressed: () async {
                          /*  if (_formKey.currentState.validate()) {
                                  checkForInternet(context);
                                }*/
                          if (widget.name == "") {
                            Navigator.pushNamed(context, parentsScreens);
                          } else {
                            Navigator.pop(
                                context, nameController.text.toString().trim());
                          }
                          /* var result = await Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new ParentsScreen(),
                                    fullscreenDialog: true,
                                  ));
                              print(result);*/
                        },
                        color: primaryColor,
                        child: Text(
                          'Continue',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      )),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  addressWidget() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: TextFormField(
              controller: addressController,
              decoration: const InputDecoration(
                labelText: "Street/House/Apartment",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
              ),
              style: TextStyle(color: Colors.black54, fontSize: 15),
              keyboardType: TextInputType.text),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: TextFormField(
              controller: addressController,
              decoration: const InputDecoration(
                labelText: "Landmark",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
              ),
              style: TextStyle(color: Colors.black54, fontSize: 15),
              keyboardType: TextInputType.text),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: TextFormField(
              controller: pincodeController,
              decoration: const InputDecoration(
                labelText: "Pin Code",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
              ),
              style: TextStyle(color: Colors.black54, fontSize: 15),
              keyboardType: TextInputType.text),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: TextFormField(
              controller: cityController,
              decoration: const InputDecoration(
                labelText: "City",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
              ),
              style: TextStyle(color: Colors.black54, fontSize: 15),
              keyboardType: TextInputType.text),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: TextFormField(
              controller: stateController,
              decoration: const InputDecoration(
                labelText: "State",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
              ),
              style: TextStyle(color: Colors.black54, fontSize: 15),
              keyboardType: TextInputType.text),
        ),
      ],
    );
  }

  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  selectDate(BuildContext context, DateTime initialDateTime,
      {DateTime lastDate}) async {
    Completer completer = Completer();
    String _selectedDateInString;
    if (Platform.isAndroid)
      showDatePicker(
              context: context,
              initialDate: initialDateTime,
              firstDate: DateTime(1970),
              lastDate: lastDate == null
                  ? DateTime(initialDateTime.year + 10)
                  : lastDate)
          .then((temp) {
        if (temp == null) return null;
        completer.complete(temp);
        setState(() {});
      });
    else
      DatePicker.showDatePicker(
        context,
        dateFormat: 'yyyy-mmm-dd',
        locale: 'en',
        onConfirm2: (temp, selectedIndex) {
          if (temp == null) return null;
          completer.complete(temp);

          setState(() {});
        },
      );
    return completer.future;
  }

  upload(File imageFile, BuildContext context) async {
    var name = nameController.text.toString();
    var pinCode = pincodeController.text.toString();
    var address = addressController.text.toString();
    var city = cityController.text.toString();
    var mobile = mobileController.text.toString();
    var state = stateController.text.toString();
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse(Network.updateProfileUrl);
    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('logo', stream, length,
        filename: basename(imageFile.path));
    request.files.add(multipartFile);
    request.fields['name'] = name;
    request.fields['pincode'] = pinCode;
    request.fields['address'] = address;
    request.fields['city'] = city;
    request.fields['contact'] = mobile;
    request.fields['state'] = state;
    request.fields['id'] = userId;

    var response = await request.send();
    response.stream.transform(utf8.decoder).listen((value) {
      var message = jsonDecode(value);
      String status = message['status'];
      if (status == 'true') {
        setUser(context);
      } else {
        Fluttertoast.showToast(msg: "Something went wrong");
      }
    });
  }

  Future<void> checkForInternet(BuildContext context) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        if (_image != null) {
          upload(_image, context);
        } else {
          updateUser(context);
        }
      }
    } on SocketException catch (_) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("Failed to login!"),
              content: new Text(
                  "It\u0027s look like you don\u0027t have an active internet connection"),
              actions: <Widget>[
                new FlatButton(
                  child: new Text("Close"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }
  }

  dialogForImagePicker(context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Choose From"),
            actions: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FlatButton(
                      onPressed: () {
                        imageSelectorCamera();
                        Navigator.of(context, rootNavigator: true)
                            .pop('dialog');
                      },
                      child: Text("Camera",
                          style: TextStyle(
                              fontSize: 18, color: Colors.indigoAccent)),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FlatButton(
                      onPressed: () {
                        imageSelectorGallery();
                        Navigator.of(context, rootNavigator: true)
                            .pop('dialog');
                      },
                      child: Text("Gallery",
                          style: TextStyle(
                              fontSize: 18, color: Colors.indigoAccent)),
                    ),
                  ),
                ],
              )
            ],
          );
        });
  }

  String birthDate = "";
  int age = -1;
  TextStyle valueTextStyle = TextStyle(
    fontSize: 16,
  );
  TextStyle textTextStyle = TextStyle(
    fontSize: 16,
  );
  TextStyle buttonTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 16,
  );

  dateWidget(context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          (age > -1)
              ? Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "BirthDate: ",
                            style: textTextStyle,
                          ),
                          Text(
                            "$birthDate",
                            style: valueTextStyle,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Age: ",
                            style: textTextStyle,
                          ),
                          Text(
                            "$age",
                            style: valueTextStyle,
                          )
                        ],
                      ),
                    )
                  ],
                )
              : Text("Click below button for birthday"),
          SizedBox(
            height: 12,
          ),
          Align(
            child: RaisedButton(
              color: Colors.blue,
              splashColor: Colors.blue.shade300,
              onPressed: () async {
                DateTime birthDate = await selectDate(context, DateTime.now(),
                    lastDate: DateTime.now());
                final df = new DateFormat('dd-MMM-yyyy');
                this.birthDate = df.format(birthDate);
                this.age = calculateAge(birthDate);

                setState(() {});
              },
              child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Select Birthday",
                    style: buttonTextStyle,
                  )),
            ),
            alignment: Alignment.centerLeft,
          )
        ],
      ),
    );
  }
}

class Income {
  final String name;

  Income(this.name);
}

class Education {
  final String name;

  Education(this.name);
}

class Profession {
  final String name;

  Profession(this.name);
}
