import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/theme/colors.dart';
import 'package:madrassat_iqraa/core/theme/font.dart';
import 'package:madrassat_iqraa/core/theme/icons.dart';
import 'package:madrassat_iqraa/features/home/data/model/user_model.dart';

class AcceptedUserList extends StatefulWidget {
  final User user;

  const AcceptedUserList({super.key, required this.user});

  @override
  State<AcceptedUserList> createState() => _AcceptedUserListState();
}

class _AcceptedUserListState extends State<AcceptedUserList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75.h,
      margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 17.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.vibrantOrange, width: 3.5.sp),
        borderRadius: BorderRadius.circular(8.sp),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 1.5,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15.w),
            child: Opacity(
              opacity: 0.2,
              child: Image.asset(
                AppIcons.adminreject,
                height: 60.h,
                width: 60.w,
              ),
            ),
          ),
          Text(
            widget.user.userName,
            style: AppTextStyle.subTitles,
          ),
          Padding(
            padding: EdgeInsets.only(right: 15.w),
            child: Container(
              height: 40.h,
              width: 40.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.forestGreen,
                    offset: Offset(0, 0),
                    blurRadius: 4.sp,
                    spreadRadius: 1.sp,
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: CircleBorder(
                    side: BorderSide(
                      color: AppColors.forestGreen,
                      width: 2.w,
                    ),
                  ),
                  padding: EdgeInsets.all(10.sp),
                ),
                child: Image.asset(
                  AppIcons.adminaccept,
                  width: 40.w,
                  height: 40.h,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
