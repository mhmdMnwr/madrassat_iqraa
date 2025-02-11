import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/navigation/navigation.dart';
import 'package:madrassat_iqraa/core/string.dart';
import 'package:madrassat_iqraa/core/theme/font.dart';
import 'package:madrassat_iqraa/core/theme/icons.dart';

Widget backIcons({
  required context,
  bool transactions = false,
  bool details = false,
  bool isIncome = true,
}) {
  return Padding(
    padding: EdgeInsets.only(top: 20.h, right: 15.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          transactions
              ? AppPagesNames.transactions
              : details
                  ? AppPagesNames.details
                  : isIncome
                      ? AppPagesNames.incomes
                      : AppPagesNames.expenses,
          style: AppTextStyle.titles,
          textDirection: TextDirection.rtl,
        ),
        SizedBox(
          width: 15.w,
        ),
        InkWell(
          onTap: () async {
            navigateToPage(context, AppPagesNames.home);
          },
          child: Image.asset(
            AppIcons.back1,
            height: 45.h,
            width: 45.w,
          ),
        ),
      ],
    ),
  );
}
