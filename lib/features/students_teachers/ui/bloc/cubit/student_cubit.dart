import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrassat_iqraa/features/students_teachers/data/model/payed_months.dart';
import 'package:madrassat_iqraa/features/students_teachers/data/model/student_model.dart';
import 'package:madrassat_iqraa/features/students_teachers/data/repo/student_repo.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/bloc/cubit/student_state.dart';

class StudentCubit extends Cubit<StudentState> {
  final StudentRepository _repository;

  StudentCubit({required StudentRepository repository})
      : _repository = repository,
        super(StudentLoading());

  // Load all students
  Future<void> loadStudents({required bool isteacher}) async {
    emit(StudentLoading());
    final result =
        await _repository.getStudentsByIsTeacher(isTeacher: isteacher);
    result.fold(
      (failure) => emit(StudentError(message: failure)),
      (students) =>
          emit(StudentLoaded(students: students.whereType<Student>().toList())),
    );
  }

  //search student
  Future<void> searchStudents(String name, {required bool isTeacher}) async {
    emit(StudentLoading());
    final result = await _repository.getStudentsByName(
      name,
      isTeacher: isTeacher,
    );
    result.fold(
      (failure) => emit(StudentError(message: failure)),
      (students) => emit(SearchedStudentLoaded(
          students: students.whereType<Student>().toList())),
    );
  }

  // Add a new student
  Future<void> addStudent(Student student, {required bool isTeacher}) async {
    emit(StudentLoading());
    final result = await _repository.createStudent(student);
    result.fold(
      (failure) => emit(StudentError(message: failure)),
      (_) => emit(StudentAdded()),
    );
    await loadStudents(isteacher: isTeacher); // Refresh after adding
  }

  // Update an existing student
  Future<void> updateStudent(String id, Student student,
      {required bool isTeacher}) async {
    final result = await _repository.updateStudent(id, student);
    result.fold(
      (failure) => emit(StudentError(message: failure)),
      (_) => emit(StudentUpdated()),
    );
    await loadStudents(isteacher: isTeacher); // Refresh after updating
  }

  Future<void> updatePayed(String id, Student student,
      {required bool isTeacher}) async {
    final result = await _repository.updateStudent(id, student);
    result.fold(
      (failure) => emit(StudentError(message: failure)),
      (_) => emit(StudentPayed()),
    );
    await loadStudents(isteacher: isTeacher); // Refresh after updating
  }

  // Delete a student
  Future<void> deleteStudent(String id, {required bool isTeacher}) async {
    final result = await _repository.deleteStudent(id);
    result.fold(
      (failure) => emit(StudentError(message: failure)),
      (_) => emit(StudentDeleted()),
    );
    await loadStudents(isteacher: isTeacher); // Refresh after deleting
  }

  //change all students payed status
  Future<void> changeAllStudentsPayedStatus() async {
    final result = await _repository.changeAllStudentsPayedStatus();
    result.fold(
      (failure) => emit(StudentError(message: failure)),
      (_) => emit(StudentOperationSuccess()),
    );
  }

  //create payed months
  Future<void> createPayedMonths(PayedMonths date) async {
    final result = await _repository.createPayedMonths(date);
    result.fold(
      (failure) => emit(PayedMonthError(message: failure)),
      (_) => emit(PayedMonthSuccess()),
    );
  }

  //get payed months
  Future<void> getPayedMonths({required String id}) async {
    emit(StudentLoading());
    final result = await _repository.getPayedMonths(id: id);
    result.fold(
      (failure) => emit(PayedMonthError(message: failure)),
      (dates) => emit(PayedMonthsLoaded(dates: dates)),
    );
  }
}
