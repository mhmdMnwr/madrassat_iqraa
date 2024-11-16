import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/String.dart';
import 'package:madrassat_iqraa/core/theme/colors.dart';

Widget hiText() {
  return Positioned(
    top: 100.h,
    right: 20.w,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          child: Text(
            "السلام عليكم",
            style: TextStyle(
                fontFamily: AppStrings.fontfam,
                fontWeight: FontWeight.w400,
                color: AppColors.background,
                fontSize: 26.sp),
          ),
        ),
        SizedBox(
          child: Text(
            "عامر محمد منور",
            style: TextStyle(
                fontFamily: AppStrings.fontfam,
                fontWeight: FontWeight.w400,
                color: Colors.white,
                fontSize: 28.sp),
          ),
        ),
      ],
    ),
  );
}
