import 'package:equatable/equatable.dart';
import 'package:madrassat_iqraa/core/admin/admin_state.dart';

class Student extends Equatable {
  final String name;
  final String registrationDate;
  final String sex;
  final bool isTeacher;
  final bool payed;
  final DateTime createdAt;

  Student({
    required this.name,
    required this.registrationDate,
    required this.sex,
    required this.isTeacher,
    required this.createdAt,
    required this.payed,
  }) {
    if (isTeacher) {
      AdminStatsService().incrementTeacherCount();
    } else {
      AdminStatsService().incrementStudentCount();
    }
  }

  @override
  List<Object?> get props =>
      [name, registrationDate, sex, isTeacher, createdAt, payed];

  // Factory constructor to create a Student instance from JSON
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
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
