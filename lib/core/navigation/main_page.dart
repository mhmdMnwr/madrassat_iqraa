import 'package:flutter/material.dart';
import 'package:madrassat_iqraa/features/home/data/repo/user_repo.dart';
import 'package:madrassat_iqraa/features/home/ui/pages/home_page.dart';
import 'package:madrassat_iqraa/features/home/ui/pages/login_page.dart';
import 'package:madrassat_iqraa/injection.dart';

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
