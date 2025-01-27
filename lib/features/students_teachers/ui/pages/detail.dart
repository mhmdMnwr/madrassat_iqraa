import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/string.dart';
import 'package:madrassat_iqraa/core/theme/colors.dart';
import 'package:madrassat_iqraa/core/theme/icons.dart';
import 'package:madrassat_iqraa/features/home/ui/widgets/appBar/curved_appbar.dart';
import 'package:madrassat_iqraa/features/students_teachers/data/model/payed_months.dart';
import 'package:madrassat_iqraa/features/students_teachers/data/model/student_model.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/bloc/cubit/student_cubit.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/bloc/cubit/student_state.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/widgets/details/widgets.dart';
import 'package:madrassat_iqraa/features/transaction/ui/widgets/back_icons.dart';
import 'package:madrassat_iqraa/features/transaction/ui/widgets/transactionItems/stuff.dart';

class DetailPage extends StatefulWidget {
  final Student student;

  const DetailPage({super.key, required this.student});
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<StudentCubit>().getPayedMonths(id: widget.student.id);
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
            details: true,
          ),
          details(),
        ],
      ),
    );
  }

  Widget _buildBloc() {
    return BlocBuilder<StudentCubit, StudentState>(
      builder: (context, state) {
        if (state is StudentLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is PayedMonthsLoaded) {
          return payedMonthList(
            dates: state.dates,
          );
        } else if (state is PayedMonthError) {
          return Center(child: Text(state.message));
        } else {
          return Container();
        }
      },
    );
  }

  Widget details() {
    return Positioned(
      top: 90.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Container(
            height: 150.h,
            width: 350.w,
            decoration: border(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                detailsImage(),
                studentDetailsInfo(student: widget.student),
                studentDetails(),
              ],
            )),
      ),
    );
  }
}

BoxDecoration border() {
  return BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: Colors.black87,
        offset: Offset(0, 1),
        blurRadius: 2.sp,
      ),
    ],
    color: Colors.white,
    borderRadius: BorderRadius.circular(7.sp),
    border: Border.all(
      color: AppColors.midnightBlue,
      width: 1.w,
    ),
  );
}

class payedMonthList extends StatelessWidget {
  final List<PayedMonths> dates;

  const payedMonthList({super.key, required this.dates});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dates.length, // Adjust the item count as needed
      itemBuilder: (context, index) {
        return monthList(index: index, date: dates[index].toString());
      },
    );
  }
}

Widget monthList({required int index, required String date}) {
  return Padding(
    padding: EdgeInsets.fromLTRB(6.w, (index == 0) ? 255.h : 12.h, 6.w, 0),
    child: Container(
      height: 100.h,
      width: 400.w,
      decoration: border(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _moneyRow(isIncome: true, date: date),
          _infoColumn(date: date),
        ],
      ),
    ),
  );
}

Widget _infoColumn({required String date}) {
  return Padding(
    padding: EdgeInsets.only(
      left: 30.w,
      bottom: 5.h,
    ),
    child: Padding(
      padding: EdgeInsets.only(left: 1.w),
      child: Padding(
        padding: EdgeInsets.only(top: 10.h, right: 10.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            timeRow(
                time:
                    '${DateTime.parse(date).hour}:${DateTime.parse(date).minute}',
                icon: AppIcons.clock),
            SizedBox(
              height: 5.h,
            ),
            timeRow(
                time:
                    '${DateTime.parse(date).day}/${DateTime.parse(date).month}/${DateTime.parse(date).year}',
                icon: AppIcons.calendar),
          ],
        ),
      ),
    ),
  );
}

Widget _moneyRow({required bool isIncome, required String date}) {
  return Padding(
    padding: EdgeInsets.only(
      left: 25.w,
      top: 50.h,
    ),
    child: Row(children: [
      Text("800 دج",
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
          style: TextStyle(
              fontFamily: AppStrings.fontfam,
              fontWeight: FontWeight.w700,
              color: AppColors.forestGreen,
              fontSize: 22.sp)),
      SizedBox(
        width: 6.w,
      ),
      moneyIcon(isIncome: isIncome),
    ]),
  );
}
