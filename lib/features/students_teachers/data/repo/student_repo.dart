import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:madrassat_iqraa/core/error/error_message.dart';
import 'package:madrassat_iqraa/features/students_teachers/data/model/student_model.dart';

import '../source/student_firebase_service.dart';

class StudentRepository {
  final StudentRemoteDataSource _dataSource;
  final InternetConnectionChecker _connectionChecker;

  StudentRepository({
    required StudentRemoteDataSource dataSource,
    required InternetConnectionChecker connectionChecker,
  })  : _dataSource = dataSource,
        _connectionChecker = connectionChecker;

  // Helper method to check for internet connectivity
  Future<bool> _hasConnection() async {
    return await _connectionChecker.hasConnection;
  }

  // Get student by ID with error handling
  Future<Either<String, List<Student?>>> getAllStudents() async {
    if (await _hasConnection()) {
      try {
        final students = await _dataSource.getStudentsByNamePrefix("test");
        return Right(students);
      } catch (e) {
        return Left(ordinaryError);
      }
    } else {
      return Left(noConnctionError);
    }
  }

  // Get student by ID with error handling
  Future<Either<String, Student?>> getStudentById(String id) async {
    if (await _hasConnection()) {
      try {
        final student = await _dataSource.getStudentById(id);
        return Right(student);
      } catch (e) {
        return Left(ordinaryError);
      }
    } else {
      return Left(noConnctionError);
    }
  }

  // Get student by name with error handling
  Future<Either<String, List<Student>>> getStudentsByNamePrefix(
      String namePrefix) async {
    if (await _hasConnection()) {
      try {
        final students = await _dataSource.getStudentsByNamePrefix(namePrefix);
        return Right(students);
      } catch (e) {
        return Left(ordinaryError);
      }
    } else {
      return Left(noConnctionError);
    }
  }

  // Get students by isTeacher status with error handling
  Future<Either<String, List<Student>>> getStudentsByIsTeacher(
      {bool isTeacher = true}) async {
    if (await _hasConnection()) {
      try {
        final students = await _dataSource.getStudentsByIsTeacher();
        return Right(students);
      } catch (e) {
        return Left(ordinaryError);
      }
    } else {
      return Left(noConnctionError);
    }
  }

  Future<Either<String, List<Student>>> getStudentsBypayed({
    bool isTeacher = false,
    bool payed = true,
  }) async {
    if (await _hasConnection()) {
      try {
        final students = await _dataSource.getpayedStudents(
          isTeacher: isTeacher,
          payed: payed,
        );
        return Right(students);
      } catch (e) {
        return Left(ordinaryError);
      }
    } else {
      return Left(noConnctionError);
    }
  }

  // Create a new student with error handling
  Future<Either<String, void>> createStudent(Student student) async {
    if (await _hasConnection()) {
      try {
        await _dataSource.createStudent(student);
        return const Right(null);
      } catch (e) {
        return Left(ordinaryError);
      }
    } else {
      return Left(noConnctionError);
    }
  }

  // Update an existing student with error handling
  Future<Either<String, void>> updateStudent(int id, Student student) async {
    if (await _hasConnection()) {
      try {
        await _dataSource.updateStudent(id, student);
        return const Right(null);
      } catch (e) {
        return Left(ordinaryError);
      }
    } else {
      return Left(noConnctionError);
    }
  }

  // Delete a student with error handling
  Future<Either<String, void>> deleteStudent(int id) async {
    if (await _hasConnection()) {
      try {
        await _dataSource.deleteStudent(id);
        return const Right(null);
      } catch (e) {
        return Left(ordinaryError);
      }
    } else {
      return Left(noConnctionError);
    }
  }
}
