import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/String.dart';
import 'package:madrassat_iqraa/core/theme/font.dart';
import 'package:madrassat_iqraa/core/theme/icons.dart';

Widget backIcons({required context}) {
  return Padding(
    padding: EdgeInsets.only(top: 20.h, right: 15.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          AppPagesNames.incomes,
          style: AppTextStyle.titles,
          textDirection: TextDirection.rtl,
        ),
        SizedBox(
          width: 15.w,
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).pop();
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
