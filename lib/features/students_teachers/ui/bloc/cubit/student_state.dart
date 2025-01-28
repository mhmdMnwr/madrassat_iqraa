import 'package:equatable/equatable.dart';
import 'package:madrassat_iqraa/features/students_teachers/data/model/payed_months.dart';
import '../../../data/model/student_model.dart';

// Base class for all student states
abstract class StudentState extends Equatable {
  const StudentState();

  @override
  List<Object?> get props => [];
}

// State when data is being loaded
class StudentLoading extends StudentState {}

// State when data is successfully loaded
class StudentLoaded extends StudentState {
  final List<Student> students;

  const StudentLoaded({required this.students});

  @override
  List<Object?> get props => [students];
}

// State when data is successfully loaded
class SearchedStudentLoaded extends StudentState {
  final List<Student> students;

  const SearchedStudentLoaded({required this.students});

  @override
  List<Object?> get props => [students];
}

// State when there is an error
class StudentError extends StudentState {
  final String message;

  const StudentError({required this.message});

  @override
  List<Object?> get props => [message];
}

// State when a student operation (add/update/delete) succeeds
class StudentOperationSuccess extends StudentState {}

class PayedMonthsLoaded extends StudentState {
  final List<PayedMonths> dates;

  const PayedMonthsLoaded({required this.dates});

  @override
  List<Object?> get props => [dates];
}

class PayedMonthSuccess extends StudentState {}

class PayedMonthError extends StudentState {
  final String message;

  const PayedMonthError({required this.message});

  @override
  List<Object?> get props => [message];
}
