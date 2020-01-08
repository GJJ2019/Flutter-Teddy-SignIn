import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../home.dart';
import '../style.dart' as style;
import 'teddy_controller.dart';
import 'tracking_text_input.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TeddyController _teddyController;
  String _email = '';
  String _password = '';
  bool _isLoading = false;
  bool _isObscured = true;

  @override
  void initState() {
    _teddyController = TeddyController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              style.Style.upperGradientColor,
              style.Style.lowerGradientColor,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: height * 0.05),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 40.0,
                  ),
                  //Todo: Add On Pop Methods Here
                  onPressed: () {
                    print('Add On Pop Methods Here');
                  },
                ),
              ),
              Container(
                height: height * 0.25,
                child: FlareActor(
                  "assets/Teddy.flr",
                  shouldClip: false,
                  alignment: Alignment.bottomCenter,
                  fit: BoxFit.contain,
                  controller: _teddyController,
                ),
              ),
              Container(
                height: height * 0.45,
                margin: const EdgeInsets.symmetric(horizontal: 15.0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TrackingTextInput(
                        onTextChanged: (String email) {
                          _email = email;
                        },
                        label: "Email",
                        onCaretMoved: (Offset caret) {
                          _teddyController.lookAt(caret);
                        },
                        icon: Icons.email,
                        enable: !_isLoading,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Expanded(
                            child: TrackingTextInput(
                              label: "Password",
                              isObscured: _isObscured,
                              onCaretMoved: (Offset caret) {
                                _teddyController.coverEyes(caret != null);
                                _teddyController.lookAt(null);
                              },
                              onTextChanged: (String password) {
                                _password = password;
                              },
                              icon: Icons.lock,
                              enable: !_isLoading,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                                _isObscured
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.black45),
                            onPressed: () {
                              setState(() {
                                _isObscured = !_isObscured;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      RaisedButton(
                        child: _isLoading
                            ? SpinKitThreeBounce(
                                color: Colors.white,
                                size: 25.0,
                              )
                            : Text(
                                'Sign In',
                                style: TextStyle(
                                    fontFamily: 'Nunito',
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                        highlightElevation: 0.0,
                        onPressed: onPressed,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onPressed() async {
    if (_email.isEmpty && _password.isEmpty) {
      _showSnackBar('Please Enter Valid Information');
      _teddyController.play('fail');
    } else {
      if (_isEmailValid(_email)) {
        _isLoading = true;
        setState(() {});
        bool signInSuccess = await _teddyController.checkEmailPassword(
          email: _email,
          password: _password,
        );
        if (signInSuccess)
          _signInSuccess();
        else
          _signInFailed();
      } else {
        _teddyController.play('fail');
        _showSnackBar('Please Enter Valid Email Address');
      }
    }
  }

  //Helper Methods
  /// Method to validate email id returns true if email is valid
  bool _isEmailValid(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (regex.hasMatch(email))
      return true;
    else
      return false;
  }

  // Todo: implement after sign in success
  ///  Sign in successful
  void _signInSuccess() async {
    await Future.delayed(Duration(seconds: 1));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Home(),
      ),
    );
  }

  // Todo: implement after sign in fails
  /// Sign in Fails
  void _signInFailed() {
    _showSnackBar('Your email or password is incorrect');
    _isLoading = false;
    setState(() {});
  }

  void _showSnackBar(String title) => _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(title, textAlign: TextAlign.center),
        ),
      );
}
