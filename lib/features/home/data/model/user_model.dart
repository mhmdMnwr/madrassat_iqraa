// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:madrassat_iqraa/core/helper/id_generator.dart';

class User extends Equatable {
  final String userName;
  final String id;
  final bool refused;
  final bool accepted;
  final String password;

  User({
    String? id,
    required this.refused,
    required this.userName,
    required this.password,
    required this.accepted,
  }) : id = id ?? IdGenerator.generateId();

  User copyWith({
    String? userName,
    String? id,
    bool? refused,
    bool? accepted,
    String? password,
  }) {
    return User(
      userName: userName ?? this.userName,
      id: id ?? this.id,
      refused: refused ?? this.refused,
      accepted: accepted ?? this.accepted,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [userName];

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userName: json['userName'] as String,
      refused: json['refused'] as bool,
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
      'refused': refused,
      "accepted": accepted,
      "password": password,
    };
  }
}
