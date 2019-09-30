import 'package:flutter/material.dart';

void main() => runApp(GoodworkApp());

class GoodworkApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Goodwork',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: Colors.teal,
        body: Center(
          child: Text("Welcome!"),
        ),
      ),
    );
  }
}
