import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/string.dart';
import 'package:madrassat_iqraa/core/theme/colors.dart';
import 'package:madrassat_iqraa/core/theme/icons.dart';

Widget addTransactionIcons(bool isIncome, VoidCallback? addTranaction) {
  return Padding(
    padding: EdgeInsets.fromLTRB(20.w, 0, 10.w, 10.h),
    child: Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: isIncome ? AppColors.forestGreen : AppColors.richRed,
            offset: Offset(0, 0),
            blurRadius: 4.sp,
            spreadRadius: 1.sp,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: addTranaction,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: CircleBorder(
            side: BorderSide(
              color: isIncome ? AppColors.forestGreen : AppColors.richRed,
              width: 2.w,
            ),
          ),
          padding: EdgeInsets.all(10.sp),
        ),
        child: isIncome
            ? Image.asset(AppIcons.income)
            : Image.asset(AppIcons.expense),
      ),
    ),
  );
}

Widget info(
    {required bool isIncome,
    required dynamic monthIncExp,
    required dynamic totalFund}) {
  return Padding(
    padding: EdgeInsets.fromLTRB(20.w, 10.h, 4.w, 10.h),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'الميزانية الحالية',
          style: TextStyle(
            fontFamily: AppStrings.fontfam,
            fontSize: 15.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            "$totalFund دج",
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontFamily: AppStrings.fontfam,
              fontSize: 20.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.skyBlue,
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            isIncome
                ? 'تم إضافة $monthIncExp دج لهذا الشهر'
                : 'تم سحب $monthIncExp دج لهذا الشهر',
            style: TextStyle(
              fontFamily: AppStrings.fontfam,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: isIncome ? AppColors.forestGreen : AppColors.richRed,
            ),
          ),
        ),
      ],
    ),
  );
}

BoxDecoration border() {
  return BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: Colors.black87,
        offset: Offset(0, 1),
        blurRadius: 11.sp,
      ),
    ],
    color: Colors.white,
    borderRadius: BorderRadius.circular(7.sp),
    border: Border.all(
      color: AppColors.background,
      width: 2.w,
    ),
  );
}
