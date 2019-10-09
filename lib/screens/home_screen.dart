import 'package:flutter/material.dart';
import 'package:goodwork/blocs/auth/auth_state.dart';
import 'package:goodwork/models/task.dart';
import 'package:goodwork/models/user.dart';
import 'package:goodwork/widgets/default_dashboard.dart';
import 'package:goodwork/widgets/home_top_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({this.authUser, this.currentWork}) : super();

  final User authUser;
  final List<Task> currentWork;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 0.3,
            color: Colors.white,
          ),
        ),
      ),
      child: Column(
        children: <Widget>[
          HomeTopMenu(),
          DefaultDashboard(
            currentWork: widget.currentWork,
          ),
        ],
      ),
    );
  }
}
