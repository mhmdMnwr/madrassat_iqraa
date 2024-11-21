// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrassat_iqraa/core/String.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/bloc/cubit/student_cubit.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/bloc/cubit/student_state.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/widgets/mylist.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/widgets/stud_teach_app_bar.dart';

class SearchPage extends StatefulWidget {
  final bool isteacher;
  const SearchPage({super.key, this.isteacher = true});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StudTeachAppBar(
        context: context,
        title: AppPagesNames.search,
        search: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search by name',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                context.read<StudentCubit>().searchStudents(
                    _searchController.text,
                    isteacher: widget.isteacher);
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<StudentCubit, StudentState>(
              builder: (context, state) {
                if (state is StudentLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is SearchedStudentLoaded) {
                  return MyList(
                    students: state.students,
                    isteacher: widget.isteacher,
                  );
                } else if (state is StudentError) {
                  return Center(child: Text('Error: ${state.message}'));
                } else {
                  return Center(child: Text('No students found'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
