import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/String.dart';
import 'package:madrassat_iqraa/core/theme/colors.dart';
import 'package:madrassat_iqraa/core/theme/font.dart';
import 'package:madrassat_iqraa/core/theme/icons.dart';
import 'package:madrassat_iqraa/features/transaction/data/model/transaction_model.dart';

class DetailsPopup extends StatelessWidget {
  final Transactions transaction;

  const DetailsPopup({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0.sp),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(16.0.sp),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0.sp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
                CrossAxisAlignment.end, // Align content to the right
            children: [
              Center(
                child: Text(
                  "تفاصيل العملية",
                  textAlign: TextAlign.center,
                  style: AppTextStyle.mains,
                ),
              ),
              SizedBox(height: 20.h),
              _info2(
                  icon: AppIcons.logo,
                  title: "اسم المستخدم",
                  value: transaction.userName),
              SizedBox(height: 16.h),
              _info2(
                  icon: AppIcons.minusmoney,
                  title: "المبلغ",
                  value: transaction.amount.toString()),
              SizedBox(height: 16.h),
              _info2(
                icon: AppIcons.calendar,
                title: "التاريخ",
                value:
                    '${transaction.createdAt.day}/${transaction.createdAt.month}/${transaction.createdAt.year}',
              ),
              SizedBox(height: 16.h),
              _info2(
                icon: AppIcons.clock,
                title: "الوقت",
                value:
                    '${transaction.createdAt.hour.toString().padLeft(2, '0')}:${transaction.createdAt.minute.toString().padLeft(2, '0')}',
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    ":التفاصيل",
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.vibrantOrange,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Icon(Icons.info_outline,
                      color: AppColors.vibrantOrange, size: 30.sp),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(right: 5.w, top: 4.h),
                child: Text(
                  transaction.description,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 24.h),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.shadowBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0.sp),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  ),
                  child: Text(
                    "إغلاق",
                    style: TextStyle(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _info({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          value,
          style: TextStyle(
            fontFamily: AppStrings.fontfam,
            fontSize: 20.sp,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: 20.w,
        ),
        Text(':$title', style: AppTextStyle.subTitles),
        SizedBox(width: 8.w),
        Icon(icon, color: AppColors.shadowBlue, size: 30.sp),
      ],
    );
  }

  Widget _info2({
    required String title,
    required String value,
    required String icon,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          value,
          style: TextStyle(
            fontFamily: AppStrings.fontfam,
            fontSize: 20.sp,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: 20.w,
        ),
        Text(':$title', style: AppTextStyle.subTitles),
        SizedBox(width: 8.w),
        Image.asset(
          icon,
          color: AppColors.skyBlue,
          width: 30.w,
          height: 30.h,
        ),
      ],
    );
  }
}
