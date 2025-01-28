import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/theme/font.dart';
import 'package:madrassat_iqraa/core/theme/icons.dart';
import 'package:madrassat_iqraa/features/students_teachers/data/model/student_model.dart';

class UserInfoCard extends StatelessWidget {
  final Student student;
  final bool isteacher;

  const UserInfoCard(
      {super.key, required this.student, required this.isteacher});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: !isteacher ? 100.h : 120.h,
      margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.sp),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 2,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          if (student.payed)
            Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: Image.asset(
                AppIcons.coins,
                height: 40.h,
                width: 40.w,
              ),
            ),
          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.w, top: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Name
                  Text(
                    student.name,
                    style: AppTextStyle.subTitles,
                    textAlign: TextAlign.right,
                  ),

                  // Registration Date
                  Text(
                    !isteacher
                        ? student.sex
                        : "المبلغ المستحق: ${student.money} دج",
                    style: AppTextStyle.text,
                    textAlign: TextAlign.right,
                  ),

                  // ID
                  Text(
                    "تاريخ الميلاد: ${student.birthDate.substring(0, 10).replaceAll('-', '/')}",
                    style: AppTextStyle.text,
                    textAlign: TextAlign.right,
                  ),
                  if (isteacher)
                    Text(
                      "تاريخ الإنضمام: ${student.payDay.substring(0, 10).replaceAll('-', '/')}",
                      style: AppTextStyle.bluetext,
                      textAlign: TextAlign.right,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
