import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/theme/font.dart';
import 'package:madrassat_iqraa/features/students_teachers/data/model/student_model.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/widgets/info.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/widgets/pop_up_create.dart';

class MyList extends StatefulWidget {
  final List<Student> students;
  final bool isteacher;

  const MyList({super.key, required this.students, required this.isteacher});

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
                myListTile(Icons.payment, label1, null),
                myListTile(
                    Icons.update,
                    'تعديل',
                    () => showAddUserDialog(
                        student: student,
                        isUpdate: true,
                        context: context,
                        bithdateController: bithdateController,
                        isTeacher: isTeacher,
                        nameController: nameController,
                        payDayController: payDayController,
                        priceController: priceController,
                        sexController: sexController)),
                myListTile(Icons.details, 'تفاصيل', null),
                Divider(
                  thickness: 2.sp,
                  height: 5,
                ),
                myListTile(Icons.delete, 'طرد', null),
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
        onTap: () {
          func;
        });
  }
}
