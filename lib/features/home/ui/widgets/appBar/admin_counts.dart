import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/admin/cubit/admin_cubit.dart';
import 'package:madrassat_iqraa/core/admin/model/admin_model.dart';
import 'package:madrassat_iqraa/core/string.dart';
import 'package:madrassat_iqraa/core/theme/colors.dart';

class AdminCounts extends StatefulWidget {
  @override
  _AdminCountsState createState() => _AdminCountsState();
}

class _AdminCountsState extends State<AdminCounts> {
  @override
  void initState() {
    super.initState();
    context.read<AdminCubit>().getAdminData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminCubit, AdminState>(builder: (context, state) {
      if (state is AdminLoading) {
        return builder(
          error: true,
        );
      } else if (state is AdminLoaded) {
        return builder(schoolState: state.schoolState);
      } else if (state is AdminError) {
        return builder(error: true, message: state.message);
      } else {
        return Center(
          child: Container(
            color: Colors.red,
          ),
        );
      }
    });
  }
}

Widget builder({
  bool error = false,
  String message = "-----",
  SchoolState? schoolState,
}) {
  return Positioned(
    top: 180.h,
    left: 45.w,
    right: 45.w,
    height: 115.h,
    child: Container(
      padding: EdgeInsets.fromLTRB(3.w, 14.h, 3.w, 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          11.sp,
        ),
        border: Border.all(
          color: AppColors.goldenYellow,
          width: 2.5.sp,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Subtle shadow color
            offset: Offset(0, 3), // Horizontal and vertical offset
            blurRadius: 6, // Amount of blur
            spreadRadius: 4, // Spread of the shadow
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          numHolder(
            text: error ? message : schoolState?.teacherCount,
            text2: "عدد المعلمين",
          ),
          VerticalDivider(
            color: Colors.black,
            thickness: 0.5,
            width: 5.w,
          ),
          numHolder(
            da: true,
            text: error ? message : schoolState?.totalFunds,
            text2: "مبلغ الميزانية",
          ),
          VerticalDivider(
            color: Colors.black,
            thickness: 0.5,
            width: 5.w,
          ),
          numHolder(
            text: error ? message : schoolState?.studentCount,
            text2: "عدد الطلاب",
          ),
        ],
      ),
    ),
  );
}

Widget numHolder({
  bool da = false,
  required dynamic text,
  required String text2,
}) {
  return SizedBox(
    width: 90.w,
    height: 90.h,
    child: Column(
      children: [
        SizedBox(
          height: 5.h,
        ),
        Text(
          text2,
          style: TextStyle(
            fontFamily: AppStrings.fontfam,
            fontWeight: FontWeight.w600,
            fontSize: 20.sp,
            color: AppColors.shadowBlue,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            !da ? text.toString() : "${text.toString()} دج",
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontFamily: AppStrings.fontfam,
              fontWeight: FontWeight.w500,
              fontSize: 23.sp,
              color: AppColors.skyBlue,
            ),
          ),
        ),
      ],
    ),
  );
}
