import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:madrassat_iqraa/core/admin/cubit/admin_cubit.dart';
import 'package:madrassat_iqraa/core/navigation/main_page.dart';
import 'package:madrassat_iqraa/features/home/ui/bloc/cubit/user_cubit.dart';
import 'package:madrassat_iqraa/features/home/ui/pages/admin.dart';
import 'package:madrassat_iqraa/features/home/ui/pages/home_page.dart';
import 'package:madrassat_iqraa/features/home/ui/pages/login_page.dart';
import 'package:madrassat_iqraa/features/home/ui/pages/splash_screen.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/bloc/cubit/student_cubit.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/pages/search_page.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/pages/stud&teach_page.dart';
import 'package:madrassat_iqraa/features/transaction/ui/bloc/cubit/transactions_cubit.dart';
import 'package:madrassat_iqraa/features/transaction/ui/pages/income_expense_page.dart';
import 'package:madrassat_iqraa/features/transaction/ui/pages/transaction_page.dart';
import 'package:madrassat_iqraa/injection.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
        path: '/',
        builder: (context, state) => BlocProvider(
              create: (context) => getIt<UserCubit>(),
              child: SplashScreen(),
            )),
    GoRoute(
        path: '/Main',
        builder: (context, state) => BlocProvider(
              create: (context) => getIt<UserCubit>(),
              child: MainPage(),
            )),
    GoRoute(
        path: '/LogIn',
        builder: (context, state) => BlocProvider(
              create: (context) => getIt<UserCubit>(),
              child: LoginPage(),
            )),
    GoRoute(
        path: '/home',
        builder: (context, state) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => getIt<UserCubit>(),
                ),
                BlocProvider(
                  create: (context) => getIt<AdminCubit>(),
                ),
              ],
              child: HomePage(),
            )),
    GoRoute(
        path: '/searchTeacher',
        builder: (context, state) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => getIt<StudentCubit>(),
                ),
                BlocProvider(
                  create: (context) => getIt<UserCubit>(),
                ),
              ],
              child: SearchPage(
                isTeacher: true,
              ),
            )),
    GoRoute(
        path: '/searchStudent',
        builder: (context, state) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => getIt<StudentCubit>(),
                ),
                BlocProvider(
                  create: (context) => getIt<UserCubit>(),
                ),
              ],
              child: SearchPage(
                isTeacher: false,
              ),
            )),
    GoRoute(
        path: '/studentsList',
        builder: (context, state) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => getIt<TransactionsCubit>(),
                ),
                BlocProvider(
                  create: (context) => getIt<StudentCubit>(),
                ),
                BlocProvider(
                  create: (context) => getIt<UserCubit>(),
                ),
                BlocProvider(
                  create: (context) => getIt<AdminCubit>(),
                ),
              ],
              child: StudentsTeachersPage(
                isteacher: false,
              ),
            )),
    GoRoute(
        path: '/teachersList',
        builder: (context, state) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => getIt<StudentCubit>(),
                ),
                BlocProvider(
                  create: (context) => getIt<TransactionsCubit>(),
                ),
                BlocProvider(
                  create: (context) => getIt<UserCubit>(),
                ),
                BlocProvider(
                  create: (context) => getIt<AdminCubit>(),
                ),
              ],
              child: StudentsTeachersPage(
                isteacher: true,
              ),
            )),
    GoRoute(
        path: '/expenses',
        builder: (context, state) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => getIt<TransactionsCubit>(),
                ),
                BlocProvider(
                  create: (context) => getIt<UserCubit>(),
                ),
                BlocProvider(
                  create: (context) => getIt<AdminCubit>(),
                ),
              ],
              child: const IncomeExpensePage(
                isIncome: false,
              ),
            )),
    GoRoute(
        path: '/income',
        builder: (context, state) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => getIt<TransactionsCubit>(),
                ),
                BlocProvider(
                  create: (context) => getIt<UserCubit>(),
                ),
                BlocProvider(
                  create: (context) => getIt<AdminCubit>(),
                ),
              ],
              child: const IncomeExpensePage(
                isIncome: true,
              ),
            )),
    GoRoute(
        path: '/transaction',
        builder: (context, state) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => getIt<TransactionsCubit>(),
                ),
                BlocProvider(
                  create: (context) => getIt<AdminCubit>(),
                ),
              ],
              child: const TransactionPage(),
            )),
    GoRoute(
        path: '/admin',
        builder: (context, state) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => getIt<UserCubit>(),
                ),
                BlocProvider(
                  create: (context) => getIt<StudentCubit>(),
                ),
              ],
              child: const Admin(),
            )),
  ],
);
