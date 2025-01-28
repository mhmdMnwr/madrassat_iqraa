import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/theme/colors.dart';
import 'package:madrassat_iqraa/features/home/ui/widgets/appBar/curved_appbar.dart';
import 'package:madrassat_iqraa/features/students_teachers/data/model/student_model.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/bloc/cubit/student_cubit.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/bloc/cubit/student_state.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/widgets/details/list_widget.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/widgets/details/widgets.dart';
import 'package:madrassat_iqraa/features/transaction/ui/widgets/back_icons.dart';

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
          curvedAppBar(200),
          _buildBloc(),
          details(),
          backIcons(
            context: context,
            details: true,
          ),
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
