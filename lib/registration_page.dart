import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:databasetry/Common/theme_helper.dart';
import 'package:gender_picker/source/enums.dart';
import 'header_widget.dart';
import 'DatabaseHandler/Database_Helper.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gender_picker/gender_picker.dart';

class RegistrationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegistrationPageState();
  }
}

class _RegistrationPageState extends State<RegistrationPage> {
  PickedFile? _imageFile;

  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;
  String date = "";
  DateTime selectedDate = DateTime.parse("1991-07-20");
  final _fname = TextEditingController();
  final _uid = TextEditingController();
  final _mname = TextEditingController();
  final _lname = TextEditingController();
  final _height = TextEditingController();
  final _weight = TextEditingController();
  final _address = TextEditingController();
  final _email = TextEditingController();
  final _bmi = TextEditingController();
  //PickedFile? _imageFile;
  QueryAll(String id) async {
    // List<Map<String, dynamic>> queryrows =
    //     await DatabaseHelper.instance.QueryAll(id);
    // print(queryrows);

    // if (queryrows != null) {
    //   _fname.text = "MIcol";
    //   _bmi.text = "34.5";

    //   print('Micol is printed==================');
    //   print(queryrows[0]);
    // }
    print("query called");
  }

  Forinserting() async {
    print("insert called");
    // String uid = _uid.text;
    // String fname= _fname.text;
    // int i =  await DatabaseHelper.instance.insert({

    // DatabaseHelper.columnname:'$_fname',
    //   DatabaseHelper.user_id:'$_uid',
    // });
    // print('The inserted ID is $i');
    // if(i!=null) QueryAll('$_uid');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 150,
              child: HeaderWidget(150, false, Icons.person_add_alt_1_rounded),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        GestureDetector(
                          child: Stack(
                            children: [
                              Center(
                                child: CircleAvatar(
                                  radius: 60.0,
                                  backgroundImage: _imageFile == null
                                      ? AssetImage("assets/images/mdh.jpeg")
                                      : FileImage(File(_imageFile!.path))
                                          as ImageProvider,
                                ),
                              ),
                              Center(
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(80, 80, 0, 0),
                                  child: InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: ((builder) => bottomSheet()),
                                      );
                                    },
                                    child: Icon(
                                      Icons.add_circle,
                                      color: Colors.grey.shade700,
                                      size: 25.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: TextFormField(
                            controller: _uid,
                            decoration: ThemeHelper().textInputDecoration(
                                'User ID.', 'Enter your ID'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: TextFormField(
                            controller: _fname,
                            decoration: ThemeHelper().textInputDecoration(
                                'First Name', 'Enter your first name'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: TextFormField(
                            controller: _mname,
                            decoration: ThemeHelper().textInputDecoration(
                                'Middle Name', 'Enter your Middle name'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(
                                'Last Name', 'Enter your last name'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text("Please Choose your Gender"),
                        Center(child: _genderWidget(false, false)),
                        Container(
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: TextFormField(
                            controller: _height,
                            decoration: ThemeHelper().textInputDecoration(
                                'Heght', 'Enter your Height'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: TextFormField(
                            controller: _weight,
                            keyboardType: TextInputType.number,
                            decoration: ThemeHelper().textInputDecoration(
                                'Weight', 'Enter your Weight'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(
                                'Resident Address',
                                'Enter your Resident Address'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(
                                "E-mail address", "Enter your email"),
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) {
                              if (!(val!.isEmpty) &&
                                  !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                      .hasMatch(val)) {
                                return "Enter a valid email address";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: CountryCodePicker(
                                  initialSelection: 'ET',
                                  showCountryOnly: true,
                                  alignLeft: true,
                                  showDropDownButton: true,
                                ),
                              )),
//

                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: ThemeHelper().textInputDecoration(
                                'Phone Number', 'Enter your Phone number'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Choose Your Date of Birth"),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      _selectDate(context);
                                    },
                                    child: Icon(
                                      Icons.calendar_today_sharp,
                                      size: 38,
                                    ),
                                  ),
                                ),
                                Text(
                                    "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}")
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            obscureText: false,
                            controller: _bmi,
                            enabled: false,
                            decoration: ThemeHelper()
                                .textInputDecoration("BMI*", "Body Mass Index"),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 15.0),
                        FormField<bool>(
                          builder: (state) {
                            return Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Checkbox(
                                        value: checkboxValue,
                                        onChanged: (value) {
                                          setState(() {
                                            checkboxValue = value!;
                                            state.didChange(value);
                                          });
                                        }),
                                    Text(
                                      "I accept all terms and conditions.",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    state.errorText ?? '',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Theme.of(context).errorColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                          validator: (value) {
                            if (!checkboxValue) {
                              return 'You need to accept terms and conditions';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          decoration:
                              ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                "Register".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: Forinserting, //() {
//                              if (_formKey.currentState!.validate()) {
////                                Navigator.of(context).pushAndRemoveUntil(
////                                    MaterialPageRoute(
////                                        builder: (context) => ProfilePage()
////                                    ),
////                                        (Route<dynamic> route) => false
////                                );
//
//                              }
//                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
                Navigator.of(context).pop();
              },
              label: Text("Camera"),
            ),
            FlatButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
                Navigator.of(context).pop();
              },
              label: Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    try {
      final pickedFile = await _picker.getImage(
        source: source,
      );
      setState(() {
        _imageFile = pickedFile;
      });
    } catch (e) {}
  }

  Widget _genderWidget(bool showOtherGender, bool alignVertical) {
    return Container(
      child: GenderPickerWithImage(
        showOtherGender: false,
        verticalAlignedText: alignVertical,
        selectedGender: Gender.Male,
        selectedGenderTextStyle:
            TextStyle(color: Color(0xFF8b32a8), fontWeight: FontWeight.bold),
        unSelectedGenderTextStyle:
            TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
        onChanged: (Gender? gender) {
          print(gender);
        },
        equallyAligned: true,
        animationDuration: Duration(milliseconds: 300),
        isCircular: true,
        // default : true,
        opacityOfGradient: 0.4,
        padding: const EdgeInsets.all(3),
        size: 50, //default : 40
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1990),
      lastDate: DateTime(2010),
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
      });
  }
}
