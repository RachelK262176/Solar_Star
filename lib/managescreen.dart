import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:solar_star/addnewscreen.dart';
import 'package:solar_star/battery.dart';

void main() => runApp(ManageScreen());

class ManageScreen extends StatefulWidget {
  final Battery battery;

  const ManageScreen({Key key, this.battery}) : super(key: key);
  @override
  _ManageScreenState createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen> {
  double screenHeight, screenWidth;
  String titlecenter = "Loading ...";
  List batteryList;

  @override
  void initState() {
    super.initState();
    _loadBattery();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.teal[100],
            appBar: AppBar(
              backgroundColor: Colors.teal[400],
              title: Text(
                'Manage',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.tealAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: <Widget>[
                Flexible(
                  child: IconButton(
                    icon: Icon(Icons.add, color: Colors.white, size: 30),
                    onPressed: () {
                      _addnew();
                    },
                  ),
                ),
              ],
            ),
            body: Column(children: [
              batteryList == null
                  ? Flexible(
                      child: Container(
                          child: Center(
                              child: Text(
                      titlecenter,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ))))
                  : Flexible(
                      child: GridView.count(
                          crossAxisCount: 1,
                          childAspectRatio: (screenWidth / screenHeight) / 0.95,
                          children: List.generate(batteryList.length, (index) {
                            return Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Card(
                                    color: Colors.teal[50],
                                    child: InkWell(
                                        onTap: () => null,
                                        child: SingleChildScrollView(
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                              SizedBox(height: 3),
                                              Stack(
                                                children: [
                                                  Container(
                                                    height: screenHeight / 2.0,
                                                    width: screenWidth / 0.1,
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          "http://rachelcake.com/solar_star/images/batteryimages/${batteryList[index]['image']}.jpeg",
                                                      fit: BoxFit.cover,
                                                      placeholder: (context,
                                                              url) =>
                                                          new CircularProgressIndicator(),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          new Icon(
                                                        Icons.broken_image,
                                                        size: screenWidth / 2,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Text("Name: ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 24,
                                                  )),
                                              Text(
                                                  batteryList[index][
                                                      'name'], //widget.battery.name
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 24,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      color:
                                                          Colors.blueAccent)),
                                              SizedBox(height: 15),
                                              Text("Wattage: ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 24,
                                                  )),
                                              Text(
                                                  batteryList[index]
                                                          ['wattage'] +
                                                      "  watt", //widget.battery.wattage
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 24,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      color:
                                                          Colors.blueAccent)),
                                              SizedBox(height: 15),
                                              Text("Voltage: ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 24,
                                                  )),
                                              Text(
                                                  batteryList[index]
                                                          ['voltage'] +
                                                      "  volt", //widget.battery.voltage
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 24,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      color:
                                                          Colors.blueAccent)),
                                              SizedBox(height: 15),
                                              Text("Current: ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 24,
                                                  )),
                                              Text(
                                                  batteryList[index]['ampere'] +
                                                      "  ampere", //widget.battery.ampere
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 24,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      color:
                                                          Colors.blueAccent)),
                                              SizedBox(height: 15),
                                            ])))));
                          })))
            ])));
  }

  Future<void> _addnew() async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => AddNewScreen(
                  battery: widget.battery,
                )));
  }

  Future<void> _loadBattery() async {
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Loading...");
    await pr.show();
    http.post("http://rachelcake.com/solar_star/php/load_battery.php",
        body: {}).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        batteryList = null;
        setState(() {
          titlecenter = "No Battery Found";
        });
      } else {
        setState(() {
          var jsondata = json.decode(res.body);
          batteryList = jsondata["battery"];
        });
      }
    }).catchError((err) {
      print(err);
    });
    await pr.hide();
  }
}
