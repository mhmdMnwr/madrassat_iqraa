import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/navigation/navigation.dart';
import 'package:madrassat_iqraa/core/theme/font.dart';
import 'package:madrassat_iqraa/core/theme/icons.dart';
import 'package:madrassat_iqraa/core/theme/colors.dart';

class StudTeachAppBar extends AppBar {
  StudTeachAppBar({
    super.key,
    bool reset = false,
    void Function()? onReset,
    required bool search,
    bool isteacher = false,
    required String title,
    required context,
    //  VoidCallback onSearchPressed,
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
          leading: reset
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
                if (search || reset) {
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
