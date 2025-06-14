import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/admin/cubit/admin_cubit.dart';
import 'package:madrassat_iqraa/core/admin/strings.dart';
import 'package:madrassat_iqraa/core/navigation/navigation.dart';
import 'package:madrassat_iqraa/core/theme/colors.dart';
import 'package:madrassat_iqraa/core/widgets/snack_bar.dart';
import 'package:madrassat_iqraa/features/home/data/repo/user_repo.dart';
import 'package:madrassat_iqraa/features/home/ui/bloc/cubit/user_cubit.dart';
import 'package:madrassat_iqraa/features/home/ui/widgets/appBar/admin_counts.dart';
import 'package:madrassat_iqraa/features/home/ui/widgets/appBar/curved_appbar.dart';
import 'package:madrassat_iqraa/features/home/ui/widgets/appBar/hi_text.dart';
import 'package:madrassat_iqraa/features/home/ui/widgets/appBar/logo.dart';
import 'package:madrassat_iqraa/features/home/ui/widgets/body/categories.dart';
import 'package:madrassat_iqraa/injection.dart';

class HomePage extends StatefulWidget {
  final repository = getIt<UserRepository>();
  HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool admin = false;
  @override
  void initState() {
    super.initState();
    widget.repository.getUserById().then((result) {
      result.fold(
        (error) => setState,
        (user) {
          if (user != null) {
            setState(() {
              admin = (user.userName == AdminString.name &&
                  user.password == AdminString.password);
            });
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state is LogOut) {
          navigateToPage(context, 'LogIn');
          MySnackBars.success(message: 'تمت العملية بنجاح', context: context);
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(color: AppColors.background),
            curvedAppBar(250),
            const Logo(),
            HiText(),
            BlocProvider(
              create: (context) => getIt<AdminCubit>(),
              child: AdminCounts(),
            ),
            Column(
              children: [
                SizedBox(height: 310.h),
                Expanded(child: categories(admin: admin)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
