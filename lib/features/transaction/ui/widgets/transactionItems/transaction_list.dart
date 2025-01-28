import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/features/transaction/ui/widgets/details.dart';
import 'package:madrassat_iqraa/features/transaction/ui/widgets/transactionItems/stuff.dart';
import 'package:madrassat_iqraa/features/transaction/data/model/transaction_model.dart';

class TransactionList extends StatelessWidget {
  final bool isIncome;
  final List<Transactions> transactions;

  const TransactionList(
      {super.key, required this.isIncome, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 15.h),
      child: ListView.builder(
        itemCount: transactions.length, // Adjust the item count as needed
        itemBuilder: (context, index) {
          return transactionList(
              context: context,
              isIncome: isIncome,
              index: index,
              transaction: transactions[index]);
        },
      ),
    );
  }

  Widget transactionList(
      {required BuildContext context,
      required bool isIncome,
      required int index,
      required Transactions transaction}) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => DetailsPopup(
            transaction: transaction,
          ),
        );
      },
      child: Padding(
        padding:
            EdgeInsets.fromLTRB(7.w, (index == 0) ? 255.h : 12.h, 10.w, 20.h),
        child: Container(
          height: 100.h,
          width: 400.w,
          decoration: border(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              moneyRow(isIncome: isIncome, transaction: transaction),
              infoColumn(transaction: transaction),
            ],
          ),
        ),
      ),
    );
  }
}
