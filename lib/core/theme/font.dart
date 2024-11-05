import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/String.dart';
import 'package:madrassat_iqraa/core/theme/colors.dart';

class AppTextStyle {
  TextStyle primary = TextStyle(
    fontFamily: AppStrings().fontfam,
    fontWeight: FontWeight.w800,
    color: Colors.black,
    fontSize: 16.sp,
  );
  TextStyle categories = TextStyle(
    fontFamily: AppStrings().fontfam,
    fontWeight: FontWeight.w800,
    color: Colors.black,
    fontSize: 18.sp,
  );
}
