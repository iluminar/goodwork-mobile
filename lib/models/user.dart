import 'package:goodwork/models/base_model.dart';
import 'package:meta/meta.dart';

class User extends BaseModel {
  User({
    this.name,
    @required this.username,
    this.avatar,
    this.bio,
    this.designation,
    @required this.email,
    this.timezone,
    this.lang,
    this.weekStart,
  });

  final String name;
  final String username;
  final String avatar;
  final String bio;
  final String designation;
  final String email;
  final String timezone;
  final String lang;
  final String weekStart;

  @override
  List<Object> get props => <String>[name, username, email];

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'username': username,
      'avatar': avatar,
      'bio': bio,
      'designation': designation,
      'email': email,
      'timezone': timezone,
      'lang': lang,
      'week_start': weekStart,
    };
  }
}
