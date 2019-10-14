import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:goodwork/errors/user_not_found_exception.dart';
import 'package:goodwork/models/user.dart';
import 'package:goodwork/repositories/auth_repository.dart';
import 'package:http/http.dart' as http;

import './bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this.authRepository);

  String baseUrl;
  final http.Client client = http.Client();
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final AuthRepository authRepository;
  Map<String, dynamic> responseBody;

  @override
  AuthState get initialState => InitialAuthState();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    try {
      if (event is BaseUrlLoaded) {
        yield const BaseUrlSet(urlSet: true);
        print('BaseUrlSet');
      }
      if (event is AccessTokenLoaded) {
        yield UserLoading();

        final Map<String, dynamic> response =
            await authRepository.getAuthUser();
        final User user = await getUser(response);

        yield UserLoaded(authUser: user);
      }

      if (event is Login) {
        yield UserLoading();

        final Future<http.Response> response =
            authRepository.sendTokenRequest(event.email, event.password);

        await saveTokenAndUser(response);

        final User user = await getUser(responseBody['user']);

        yield UserLoaded(authUser: user);
      }

      if ( event is Logout ) {
        await removeAccessToken();

        yield InitialAuthState();
      }
    } catch (e) {
      yield UserNotFound();
    } finally {
      client.close();
    }
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

  Future<User> getUser(Map<String, dynamic> user) async {
    baseUrl = await authRepository.getBaseUrl();
    return User(
      name: user['name'],
      username: user['username'],
      avatar: user['avatar'] == null
          ? 'assets/images/avatar.png'
          : "$baseUrl/${user['avatar']}",
      bio: user['bio'],
      designation: user['designation'],
      email: user['email'],
      lang: user['lang'],
      timezone: user['timezone'],
      weekStart: user['week_start'],
    );
  }

  Future<void> removeAccessToken() async {
    await storage.delete(key: 'access_token');
  }
}
