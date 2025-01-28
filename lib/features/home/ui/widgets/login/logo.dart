import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/theme/icons.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50.h,
      right: 156.w,
      child: Image.asset(
        AppIcons.logo,
        width: 100.w,
        height: 100.h,
      ),
    );
  }
}
