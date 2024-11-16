import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/theme/font.dart';

Widget categories() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 30.w),
    child: GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns
        crossAxisSpacing: 22.w, // Spacing between columns
        mainAxisSpacing: 22.w, // Spacing between rows
        childAspectRatio: 1.11.sp, // Adjust the aspect ratio as needed
      ),
      itemCount: 5,
      itemBuilder: (context, index) {
        return gridsBorder(index: index);
      },
    ),
  );
}

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
  "assets/images/homepage1.png",
  "assets/images/homepage2.png",
  "assets/images/homepage3.png",
  "assets/images/homepage4.png",
  "assets/images/homepage5.png",
];
List<String> homePageTitles = [
  "سجل الطلاب",
  "سجل المعلمين",
  "المصاريف الشهرية",
  "التبرعات الشهرية",
  "سجل المعاملات المالية",
];
