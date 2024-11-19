import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/theme/font.dart';
import 'package:madrassat_iqraa/core/theme/icons.dart';
import 'package:madrassat_iqraa/core/theme/colors.dart';

class StudTeachAppBar extends AppBar {
  StudTeachAppBar({
    super.key,
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
          leading: IconButton(
            icon: Image.asset(AppIcons.search),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              icon: Image.asset(AppIcons.back1),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
}
