import 'package:flutter/material.dart';
import 'package:goodwork/screens/splash_screen.dart';

void main() => runApp(GoodworkApp());

class GoodworkApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Goodwork',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
