import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class UserLoggedIn extends HomeEvent {
  @override
  List<Object> get props => [];
}
