import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:madrassat_iqraa/features/home/data/repo/user_repo.dart';
import 'package:madrassat_iqraa/features/home/data/source/local_data_source.dart';
import 'package:madrassat_iqraa/features/home/data/source/user_database.dart';
import 'package:madrassat_iqraa/features/home/ui/bloc/cubit/user_cubit.dart';
import 'package:madrassat_iqraa/features/students_teachers/data/repo/student_repo.dart';
import 'package:madrassat_iqraa/features/students_teachers/data/source/student_firebase_service.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/bloc/cubit/student_cubit.dart';
import 'package:madrassat_iqraa/features/transaction/data/repo/transaction_repo.dart';
import 'package:madrassat_iqraa/features/transaction/data/source/transaction_firebase.dart';
import 'package:madrassat_iqraa/features/transaction/ui/bloc/cubit/transactions_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupInjection() async {
  //! Initialize Firebase
  await Firebase.initializeApp();

  //! Register Firebase services
  final firestore = FirebaseFirestore.instance;
  getIt.registerLazySingleton<FirebaseFirestore>(() => firestore);

  //! Register InternetConnectionChecker
  getIt.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker(),
  );

  //! Register SharedPreferences for local storage
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  //! Register student  Data Sources
  getIt.registerLazySingleton<StudentRemoteDataSource>(
    () => StudentRemoteDataSource(firestore: getIt<FirebaseFirestore>()),
  );

  //! Register transaction  Data Sources
  getIt.registerLazySingleton<TransactionsRemoteDataSource>(
    () => TransactionsRemoteDataSource(firestore: getIt<FirebaseFirestore>()),
  );

  //! User local data sources
  getIt.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSource(), // Pass SharedPreferences instance
  );

  //!user remote data source
  getIt.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSource(firestore: getIt<FirebaseFirestore>()),
  );

  //! Register student Repositories
  getIt.registerLazySingleton<StudentRepository>(
    () => StudentRepository(
      dataSource: getIt<StudentRemoteDataSource>(),
      connectionChecker: getIt<InternetConnectionChecker>(),
    ),
  );

  //! Register transaction Repositories
  getIt.registerLazySingleton<TransactionsRepository>(
    () => TransactionsRepository(
      dataSource: getIt<TransactionsRemoteDataSource>(),
      connectionChecker: getIt<InternetConnectionChecker>(),
    ),
  );

  //! user repository
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepository(
      localDataSource: getIt<UserLocalDataSource>(),
      remoteDataSource: getIt<UserRemoteDataSource>(),
      connectionChecker: getIt<InternetConnectionChecker>(),
    ),
  );

  //! Register student  Cubits
  getIt.registerFactory<StudentCubit>(
    () => StudentCubit(repository: getIt<StudentRepository>()),
  );

  //! Register transaction  Cubits
  getIt.registerFactory<TransactionsCubit>(
    () => TransactionsCubit(repository: getIt<TransactionsRepository>()),
  );
//! register user cubit
  getIt.registerFactory<UserCubit>(
    () => UserCubit(userRepository: getIt<UserRepository>()),
  );

  // Register other services, repositories, and cubits as needed.
}
