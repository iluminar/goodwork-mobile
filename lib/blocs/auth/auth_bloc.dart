import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:goodwork/errors/user_not_found_exception.dart';
import 'package:goodwork/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import './bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  String baseUrl;
  final http.Client client = http.Client();
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  Map<String, dynamic> responseBody;

  @override
  AuthState get initialState => InitialAuthState();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is BaseUrlLoaded) {
      yield BaseUrlSet(urlSet: true);
    }

    if (event is Login) {
      try {
        yield UserLoading();

        await getBaseUrl();

        final Future<http.Response> response =
            sendTokenRequest(event.email, event.password);

        await saveTokenAndUser(response);

        final User user = User(
          name: responseBody['user']['name'],
          username: responseBody['user']['username'],
          avatar: responseBody['user']['avatar'] == null
              ? 'assets/images/avatar.png'
              : '$baseUrl/${responseBody['user']['avatar']}',
          bio: responseBody['user']['bio'],
          designation: responseBody['user']['designation'],
          email: responseBody['user']['email'],
          lang: responseBody['user']['lang'],
          timezone: responseBody['user']['timezone'],
          weekStart: responseBody['user']['week_start'],
        );

        yield UserLoaded(authUser: user);
      } catch (e) {
        yield UserNotFound();
      } finally {
        client.close();
      }
    }
  }

  Future<void> getBaseUrl() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('base_url')) {
      baseUrl = prefs.getString('base_url');
    }
  }

  Future<http.Response> sendTokenRequest(String email, String password) async {
    http.StreamedResponse response;
    final String url = '$baseUrl/oauth/token';
    response = await client.send(http.Request('POST', Uri.parse(url))
      ..headers['content-type'] = 'application/json'
      ..body = jsonEncode({
        'username': email,
        'password': password,
      }));

    return await http.Response.fromStream(response);
  }

  Future<void> saveTokenAndUser(Future<http.Response> response) async {
    await response.then((http.Response response) async {
      if (response.statusCode == 401) {
        throw UserNotFoundException();
      }
      responseBody = await json.decode(response.body);
      await storage.write(
          key: 'access_token', value: responseBody['access_token']);
      await storage.write(
          key: 'refresh_token', value: responseBody['refresh_token']);
    });
  }
}
