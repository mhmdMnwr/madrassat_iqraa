import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrassat_iqraa/core/String.dart';
import 'package:madrassat_iqraa/core/theme/colors.dart';
import 'package:madrassat_iqraa/features/students_teachers/data/model/student_model.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/bloc/cubit/student_cubit.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/bloc/cubit/student_state.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/widgets/info.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/widgets/stud_teach_app_bar.dart';

class StudentsPage extends StatefulWidget {
  StudentsPage({super.key});

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  @override
  void initState() {
    super.initState();
    context.read<StudentCubit>().loadStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StudTeachAppBar(
        context: context,
        title: AppPagesNames.studentsList,
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
          return MyList(students: state.students);
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

class MyList extends StatelessWidget {
  final List<Student> students;

  const MyList({super.key, required this.students});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: students.length,
      itemBuilder: (context, index) {
        return UserInfoCard(
          student: students[index],
        );
      },
    );
  }
}
