import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:solar_star/status.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:solar_star/battery.dart';
import 'package:http/http.dart' as http;

//void main() => runApp(ViewScreen());

class ViewScreen extends StatefulWidget {
  final Battery battery;
  final Status status;
  final List statusList;

  const ViewScreen(
      {Key key, this.battery, this.status, @required this.statusList})
      : super(key: key);

  @override
  _ViewScreenState createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  GlobalKey<RefreshIndicatorState> refreshKey;

  double screenHeight, screenWidth;
  double _volumeValue = 0;
  List statusList;
  String titlecenter = "Loading...";
  double power = 0;

  @override
  void initState() {
    super.initState();
    statusList = widget.statusList;
    _calculate_power(power);
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.green[100],
            appBar: AppBar(
              backgroundColor: Colors.green[200],
              title: Text(
                'View',
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold),
              ),
              actions: <Widget>[
                Flexible(
                    child: IconButton(
                  icon: Icon(Icons.refresh_rounded,
                      color: Colors.black, size: 30),
                  onPressed: () {},
                )),
              ],
            ),
            body: Column(children: <Widget>[
              statusList == null
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
                          childAspectRatio: (screenWidth / screenHeight) / 0.90,
                          children: List.generate(statusList.length, (index) {
                            return Padding(
                                padding: EdgeInsets.all(1),
                                child: Card(
                                    color: Colors.green[50],
                                    child: InkWell(
                                        onTap: () => null,
                                        child: SingleChildScrollView(
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                              SizedBox(height: 3),
                                              Stack(
                                                children: <Widget>[
                                                  Expanded(
                                                      child:
                                                          SingleChildScrollView(
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          SizedBox(height: 100),
                                                          Text("Power",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 30,
                                                              )),
                                                          SizedBox(height: 20),
                                                          Container(
                                                              child: SfRadialGauge(
                                                                  axes: <
                                                                      RadialAxis>[
                                                                RadialAxis(
                                                                    minimum: 0,
                                                                    maximum:
                                                                        100,
                                                                    showLabels:
                                                                        false,
                                                                    showTicks:
                                                                        false,
                                                                    radiusFactor:
                                                                        0.9,
                                                                    axisLineStyle: AxisLineStyle(
                                                                        cornerStyle:
                                                                            CornerStyle
                                                                                .bothCurve,
                                                                        color: Colors
                                                                            .black12,
                                                                        thickness:
                                                                            25),
                                                                    pointers: <
                                                                        GaugePointer>[
                                                                      RangePointer(
                                                                          value:
                                                                              power,
                                                                          cornerStyle: CornerStyle
                                                                              .bothCurve,
                                                                          width:
                                                                              30,
                                                                          sizeUnit: GaugeSizeUnit
                                                                              .logicalPixel,
                                                                          gradient: const SweepGradient(colors: <
                                                                              Color>[
                                                                            Color(0xFFCC2B5E),
                                                                            Color(0xFF753A88)
                                                                          ], stops: <
                                                                              double>[
                                                                            0.25,
                                                                            0.75
                                                                          ])),
                                                                      MarkerPointer(
                                                                          value:
                                                                              power,
                                                                          enableDragging:
                                                                              true,
                                                                          onValueChanged:
                                                                              onVolumeChanged,
                                                                          markerHeight:
                                                                              40,
                                                                          markerWidth:
                                                                              40,
                                                                          markerType: MarkerType
                                                                              .circle,
                                                                          color: Color(
                                                                              0xFF753A88),
                                                                          borderWidth:
                                                                              2,
                                                                          borderColor:
                                                                              Colors.white54)
                                                                    ],
                                                                    annotations: <
                                                                        GaugeAnnotation>[
                                                                      GaugeAnnotation(
                                                                          angle:
                                                                              90,
                                                                          axisValue:
                                                                              5,
                                                                          positionFactor:
                                                                              0.2,
                                                                          widget: Text(
                                                                              power.toString() + '%',
                                                                              style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Color(0xFFCC2B5E))))
                                                                    ])
                                                              ])), //Container
                                                          Divider(
                                                              height: 2,
                                                              color: Colors
                                                                  .grey[900]),
                                                          SizedBox(height: 25),
                                                          Text("Voltage",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 30,
                                                              )),
                                                          SizedBox(height: 13),
                                                          Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                    statusList[
                                                                            index]
                                                                        [
                                                                        'voltage'], //widget.status.voltage,
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          50,
                                                                    )),
                                                                Text("   Volts",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          30,
                                                                    )),
                                                              ]),
                                                        ]),
                                                  ))
                                                ],
                                              ),
                                            ])))));
                          })))
            ])));
  }

  void onVolumeChanged(double dummy) {
    setState(() {
      power = _calculate_power(dummy);
    });
  }

  double _calculate_power(double dummy) {
    double voltage = double.parse(statusList[0]['voltage']);

    setState(() {
      if (voltage <= 4.2 && voltage > 4.15) {
        power = 100;
      } else if (voltage <= 4.15 && voltage > 4.11) {
        power = 95;
      } else if (voltage <= 4.11 && voltage > 4.08) {
        power = 90;
      } else if (voltage <= 4.08 && voltage > 4.02) {
        power = 85;
      } else if (voltage <= 4.02 && voltage > 3.98) {
        power = 80;
      } else if (voltage <= 3.98 && voltage > 3.95) {
        power = 75;
      } else if (voltage <= 3.95 && voltage > 3.91) {
        power = 70;
      } else if (voltage <= 3.91 && voltage > 3.87) {
        power = 65;
      } else if (voltage <= 3.87 && voltage > 3.85) {
        power = 60;
      } else if (voltage <= 3.85 && voltage > 3.84) {
        power = 55;
      } else if (voltage <= 3.84 && voltage > 3.82) {
        power = 50;
      } else if (voltage <= 3.82 && voltage > 3.80) {
        power = 45;
      } else if (voltage <= 3.80 && voltage > 3.79) {
        power = 40;
      } else if (voltage <= 3.79 && voltage > 3.77) {
        power = 35;
      } else if (voltage <= 3.77 && voltage > 3.75) {
        power = 30;
      } else if (voltage <= 3.75 && voltage > 3.73) {
        power = 25;
      } else if (voltage <= 3.73 && voltage > 3.71) {
        power = 20;
        _alert();
      } else if (voltage <= 3.71 && voltage > 3.69) {
        power = 15;
        _alert();
      } else if (voltage <= 3.69 && voltage > 3.61) {
        power = 10;
        _alert();
      } else if (voltage <= 3.61 && voltage > 3.27) {
        power = 5;
        _alert();
      } else if (voltage <= 3.27) {
        power = 0;
        _alert();
      }
    });

    return power;
  }

  void _alert() {
    http.post("http://rachelcake.com/solar_star/php/alert_mail.php",
        body: {}).then((res) {
      print("Success");
      print(res.body);
    }).catchError((err) {
      print(err);
    });
  }
}
