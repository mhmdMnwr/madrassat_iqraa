import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:madrassat_iqraa/features/students_teachers/data/model/student_model.dart';

class StudentRemoteDataSource {
  final FirebaseFirestore firestore;

  StudentRemoteDataSource({required this.firestore});

  //! Get all students
  Future<List<Student>> getAllStudents() async {
    try {
      final querySnapshot = await firestore.collection('students').get();
      return querySnapshot.docs
          .map((doc) => Student.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      // Handle any errors that occur during the fetch
      print('Error fetching students: $e');
      return [];
    }
  }

  //! Get student by ID
  Future<Student?> getStudentById(String id) async {
    final querySnapshot = await firestore.collection('students').doc(id).get();

    return Student.fromJson(querySnapshot.data()!);
  }

  //! Get student by name
  Future<List<Student>> getStudentsByNamePrefix(String namePrefix) async {
    final querySnapshot = await firestore
        .collection('students')
        .orderBy('name')
        .startAt([namePrefix]).get();

    return querySnapshot.docs
        .map((doc) => Student.fromJson(doc.data()))
        .toList();
  }

  //! Get students by isTeacher
  Future<List<Student>> getStudentsByIsTeacher({bool isTeacher = true}) async {
    final querySnapshot = await firestore
        .collection('students')
        .where('isTeacher', isEqualTo: isTeacher)
        .get();

    return querySnapshot.docs
        .map((doc) => Student.fromJson(doc.data()))
        .toList();
  }

  Future<List<Student>> getpayedStudents(
      {bool isTeacher = false, payed = true}) async {
    final querySnapshot = await firestore
        .collection('students')
        .where('isTeacher', isEqualTo: isTeacher)
        .where('payed', isEqualTo: payed)
        .get();

    return querySnapshot.docs
        .map((doc) => Student.fromJson(doc.data()))
        .toList();
  }

  //! Create a new student
  Future<void> createStudent(Student student) async {
    final docRef = firestore.collection('students').doc();
    await docRef.set(student.toJson());
  }

  //! Update an existing student
  Future<void> updateStudent(int id, Student student) async {
    final querySnapshot = await firestore
        .collection('students')
        .where('id', isEqualTo: id)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final docId = querySnapshot.docs.first.id;
      await firestore
          .collection('students')
          .doc(docId)
          .update(student.toJson());
    }
  }

  //! Delete a student
  Future<void> deleteStudent(int id) async {
    final querySnapshot = await firestore
        .collection('students')
        .where('id', isEqualTo: id)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final docId = querySnapshot.docs.first.id;
      await firestore.collection('students').doc(docId).delete();
    }
  }
}
