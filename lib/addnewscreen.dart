import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:solar_star/battery.dart';

void main() => runApp(AddNewScreen());

class AddNewScreen extends StatefulWidget {
  final Battery battery;
  const AddNewScreen({Key key, this.battery}) : super(key: key);

  @override
  _AddNewScreenState createState() => _AddNewScreenState();
}

class _AddNewScreenState extends State<AddNewScreen> {
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _wattagecontroller = TextEditingController();
  final TextEditingController _voltagecontroller = TextEditingController();
  final TextEditingController _amperecontroller = TextEditingController();

  String _name = "";
  String _wattage = "";
  String _voltage = "";
  String _ampere = "";
  double screenHeight, screenWidth;
  File _image;
  String pathAsset = 'assets/images/camera.png';
  //int _radioValue = 0;
  //String foodtype = "Food";

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.deepPurple[700],
      appBar: AppBar(
        title: Text('Add New Battery',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.indigo[100])),
        backgroundColor: Colors.deepPurple[900],
      ),
      body: Container(
          child: Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    GestureDetector(
                        onTap: () => {_onPictureSelection()},
                        child: Container(
                          height: screenHeight / 3.2,
                          width: screenWidth / 1.8,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: _image == null
                                  ? AssetImage(pathAsset)
                                  : FileImage(_image),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(
                              width: 3.0,
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(
                                    5.0) //         <--- border radius here
                                ),
                          ),
                        )),
                    SizedBox(height: 5),
                    Text("Click image to take battery picture",
                        style: TextStyle(fontSize: 18.0, color: Colors.black)),
                    SizedBox(height: 10),
                    TextField(
                        controller: _namecontroller,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            labelText: 'Battery Name',
                            labelStyle: TextStyle(color: Colors.blueGrey[100]),
                            icon: Icon(Icons.battery_full_outlined,
                                color: Colors.cyan))),
                    SizedBox(height: 5),
                    TextField(
                        controller: _wattagecontroller,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            labelText: 'Wattage',
                            labelStyle: TextStyle(color: Colors.blueGrey[100]),
                            icon: Icon(Icons.battery_unknown_outlined,
                                color: Colors.teal))),
                    SizedBox(height: 5),
                    TextField(
                        controller: _voltagecontroller,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            labelText: 'Voltage',
                            labelStyle: TextStyle(color: Colors.blueGrey[100]),
                            icon: Icon(Icons.battery_charging_full_outlined,
                                color: Colors.lime))),
                    SizedBox(height: 5),
                    TextField(
                        controller: _amperecontroller,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            labelText: 'Ampere',
                            labelStyle: TextStyle(color: Colors.blueGrey[100]),
                            icon: Icon(Icons.battery_alert_outlined,
                                color: Colors.amber))),
                    SizedBox(height: 40),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      minWidth: 300,
                      height: 50,
                      child: Text('Add New Battery',
                          style: TextStyle(fontSize: 18)),
                      color: Colors.cyan[100],
                      textColor: Colors.black,
                      elevation: 15,
                      onPressed: newBatteryDialog,
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ))),
    );
  }

  _onPictureSelection() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: Colors.lime[50],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: new Container(
              //color: Colors.white,
              height: screenHeight / 4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Take picture from:",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )),
                  SizedBox(height: 15),
                  // Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // children: [
                  Flexible(
                      child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    minWidth: 100,
                    height: 50,
                    child: Text('Camera',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        )),
                    //color: Color.fromRGBO(101, 255, 218, 50),
                    color: Colors.lime[100],
                    textColor: Colors.black,
                    elevation: 10,
                    onPressed: () => {Navigator.pop(context), _chooseCamera()},
                  )),
                  SizedBox(height: 10),
                  Flexible(
                      child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    minWidth: 100,
                    height: 50,
                    child: Text('Gallery',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        )),
                    //color: Color.fromRGBO(101, 255, 218, 50),
                    color: Colors.lime[100],
                    textColor: Colors.black,
                    elevation: 10,
                    onPressed: () => {
                      Navigator.pop(context),
                      _chooseGallery(),
                    },
                  )),
                  // ],
                  // ),
                ],
              ),
            ));
      },
    );
  }

  void newBatteryDialog() {
    _name = _namecontroller.text;
    _wattage = _wattagecontroller.text;
    _voltage = _voltagecontroller.text;
    _ampere = _amperecontroller.text;

    if (_name == "" && _wattage == "" && _voltage == "" && _ampere == "") {
      Toast.show(
        "Fill all required fields",
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.TOP,
      );
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          /*title: new Text(
            "Register new Battery? ",
            style: TextStyle(
              color: Colors.black,
            ),
          ),*/
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          content: new Text(
            "Are you sure to add new battery?",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(
                "Yes",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _onAddBattery();
              },
            ),
            new FlatButton(
              child: new Text(
                "No",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _chooseCamera() async {
    _image = await ImagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 800, maxWidth: 800);
    _cropImage();
    setState(() {});
  }

  _chooseGallery() async {
    _image = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxHeight: 800, maxWidth: 800);
    _cropImage();
    setState(() {});
  }

  Future<void> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: _image.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
              ]
            : [
                CropAspectRatioPreset.square,
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Resize',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      _image = croppedFile;
      setState(() {});
    }
  }

  void _onAddBattery() {
    final dateTime = DateTime.now();
    _name = _namecontroller.text;
    _wattage = _wattagecontroller.text;
    _voltage = _voltagecontroller.text;
    _ampere = _amperecontroller.text;

    String base64Image = base64Encode(_image.readAsBytesSync());

    http.post("http://rachelcake.com/solar_star/php/add_newbattery.php", body: {
      "name": _name,
      "wattage": _wattage,
      "voltage": _voltage,
      "ampere": _ampere,
      "encoded_string": base64Image,
      "imagename": _name + "-${dateTime.microsecondsSinceEpoch}",
    }).then((res) {
      print(res.body);
      if (res.body == "success") {
        Toast.show(
          "Success",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
        );
        Navigator.pop(context);
      } else {
        Toast.show(
          "Failed",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
        );
      }
    }).catchError((err) {
      print(err);
    });
  }
}
