import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AppStarted extends AuthEvent {
  @override
  String toString() => 'AppStarted';

  @override
  List<Object> get props => [];
}

class BaseUrlLoaded extends AuthEvent {
  @override
  List<Object> get props => [];
}

class AccessTokenLoaded extends AuthEvent {
  @override
  List<Object> get props => [];
}

class Login extends AuthEvent {
  const Login({@required this.email, @required this.password});

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class Logout extends AuthEvent {
  @override
  List<Object> get props => [];
}
