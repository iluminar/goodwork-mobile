import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goodwork/blocs/auth/auth_bloc.dart';
import 'package:goodwork/blocs/auth/auth_state.dart';
import 'package:goodwork/models/user.dart';
import 'package:goodwork/screens/connection_request_screen.dart';
import 'package:goodwork/screens/home_screen.dart';
import 'package:goodwork/screens/login_screen.dart';
import 'package:goodwork/widgets/side_menu.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.teal,
  ));
  runApp(GoodworkApp());
}

class GoodworkApp extends StatefulWidget {
  @override
  _GoodworkAppState createState() => _GoodworkAppState();
}

class _GoodworkAppState extends State<GoodworkApp> {
  bool _isConnected = false;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final AuthBloc authBloc = AuthBloc();

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;

    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    if (!mounted) {
      return;
    }

    _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      setState(() {
        _isConnected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Goodwork',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider.value(
        value: authBloc,
        child: BlocBuilder(
          bloc: authBloc,
          builder: (BuildContext context, AuthState state) {
            if (state is UserLoaded) {
              return Scaffold(
                extendBody: true,
                backgroundColor: Colors.grey[200],
                drawer: showDrawerMenu(state.authUser),
                body: loadScreen(state),
              );
            }
            return Scaffold(
              extendBody: true,
              backgroundColor: Colors.grey[200],
              body: loadScreen(state),
            );
          },
        ),
      ),
    );
  }

  Widget loadScreen(AuthState state) {
    if (state is InitialAuthState) {
      return _isConnected == true
          ? loadLoginScreen()
          : ConnectionRequestScreen();
    } else if (state is UserLoading) {
      return showLoadingScreen();
    } else if (state is UserLoaded) {
      return showHomeScreen(state.authUser);
    } else if (state is UserNotFound) {
      return loadLoginScreen();
    }
  }

  void dispose() {
    authBloc.dispose();
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

Widget showDrawerMenu(User authUser) {
  return SideMenu(
    authUser: authUser,
  );
}
