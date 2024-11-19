import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/navigation/router.dart';
import 'package:madrassat_iqraa/features/home/ui/bloc/cubit/user_cubit.dart';
import 'package:madrassat_iqraa/features/home/ui/pages/login_page.dart';
import 'package:madrassat_iqraa/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupInjection();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 903),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // routerConfig: router,
        home: BlocProvider(
          create: (context) => getIt<UserCubit>(),
          child: LoginPage(),
        ),
      ),
    );
  }
}
