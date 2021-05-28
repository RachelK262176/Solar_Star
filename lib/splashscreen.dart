import 'package:flutter/material.dart';
import 'package:solar_star/loginscreen.dart';

void main() => runApp(SplashScreen());

class SplashScreen extends StatelessWidget {
  double screenHeight, screenWidth;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme(),
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.orange[50],
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/abc.png',
                    width: 370,
                    height: 350,
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  new ProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                  ),
                  Text("Welcome to Solar Power Management System",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.green[400],
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProgressIndicator extends StatefulWidget {
  @override
  _ProgressIndicatorState createState() => new _ProgressIndicatorState();
}

class _ProgressIndicatorState extends State<ProgressIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          if (animation.value > 0.99) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => LoginScreen()));
          }
        });
      });
    controller.repeat();
  }

  @override
  void dispose() {
    controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
        child: new Container(
      child: CircularProgressIndicator(
        value: animation.value,
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.green[200]),
      ),
    ));
  }
}

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.black,
    fontFamily: "Muli",
    appBarTheme: AppBarTheme(
      color: Colors.grey,
      elevation: 0,
      brightness: Brightness.light,
      iconTheme: IconThemeData(color: Colors.black),
      textTheme: TextTheme(
        headline6: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
      ),
    ),
  );
}
