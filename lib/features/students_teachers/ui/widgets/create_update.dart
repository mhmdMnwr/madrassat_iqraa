import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:madrassat_iqraa/core/string.dart';
import 'package:madrassat_iqraa/core/theme/colors.dart';
import 'dart:ui' as ui; // Import TextDirection from dart:ui

Widget cuTextField(String label, TextEditingController controller,
    {required String? Function(String?)? validator}) {
  return SizedBox(
    width: 300.w,
    child: TextFormField(
        textAlign: TextAlign.right,
        // textDirection: TextDirection.rtl,
        controller: controller,
        style: TextStyle(
          fontFamily: AppStrings.fontfam,
          fontWeight: FontWeight.w500,
          color: AppColors.skyBlue,
          fontSize: 22.sp,
        ),
        decoration: InputDecoration(
          hintText: label,
          hintStyle: TextStyle(
            fontFamily: AppStrings.fontfam,
            fontWeight: FontWeight.w400,
            color: AppColors.skyBlue,
            fontSize: 20.sp,
          ),
          alignLabelWithHint: true,
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              EdgeInsets.symmetric(vertical: 14.h, horizontal: 18.w),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0.sp),
            borderSide: BorderSide(
              color: AppColors.navyBlue,
              width: 1.8,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0.sp),
            borderSide: BorderSide(
              color: AppColors.skyBlue,
              width: 1.8,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0.sp),
            borderSide: BorderSide(
              color: AppColors.vibrantOrange,
              width: 2.2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0.sp),
            borderSide: BorderSide(
              color: Colors.redAccent,
              width: 2.0,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0.sp),
            borderSide: BorderSide(
              color: Colors.redAccent,
              width: 2.5,
            ),
          ),
          suffixIconConstraints: BoxConstraints(
            maxHeight: 50.h,
            maxWidth: 50.w,
          ),
          suffixIcon: Padding(
            padding: EdgeInsets.only(left: 12.w, right: 8.w),
            child: Icon(
              Icons.edit,
              color: AppColors.navyBlue,
              size: 28.sp,
            ),
          ),
        ),
        textAlignVertical: TextAlignVertical.center,
        cursorColor: AppColors.skyBlue,
        keyboardType: TextInputType.text,
        validator: validator),
  );
}

Widget cuDateField(String label, TextEditingController controller,
    {required String? Function(String?)? validator}) {
  return TextFormField(
    textAlign: TextAlign.right,
    // textDirection: TextDirection.rtl,
    controller: controller,
    style: TextStyle(
      fontFamily: AppStrings.fontfam,
      fontWeight: FontWeight.w500,
      color: AppColors.skyBlue,
      fontSize: 22.sp,
    ),
    decoration: InputDecoration(
      hintText: label,
      hintStyle: TextStyle(
        fontFamily: AppStrings.fontfam,
        fontWeight: FontWeight.w400,
        color: AppColors.skyBlue,
        fontSize: 20.sp,
      ),
      alignLabelWithHint: true,
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 18.w),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0.sp),
        borderSide: BorderSide(
          color: AppColors.navyBlue,
          width: 1.8,
        ),
      ),
      suffixIcon: Builder(
        builder: (context) => IconButton(
          icon: Icon(Icons.calendar_today,
              color: AppColors.navyBlue, size: 28.sp),
          onPressed: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );
            if (pickedDate != null) {
              String formattedDate =
                  DateFormat('dd/MM/yyyy').format(pickedDate);
              controller.text = formattedDate;
            }
          },
        ),
      ),
    ),
    readOnly: true,
    validator: validator,
  );
}

Widget genderField({required TextEditingController sexController}) {
  return Directionality(
    textDirection: ui.TextDirection.rtl, // Use the TextDirection from dart:ui
    child: SizedBox(
      width: 300.w,
      child: DropdownButtonFormField<String>(
        value: ['ذكر', 'أنثى'].contains(sexController.text)
            ? sexController.text
            : null, // Ensure valid selection
        onChanged: (value) {
          sexController.text = value ?? '';
        },
        items: ['ذكر', 'أنثى'].map((String sex) {
          return DropdownMenuItem<String>(
            value: sex,
            child: Text(
              sex,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontFamily: AppStrings.fontfam,
                fontWeight: FontWeight.w500,
                color: AppColors.skyBlue,
                fontSize: 22.sp,
              ),
            ),
          );
        }).toList(),
        decoration: InputDecoration(
          hintText: "الرجاء اختيار الجنس",
          hintStyle: TextStyle(
            fontFamily: AppStrings.fontfam,
            fontWeight: FontWeight.w600,
            color: AppColors.skyBlue,
            fontSize: 23.sp,
          ),
          alignLabelWithHint: true,
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              EdgeInsets.symmetric(vertical: 14.h, horizontal: 18.w),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0.sp),
            borderSide: BorderSide(
              color: AppColors.navyBlue,
              width: 1.8,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0.sp),
            borderSide: BorderSide(
              color: AppColors.skyBlue,
              width: 1.8,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0.sp),
            borderSide: BorderSide(
              color: AppColors.skyBlue,
              width: 2.2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0.sp),
            borderSide: BorderSide(
              color: Colors.redAccent,
              width: 2.0,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0.sp),
            borderSide: BorderSide(
              color: Colors.redAccent,
              width: 2.5,
            ),
          ),
          suffixIconConstraints: BoxConstraints(
            maxHeight: 50.h,
            maxWidth: 50.w,
          ),
          suffixIcon: Padding(
            padding: EdgeInsets.only(left: 12.w, right: 8.w),
            child: Icon(
              Icons.edit,
              color: AppColors.navyBlue,
              size: 28.sp,
            ),
          ),
        ),
      ),
    ),
  );
}
