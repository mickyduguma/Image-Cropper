import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  // PickedFile? _imageFile;
  File? _imageFile;
  bool _inProcess = false;
  String path = "";
  String name = "";
  final ImagePicker _picker = ImagePicker();
  double _drawerIconSize = 24;
  double _drawerFontSize = 17;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile Page",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0.5,
        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Theme.of(context).primaryColor,
                Theme.of(context).colorScheme.secondary,
              ])),
        ),
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [
                0.0,
                1.0
              ],
                  colors: [
                Theme.of(context).primaryColor.withOpacity(0.2),
                Theme.of(context).accentColor.withOpacity(0.5),
              ])),
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, 1.0],
                    colors: [
                      Theme.of(context).errorColor,
                      Theme.of(context).errorColor,
                    ],
                  ),
                ),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "CNET",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.login_rounded,
                    size: _drawerIconSize,
                    color: Theme.of(context).primaryColor),
                title: Text(
                  'Profile Page',
                  style: TextStyle(
                      fontSize: _drawerFontSize,
                      color: Theme.of(context).primaryColor),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
              ),
              Divider(
                color: Theme.of(context).primaryColor,
                height: 1,
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: [
                  GestureDetector(
                    child: Stack(
                      children: [
                        Center(
                          child: CircleAvatar(
                            radius: 60.0,
                            backgroundImage: _imageFile == null
                                ? AssetImage("assets/images/new.jpg")
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
                                color: Colors.redAccent.shade700,
                                size: 15.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Full Name',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.fromLTRB(25, 200, 25, 10),
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Image Information",
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Card(
                      child: Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.all(15),
                        child: Column(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                ...ListTile.divideTiles(
                                  color: Colors.grey,
                                  tiles: [
                                    ListTile(
                                      leading: Icon(Icons.pattern),
                                      title: Text("Image path: "),
                                      subtitle: Text(path),
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.account_tree),
                                      title: Text("Image name: "),
                                      subtitle: Text(name),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            (_inProcess)
                ? Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height * 0.95,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Center()
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
            TextButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
                Navigator.of(context).pop();
              },
              label: Text("Camera"),
            ),
            TextButton.icon(
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
      setState(() {
        _inProcess = true;
      });
      final pickedFile = await _picker.getImage(
        source: source,
      );
      // setState(() {
      //   _imageFile = pickedFile;
      //   print(File(_imageFile!.path));
      // });
      if (pickedFile != null) {
        File? cropped = await ImageCropper.cropImage(
            sourcePath: pickedFile.path,
            aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
            compressQuality: 100,
            maxWidth: 700,
            maxHeight: 700,
            compressFormat: ImageCompressFormat.jpg,
            androidUiSettings: AndroidUiSettings(
              toolbarColor: Colors.deepOrange,
              toolbarTitle: "Crop & Edit",
              statusBarColor: Colors.deepOrange.shade900,
              backgroundColor: Colors.white,
            ));

        setState(() {
          _imageFile = cropped;
          if (_imageFile != null) {
            path = _imageFile!.path.toString();
            name = _imageFile!.path.split('/').last;
          }
          //uploadImage('image', File(_imageFile!.path));

          _inProcess = false;
        });
      } else {
        setState(() {
          _inProcess = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }
}

uploadImage(String title, File file) async {
  // var request =
  //     http.MultipartRequest("POST", Uri.parse("https://api.imgur.com/3/image"));

  // request.fields['title'] = "dummyImage";
  // request.headers['Authorization'] = "Client-ID " + "e0bfa5353df190e";
  String authToken = "e0bfa5353df190e";
// (await rootBundle.load('assets/images/person.jpg')).buffer.asUint8List(),
  FormData formData = new FormData.fromMap(
      {"image": await MultipartFile.fromFile(file.path, filename: "dp")});

  // var picture = http.MultipartFile.fromBytes(
  //     'image', (await rootBundle.load(file.path)).buffer.asUint8List(),
  //     filename: file.path.split('/').last);
  Response response = await Dio().put("https://api.imgur.com/3/image",
      data: formData,
      options: Options(headers: <String, String>{
        'Authorization': 'Client-ID $authToken',
      }));

//  request.files.add(picture);

  // var response = await request.send();

  var responseData = await response.data;

  var result = String.fromCharCodes(responseData);

  print(result);
}
