import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/theme/colors.dart';
import 'package:madrassat_iqraa/features/home/ui/widgets/appBar/admin_counts.dart';
import 'package:madrassat_iqraa/features/home/ui/widgets/appBar/curved_appbar.dart';
import 'package:madrassat_iqraa/features/home/ui/widgets/appBar/hi_text.dart';
import 'package:madrassat_iqraa/features/home/ui/widgets/appBar/logo.dart';
import 'package:madrassat_iqraa/features/home/ui/widgets/body/categories.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: AppColors.background),
          curvedAppBar(),
          logo(),
          HiText(),
          adminCounts(),
          Column(
            children: [
              SizedBox(
                height: 330.h,
              ),
              Expanded(child: categories()),
            ],
          ),
        ],
      ),
    );
  }
}
