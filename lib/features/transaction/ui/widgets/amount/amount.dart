import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/features/transaction/ui/widgets/amount/am_stuff.dart';

Widget amount({
  required dynamic monthIncExp,
  required dynamic totalFund,
  required bool isIncome,
  required VoidCallback? addTransaction,
}) {
  return Positioned(
    top: 110.h,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Container(
          height: 130.h,
          width: 330.w,
          decoration: border(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              addTransactionIcons(
                isIncome,
                addTransaction,
              ),
              info(
                isIncome: isIncome,
                monthIncExp: monthIncExp,
                totalFund: totalFund,
              ),
            ],
          )),
    ),
  );
}
