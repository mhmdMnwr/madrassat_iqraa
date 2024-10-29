import 'package:equatable/equatable.dart';

class Student extends Equatable {
  final int? id;
  final String name;
  final String registrationDate;
  final String sex;
  final bool isTeacher;
  final bool payed;
  final DateTime createdAt;

  const Student({
    this.id,
    required this.name,
    required this.registrationDate,
    required this.sex,
    required this.isTeacher,
    required this.createdAt,
    required this.payed,
  });

  @override
  List<Object?> get props =>
      [id, name, registrationDate, sex, isTeacher, createdAt, payed];

  // Factory constructor to create a Student instance from JSON
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] as int?,
      name: json['name'] as String,
      registrationDate: json['registrationDate'] as String,
      sex: json['sex'] as String,
      isTeacher: json['isTeacher'] as bool,
      payed: json['payed'] as bool,
      // Parse createdAt from String to DateTime
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  // Method to convert a Student instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'registrationDate': registrationDate,
      'sex': sex,
      'isTeacher': isTeacher,
      'payed': payed,
      // Convert createdAt from DateTime to String
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
