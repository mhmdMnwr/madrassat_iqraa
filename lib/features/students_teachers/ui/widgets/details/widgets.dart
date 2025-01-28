import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/string.dart';
import 'package:madrassat_iqraa/core/theme/colors.dart';
import 'package:madrassat_iqraa/core/theme/icons.dart';
import 'package:madrassat_iqraa/features/students_teachers/data/model/student_model.dart';

Widget detailsImage() {
  return Padding(
    padding: EdgeInsets.fromLTRB(20.w, 0, 5.w, 10.h),
    child: Container(
      child: Image.asset(
        AppIcons.studentDetails,
        width: 100.sp,
        height: 100.sp,
      ),
    ),
  );
}

Widget studentDetails() {
  return Padding(
    padding: EdgeInsets.fromLTRB(30.w, 10.h, 5.w, 21.h),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'الاسم',
          style: TextStyle(
            fontFamily: AppStrings.fontfam,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.skyBlue,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          "تاريخ الميلاد",
          style: TextStyle(
            fontFamily: AppStrings.fontfam,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.skyBlue,
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
        Text(
          'الجنس',
          style: TextStyle(
            fontFamily: AppStrings.fontfam,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.skyBlue,
          ),
        ),
      ],
    ),
  );
}

Widget studentDetailsInfo({required Student student}) {
  return Padding(
    padding: EdgeInsets.fromLTRB(30.w, 10.h, 10.w, 21.h),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          student.name,
          style: TextStyle(
            fontFamily: AppStrings.fontfam,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          student.birthDate,
          style: TextStyle(
            fontFamily: AppStrings.fontfam,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
        Text(
          student.sex,
          style: TextStyle(
            fontFamily: AppStrings.fontfam,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}
