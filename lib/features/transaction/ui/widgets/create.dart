import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/theme/colors.dart';
import 'package:madrassat_iqraa/core/theme/font.dart';
import 'package:madrassat_iqraa/features/home/data/repo/user_repo.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/widgets/create_update_search_fields.dart';
import 'package:madrassat_iqraa/features/transaction/data/model/transaction_model.dart';
import 'package:madrassat_iqraa/features/transaction/ui/bloc/cubit/transactions_cubit.dart';
import 'package:madrassat_iqraa/injection.dart';

Future<void> showAddTransactionDialog({
  required bool isIncome,
  required BuildContext context,
  required TextEditingController amountController,
  required TextEditingController descriptionController,
}) async {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final repository = getIt<UserRepository>();

  return showDialog(
    context: context,
    builder: (
      dialogContext,
    ) {
      return AlertDialog(
        title: Center(
            child: Text(
          isIncome ? 'إضافة تبرع' : 'سحب مبلغ',
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
                    return 'يرجى إدخال المبلغ المستحق';
                  }
                  if (int.tryParse(value) == null) {
                    return 'يرجى إدخال قيمة رقمية';
                  }
                  if (value.length > 7) {
                    return 'القيمة المدخلة كبيرة جدا';
                  }
                  return null;
                }),
                SizedBox(
                  height: 30.h,
                ),
                cuTextField('الوصف', descriptionController, validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال الوصف';
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
              onPressed: () async {
                String userName = '';
                await repository.getUserById().then((result) {
                  result.fold(
                    (error) => () {
                      if (Navigator.canPop(dialogContext)) {
                        Navigator.of(dialogContext).pop();
                      }
                    },
                    (user) {
                      userName = user!.userName;
                    },
                  );
                });
                if (formKey.currentState!.validate()) {
                  Transactions newTransaction = Transactions(
                    amount: int.parse(amountController.text),
                    description: descriptionController.text,
                    type: isIncome,
                    userName: userName,
                  );

                  context
                      .read<TransactionsCubit>()
                      .createTransaction(newTransaction);

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
                'حفظ',
                style: AppTextStyle.titles,
              ),
            ),
          )
        ],
      );
    },
  );
}
