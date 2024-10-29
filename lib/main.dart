// import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:madrassat_iqraa/features/students_teachers/data/model/student_model.dart';
import 'package:madrassat_iqraa/features/students_teachers/data/repo/student_repo.dart';
import 'package:madrassat_iqraa/features/students_teachers/data/source/student_firebase_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final Student student1 = Student(
      id: 123,
      name: "new nale",
      registrationDate: "11/12/2024",
      sex: "boy",
      isTeacher: true,
      createdAt: DateTime.now(),
      payed: false);
  // final FirebaseFirestore firestore = FirebaseFirestore();
  // StudentRemoteDataSource srd =StudentRemoteDataSource(firestore: FirebaseFirestore());
  StudentRepository sr = StudentRepository(
    dataSource: StudentRemoteDataSource(firestore: FirebaseFirestore.instance),
    connectionChecker: InternetConnectionChecker(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "test",
          style: TextStyle(
            fontSize: 50,
            color: Colors.red,
          ),
        ),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              // final result =
              await sr.updateStudent(123, student1);
              // result.fold(
              //   (failure) {
              //     print(failure);
              //   },
              //   (list) {
              //     if (list.isNotEmpty) {
              //       list.forEach((student) => print(student.toJson()));
              //     } else {
              //       print("No students found with the specified criteria.");
              //     }
              //   },
              // );
              // print(sr.getStudentsByIsTeacher(isTeacher: false));
            },
            child: const Icon(
              Icons.add,
              color: Colors.blue,
            )),
      ),
    );
  }
}
