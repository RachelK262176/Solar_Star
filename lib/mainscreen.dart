import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:solar_star/battery.dart';
import 'package:solar_star/controlscreen.dart';
import 'package:solar_star/loginscreen.dart';
import 'package:solar_star/managescreen.dart';
import 'package:solar_star/status.dart';
import 'package:solar_star/viewscreen.dart';
import 'package:toast/toast.dart';

class MainScreen extends StatefulWidget {
  final Battery battery;
  final Status status;

  const MainScreen({Key key, this.battery, this.status}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  GlobalKey<RefreshIndicatorState> refreshKey;

  List statusList;
  String titlecenter;

  @override
  void initState() {
    super.initState();
    _loadStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      appBar: AppBar(
        backgroundColor: Colors.orange[100],
        leading: Icon(Icons.home, size: 30, color: Colors.white),
        title: Text(
          'Home',
          style: TextStyle(
            fontSize: 24,
            color: Colors.brown[600],
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white, size: 30),
            onPressed: _logout,
          ),
        ],
      ),
      body: Center(
          child: SingleChildScrollView(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <
                Widget>[
          RaisedButton.icon(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            label: Text('View',
                style: TextStyle(fontSize: (40), fontStyle: FontStyle.italic)),
            icon: Icon(Icons.search_rounded, size: 50),
            color: Colors.green[200],
            textColor: Colors.white,
            onPressed: _onView,
            padding: EdgeInsets.fromLTRB(110, 30, 110, 30),
          ),
          SizedBox(height: 40),
          RaisedButton.icon(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            label: Text('Manage',
                style: TextStyle(fontSize: (40), fontStyle: FontStyle.italic)),
            icon: Icon(Icons.battery_unknown_outlined, size: 50),
            color: Colors.teal[200],
            textColor: Colors.white,
            onPressed: _onManage,
            padding: EdgeInsets.fromLTRB(80, 30, 80, 30),
          ),
          SizedBox(height: 40),
          RaisedButton.icon(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            label: Text('Control',
                style: TextStyle(fontSize: (40), fontStyle: FontStyle.italic)),
            icon: Icon(Icons.charging_station, color: Colors.white, size: 50),
            color: Colors.cyan[200],
            textColor: Colors.white,
            elevation: 10,
            onPressed: _onControl,
            padding: EdgeInsets.fromLTRB(90, 30, 90, 30),
          ),
        ]),
      )),
    );
  }

  _onView() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => ViewScreen(
                battery: widget.battery, statusList: statusList))); //
  }

  void _onManage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => ManageScreen(
                  battery: widget.battery,
                )));
  }

  void _onControl() {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => ControlScreen()));
  }

  void _logout() {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
    Toast.show(
      "Successful logout",
      context,
      duration: Toast.LENGTH_LONG,
      gravity: Toast.TOP,
    );
  }

  void _loadStatus() {
    http.post("http://rachelcake.com/solar_star/php/load_status.php",
        body: {}).then((res) {
      print(res.body);
      if (res.body == "nodata") {
        statusList = null;
        setState(() {
          titlecenter = "Not Found";
        });
      } else {
        setState(() {
          var jsondata = json.decode(res.body);
          statusList = jsondata["status"];
        });
      }
    }).catchError((err) {
      print(err);
    });
  }
}
