import 'package:equatable/equatable.dart';
import 'package:goodwork/models/user.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class InitialAuthState extends AuthState {
  @override
  List<Object> get props => [];
}

class UserLoading extends AuthState {
  @override
  List<Object> get props => [];
}

class UserNotFound extends AuthState {
  @override
  List<Object> get props => [];
}

class UserLoaded extends AuthState {
  const UserLoaded({this.authUser});

  final User authUser;

  @override
  List<Object> get props => [authUser];
}
