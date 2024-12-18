// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:madrassat_iqraa/core/helper/id_generator.dart';

class User extends Equatable {
  final String userName;
  final String id;
  bool accepted;
  String password;

  User({
    String? id,
    required this.userName,
    required this.password,
    required this.accepted,
  }) : id = id ?? IdGenerator.generateId();

  @override
  List<Object?> get props => [userName];

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userName: json['userName'] as String,
      id: json['id'] as String,
      password: json['password'] as String,
      accepted: json['accepted'] as bool,
    );
  }

  // Convert a User instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      "accepted": accepted,
      "password": password,
    };
  }
}
