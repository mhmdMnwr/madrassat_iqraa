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

  bool _payed; // Private field to store the actual value
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
    required bool payed,
  })  : id = id ?? IdGenerator.generateId(),
        createdAt = createdAt ?? DateTime.now(),
        _payed = payed;

  // Computed getter for `payed`
  bool get payed {
    final today = DateTime.now();
    // Reset to false if it's the 25th and the student is not a teacher
    if (!isTeacher && today.day == 25) {
      return false;
    }
    return _payed;
  }

  // Setter to update the private `_payed` field
  set payed(bool value) => _payed = value;

  Student copyWith({
    String? name,
    int? money,
    String? id,
    String? birthDate,
    String? sex,
    bool? isTeacher,
    String? payDay,
    bool? payed,
    DateTime? createdAt,
  }) {
    return Student(
      name: name ?? this.name,
      money: money ?? this.money,
      id: id ?? this.id,
      birthDate: birthDate ?? this.birthDate,
      sex: sex ?? this.sex,
      isTeacher: isTeacher ?? this.isTeacher,
      payDay: payDay ?? this.payDay,
      payed: payed ?? this._payed,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props =>
      [name, birthDate, sex, isTeacher, createdAt, _payed];

  // Factory constructor to create a Student from JSON
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      name: json['name'] as String,
      money: json['money'] as int,
      id: json['id'] as String,
      birthDate: json['birthDate'] as String,
      payDay: json['payDay'] as String,
      sex: json['sex'] as String,
      isTeacher: json['isTeacher'] as bool,
      payed: json['payed'] as bool, // Sets the private `_payed`
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  // Convert Student to JSON (uses the private `_payed`)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'money': money,
      'birthDate': birthDate,
      'payDay': payDay,
      'id': id,
      'sex': sex,
      'isTeacher': isTeacher,
      'payed': _payed, // Save the stored value
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
