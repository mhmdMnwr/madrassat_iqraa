import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/theme/colors.dart';
import 'package:madrassat_iqraa/core/theme/font.dart';

Widget categories() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 12.w),
    child: GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns
        crossAxisSpacing: 12.w, // Spacing between columns
        mainAxisSpacing: 12.w, // Spacing between rows
        childAspectRatio: 0.905.sp, // Adjust the aspect ratio as needed
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(11.sp),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 1.2,
                      spreadRadius: 0.5,
                      color: AppColors().primary)
                ]),
            child: gridsComponent(
                icon: homePageIcons[index], text: homePageTitles[index]));
      },
    ),
  );
}

Widget gridsComponent({required String text, required IconData icon}) {
  return Container(
    margin: EdgeInsets.fromLTRB(5.sp, 5.sp, 5.sp, 10.sp),
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 120.h,
          width: 200.w,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.sp),
              boxShadow: [
                BoxShadow(
                    blurRadius: 1.2,
                    spreadRadius: 0.5,
                    color: AppColors().primary)
              ]),
          child: Icon(
            icon,
            color: Colors.blue,
            size: 80.sp,
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        Container(
          height: 30.h,
          child: Text(
            text,
            style: AppTextStyle().categories,
          ),
        ),
      ],
    ),
  );
}

List<IconData> homePageIcons = [
  Icons.school,
  Icons.badge,
  Icons.volunteer_activism,
  Icons.attach_money,
  Icons.app_registration,
  Icons.receipt_long,
];
List<String> homePageTitles = [
  "قائمة الطلبة",
  "قائمة المعلمين",
  "التبرعات",
  "النفقات",
  "السجل",
  "سجل التسجيلات",
];
