import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/String.dart';
import 'package:madrassat_iqraa/core/theme/colors.dart';

Widget hiText() {
  return Positioned(
    top: 80.h,
    right: 90.w,
    child: Column(
      children: [
        SizedBox(
          child: Text(
            "مرحبا بك",
            style: TextStyle(
                fontFamily: AppStrings().fontfam,
                fontWeight: FontWeight.w600,
                color: AppColors().background,
                fontSize: 23.sp),
          ),
        ),
        SizedBox(
          child: Text(
            "عامر محمد منور",
            style: TextStyle(
                fontFamily: AppStrings().fontfam,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: 25.sp),
          ),
        ),
      ],
    ),
  );
}
