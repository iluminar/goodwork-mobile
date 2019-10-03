import 'package:flutter/material.dart';
import 'package:goodwork/blocs/auth/auth_state.dart';
import 'package:goodwork/models/user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({this.authUser}) : super();

  final User authUser;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Welcome ${widget.authUser.name}'),
    );
  }
}
