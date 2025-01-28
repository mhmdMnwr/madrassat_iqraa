import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrassat_iqraa/core/string.dart';
import 'package:madrassat_iqraa/core/theme/colors.dart';
import 'package:madrassat_iqraa/features/home/ui/bloc/cubit/user_cubit.dart';
import 'package:madrassat_iqraa/features/home/ui/widgets/admin/list_items.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/bloc/cubit/student_cubit.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/bloc/cubit/student_state.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/widgets/stud_teach_app_bar.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().getAdminUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StudentCubit, StudentState>(
      listener: (context, state) {
        if (state is StudentOperationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('تمت العملية بنجاح'),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is StudentError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: StudTeachAppBar(
          onReset: () {
            context.read<StudentCubit>().changeAllStudentsPayedStatus();
          },
          reset: true,
          context: context,
          title: AppPagesNames.admin,
          search: false,
        ),
        body: _buildbloc(),
      ),
    );
  }

  Widget _buildbloc() {
    return BlocBuilder<UserCubit, UserState>(
      buildWhen: (previous, current) {
        // Only rebuild if the current state is relevant
        return current is UserLoading ||
            current is AcceptedUsersLoaded ||
            current is UserError;
      },
      builder: (context, state) {
        if (state is UserLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is AcceptedUsersLoaded) {
          // i used this accepted thing to get the accepted users liste
          //and the not accepted at the same time from the same cubit func
          return AdminList(
              users: state.updatedUsers, accepted: state.acceptedUsers);
        } else if (state is UserError) {
          return Center(
            child: Text(
              state.message,
              style: TextStyle(
                  color: const Color.fromARGB(255, 68, 34, 31), fontSize: 18),
            ),
          );
        }

        // Fallback UI (safe placeholder)
        return Center(
          child: Text(
            'No data available',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        );
      },
    );
  }
}
