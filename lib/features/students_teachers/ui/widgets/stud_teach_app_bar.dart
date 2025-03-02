import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/navigation/navigation.dart';
import 'package:madrassat_iqraa/core/theme/colors.dart';
import 'package:madrassat_iqraa/core/theme/font.dart';
import 'package:madrassat_iqraa/core/theme/icons.dart';

class StudTeachAppBar extends AppBar {
  StudTeachAppBar({
    bool transactions = false,
    super.key,
    bool reset = false,
    void Function()? onReset,
    void Function(DateTime?)? onDateSelected, // Callback for date selection
    required bool search,
    bool isteacher = false,
    required String title,
    required context,
  }) : super(
          toolbarHeight: 64.h,
          backgroundColor: AppColors.shadowBlue,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                title,
                style: AppTextStyle.titles,
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
              ),
            ],
          ),
          leading: transactions
              ? InkWell(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );

                    if (onDateSelected != null) {
                      onDateSelected(pickedDate); // Notify parent
                    }
                  },
                  child: Image.asset(
                    AppIcons.calendar,
                    color: AppColors.vibrantOrange,
                    height: 35.h,
                    width: 35.w,
                  ),
                )
              : reset
                  ? IconButton(
                      onPressed: onReset,
                      icon: Icon(
                        Icons.settings_backup_restore,
                        color: Colors.white,
                        size: 40.sp,
                      ))
                  : search
                      ? IconButton(
                          icon: Image.asset(AppIcons.search),
                          onPressed: () {
                            if (isteacher) {
                              navigateToPage(context, "searchTeacher");
                            } else {
                              navigateToPage(context, "searchStudent");
                            }
                          },
                        )
                      : Container(),
          actions: [
            IconButton(
              icon: Image.asset(AppIcons.back1),
              onPressed: () {
                if (search || reset || transactions) {
                  navigateToPage(context, 'home');
                } else {
                  if (isteacher) {
                    navigateToPage(context, "teachersList");
                  } else {
                    navigateToPage(context, "studentsList");
                  }
                }
              },
            ),
          ],
        );
}
