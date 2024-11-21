import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:madrassat_iqraa/features/home/data/repo/user_repo.dart';
import 'package:madrassat_iqraa/features/home/ui/bloc/cubit/user_cubit.dart';
import 'package:madrassat_iqraa/features/home/ui/pages/home_page.dart';
import 'package:madrassat_iqraa/features/home/ui/pages/login_page.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/bloc/cubit/student_cubit.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/pages/search_page.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/pages/stud&teach_page.dart';
import 'package:madrassat_iqraa/features/transaction/ui/pages/expenses_page.dart';
import 'package:madrassat_iqraa/features/transaction/ui/pages/income_page.dart';
import 'package:madrassat_iqraa/features/transaction/ui/pages/transaction_page.dart';
import 'package:madrassat_iqraa/injection.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
        path: '/',
        builder: (context, state) => BlocProvider(
              create: (context) => getIt<UserCubit>(),
              child: MainPage(),
            )),
    GoRoute(
        path: '/home',
        builder: (context, state) => BlocProvider(
              create: (context) => getIt<UserCubit>(),
              child: HomePage(),
            )),
    GoRoute(
        path: '/searchTeatcher',
        builder: (context, state) => BlocProvider(
              create: (context) => getIt<StudentCubit>(),
              child: SearchPage(
                isteacher: true,
              ),
            )),
    GoRoute(
        path: '/searchStudent',
        builder: (context, state) => BlocProvider(
              create: (context) => getIt<StudentCubit>(),
              child: SearchPage(
                isteacher: false,
              ),
            )),
    GoRoute(
        path: '/studentsList',
        builder: (context, state) => BlocProvider(
              create: (context) => getIt<StudentCubit>(),
              child: StudentsTeachersPage(
                isteacher: false,
              ),
            )),
    GoRoute(
        path: '/teachersList',
        builder: (context, state) => BlocProvider(
              create: (context) => getIt<StudentCubit>(),
              child: StudentsTeachersPage(
                isteacher: true,
              ),
            )),
    GoRoute(
        path: '/expenses', builder: (context, state) => const ExpensesPage()),
    GoRoute(path: '/income', builder: (context, state) => const IncomePage()),
    GoRoute(
        path: '/transaction',
        builder: (context, state) => const TransactionPage()),
  ],
);

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final UserRepository userRepository = getIt<UserRepository>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: userRepository.hasUserId(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasData && snapshot.data!) {
          return HomePage();
        } else {
          return LoginPage();
        }
      },
    );
  }
}
