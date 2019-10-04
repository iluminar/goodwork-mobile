import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goodwork/blocs/auth/auth_bloc.dart';
import 'package:goodwork/blocs/auth/auth_state.dart';
import 'package:goodwork/models/user.dart';
import 'package:goodwork/screens/home_screen.dart';
import 'package:goodwork/screens/login_screen.dart';
import 'dart:io';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthBloc authBloc = AuthBloc();
  bool connected = false;

  @override
  void initState() {
    super.initState();
    checkConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    if (connected) {
      return Scaffold(
        extendBody: true,
        backgroundColor: Colors.grey[200],
        body: BlocProvider.value(
          value: authBloc,
          child: BlocBuilder(
            bloc: authBloc,
            builder: (BuildContext context, AuthState state) {
              if (state is InitialAuthState) {
                return loadLoginScreen();
              } else if (state is UserLoading) {
                return showLoadingScreen();
              } else if (state is UserLoaded) {
                return showHomeScreen(state.authUser);
              } else if (state is UserNotFound) {
                return loadLoginScreen();
              }
            },
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Container(
          child: Padding(
            padding: EdgeInsets.fromLTRB(25, 250, 25, 25),
            child: Column(
              children: <Widget>[
                Image.asset('assets/images/icon.png'),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                Text(
                    'No network available. Please turn on your wifi or cellular network')
              ],
            ),
          ),
        ),
      );
    }
  }

  void dispose() {
    authBloc.dispose();
  }

  void checkConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          connected = true;
        });
      }
    } on SocketException catch (_) {
      setState(() {
        connected = false;
      });
    }
  }
}

Widget loadLoginScreen() {
  return Center(
    child: LoginScreen(),
  );
}

Widget showHomeScreen(User authUser) {
  return Center(
    child: HomeScreen(
      authUser: authUser,
    ),
  );
}

Widget showLoadingScreen() {
  return Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
    ),
  );
}
