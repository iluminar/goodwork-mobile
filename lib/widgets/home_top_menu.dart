import 'package:flutter/material.dart';

class HomeTopMenu extends StatefulWidget {
  @override
  _HomeTopMenuState createState() => _HomeTopMenuState();
}

class _HomeTopMenuState extends State<HomeTopMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal,
      height: 48,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Material(
              color: Colors.teal,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.orange,
                      width: 3,
                    ),
                  ),
                ),
                child: FlatButton(
                  onPressed: () {},
                  child: const Text(
                    'Home',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Material(
              color: Colors.teal,
              child: Container(
                width: double.infinity,
                child: FlatButton(
                  onPressed: () {},
                  child: const Text(
                    'Projects',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Material(
              color: Colors.teal,
              child: Container(
                child: FlatButton(
                  onPressed: () {},
                  child: const Text(
                    'Teams',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Material(
              color: Colors.teal,
              child: Container(
                child: FlatButton(
                  onPressed: () {},
                  child: const Text(
                    'Offices',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
