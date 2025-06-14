import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/string.dart';
import 'package:madrassat_iqraa/core/theme/colors.dart';
import 'package:madrassat_iqraa/core/theme/font.dart';
import 'package:madrassat_iqraa/core/theme/icons.dart';

TextFormField usernameTFF({TextEditingController? controller}) {
  return TextFormField(
    textAlign: TextAlign.right,
    textDirection: TextDirection.rtl,
    controller: controller,
    style: TextStyle(
      fontFamily: AppStrings.fontfam,
      fontWeight: FontWeight.w400,
      color: AppColors.navyBlue,
      fontSize: 22.sp,
    ),
    decoration: InputDecoration(
      hintText: 'اسم المستخدم',
      hintStyle: TextStyle(
        fontFamily: AppStrings.fontfam,
        fontWeight: FontWeight.w400,
        color: AppColors.skyBlue,
        fontSize: 22.sp,
      ),
      alignLabelWithHint: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0.sp),
        borderSide: BorderSide(
          color: AppColors.navyBlue,
          width: 2.0,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0.sp),
        borderSide: BorderSide(
          color: AppColors.skyBlue,
          width: 2.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0.sp),
        borderSide: BorderSide(
          color: AppColors.vibrantOrange,
          width: 2.0,
        ),
      ),
      fillColor: Colors.white,
      suffixIconConstraints: BoxConstraints(
        maxHeight: 60.h,
        maxWidth: 60.w,
      ),
      suffixIcon: Padding(
        padding: EdgeInsets.only(
          right: 10.w,
          left: 15.w,
        ),
        child: Image.asset(
          AppIcons.username,
          color: Colors.black,
        ),
      ),
    ),
    textAlignVertical: TextAlignVertical.center,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'يرجى اختيار اسم المستخدم';
      } else if (value.length < 5) {
        return 'يجب أن يكون اسم المستخدم أكثر من 5 أحرف';
      } else if (value.length > 15) {
        return 'يجب أن يكون اسم المستخدم أقل من 15 حرف';
      }
      return null;
    },
  );
}

ElevatedButton registerButton({required VoidCallback saveUser}) {
  return ElevatedButton(
    onPressed: saveUser,
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.shadowBlue, // Button background color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0.sp),
      ),
      padding: EdgeInsets.symmetric(vertical: 12.0.h, horizontal: 24.0.w),
    ),
    child: Text(
      'تسجيل الدخول',
      style: AppTextStyle.titles,
    ),
  );
}

class PasswordField extends StatefulWidget {
  final TextEditingController? controller;
  const PasswordField({Key? key, this.controller}) : super(key: key);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.right,
      textDirection: TextDirection.rtl,
      controller: widget.controller,
      obscureText: _obscureText,
      style: TextStyle(
        fontFamily: AppStrings.fontfam,
        fontWeight: FontWeight.w400,
        color: AppColors.navyBlue,
        fontSize: 22.sp,
      ),
      decoration: InputDecoration(
        hintText: 'كلمة المرور',
        hintStyle: TextStyle(
          fontFamily: AppStrings.fontfam,
          fontWeight: FontWeight.w400,
          color: AppColors.skyBlue,
          fontSize: 22.sp,
        ),
        alignLabelWithHint: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0.sp),
          borderSide: BorderSide(
            color: AppColors.navyBlue,
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0.sp),
          borderSide: BorderSide(
            color: AppColors.skyBlue,
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0.sp),
          borderSide: BorderSide(
            color: AppColors.vibrantOrange,
            width: 2.0,
          ),
        ),
        fillColor: Colors.white,
        suffixIcon: Padding(
          padding: EdgeInsets.only(left: 10.w, right: 15.w),
          child: Image.asset(
            AppIcons.password,
            color: Colors.black,
          ),
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 15.w, right: 10.w),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: Colors.black,
            ),
          ),
        ),
      ),
      textAlignVertical: TextAlignVertical.center,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'يرجى إدخال كلمة المرور';
        } else if (value.length < 8) {
          return 'يجب أن تكون كلمة المرور أكثر من 8 أحرف';
        }
        return null;
      },
    );
  }
}
