import 'package:flutter/material.dart';

import 'core/style.dart';
import 'pages/auth/sign_in_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teddy Sign In',
      theme: ThemeData(
        fontFamily: 'OpenSans',
        primaryColor: Style.buttonColor,
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Colors.red,
          contentTextStyle: TextStyle(color: Colors.white),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Style.buttonColor,
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          highlightColor: Style.buttonHighlightColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
      home: const SignInPage(),
    );
  }
}
