import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:madrassat_iqraa/features/students_teachers/data/repo/student_repo.dart';
import 'package:madrassat_iqraa/features/students_teachers/data/source/student_firebase_service.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/bloc/cubit/student_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupInjection() async {
  // Register Firebase services
  await Firebase
      .initializeApp(); // Make sure to initialize Firebase before using it
  final firestore = FirebaseFirestore.instance;

  // Register services
  getIt.registerLazySingleton<FirebaseFirestore>(() => firestore);
  getIt.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());

  // Register Data Sources
  getIt.registerLazySingleton<StudentRemoteDataSource>(
    () => StudentRemoteDataSource(firestore: getIt<FirebaseFirestore>()),
  );

  // Register Repositories
  getIt.registerLazySingleton<StudentRepository>(
    () => StudentRepository(
      dataSource: getIt<StudentRemoteDataSource>(),
      connectionChecker: getIt<InternetConnectionChecker>(),
    ),
  );

  // Register Cubits
  getIt.registerFactory<StudentCubit>(
    () => StudentCubit(repository: getIt<StudentRepository>()),
  );

  // Register other services, repositories, and cubits as needed
}
