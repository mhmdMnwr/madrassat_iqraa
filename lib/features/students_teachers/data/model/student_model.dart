import 'package:equatable/equatable.dart';
import 'package:madrassat_iqraa/core/helper/id_generator.dart';

class Student extends Equatable {
  final String name;
  final int money;
  final String id;
  final String birthDate;
  final String sex;
  final bool isTeacher;
  final String payDay;
  int get age {
    final birthDateParsed = DateTime.parse(birthDate);
    final today = DateTime.now();
    int age = today.year - birthDateParsed.year;
    if (today.month < birthDateParsed.month ||
        (today.month == birthDateParsed.month &&
            today.day < birthDateParsed.day)) {
      age--;
    }
    return age;
  }

  final bool payed;
  final DateTime createdAt;

  Student({
    required this.payDay,
    String? id,
    required this.name,
    this.money = 0,
    required this.birthDate,
    required this.sex,
    required this.isTeacher,
    DateTime? createdAt,
    required this.payed,
  })  : id = id ?? IdGenerator.generateId(),
        createdAt = createdAt ?? DateTime.now();

  @override
  List<Object?> get props =>
      [name, birthDate, sex, isTeacher, createdAt, payed];

  // Factory constructor to create a Student instance from JSON
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      name: json['name'] as String,
      money: json['money'] as int,
      id: json['id'] as String,
      birthDate: json['birthDate'] as String,
      payDay: json['payDay'] as String,
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
      'money': money,
      'birthDate': birthDate,
      "payDay": payDay,
      'id': id,
      'registrationDate': birthDate,
      'sex': sex,
      'isTeacher': isTeacher,
      'payed': payed,
      // Convert createdAt from DateTime to String
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
