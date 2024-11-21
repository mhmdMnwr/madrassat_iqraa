import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/theme/colors.dart';

Widget amount() {
  return Positioned(
    top: 90.h,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Container(
        height: 150.h,
        width: 350.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7.sp),
          border: Border.all(
            color: AppColors.vibrantOrange,
            width: 5.w,
          ),
        ),
        child: Center(
          child: Text(
            'Amount',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    ),
  );
}
