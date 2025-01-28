import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/string.dart';
import 'package:madrassat_iqraa/core/theme/colors.dart';
import 'package:madrassat_iqraa/core/theme/icons.dart';
import 'package:madrassat_iqraa/features/students_teachers/data/model/payed_months.dart';
import 'package:madrassat_iqraa/features/transaction/ui/widgets/transactionItems/stuff.dart';

class payedMonthList extends StatelessWidget {
  final List<PayedMonths> dates;

  const payedMonthList({super.key, required this.dates});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dates.length, // Adjust the item count as needed
      itemBuilder: (context, index) {
        return monthList(index: index, date: dates[index].payedDates);
      },
    );
  }
}

Widget monthList({required int index, required DateTime date}) {
  return Padding(
    padding: EdgeInsets.fromLTRB(25.w, (index == 0) ? 255.h : 25.h, 25.w, 0),
    child: Container(
      height: 80.h,
      width: 370.w,
      decoration: border(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _moneyRow(isIncome: true),
          _infoColumn(date: date),
        ],
      ),
    ),
  );
}

Widget _infoColumn({required DateTime date}) {
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
            timeRow(time: '${date.hour}:${date.minute}', icon: AppIcons.clock),
            SizedBox(
              height: 5.h,
            ),
            timeRow(
                time: '${date.day}/${date.month}/${date.year}',
                icon: AppIcons.calendar),
          ],
        ),
      ),
    ),
  );
}

Widget _moneyRow({
  required bool isIncome,
}) {
  return Padding(
    padding: EdgeInsets.only(
      left: 25.w,
      top: 15.h,
    ),
    child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Text("800 دج",
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
          style: TextStyle(
              fontFamily: AppStrings.fontfam,
              fontWeight: FontWeight.w700,
              color: AppColors.forestGreen,
              fontSize: 22.sp)),
      SizedBox(
        width: 6.w,
      ),
      moneyIcon(isIncome: isIncome),
    ]),
  );
}
