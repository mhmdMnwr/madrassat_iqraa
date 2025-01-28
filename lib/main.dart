import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/navigation/router.dart';
import 'package:madrassat_iqraa/injection.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupInjection();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 903),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp.router(
        locale: Locale('ar', 'AE'), // Set the locale to Arabic
        supportedLocales: [
          Locale('en', 'US'),
          // Locale('ar', 'AE'),
        ],
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}
