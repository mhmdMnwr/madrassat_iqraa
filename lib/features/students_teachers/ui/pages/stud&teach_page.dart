import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/admin/cubit/admin_cubit.dart';
import 'package:madrassat_iqraa/core/string.dart';
import 'package:madrassat_iqraa/core/theme/colors.dart';
import 'package:madrassat_iqraa/core/theme/font.dart';
import 'package:madrassat_iqraa/features/home/data/repo/user_repo.dart';
import 'package:madrassat_iqraa/features/home/ui/bloc/cubit/user_cubit.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/bloc/cubit/student_cubit.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/bloc/cubit/student_state.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/widgets/mylist.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/widgets/pop_up_create.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/widgets/stud_teach_app_bar.dart';
import 'package:madrassat_iqraa/injection.dart';

class StudentsTeachersPage extends StatefulWidget {
  final repository = getIt<UserRepository>();
  final bool isteacher;
  StudentsTeachersPage({super.key, required this.isteacher});

  @override
  State<StudentsTeachersPage> createState() => _StudentsTeachersPageState();
}

class _StudentsTeachersPageState extends State<StudentsTeachersPage> {
  late final TextEditingController nameController;
  late final TextEditingController bithdateController;
  late final TextEditingController sexController;
  late final TextEditingController priceController;
  late final TextEditingController payDayController;
  String userName = '';

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    bithdateController = TextEditingController();
    sexController = TextEditingController();
    priceController = TextEditingController();
    payDayController = TextEditingController();
    context.read<UserCubit>().getUserById();
    context.read<StudentCubit>().loadStudents(isteacher: widget.isteacher);
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
    return MultiBlocListener(
      listeners: [
        BlocListener<StudentCubit, StudentState>(
          listener: (context, state) {
            if (state is StudentPayed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('تمت العملية بنجاح'),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is StudentUpdated) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('تم التعديل بنجاح'),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is StudentAdded) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('تمت الإضافة بنجاح'),
                  backgroundColor: Colors.green,
                ),
              );
              if (widget.isteacher) {
                context.read<AdminCubit>().addTeacher();
              } else {
                context.read<AdminCubit>().addStudent();
              }
            } else if (state is StudentDeleted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('تم الحذف بنجاح'),
                  backgroundColor: Colors.green,
                ),
              );
              if (widget.isteacher) {
                context.read<AdminCubit>().removeTeacher();
              } else {
                context.read<AdminCubit>().removeStudent();
              }
            } else if (state is StudentError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is StudentLoading) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('جاري المعالجة...'),
                  backgroundColor: AppColors.vibrantOrange,
                ),
              );
            }
          },
        ),
        BlocListener<UserCubit, UserState>(
          listener: (context, state) {
            if (state is MeUserLoaded) {
              setState(() {
                userName = state.user.userName;
              });
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: StudTeachAppBar(
          search: true,
          context: context,
          title: !widget.isteacher
              ? AppPagesNames.studentsList
              : AppPagesNames.teachersList,
        ),
        body: Container(color: AppColors.background, child: _buildbloc()),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: SizedBox(
          height: 75.h,
          width: 75.w,
          child: FloatingActionButton(
              shape: CircleBorder(
                side: BorderSide(
                  color: AppColors.forestGreen, // Green border
                  width: 3.0.sp, // Border thickness
                ),
              ),
              backgroundColor: Colors.green, // Button background color
              elevation: 11.0, // Shadow effect

              mini: false,
              onPressed: () {
                showAddUserDialog(
                    context: context,
                    bithdateController: bithdateController,
                    isTeacher: widget.isteacher,
                    nameController: nameController,
                    payDayController: payDayController,
                    priceController: priceController,
                    sexController: sexController);
              },
              child: Text(
                'إضافة',
                style: AppTextStyle.titles,
              )),
        ),
      ),
    );
  }

  Widget _buildbloc() {
    return BlocBuilder<StudentCubit, StudentState>(
      buildWhen: (previous, current) {
        // Only rebuild if the current state is relevant
        return current is StudentLoading ||
            current is StudentLoaded ||
            current is StudentError;
      },
      builder: (context, state) {
        if (state is StudentLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is StudentLoaded) {
          return MyList(
            userName: userName,
            previousContext: context,
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

//this is a pop up view that shows the form to add students/teachers
}
