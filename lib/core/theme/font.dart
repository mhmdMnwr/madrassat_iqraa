import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/string.dart';
import 'package:madrassat_iqraa/core/theme/colors.dart';

class AppTextStyle {
  static TextStyle categories = TextStyle(
    fontFamily: AppStrings.fontfam,
    fontWeight: FontWeight.w600,
    color: AppColors.navyBlue,
    fontSize: 20.sp,
  );
  static TextStyle titles = TextStyle(
      fontFamily: AppStrings.fontfam,
      fontWeight: FontWeight.w400,
      color: Colors.white,
      fontSize: 28.sp);
  static TextStyle mains = TextStyle(
      fontFamily: AppStrings.fontfam,
      fontWeight: FontWeight.w600,
      color: AppColors.midnightBlue,
      fontSize: 35.sp);
  static TextStyle subTitles = TextStyle(
      fontFamily: AppStrings.fontfam,
      fontWeight: FontWeight.w700,
      color: AppColors.skyBlue,
      fontSize: 22.sp);
  static TextStyle text = TextStyle(
      fontFamily: AppStrings.fontfam,
      fontWeight: FontWeight.w700,
      color: Colors.black,
      fontSize: 16.sp);
  static TextStyle bluetext = TextStyle(
      fontFamily: AppStrings.fontfam,
      fontWeight: FontWeight.w700,
      color: AppColors.richRed,
      fontSize: 16.sp);
}
