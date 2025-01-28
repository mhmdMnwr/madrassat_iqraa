import 'package:equatable/equatable.dart';

class SchoolState extends Equatable {
  final int totalFunds;
  final int teacherCount;
  final int studentCount;

  const SchoolState({
    required this.totalFunds,
    required this.teacherCount,
    required this.studentCount,
  });

  SchoolState copyWith({
    int? totalFunds,
    int? teacherCount,
    int? studentCount,
  }) {
    return SchoolState(
      totalFunds: totalFunds ?? this.totalFunds,
      teacherCount: teacherCount ?? this.teacherCount,
      studentCount: studentCount ?? this.studentCount,
    );
  }

  @override
  List<Object?> get props => [totalFunds, teacherCount, studentCount];

  factory SchoolState.fromJson(Map<String, dynamic> json) {
    return SchoolState(
      totalFunds: json['totalFunds'],
      teacherCount: json['teacherCount'],
      studentCount: json['studentCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalFunds': totalFunds,
      'teacherCount': teacherCount,
      'studentCount': studentCount,
    };
  }
}
