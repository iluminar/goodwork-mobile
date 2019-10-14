import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:goodwork/blocs/auth/auth_bloc.dart';
import 'package:goodwork/blocs/auth/auth_event.dart';
import 'package:goodwork/blocs/auth/auth_state.dart';
import 'package:goodwork/blocs/home/home_bloc.dart';
import 'package:goodwork/blocs/home/home_state.dart';
import 'package:goodwork/models/user.dart';
import 'package:goodwork/repositories/auth_repository.dart';
import 'package:goodwork/repositories/task_repository.dart';
import 'package:goodwork/screens/connection_request_screen.dart';
import 'package:goodwork/screens/home_screen.dart';
import 'package:goodwork/screens/loading_screen.dart';
import 'package:goodwork/screens/login_screen.dart';
import 'package:goodwork/screens/set_app_url_screen.dart';
import 'package:goodwork/widgets/side_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  bool _connected = false;
  bool _webAppUrlSet = false;
  bool _loggedIn = false;
  String webAppUrl;
  SharedPreferences prefs;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final AuthBloc authBloc = AuthBloc(AuthRepository());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    initConnectivity();
    initPreference();
    checkAuthStatus();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> initPreference() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('base_url')) {
      webAppUrl = prefs.getString('base_url');
      _webAppUrlSet = true;
    }
  }

  Future<void> checkAuthStatus() async {
    final String _accessToken = await _storage.read(key: 'access_token');
    _loggedIn = _accessToken != null;
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
        _connected = true;
      });
    }
  }

  void showErrorMessage(String message) {
    final SnackBar snackBar = SnackBar(
      content: Text(
        '$message',
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      duration: Duration(seconds: 5),
      backgroundColor: Colors.red,
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Goodwork',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: BlocProvider.value(
        value: authBloc,
        child: BlocListener(
          bloc: authBloc,
          listener: (BuildContext context, AuthState state) {
            if (state is UserNotFound) {
              showErrorMessage('User not found');
            } else if (state is InitialAuthState) {
              _loggedIn = false;
            }
          },
          child: BlocBuilder(
            bloc: authBloc,
            builder: (BuildContext context, AuthState state) {
              if (state is UserLoaded) {
                return Scaffold(
                  extendBody: true,
                  appBar: AppBar(
                    elevation: 0,
                    title: const Text('Goodwork'),
                  ),
                  backgroundColor: Colors.grey[200],
                  endDrawer: showDrawerMenu(state.authUser),
                  body: loadScreen(state),
                );
              }
              return Scaffold(
                key: _scaffoldKey,
                extendBody: true,
                backgroundColor: Colors.grey[200],
                body: loadScreen(state),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget loadScreen(AuthState state) {
    if (state is InitialAuthState) {
      return _connected == true
          ? loadSetAppUrlScreen()
          : ConnectionRequestScreen();
    } else if (state is BaseUrlSet) {
      return loadSetAppUrlScreen();
    } else if (state is UserLoading) {
      return showLoadingScreen();
    } else if (state is UserLoaded) {
      return showHomeScreen(state.authUser);
    } else if (state is UserNotFound) {
      return loadSetAppUrlScreen();
    }
  }

  Widget loadSetAppUrlScreen() {
    return _webAppUrlSet == true
        ? loadLoginScreen()
        : SetAppUrlScreen(
            prefs: prefs,
          );
  }

  Widget loadLoginScreen() {
    if (_loggedIn) {
      authBloc.dispatch(AccessTokenLoaded());
      return showLoadingScreen();
    }
    return LoginScreen();
  }

  Widget showHomeScreen(User authUser) {
    return BlocBuilder(
      bloc: HomeBloc(authBloc, TaskRepository()),
      builder: (BuildContext context, HomeState state) {
        if (state is CurrentWorkLoaded) {
          return HomeScreen(
            authUser: authUser,
            currentWork: state.currentWork,
          );
        }
        return Center(
          child: HomeScreen(
            authUser: authUser,
          ),
        );
      },
    );
  }

  Widget showLoadingScreen() {
    return Center(
      child: LoadingScreen(),
    );
  }

  Widget showDrawerMenu(User authUser) {
    return SideMenu(
      authUser: authUser,
    );
  }

  @override
  void dispose() {
    super.dispose();
    authBloc.dispose();
  }
}
