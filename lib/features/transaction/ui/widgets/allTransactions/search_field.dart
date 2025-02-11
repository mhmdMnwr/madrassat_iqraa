import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/theme/font.dart';
import 'dart:ui' as ui;

class TransactionSearchField extends StatefulWidget {
  final TextEditingController controller;
  const TransactionSearchField({
    super.key,
    required this.controller,
  });

  @override
  // ignore: library_private_types_in_public_api
  _TransactionSearchFieldState createState() => _TransactionSearchFieldState();
}

class _TransactionSearchFieldState extends State<TransactionSearchField> {
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
    );
  }
}
