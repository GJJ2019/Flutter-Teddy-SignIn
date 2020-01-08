import 'package:flutter/material.dart';

import 'sign_in/sign_in.dart';
import 'style.dart' as styles;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teddy Sign In',
      theme: ThemeData(
        fontFamily: 'OpenSans',
        primaryColor: styles.Style.buttonColor,
        cursorColor: styles.Style.buttonColor,
        snackBarTheme: SnackBarThemeData(
          backgroundColor: Colors.red,
          contentTextStyle: TextStyle(color: Colors.white),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: styles.Style.buttonColor,
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          highlightColor: styles.Style.buttonHighlightColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
      home: SignIn(),
    );
  }
}
