import 'package:flutter/material.dart';
import 'package:madrassat_iqraa/core/theme/colors.dart';
import 'package:madrassat_iqraa/features/home/ui/widgets/appBar/curved_appbar.dart';
import 'package:madrassat_iqraa/features/transaction/ui/widgets/amount.dart';
import 'package:madrassat_iqraa/features/transaction/ui/widgets/back_icons.dart';

class IncomePage extends StatelessWidget {
  const IncomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: AppColors.background),
          curvedAppBar(200),
          backIcons(context: context),
          amount(),
        ],
      ),
    );
  }
}
