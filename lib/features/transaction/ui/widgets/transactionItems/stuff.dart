import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/string.dart';
import 'package:madrassat_iqraa/core/theme/colors.dart';
import 'package:madrassat_iqraa/core/theme/font.dart';
import 'package:madrassat_iqraa/core/theme/icons.dart';
import 'package:madrassat_iqraa/features/transaction/data/model/transaction_model.dart';

BoxDecoration border() {
  return BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: Colors.black87,
        offset: Offset(0, 1),
        blurRadius: 2.sp,
      ),
    ],
    color: Colors.white,
    borderRadius: BorderRadius.circular(7.sp),
    border: Border.all(
      color: AppColors.midnightBlue,
      width: 1.w,
    ),
  );
}

Widget infoColumn({required Transactions transaction}) {
  return Padding(
    padding: EdgeInsets.only(
      left: 30.w,
      bottom: 5.h,
    ),
    child: Padding(
      padding: EdgeInsets.only(left: 1.w),
      child: Padding(
        padding: EdgeInsets.only(top: 10.h, right: 10.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('عامر محمد منور',
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontFamily: AppStrings.fontfam,
                    fontWeight: FontWeight.w500,
                    color: AppColors.skyBlue,
                    fontSize: 18.sp)),
            timeRow(
                time:
                    '${transaction.createdAt.hour}:${transaction.createdAt.minute}',
                icon: AppIcons.clock),
            SizedBox(
              height: 5.h,
            ),
            timeRow(
                time:
                    '${transaction.createdAt.day}/${transaction.createdAt.month}/${transaction.createdAt.year}',
                icon: AppIcons.calendar),
          ],
        ),
      ),
    ),
  );
}

Widget timeRow({required String time, required String icon}) {
  return Row(children: [
    Text(
      time,
      style: AppTextStyle.text,
    ),
    SizedBox(
      width: 5.w,
    ),
    Image.asset(
      icon,
      width: 25.w,
      height: 25.h,
    ),
  ]);
}

Widget moneyRow({required bool isIncome, required Transactions transaction}) {
  return Padding(
    padding: EdgeInsets.only(
      left: 25.w,
      top: 50.h,
    ),
    child: Row(children: [
      Text("${transaction.amount} دج",
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
          style: TextStyle(
              fontFamily: AppStrings.fontfam,
              fontWeight: FontWeight.w700,
              color: isIncome ? AppColors.forestGreen : AppColors.richRed,
              fontSize: 22.sp)),
      SizedBox(
        width: 6.w,
      ),
      moneyIcon(isIncome: isIncome),
    ]),
  );
}

Widget moneyIcon({required bool isIncome}) {
  if (isIncome) {
    return Image.asset(
      AppIcons.addmoney,
      width: 40.w,
      height: 40.h,
    );
  } else {
    return Image.asset(
      AppIcons.minusmoney,
      width: 40.w,
      height: 40.h,
    );
  }
}
