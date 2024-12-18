import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/string.dart';
import 'package:madrassat_iqraa/core/theme/font.dart';
import 'package:madrassat_iqraa/core/theme/icons.dart';

Widget gridsBorder({required int index}) {
  return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          15.sp,
        ),
        border: Border(
          top: BorderSide(
            color: Colors.black,
            width: 0.6.sp,
          ),
          bottom: BorderSide(
            color: Colors.black,
            width: 0.6.sp,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Subtle shadow color
            offset: Offset(0, 3), // Horizontal and vertical offset
            blurRadius: 6, // Amount of blur
            spreadRadius: 4, // Spread of the shadow
          ),
        ],
      ),
      child: gridsComponent(
          imagePath: homePageImages[index], text: homePageTitles[index]));
}

Widget gridsComponent({required String text, required String imagePath}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Center(
        child: SizedBox(
          height: 80.h,
          width: 80.w,
          child: Image.asset(
            imagePath,
          ),
        ),
      ),
      SizedBox(
        height: (text != "سجل المعلمين") ? 10.h : 20.h,
      ),
      Container(
        padding: EdgeInsets.only(bottom: 15.h),
        height: 45.h,
        child: Text(
          text,
          style: AppTextStyle.categories,
        ),
      ),
    ],
  );
}

List<String> homePageImages = [
  AppIcons.homepage1,
  AppIcons.homepage2,
  AppIcons.homepage3,
  AppIcons.homepage4,
  AppIcons.homepage5,
];
List<String> homePageTitles = [
  AppPagesNames.studentsList,
  AppPagesNames.teachersList,
  AppPagesNames.expenses,
  AppPagesNames.incomes,
  AppPagesNames.transactions,
];
