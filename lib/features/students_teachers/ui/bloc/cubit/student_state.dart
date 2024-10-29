import 'package:equatable/equatable.dart';
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

// State when there is an error
class StudentError extends StudentState {
  final String message;

  const StudentError({required this.message});

  @override
  List<Object?> get props => [message];
}

// State when a student operation (add/update/delete) succeeds
class StudentOperationSuccess extends StudentState {}
