import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/theme/colors.dart';
import 'package:madrassat_iqraa/core/theme/font.dart';
import 'package:madrassat_iqraa/features/students_teachers/data/model/student_model.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/widgets/create_update_search_fields.dart';

Future<void> showAddamount({
  required BuildContext context,
  required TextEditingController amountController,
  required Student student,
  required BuildContext popUpContext,
  required BuildContext previousContext,
  required String userName,
  required bool isTeacher,
}) async {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  return showDialog(
    context: context,
    builder: (
      dialogContext,
    ) {
      return AlertDialog(
        title: Center(
            child: Text(
          ' مبلغ التبرع',
          style: AppTextStyle.mains,
        )),
        content: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                cuTextField('المبلغ ', amountController, validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال المبلغ';
                  }
                  if (int.tryParse(value) == null) {
                    return 'يرجى إدخال قيمة رقمية';
                  }
                  if (value.length > 7) {
                    return 'القيمة المدخلة كبيرة جدا';
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
                  // int amount = int.parse(amountController.text);
                  //   Transactions transaction = Transactions(
                  //       type: true,
                  //       userName: userName,
                  //       amount: amount,
                  //       description:
                  //           'تبرع الطالب ${student.name} بمبلغ $amount');
                  //   PayedMonths date =
                  //       PayedMonths(studentId: student.id, amount: amount);

                  //   Student payedStudent =
                  //       student.copyWith(payed: true, money: amount);
                  //   previousContext
                  //       .read<StudentCubit>()
                  //       .createPayedMonths(date);

                  //   previousContext.read<StudentCubit>().updatePayed(
                  //       student.id, payedStudent,
                  //       isTeacher: isTeacher);
                  //   previousContext
                  //       .read<TransactionsCubit>()
                  //       .createTransaction(transaction);
                  //   previousContext
                  //       .read<AdminCubit>()
                  //       .addFunds(amount: amount);
                  //   Navigator.of(popUpContext).pop();

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
                'إضافة',
                style: AppTextStyle.titles,
              ),
            ),
          )
        ],
      );
    },
  );
}
