import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrassat_iqraa/core/String.dart';
import 'package:madrassat_iqraa/core/admin/cubit/admin_cubit.dart';
import 'package:madrassat_iqraa/core/theme/colors.dart';
import 'package:madrassat_iqraa/core/widgets/snack_bar.dart';
import 'package:madrassat_iqraa/features/home/ui/widgets/appBar/curved_appbar.dart';
import 'package:madrassat_iqraa/features/transaction/data/model/transaction_model.dart';
import 'package:madrassat_iqraa/features/transaction/ui/bloc/cubit/transactions_cubit.dart';
import 'package:madrassat_iqraa/features/transaction/ui/widgets/amount/amount.dart';
import 'package:madrassat_iqraa/features/transaction/ui/widgets/back_icons.dart';
import 'package:madrassat_iqraa/features/transaction/ui/widgets/create.dart';
import 'package:madrassat_iqraa/features/transaction/ui/widgets/transactionItems/transaction_list.dart';

class IncomeExpensePage extends StatefulWidget {
  final bool isIncome;

  const IncomeExpensePage({
    super.key,
    required this.isIncome,
  });

  @override
  State<IncomeExpensePage> createState() => _IncomeExpensePageState();
}

class _IncomeExpensePageState extends State<IncomeExpensePage> {
  late final TextEditingController amountController;
  late final TextEditingController descriptionController;
  @override
  void initState() {
    super.initState();
    context.read<AdminCubit>().getAdminData();

    context.read<TransactionsCubit>().fetchLastMonthByType(widget.isIncome);

    amountController = TextEditingController();
    descriptionController = TextEditingController();
  }

  int totalFund = 0;
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AdminCubit, AdminState>(
          listener: (context, state) {
            if (state is AdminLoaded) {
              setState(() {
                totalFund = state.schoolState?.totalFunds ?? 0;
              });
            }
          },
        ),
        BlocListener<TransactionsCubit, TransactionsState>(
          listener: (context, state) {
            if (state is TransactionCreated) {
              MySnackBars.success(
                  message: 'تمت العملية بنجاح', context: context);

              if (widget.isIncome) {
                context
                    .read<AdminCubit>()
                    .addFunds(amount: int.parse(amountController.text));
              } else {
                context
                    .read<AdminCubit>()
                    .removeFunds(amount: int.parse(amountController.text));
              }

              context
                  .read<TransactionsCubit>()
                  .fetchLastMonthByType(widget.isIncome);
            }
          },
        )
      ],
      child: Scaffold(
        body: Stack(
          children: [
            Container(color: AppColors.background),
            _buildBloc(),
            curvedAppBar(200),
            backIcons(
              context: context,
              isIncome: widget.isIncome,
            ),
            _buildblocAmount(),
          ],
        ),
      ),
    );
  }

  Widget _buildblocAmount() {
    return BlocBuilder<TransactionsCubit, TransactionsState>(
      buildWhen: (previous, current) {
        // Only rebuild if the current state is relevant
        return current is TransactionsLoading ||
            current is TransactionsLoaded ||
            current is TransactionsError;
      },
      builder: (context, state) {
        if (state is TransactionsLoading) {
          return amount(
              monthIncExp: '----',
              totalFund: '-----',
              isIncome: widget.isIncome,
              addTransaction: () {});
        } else if (state is TransactionsLoaded) {
          context.read<AdminCubit>().getAdminData();
          return amount(
            monthIncExp: calculateLastMonthFunds(state.transactions),
            addTransaction: () {
              showAddTransactionDialog(
                amountController: amountController,
                descriptionController: descriptionController,
                context: context,
                isIncome: widget.isIncome,
              );
            },
            isIncome: widget.isIncome,
            totalFund: totalFund,
          );
        } else if (state is TransactionsError) {
          MySnackBars.failure(message: state.message, context: context);
          return Center(child: Text(state.message));
        } else {
          return Container(
            color: Colors.red,
          );
        }
      },
    );
  }

  Widget _buildBloc() {
    return BlocBuilder<TransactionsCubit, TransactionsState>(
      buildWhen: (previous, current) {
        // Only rebuild if the current state is relevant
        return current is TransactionsLoading ||
            current is TransactionsLoaded ||
            current is TransactionsError;
      },
      builder: (context, state) {
        if (state is TransactionsLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is TransactionsLoaded) {
          if (state.transactions.isEmpty) {
            return const Center(
                child: Text('لا توجد نتائج',
                    style: TextStyle(
                      fontFamily: AppStrings.fontfam,
                      fontSize: 18,
                    )));
          } else {
            return TransactionList(
              isIncome: widget.isIncome,
              transactions: state.transactions,
            );
          }
        } else if (state is TransactionsError) {
          MySnackBars.failure(message: state.message, context: context);
          return Text(state.message);
        } else {
          return Container(
            color: Colors.red,
          );
        }
      },
    );
  }

  int calculateLastMonthFunds(List<Transactions> transactions) {
    int total = 0;
    for (var transaction in transactions) {
      total += transaction.amount;
    }
    return total;
  }
}
