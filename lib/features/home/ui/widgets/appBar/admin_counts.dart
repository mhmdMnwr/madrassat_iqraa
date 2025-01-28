import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/string.dart';
import 'package:madrassat_iqraa/core/admin/admin_state.dart';
import 'package:madrassat_iqraa/core/theme/colors.dart';

Widget adminCounts() {
  return Positioned(
    top: 219.h,
    left: 30.w,
    right: 30.w,
    height: 115.h,
    child: Container(
      padding: EdgeInsets.fromLTRB(3.w, 14.h, 3.w, 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          11.sp,
        ),
        border: Border.all(
          color: AppColors.goldenYellow,
          width: 2.5.sp,
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          nums(
            text: "teacherCount",
            text2: "عدد المعلمين",
          ),
          VerticalDivider(
            color: Colors.black,
            thickness: 0.5,
            width: 5.w,
          ),
          nums(
            text: "totalFunds",
            text2: "مبلغ الميزانية",
          ),
          VerticalDivider(
            color: Colors.black,
            thickness: 0.5,
            width: 5.w,
          ),
          nums(
            text: "studentCount",
            text2: "عدد الطلاب",
          ),
        ],
      ),
    ),
  );
}

Widget numHolder({
  bool da = false,
  required dynamic text,
  required String text2,
}) {
  return SizedBox(
    width: 110.w,
    height: 100.h,
    child: Column(
      children: [
        SizedBox(
          height: 5.h,
        ),
        Text(
          text2,
          style: TextStyle(
              fontFamily: AppStrings.fontfam,
              fontWeight: FontWeight.w600,
              fontSize: 20.sp,
              color: AppColors.shadowBlue),
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          !da ? text.toString() : "${text.toString()} دج",
          textDirection: TextDirection.rtl,
          style: TextStyle(
              fontFamily: AppStrings.fontfam,
              fontWeight: FontWeight.w500,
              fontSize: (da && text.toString().length > 5) ? 20.sp : 23.sp,
              color: AppColors.skyBlue),
        ),
      ],
    ),
  );
}

dynamic nums({
  required String text,
  required String text2,
}) {
  return FutureBuilder<Map<String, dynamic>?>(
    future: AdminStatsService().getStats(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return numHolder(
          text: "---",
          text2: text2,
        );
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else if (snapshot.hasData) {
        // Access the 'studentCount' from the map safely
        final count = snapshot.data?[text] ?? 0;
        return numHolder(
          da: (text2 == "مبلغ الميزانية"),
          text: count,
          text2: text2,
        );
      } else {
        return Text('No data available');
      }
    },
  );
}
