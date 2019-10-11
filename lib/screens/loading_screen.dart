import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal,
      child: const FlareActor(
        'assets/images/loading.flr',
        alignment: Alignment.center,
        animation: 'Loading',
      ),
    );
  }
}
