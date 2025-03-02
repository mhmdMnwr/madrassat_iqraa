import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:madrassat_iqraa/core/string.dart';
import 'package:madrassat_iqraa/core/theme/colors.dart';
import 'dart:ui' as ui;

import 'package:madrassat_iqraa/core/theme/font.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/bloc/cubit/student_cubit.dart'; // Import TextDirection from dart:ui

Widget cuTextField(String label, TextEditingController controller,
    {required String? Function(String?)? validator}) {
  return SizedBox(
    width: 300.w,
    child: TextFormField(
      textAlign: TextAlign.right,
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
        contentPadding: EdgeInsets.symmetric(
          vertical: 14.h,
          horizontal: 18.w,
        ),
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
      keyboardType: TextInputType.multiline, // Allow multiline input
      maxLines: null, // Makes the field grow dynamically
      minLines: 1, // Sets the initial height
      validator: validator,
    ),
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
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'الرجاء اختيار الجنس';
          }
          return null;
        },
      ),
    ),
  );
}

class ArabicSearchField extends StatefulWidget {
  final BuildContext pcontext;
  final bool isTeacher;
  final TextEditingController controller;

  const ArabicSearchField({
    required this.pcontext,
    super.key,
    required this.controller,
    required this.isTeacher,
  });

  @override
  _ArabicSearchFieldState createState() => _ArabicSearchFieldState();
}

class _ArabicSearchFieldState extends State<ArabicSearchField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      textAlign: TextAlign.right,
      textDirection: ui.TextDirection.rtl,
      style: AppTextStyle.categories,
      decoration: InputDecoration(
        hintText: 'بحث',
        hintStyle: AppTextStyle.categories,
        hintTextDirection: ui.TextDirection.rtl,
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 12.w),
          child: Icon(Icons.search, color: Colors.grey, size: 35.sp),
        ),
        suffixIcon: widget.controller.text.isEmpty
            ? null
            : IconButton(
                icon: const Icon(Icons.close, color: Colors.grey),
                onPressed: () {
                  widget.controller.clear();
                  context.read<StudentCubit>().searchStudents(
                        '',
                        isTeacher: widget.isTeacher,
                      );
                },
              ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
      ),
      onChanged: (value) {
        widget.pcontext
            .read<StudentCubit>()
            .searchStudents(value, isTeacher: widget.isTeacher);
      },
    );
  }
}
