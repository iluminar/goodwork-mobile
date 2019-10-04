import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class ConnectionRequestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 200,
            child: FlareActor(
              'assets/images/no_connection.flr',
              alignment: Alignment.center,
              animation: 'no_connection',
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Text(
            'NO CONNECTION',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
