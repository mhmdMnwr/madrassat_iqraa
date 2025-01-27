import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/theme/colors.dart';
import 'package:madrassat_iqraa/core/theme/font.dart';
import 'package:madrassat_iqraa/features/students_teachers/data/model/student_model.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/bloc/cubit/student_cubit.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/widgets/create_update_search_fields.dart';

Future<void> showAddUserDialog({
  Student? student,
  bool isUpdate = false,
  required BuildContext context,
  required bool isTeacher,
  required TextEditingController nameController,
  required TextEditingController bithdateController,
  required TextEditingController sexController,
  required TextEditingController priceController,
  required TextEditingController payDayController,
}) async {
  if (!isTeacher && !isUpdate) {
    priceController.text = '0';
    payDayController.text = '0 / 0 / 0';
  }
  if (isUpdate) {
    nameController.text = student!.name;
    bithdateController.text = student.birthDate;
    sexController.text = student.sex;
    priceController.text = student.money.toString();
    payDayController.text = student.payDay;
  }
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  return showDialog(
    context: context,
    builder: (
      dialogContext,
    ) {
      return AlertDialog(
        title: Center(
            child: Text(
          !isUpdate
              ? 'إضافة ${isTeacher ? 'معلم' : 'طالب'}'
              : 'تعديل ${isTeacher ? 'معلم' : 'طالب'}',
          style: AppTextStyle.mains,
        )),
        content: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                cuTextField('الاسم', nameController, validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال الاسم';
                  }
                  return null;
                }),
                SizedBox(
                  height: 30.h,
                ),
                cuDateField('تاريخ الميلاد', bithdateController,
                    validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال تاريخ الميلاد';
                  }
                  return null;
                }),
                SizedBox(
                  height: 30.h,
                ),
                genderField(sexController: sexController),
                SizedBox(
                  height: 30.h,
                ),
                if (isTeacher)
                  cuTextField('المبلغ المستحق', priceController,
                      validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى إدخال المبلغ المستحق';
                    }
                    if (int.tryParse(value) == null) {
                      return 'يرجى إدخال قيمة رقمية';
                    }
                    return null;
                  }),
                SizedBox(
                  height: 30.h,
                ),
                if (isTeacher)
                  cuDateField('تاريخ الدفع', payDayController,
                      validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى إدخال تاريخ الدفع';
                    }
                    return null;
                  }),
              ],
            ),
          ),
        ),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Student newStudent = Student(
                    id: student?.id,
                    name: nameController.text,
                    sex: sexController.text,
                    isTeacher: isTeacher,
                    birthDate: bithdateController.text,
                    payed: isTeacher
                        ? true
                        : isUpdate
                            ? student!.payed
                            : false,
                    money: int.parse(priceController.text),
                    payDay: payDayController.text,
                  );
                  if (!isUpdate) {
                    context
                        .read<StudentCubit>()
                        .addStudent(newStudent, isTeacher: isTeacher);
                  } else {
                    context.read<StudentCubit>().updateStudent(
                        student!.id, newStudent,
                        isTeacher: isTeacher);
                  }
                  if (Navigator.canPop(dialogContext)) {
                    Navigator.of(dialogContext).pop();
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    AppColors.shadowBlue, // Button background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0.sp),
                ),
                padding:
                    EdgeInsets.symmetric(vertical: 12.0.h, horizontal: 24.0.w),
              ),
              child: Text(
                !isUpdate ? 'إضافة' : 'تعديل',
                style: AppTextStyle.titles,
              ),
            ),
          )
        ],
      );
    },
  );
}
