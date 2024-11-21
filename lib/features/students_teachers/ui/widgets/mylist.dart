import 'package:flutter/material.dart';
import 'package:madrassat_iqraa/features/students_teachers/data/model/student_model.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/widgets/info.dart';

class MyList extends StatelessWidget {
  final List<Student> students;
  final bool isteacher;

  const MyList({super.key, required this.students, required this.isteacher});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: students.length,
      itemBuilder: (context, index) {
        return UserInfoCard(
          isteacher: isteacher,
          student: students[index],
        );
      },
    );
  }
}
