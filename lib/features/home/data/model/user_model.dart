// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String userName;
  const User({
    required this.userName,
  });

  @override
  List<Object?> get props => [userName];

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userName: json['userName'] as String,
    );
  }

  // Convert a User instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
    };
  }
}
