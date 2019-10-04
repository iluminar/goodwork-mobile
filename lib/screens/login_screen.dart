import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goodwork/blocs/auth/auth_bloc.dart';
import 'package:goodwork/blocs/auth/auth_event.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(36.0, 20.0, 36.0, 0.0),
        child: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Text(
                    'GOODWORK',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  'Sensible Approach to Work & Collaboration for Software Teams',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
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
                          email = string;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'E-mail',
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
                          password = string;
                        });
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
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
                    final AuthBloc authBloc =
                        BlocProvider.of<AuthBloc>(context);
                    authBloc.dispatch(Login(email: email, password: password));
                  },
                  color: Colors.teal,
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const InkWell(
                  child: Text(
                    'Forgot Your Password?',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
