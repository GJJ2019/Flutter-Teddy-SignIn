import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  // Todo: Implement Your Home Page
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Sign In Successful',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
