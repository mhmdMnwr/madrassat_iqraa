import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/features/transaction/ui/widgets/details.dart';
import 'package:madrassat_iqraa/features/transaction/ui/widgets/transactionItems/stuff.dart';
import 'package:madrassat_iqraa/features/transaction/data/model/transaction_model.dart';

class AllTransactionList extends StatelessWidget {
  final List<Transactions> transactions;
  final bool isLoadingMore; // Add this parameter
  final ScrollController scrollController;
  const AllTransactionList({
    super.key,
    required this.transactions,
    this.isLoadingMore = false,
    required this.scrollController, // Default to false
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 13.h),
      child: ListView.builder(
        controller: scrollController,
        itemCount: transactions.length + (isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == transactions.length && isLoadingMore) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          return transactionList(
              context: context,
              isIncome: transactions[index].type,
              index: index,
              transaction: transactions[index]);
        },
      ),
    );
  }

  Widget transactionList({
    required BuildContext context,
    required bool isIncome,
    required int index,
    required Transactions transaction,
  }) {
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
            EdgeInsets.fromLTRB(7.w, (index == 0) ? 170.h : 12.h, 10.w, 14.h),
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
