import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/string.dart';
import 'package:madrassat_iqraa/core/theme/colors.dart';
import 'package:madrassat_iqraa/core/theme/font.dart';
import 'package:madrassat_iqraa/features/home/ui/bloc/cubit/user_cubit.dart';

class HiText extends StatefulWidget {
  const HiText({super.key});

  @override
  State<HiText> createState() => _HiTextState();
}

class _HiTextState extends State<HiText> {
  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().getUserById();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 100.h,
      right: 20.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            child: Text(
              "السلام عليكم",
              style: TextStyle(
                  fontFamily: AppStrings.fontfam,
                  fontWeight: FontWeight.w400,
                  color: AppColors.background,
                  fontSize: 26.sp),
            ),
          ),
          SizedBox(
            child: _blocBuilder(),
          ),
        ],
      ),
    );
  }
}

Widget _blocBuilder() =>
    BlocBuilder<UserCubit, UserState>(builder: (context, state) {
      if (state is MeUserLoaded) {
        return Text(
          state.user.userName,
          style: AppTextStyle.titles,
        );
      } else if (state is UserLoading) {
        {
          return Text(
            "-----",
            style: TextStyle(
                fontFamily: AppStrings.fontfam,
                fontWeight: FontWeight.w400,
                color: Colors.white,
                fontSize: 28.sp),
          );
        }
      } else if (state is UserError) {
        return Text(
          state.message,
          style: TextStyle(
              fontFamily: AppStrings.fontfam,
              fontWeight: FontWeight.w400,
              color: Colors.red,
              fontSize: 28.sp),
        );
      } else {
        return Container();
      }
    });
