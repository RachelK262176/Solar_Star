import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solar_star/mainscreen.dart';
import 'package:solar_star/registerscreen.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emcontroller = TextEditingController();
  String _email = "";
  final TextEditingController _pscontroller = TextEditingController();
  String _password = "";
  bool _passwordVisibleLogin = false;
  bool _rememberMe = false;
  SharedPreferences prefs;

  @override
  void initState() {
    loadpref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: WillPopScope(
            onWillPop: _onBackPressAppBar,
            child: Scaffold(
                backgroundColor: Colors.lime[50],
                body: new Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        Colors.pink[50],
                        //Colors.lime[50],
                        Colors.red[50],
                        Colors.deepOrange[50],
                        Colors.orange[50],
                        Colors.amber[50],
                      ])),
                  padding: const EdgeInsets.only(
                    top: 50.0,
                    left: 30.0,
                    right: 30.0,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 20),
                        Image.asset(
                          'assets/images/abc.png',
                          scale: 1.1,
                        ),
                        SizedBox(height: 20),
                        Card(
                            color: Colors.orange[50],
                            elevation: 15,
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                                child: Column(children: [
                                  SizedBox(height: 20),
                                  TextFormField(
                                      controller: _emcontroller,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        labelText: 'Email',
                                        hintText: "Enter your email",
                                        hintStyle: TextStyle(
                                            fontSize: (12), color: Colors.grey),
                                        labelStyle:
                                            TextStyle(color: Colors.black),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 42,
                                          vertical: 20,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          borderSide: BorderSide(
                                              color: Color(0XFF8B8B8B),
                                              width: 5.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
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
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          borderSide: BorderSide(
                                              color: Color(0XFF8B8B8B),
                                              width: 5.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
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
                                              _passwordVisibleLogin
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: Theme.of(context)
                                                  .primaryColorDark,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _passwordVisibleLogin =
                                                    !_passwordVisibleLogin;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      obscureText: _passwordVisibleLogin,
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
                                        _password = password;
                                      }),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    minWidth: 280,
                                    height: 50,
                                    child: Text('Login',
                                        style: TextStyle(fontSize: (16))),
                                    color: Colors.amber[200],
                                    textColor: Colors.black,
                                    elevation: 10,
                                    onPressed: _confirmDialog, //_onLogin,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
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
                                              fontSize: 16,
                                              color: Colors.black))
                                    ],
                                  ),
                                ]))),
                        SizedBox(height: 30),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account?",
                                  style: TextStyle(fontSize: 16)),
                              GestureDetector(
                                  onTap: _onRegister,
                                  child: Text(' Sign Up',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.teal[300]))),
                            ]),
                        // SizedBox(height: 50),
                      ],
                    ),
                  ),
                ))));
  }

  Future<void> _onLogin() async {
    Navigator.pop(context);

    _email = _emcontroller.text;
    _password = _pscontroller.text;
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Login...");
    await pr.show();
    http.post("http://rachelcake.com/solar_star/php/login_user.php", body: {
      "email": _email,
      "password": _password,
    }).then((res) {
      print(res.body);
      if (res.body == "success") {
        Toast.show(
          "Login Success",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
        );
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => MainScreen()));
      } else {
        Toast.show(
          "Invalid Email or Password",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.TOP,
        );
      }
    }).catchError((err) {
      print(err);
    });
    await pr.hide();
  }

  void _onRegister() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => RegisterScreen()));
  }

  void _onChange(bool value) {
    setState(() {
      _rememberMe = value;
      savepref(value);
    });
  }

  void loadpref() async {
    prefs = await SharedPreferences.getInstance();
    _email = (prefs.getString('email')) ?? '';
    _password = (prefs.getString('password')) ?? '';
    _rememberMe = (prefs.getBool('rememberme')) ?? false;
    if (_email.isNotEmpty) {
      setState(() {
        _emcontroller.text = _email;
        _pscontroller.text = _password;
        _rememberMe = _rememberMe;
      });
    }
  }

  void savepref(bool value) async {
    prefs = await SharedPreferences.getInstance();
    _email = _emcontroller.text;
    _password = _pscontroller.text;

    if (value) {
      if (_email.length < 5 && _password.length < 3) {
        print("EMAIL/PASSWORD EMPTY");
        _rememberMe = false;
        Toast.show(
          "Email or password is empty!",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
        );
        return;
      } else {
        await prefs.setString('email', _email);
        await prefs.setString('password', _password);
        await prefs.setBool('rememberme', value);
        Toast.show(
          "Preferences saved",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
        );
        print("SUCCESS");
      }
    } else {
      await prefs.setString('email', '');
      await prefs.setString('password', '');
      await prefs.setBool('rememberme', false);
      setState(() {
        _emcontroller.text = "";
        _pscontroller.text = "";
        _rememberMe = false;
      });
      Toast.show(
        "Preferences removed",
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
      );
    }
  }

  Future<bool> _onBackPressAppBar() async {
    SystemNavigator.pop();
    print('Backpress');
    return Future.value(false);
  }

  void _confirmDialog() {
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
            "Have you connect to your battery controller? ",
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                "Yes",
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
              onPressed: () {
                _onLogin();
              },
            ),
            new FlatButton(
              child: new Text(
                "No",
                style: TextStyle(color: Colors.blue, fontSize: 16),
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
