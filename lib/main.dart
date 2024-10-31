// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:madrassat_iqraa/core/navigation/router.dart';
import 'package:madrassat_iqraa/injection.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 960),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: "Cairo",
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: router,
      ),
    );
  }
}

// class MyHomePage extends StatelessWidget {
//   MyHomePage({super.key});

//   final Student student1 = Student(
//       id: 123,
//       name: "new nale",
//       registrationDate: "11/12/2024",
//       sex: "boy",
//       isTeacher: true,
//       createdAt: DateTime.now(),
//       payed: false);
//   // final FirebaseFirestore firestore = FirebaseFirestore();
//   // StudentRemoteDataSource srd =StudentRemoteDataSource(firestore: FirebaseFirestore());
//   StudentRepository sr = StudentRepository(
//     dataSource: StudentRemoteDataSource(firestore: FirebaseFirestore.instance),
//     connectionChecker: InternetConnectionChecker(),
//   );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "test",
//           style: TextStyle(
//             fontSize: 50,
//             color: Colors.red,
//           ),
//         ),
//       ),
//       body: Center(
//         child: ElevatedButton(
//             onPressed: () async {
//               // final result =
//               await sr.updateStudent(123, student1);
//               // result.fold(
//               //   (failure) {
//               //     print(failure);
//               //   },
//               //   (list) {
//               //     if (list.isNotEmpty) {
//               //       list.forEach((student) => print(student.toJson()));
//               //     } else {
//               //       print("No students found with the specified criteria.");
//               //     }
//               //   },
//               // );
//               // print(sr.getStudentsByIsTeacher(isTeacher: false));
//             },
//             child: const Icon(
//               Icons.add,
//               color: Colors.blue,
//             )),
//       ),
//     );
//   }
// }
