import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/admin/cubit/admin_cubit.dart';
import 'package:madrassat_iqraa/core/string.dart';
import 'package:madrassat_iqraa/core/theme/colors.dart';
import 'package:madrassat_iqraa/core/theme/font.dart';
import 'package:madrassat_iqraa/core/widgets/snack_bar.dart';
import 'package:madrassat_iqraa/features/home/data/repo/user_repo.dart';
import 'package:madrassat_iqraa/features/home/ui/bloc/cubit/user_cubit.dart';
import 'package:madrassat_iqraa/features/students_teachers/data/model/student_model.dart';
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
  String? selectedSex; // Track selected sex filter

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

  void _updateSexFilter(String? sex) {
    setState(() {
      // Toggle the selected sex
      if (selectedSex == sex) {
        selectedSex = null; // Deselect if already selected
      } else {
        selectedSex = sex; // Select the new sex
      }
    });
  }

  // Helper method to calculate the sum of money from the filtered list
  double _calculateTotalMoney(List<Student> students) {
    return students.fold(0, (sum, student) => sum + (student.money ?? 0));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<StudentCubit, StudentState>(
          listener: (context, state) {
            if (state is StudentPayed) {
              MySnackBars.success(
                  message: 'تمت العملية بنجاح', context: context);
            } else if (state is StudentUpdated) {
              MySnackBars.success(
                  message: 'تم التعديل بنجاح', context: context);
            } else if (state is StudentAdded) {
              MySnackBars.success(
                  message: 'تمت الإضافة بنجاح', context: context);
              if (widget.isteacher) {
                context.read<AdminCubit>().addTeacher();
              } else {
                context.read<AdminCubit>().addStudent();
              }
            } else if (state is StudentDeleted) {
              MySnackBars.success(message: "تم الطرد ", context: context);
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
              MySnackBars.loading(message: 'يرجى الانتظار', context: context);
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
          isteacher: widget.isteacher,
          context: context,
          title: !widget.isteacher
              ? AppPagesNames.studentsList
              : AppPagesNames.teachersList,
        ),
        body: Container(
          color: AppColors.background,
          child: Column(
            children: [
              // Add the sex filter here
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 30.w),
                    GestureDetector(
                      onTap: () => _updateSexFilter('ذكر'), // Filter by male
                      child: FilterButton(
                        label: 'ذكور',
                        isSelected: selectedSex == 'ذكر',
                      ),
                    ),
                    SizedBox(width: 30.w),
                    GestureDetector(
                      onTap: () => _updateSexFilter('أنثى'), // Filter by female
                      child: FilterButton(
                        label: 'إناث',
                        isSelected: selectedSex == 'أنثى',
                      ),
                    ),
                  ],
                ),
              ),
              // Display the total money for the filtered list
              BlocBuilder<StudentCubit, StudentState>(
                builder: (context, state) {
                  if (state is StudentLoaded) {
                    final filteredStudents = selectedSex == null
                        ? state.students
                        : state.students
                            .where((student) => student.sex == selectedSex)
                            .toList();
                    final totalMoney = _calculateTotalMoney(filteredStudents);
                    if (!widget.isteacher) {
                      return Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${totalMoney.toStringAsFixed(0)} دج',
                              textDirection: TextDirection
                                  .rtl, // Format to 2 decimal places
                              style: AppTextStyle.greenText,
                            ),
                            Text(
                              ' إجمالي التبرعات', // Format to 2 decimal places
                              style: AppTextStyle.categories,
                            ),
                          ],
                        ),
                      );
                    }
                  }
                  return SizedBox.shrink(); // Hide if no data is loaded
                },
              ),
              Expanded(child: _buildbloc()),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: SizedBox(
          height: 75.h,
          width: 75.w,
          child: FloatingActionButton(
              shape: CircleBorder(
                side: BorderSide(
                  color: AppColors.forestGreen,
                  width: 3.0.sp,
                ),
              ),
              backgroundColor: Colors.green,
              elevation: 11.0,
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
        return current is StudentLoading ||
            current is StudentLoaded ||
            current is StudentError;
      },
      builder: (context, state) {
        if (state is StudentLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is StudentLoaded) {
          final filteredStudents = selectedSex == null
              ? state.students // Show all students if no sex is selected
              : state.students
                  .where((student) => student.sex == selectedSex)
                  .toList();
          if (filteredStudents.isEmpty) {
            return const Center(
              child: Text(
                'لا توجد نتائج',
                style: TextStyle(
                  fontFamily: AppStrings.fontfam,
                  fontSize: 18,
                ),
              ),
            );
          } else {
            return MyList(
              userName: userName,
              previousContext: context,
              students: filteredStudents,
              isteacher: widget.isteacher,
            );
          }
        } else if (state is StudentError) {
          return Center(child: Text(state.message));
        } else {
          return Container(
            color: Colors.red,
          );
        }
      },
    );
  }
}

class FilterButton extends StatelessWidget {
  final String label;
  final bool isSelected;

  const FilterButton({
    super.key,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: 140.w,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.shadowBlue : AppColors.deepBlue,
        borderRadius: BorderRadius.circular(20.sp),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          label,
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontFamily: AppStrings.fontfam,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 20.sp,
          ),
        ),
      ),
    );
  }
}
