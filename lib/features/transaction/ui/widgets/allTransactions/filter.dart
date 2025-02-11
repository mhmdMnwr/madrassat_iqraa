import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/theme/colors.dart';
import 'package:madrassat_iqraa/core/String.dart';

Widget filter({
  required bool isIncomeSelected,
  required bool isExpenseSelected,
  required ValueChanged<String?> onFilterChanged,
}) {
  return Padding(
    padding: EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Income Button
        GestureDetector(
          onTap: () => onFilterChanged(
              isIncomeSelected ? null : 'income'), // Toggle Income
          child: FilterButton(
            label: 'التبرعات',
            isSelected: isIncomeSelected,
          ),
        ),
        SizedBox(width: 30.w),
        // Expense Button
        GestureDetector(
          onTap: () => onFilterChanged(
              isExpenseSelected ? null : 'expense'), // Toggle Expense
          child: FilterButton(
            label: 'المصاريف',
            isSelected: isExpenseSelected,
          ),
        ),
      ],
    ),
  );
}

class FilterButton extends StatelessWidget {
  final String label;
  final bool isSelected;

  const FilterButton({
    super.key,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: 140.w,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.shadowBlue : AppColors.deepBlue,
        borderRadius: BorderRadius.circular(20.sp),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          label,
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontFamily: AppStrings.fontfam,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 20.sp,
          ),
        ),
      ),
    );
  }
}
