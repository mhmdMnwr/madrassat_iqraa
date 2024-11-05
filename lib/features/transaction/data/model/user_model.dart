// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String user;
  const User({
    required this.user,
  });

  @override
  List<Object> get props => [user];

  factory User.fromJson(Map<String, dynamic> json) {
    return User(user: json['user'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'user': user};
  }
}
