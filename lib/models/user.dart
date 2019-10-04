import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class User extends Equatable {
  User(
      {this.name,
      @required this.username,
      this.avatar,
      this.bio,
      this.designation,
      @required this.email,
      this.timezone,
      this.lang,
      this.weekStart});

  String name;
  String username;
  String avatar;
  String bio = '';
  String designation = '';
  String email;
  String timezone = '';
  String lang = '';
  String weekStart = '';

  @override
  List<Object> get props => [name, username, email];
}
