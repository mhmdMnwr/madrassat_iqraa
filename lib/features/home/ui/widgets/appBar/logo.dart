import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrassat_iqraa/core/string.dart';
import 'package:madrassat_iqraa/core/theme/colors.dart';
import 'package:madrassat_iqraa/core/theme/icons.dart';
import 'package:madrassat_iqraa/features/home/ui/bloc/cubit/user_cubit.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10.h,
      right: 10.w,
      child: Row(
        children: [
          Text(
            "مؤسسة إقرأ التعليمية",
            style: TextStyle(
              fontFamily: AppStrings.fontfam,
              fontWeight: FontWeight.w800,
              color: AppColors.goldenYellow,
              fontSize: 20.sp,
            ),
          ),
          SizedBox(width: 12.w),
          InkWell(
            onLongPress: () {
              context.read<UserCubit>().logOut();
            },
            child: Image.asset(
              AppIcons.logo,
              height: 50.h,
              width: 50.w,
            ),
          ),
        ],
      ),
    );
  }
}
