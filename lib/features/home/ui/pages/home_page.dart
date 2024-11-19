import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/navigation/router.dart';
import 'package:madrassat_iqraa/core/theme/colors.dart';
import 'package:madrassat_iqraa/features/home/ui/widgets/appBar/admin_counts.dart';
import 'package:madrassat_iqraa/features/home/ui/widgets/appBar/curved_appbar.dart';
import 'package:madrassat_iqraa/features/home/ui/widgets/appBar/hi_text.dart';
import 'package:madrassat_iqraa/features/home/ui/widgets/appBar/logo.dart';
import 'package:madrassat_iqraa/features/home/ui/widgets/body/categories.dart';
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
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: AppColors.background),
          curvedAppBar(),
          logo(),
          hiText(),
          adminCounts(),
          Column(
            children: [
              SizedBox(
                height: 340.h,
              ),
              Expanded(child: categories()),
            ],
          ),
        ],
      ),
    );
  }
}
