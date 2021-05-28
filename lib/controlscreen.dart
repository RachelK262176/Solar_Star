import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:solar_star/battery.dart';

void main() => runApp(ControlScreen());

class ControlScreen extends StatefulWidget {
  final Battery battery;
  const ControlScreen({Key key, this.battery}) : super(key: key);

  @override
  _ControlScreenState createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  double screenHeight, screenWidth;
  double _volumeValue = 48;
  final TextEditingController delayController = TextEditingController();

  String delay = "";

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.cyan[100],
        appBar: AppBar(
          backgroundColor: Colors.cyan[200],
          title: Text(
            'Control',
            style: TextStyle(
              fontSize: 35,
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: ListView(children: <Widget>[
          Row(children: <Widget>[
            Expanded(
                child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                  SizedBox(height: 10),
                  Text("Power",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      )),
                  Container(
                      child: SfRadialGauge(axes: <RadialAxis>[
                    RadialAxis(
                        minimum: 0,
                        maximum: 100,
                        showLabels: false,
                        showTicks: false,
                        radiusFactor: 0.6,
                        axisLineStyle: AxisLineStyle(
                            cornerStyle: CornerStyle.bothCurve,
                            color: Colors.black12,
                            thickness: 25),
                        pointers: <GaugePointer>[
                          RangePointer(
                              value: _volumeValue,
                              cornerStyle: CornerStyle.bothCurve,
                              width: 25,
                              sizeUnit: GaugeSizeUnit.logicalPixel,
                              gradient: const SweepGradient(colors: <Color>[
                                Color(0xFFCC2B5E),
                                Color(0xFF753A88)
                              ], stops: <double>[
                                0.25,
                                0.75
                              ])),
                          MarkerPointer(
                              value: _volumeValue,
                              enableDragging: true,
                              onValueChanged: onVolumeChanged,
                              markerHeight: 34,
                              markerWidth: 34,
                              markerType: MarkerType.circle,
                              color: Color(0xFF753A88),
                              borderWidth: 2,
                              borderColor: Colors.white54)
                        ],
                        annotations: <GaugeAnnotation>[
                          GaugeAnnotation(
                              angle: 90,
                              axisValue: 5,
                              positionFactor: 0.1,
                              widget: Text(_volumeValue.ceil().toString() + '%',
                                  style: TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFCC2B5E))))
                        ])
                  ])),
                  // Divider(height: 2, color: Colors.grey[900]),
                  SizedBox(height: 10),
                  TextField(
                    controller: delayController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "Time per hour",
                      hintStyle: TextStyle(
                        fontSize: 13,
                      ),
                      labelText: '  Set Delay Time',
                      labelStyle: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ])))
          ])
        ]));
  }

  void onVolumeChanged(double value) {}
}
