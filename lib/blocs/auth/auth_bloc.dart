import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:goodwork/errors/user_not_found_exception.dart';
import 'package:goodwork/models/user.dart';
import 'package:http/http.dart' as http;

import './bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final String baseUrl = 'http://192.168.0.104/';
  final http.Client client = http.Client();
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  Map<String, dynamic> responseBody;

  @override
  AuthState get initialState => InitialAuthState();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is Login) {
      try {
        yield UserLoading();

        final Future<http.Response> response =
            sendTokenRequest(event.email, event.password);

        await saveTokenAndUser(response);

        final User user = User(
          name: responseBody['user']['name'],
          username: responseBody['user']['username'],
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

  Future<http.Response> sendTokenRequest(String email, String password) async {
    http.StreamedResponse response;
    response = await client
        .send(http.Request('POST', Uri.parse('${baseUrl}oauth/token'))
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
      await storage.write(key: 'token', value: responseBody['access_token']);
    });
  }
}
