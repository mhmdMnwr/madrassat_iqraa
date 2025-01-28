import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrassat_iqraa/core/theme/colors.dart';
import 'package:madrassat_iqraa/features/home/ui/widgets/appBar/curved_appbar.dart';
import 'package:madrassat_iqraa/features/transaction/ui/bloc/cubit/transactions_cubit.dart';
import 'package:madrassat_iqraa/features/transaction/ui/widgets/amount/amount.dart';
import 'package:madrassat_iqraa/features/transaction/ui/widgets/back_icons.dart';
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<TransactionsCubit>().fetchLastMonthByType(widget.isIncome);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: AppColors.background),
          _buildBloc(),
          curvedAppBar(200),
          backIcons(
            context: context,
            isIncome: widget.isIncome,
          ),
          amount(
            monthIncExp: 50000,
            addTransaction: () {},
            isIncome: widget.isIncome,
            totalFund: 500000,
          ),
        ],
      ),
    );
  }

  Widget _buildBloc() {
    return BlocBuilder<TransactionsCubit, TransactionsState>(
      builder: (context, state) {
        if (state is TransactionsLoading) {
          return CircularProgressIndicator();
        } else if (state is TransactionsLoaded) {
          return TransactionList(
              isIncome: widget.isIncome, transactions: state.transactions);
        } else if (state is TransactionsError) {
          return Text(state.message);
        } else {
          return Container(
            color: Colors.red,
          );
        }
      },
    );
  }
}
