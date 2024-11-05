import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/String.dart';
import 'package:madrassat_iqraa/core/admin/admin_state.dart';
import 'package:madrassat_iqraa/core/theme/colors.dart';

Widget adminCounts() {
  return Positioned(
    top: 185.h,
    left: 22.w,
    right: 22.w,
    child: Container(
      padding: EdgeInsets.fromLTRB(15.w, 16.h, 15.w, 16.h),
      height: 100.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          nums(text: "totalFunds", text2: "الميزانية"),
          VerticalDivider(
            color: Colors.black,
            thickness: 0.5,
            width: 20.w,
          ),
          nums(text: "teacherCount", text2: "المعلمون"),
          VerticalDivider(
            color: Colors.black,
            thickness: 0.5,
            width: 20.w,
          ),
          nums(text: "studentCount", text2: "الطلبة"),
        ],
      ),
    ),
  );
}

Widget numHolder({
  required int text,
  required String text2,
}) {
  return SizedBox(
    width: 80.w,
    height: 90.h,
    child: Column(
      children: [
        Text(
          text.toString(),
          style: TextStyle(
              fontFamily: AppStrings().fontfam,
              fontWeight: FontWeight.w700,
              fontSize: 20.sp,
              color: AppColors().primaryText),
        ),
        Text(
          text2,
          style: TextStyle(
              fontFamily: AppStrings().fontfam,
              fontWeight: FontWeight.w700,
              color: AppColors().secondaryText),
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
        return CircularProgressIndicator(); // Show a loader while waiting
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else if (snapshot.hasData) {
        // Access the 'studentCount' from the map safely
        final count = snapshot.data?[text] ?? 0;
        return numHolder(
          text: count,
          text2: text2,
        );
      } else {
        return Text('No data available');
      }
    },
  );
}
