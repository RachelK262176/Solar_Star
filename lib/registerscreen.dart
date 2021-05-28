import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solar_star/loginscreen.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

final _formKey = GlobalKey<FormState>();

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _phcontroller = TextEditingController();
  final TextEditingController _emcontroller = TextEditingController();
  final TextEditingController _pscontroller = TextEditingController();

  String _name = "";
  String _phone = "";
  String _email = "";
  String _pass = "";
  bool _passwordVisible = false;
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[50],
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Colors.lime[50],
                Colors.lightGreen[50],
                Colors.green[50],
                Colors.teal[50],
                Colors.cyan[50],
              ])),
          child: Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 30),
                      Text("Register Account",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: (25),
                              fontWeight: FontWeight.bold)),
                      Text("Complete your details",
                          style: TextStyle(
                            color: Colors.black,
                          )),
                      SizedBox(height: 10),
                      Image.asset(
                        'assets/images/abc.png',
                        scale: 1.5,
                      ),
                      SizedBox(height: 10),
                      Card(
                          color: Colors.teal[50],
                          elevation: 15,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                              child: Column(children: [
                                TextFormField(
                                    controller: _namecontroller,
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                      labelText: 'Name',
                                      hintText: "Enter your Name",
                                      hintStyle: TextStyle(
                                          fontSize: (12),
                                          color: Color(0XFF8B8B8B)),
                                      labelStyle:
                                          TextStyle(color: Colors.black),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 42,
                                        vertical: 20,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50),
                                        borderSide: BorderSide(
                                            color: Color(0XFF8B8B8B),
                                            width: 5.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50),
                                        borderSide: BorderSide(
                                            color: Color(0XFF8B8B8B)),
                                        gapPadding: 10,
                                      ),
                                      suffixIcon: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 30.0,
                                          right: 20.0,
                                        ),
                                        child: SvgPicture.asset(
                                            "assets/icons/User.svg",
                                            height: 25),
                                      ),
                                    ),
                                    textInputAction: TextInputAction.next,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter your name';
                                      }
                                      if (value.length < 3) {
                                        return 'Please enter a correct Name';
                                      }
                                      return null;
                                    },
                                    onSaved: (String name) {
                                      _name = name;
                                    }),
                                SizedBox(height: 10),
                                TextFormField(
                                    controller: _phcontroller,
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      labelText: 'Mobile',
                                      hintText: "Enter your phone",
                                      hintStyle: TextStyle(
                                          fontSize: (12),
                                          color: Color(0XFF8B8B8B)),
                                      labelStyle:
                                          TextStyle(color: Colors.black),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 42,
                                        vertical: 20,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50),
                                        borderSide: BorderSide(
                                            color: Color(0XFF8B8B8B),
                                            width: 5.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50),
                                        borderSide: BorderSide(
                                            color: Color(0XFF8B8B8B)),
                                        gapPadding: 10,
                                      ),
                                      suffixIcon: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 30.0,
                                          right: 25.0,
                                        ),
                                        child: SvgPicture.asset(
                                            "assets/icons/Phone.svg",
                                            height: 30),
                                      ),
                                    ),
                                    textInputAction: TextInputAction.next,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter phone';
                                      }
                                      if (value.length != 10) {
                                        return 'Please enter a correct Phone Number';
                                      }
                                      if (value.length < 10) {
                                        return 'Please enter valid phone';
                                      }
                                      return null;
                                    },
                                    onSaved: (String phone) {
                                      _phone = phone;
                                    }),
                                SizedBox(height: 10),
                                TextFormField(
                                    controller: _emcontroller,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      labelText: 'Email',
                                      hintText: "Enter your email",
                                      hintStyle: TextStyle(
                                          fontSize: (12),
                                          color: Color(0XFF8B8B8B)),
                                      labelStyle:
                                          TextStyle(color: Colors.black),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 42,
                                        vertical: 20,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50),
                                        borderSide: BorderSide(
                                            color: Color(0XFF8B8B8B),
                                            width: 5.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50),
                                        borderSide: BorderSide(
                                            color: Color(0XFF8B8B8B)),
                                        gapPadding: 10,
                                      ),
                                      suffixIcon: Padding(
                                        padding: EdgeInsets.all(20),
                                        child: SvgPicture.asset(
                                            "assets/icons/Mail.svg",
                                            height: 20),
                                      ),
                                    ),
                                    textInputAction: TextInputAction.next,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter email';
                                      }
                                      if (!RegExp(
                                              r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(value)) {
                                        return "Please enter valid email";
                                      }
                                      return null;
                                    },
                                    onSaved: (String email) {
                                      _email = email;
                                    }),
                                SizedBox(height: 10),
                                TextFormField(
                                    controller: _pscontroller,
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      hintText: "Enter your password",
                                      labelStyle:
                                          TextStyle(color: Colors.black),
                                      hintStyle: TextStyle(
                                          fontSize: (12),
                                          color: Color(0XFF8B8B8B)),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 42,
                                        vertical: 20,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50),
                                        borderSide: BorderSide(
                                            color: Color(0XFF8B8B8B),
                                            width: 5.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50),
                                        borderSide: BorderSide(
                                            color: Color(0XFF8B8B8B)),
                                        gapPadding: 10,
                                      ),
                                      suffixIcon: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 30.0,
                                          right: 10.0,
                                        ),
                                        child: IconButton(
                                          icon: Icon(
                                            _passwordVisible
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Theme.of(context)
                                                .primaryColorDark,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _passwordVisible =
                                                  !_passwordVisible;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    obscureText: _passwordVisible,
                                    textInputAction: TextInputAction.done,
                                    validator: (value) {
                                      //validator
                                      Pattern pattern =
                                          r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
                                      RegExp regex = new RegExp(pattern);
                                      if (!regex.hasMatch(value)) {
                                        return 'Please enter a correct Password';
                                      } else if (value.isEmpty) {
                                        return 'Please enter your Password';
                                      } else {
                                        return null;
                                      }
                                    },
                                    onSaved: (String password) {
                                      _pass = password;
                                    }),
                                SizedBox(height: 10),
                                Row(
                                  children: <Widget>[
                                    Checkbox(
                                      value: _rememberMe,
                                      onChanged: (bool value) {
                                        _onChange(value);
                                      },
                                      activeColor: Colors.green,
                                      checkColor: Colors.white,
                                    ),
                                    Text('Remember Me',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.black))
                                  ],
                                ),
                                SizedBox(height: 5),
                                MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  minWidth: 300,
                                  height: 50,
                                  child: Text('Register',
                                      style: TextStyle(fontSize: (16))),
                                  color: Colors.teal[200],
                                  textColor: Colors.black,
                                  elevation: 10,
                                  onPressed: _openDialog,
                                ),
                                SizedBox(height: 15),
                                GestureDetector(
                                    onTap: _onLogin,
                                    child: Text('Already register',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black))),
                              ]))),
                      SizedBox(height: 25),
                    ],
                  ),
                ),
              ))),
    );
  }

  void _onRegister() async {
    Navigator.pop(context);

    if (_formKey.currentState.validate()) {
      _name = _namecontroller.text;
      _phone = _phcontroller.text;
      _email = _emcontroller.text;
      _pass = _pscontroller.text;

      ProgressDialog pr = new ProgressDialog(context,
          type: ProgressDialogType.Normal, isDismissible: false);
      pr.style(message: "Registration...");
      await pr.show();
      http.post("http://rachelcake.com/solar_star/php/PHPMailer/index.php",
          body: {
            "name": _name,
            "phone": _phone,
            "email": _email,
            "password": _pass,
          }).then((res) {
        print(res.body);

        if (res.body == "success") {
          Toast.show(
            "Registration Success, Please check your email to verify your account",
            context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.TOP,
          );
          if (_rememberMe) {
            savepref();
          }
          _onLogin();
        }
      }).catchError((err) {
        print(err);
      });
      await pr.hide();
    } else {
      Toast.show(
        "Registration Failed",
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.TOP,
      );
    }
  }

  void _onLogin() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
  }

  void _onChange(bool value) {
    setState(() {
      _rememberMe = value;
    });
  }

  void savepref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _email = _emcontroller.text;
    _pass = _pscontroller.text;
    await prefs.setString('email', _email);
    await prefs.setString('password', _pass);
    await prefs.setBool('rememberme', true);
  }

  void _openDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
            "Confirmation Message",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          content: new Text(
            "Are you sure your information is correct? ",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                "Yes",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                _onRegister();
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
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
