import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrassat_iqraa/core/string.dart';
import 'package:madrassat_iqraa/core/theme/colors.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/bloc/cubit/student_cubit.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/bloc/cubit/student_state.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/widgets/mylist.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/widgets/stud_teach_app_bar.dart';

class StudentsTeachersPage extends StatefulWidget {
  final bool isteacher;
  const StudentsTeachersPage({super.key, required this.isteacher});

  @override
  State<StudentsTeachersPage> createState() => _StudentsTeachersPageState();
}

class _StudentsTeachersPageState extends State<StudentsTeachersPage> {
  @override
  void initState() {
    super.initState();
    context.read<StudentCubit>().loadStudents(isteacher: widget.isteacher);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StudTeachAppBar(
        context: context,
        title: !widget.isteacher
            ? AppPagesNames.studentsList
            : AppPagesNames.teachersList,
      ),
      body: Container(color: AppColors.background, child: _buildbloc()),
    );
  }

  Widget _buildbloc() {
    return BlocBuilder<StudentCubit, StudentState>(
      builder: (context, state) {
        if (state is StudentLoading) {
          return CircularProgressIndicator();
        } else if (state is StudentLoaded) {
          return MyList(
            students: state.students,
            isteacher: widget.isteacher,
          );
        } else if (state is StudentError) {
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
