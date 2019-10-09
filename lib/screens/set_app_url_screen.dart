import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goodwork/blocs/auth/auth_bloc.dart';
import 'package:goodwork/blocs/auth/auth_event.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetAppUrlScreen extends StatefulWidget {
  const SetAppUrlScreen({this.prefs}) : super();

  final SharedPreferences prefs;

  @override
  _SetAppUrlScreenState createState() => _SetAppUrlScreenState();
}

class _SetAppUrlScreenState extends State<SetAppUrlScreen> {
  String url;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Material(
              borderRadius: BorderRadius.circular(5.0),
              child: Container(
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: Color.fromRGBO(60, 66, 87, .12),
                      blurRadius: 14.0,
                      offset: Offset(0.0, 7.0),
                    ),
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, .12),
                      blurRadius: 6.0,
                      offset: Offset(0.0, 3.0),
                    ),
                  ],
                  color: Colors.white,
                ),
                child: TextField(
                  onChanged: (String string) {
                    setState(() {
                      url = string;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Web app url',
                    hintStyle: const TextStyle(
                      fontSize: 20,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            RaisedButton(
              onPressed: () {
                widget.prefs.setString('base_url', url);
                final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
                authBloc.dispatch(BaseUrlLoaded());
              },
              color: Colors.teal,
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              child: const Text(
                'SAVE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
