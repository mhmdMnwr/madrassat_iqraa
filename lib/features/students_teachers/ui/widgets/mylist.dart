import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/theme/font.dart';
import 'package:madrassat_iqraa/features/students_teachers/data/model/payed_months.dart';
import 'package:madrassat_iqraa/features/students_teachers/data/model/student_model.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/bloc/cubit/student_cubit.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/pages/detail.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/widgets/info.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/widgets/pop_up_create.dart';
import 'package:madrassat_iqraa/injection.dart';

class MyList extends StatefulWidget {
  final List<Student> students;
  final bool isteacher;
  final BuildContext previousContext;

  const MyList(
      {super.key,
      required this.students,
      required this.isteacher,
      required this.previousContext});

  @override
  State<MyList> createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  late final TextEditingController nameController;
  late final TextEditingController bithdateController;
  late final TextEditingController sexController;
  late final TextEditingController priceController;
  late final TextEditingController payDayController;
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    bithdateController = TextEditingController();
    sexController = TextEditingController();
    priceController = TextEditingController();
    payDayController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    bithdateController.dispose();
    sexController.dispose();
    priceController.dispose();
    payDayController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.students.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => _showOptionsPopup(
              context, widget.students[index], widget.isteacher),
          child: UserInfoCard(
            isteacher: widget.isteacher,
            student: widget.students[index],
          ),
        );
      },
    );
  }

  void _showOptionsPopup(
      BuildContext context, Student student, bool isTeacher) {
    String label1 = widget.isteacher ? 'دفع مستحقات' : 'تسجيل متبرع';
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.all(10.sp),
          child: Directionality(
            textDirection: TextDirection.rtl, // Right to left text direction
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //! daf3 mousta7a9at button
                myListTile(Icons.payment, label1, () {
                  if (!isTeacher && !student.payed) {
                    PayedMonths date = PayedMonths(studentId: student.id);
                    Student payedStudent = student.copyWith(payed: true);
                    widget.previousContext
                        .read<StudentCubit>()
                        .createPayedMonths(date);

                    widget.previousContext.read<StudentCubit>().updateStudent(
                        student.id, payedStudent,
                        isTeacher: isTeacher);
                  }
                }),

                //! update button
                myListTile(Icons.update, 'تعديل', () {
                  showAddUserDialog(
                      student: student,
                      isUpdate: true,
                      context: widget.previousContext,
                      bithdateController: bithdateController,
                      isTeacher: isTeacher,
                      nameController: nameController,
                      payDayController: payDayController,
                      priceController: priceController,
                      sexController: sexController);
                }),

                //! details button
                if (!isTeacher)
                  myListTile(Icons.details, 'تفاصيل', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BlocProvider(
                                create: (context) => getIt<StudentCubit>(),
                                child: DetailPage(
                                  student: student,
                                ),
                              )),
                    );
                  }),
                Divider(
                  thickness: 2.sp,
                  height: 5,
                ),

                //! delete button
                myListTile(Icons.delete, 'طرد', () {
                  widget.previousContext
                      .read<StudentCubit>()
                      .deleteStudent(student.id, isTeacher: isTeacher);
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  ListTile myListTile(IconData iconName, String label, dynamic func) {
    return ListTile(
        leading: Icon(
          iconName,
          size: 30.sp,
        ),
        title: Text(
          label,
          style: AppTextStyle.categories,
        ),
        onTap: func);
  }
}
