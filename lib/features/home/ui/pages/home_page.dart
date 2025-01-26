import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/string.dart';
import 'package:madrassat_iqraa/core/theme/colors.dart';
import 'package:madrassat_iqraa/features/home/data/repo/user_repo.dart';
import 'package:madrassat_iqraa/features/home/ui/widgets/appBar/admin_counts.dart';
import 'package:madrassat_iqraa/features/home/ui/widgets/appBar/curved_appbar.dart';
import 'package:madrassat_iqraa/features/home/ui/widgets/appBar/hi_text.dart';
import 'package:madrassat_iqraa/features/home/ui/widgets/appBar/logo.dart';
import 'package:madrassat_iqraa/features/home/ui/widgets/body/categories.dart';
import 'package:madrassat_iqraa/injection.dart';

class HomePage extends StatefulWidget {
  bool admin = false;
  final repository = getIt<UserRepository>();
  HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    widget.repository.getUserById().then((result) {
      result.fold(
        (error) => setState,
        (user) {
          if (user != null) {
            setState(() {
              widget.admin = (user.userName == AppStrings.adminName);
            });
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: AppColors.background),
          curvedAppBar(269),
          logo(),
          HiText(),
          adminCounts(),
          Column(
            children: [
              SizedBox(
                height: 330.h,
              ),
              Expanded(child: categories(admin: widget.admin)),
            ],
          ),
        ],
      ),
    );
  }
}
