import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/theme/colors.dart';
import 'package:madrassat_iqraa/features/home/ui/widgets/appBar/curved_appbar.dart';
import 'package:madrassat_iqraa/features/transaction/ui/widgets/amount/amount.dart';
import 'package:madrassat_iqraa/features/transaction/ui/widgets/back_icons.dart';
import 'package:madrassat_iqraa/features/transaction/ui/widgets/transactionItems/transaction_list.dart';

class IncomeExpensePage extends StatefulWidget {
  final dynamic isIncome;

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
    // context.read<TransactionsCubit>().fetchLastMonthByType(widget.isIncome);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: AppColors.background),
          TransactionList(
            isIncome: widget.isIncome,
          ),
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

  // _buildbloc() {
  //   return BlocBuilder<TransactionsCubit, TransactionsState>(
  //     builder: (context, state) {
  //       if (state is TransactionsLoading) {
  //         return CircularProgressIndicator();
  //       } else if (state is TransactionsLoaded) {
  //         return transactionList(isIncome: true);
  //       } else if (state is TransactionsError) {
  //         return Text(state.message);
  //       } else {
  //         return Container(
  //           color: Colors.red,
  //         );
  //       }
  //     },
  //   );
  // }
}
