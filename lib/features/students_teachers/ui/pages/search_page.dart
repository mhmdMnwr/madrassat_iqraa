import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrassat_iqraa/core/string.dart';
import 'package:madrassat_iqraa/core/widgets/snack_bar.dart';
import 'package:madrassat_iqraa/features/home/data/repo/user_repo.dart';
import 'package:madrassat_iqraa/features/home/ui/bloc/cubit/user_cubit.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/bloc/cubit/student_cubit.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/bloc/cubit/student_state.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/widgets/create_update_search_fields.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/widgets/mylist.dart';
import 'package:madrassat_iqraa/features/students_teachers/ui/widgets/stud_teach_app_bar.dart';
import 'package:madrassat_iqraa/injection.dart';

class SearchPage extends StatefulWidget {
  final bool isTeacher;
  const SearchPage({
    super.key,
    this.isTeacher = true,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late final TextEditingController _searchController;
  late final String userName;
  final repository = getIt<UserRepository>();
  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    context.read<UserCubit>().getUserById();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<StudentCubit, StudentState>(
          listener: (context, state) {
            if (state is StudentOperationSuccess) {
              MySnackBars.success(
                  message: 'تمت العملية بنجاح', context: context);
            } else if (state is StudentError) {
              MySnackBars.failure(message: state.message, context: context);
            } else if (state is StudentLoading) {}
          },
        ),
        BlocListener<UserCubit, UserState>(
          listener: (context, state) {
            if (state is MeUserLoaded) {
              userName = state.user.userName;
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: StudTeachAppBar(
          isteacher: widget.isTeacher,
          context: context,
          title: AppPagesNames.search,
          search: false,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildArabicSearchField(widget.isTeacher),
            ),
            Expanded(
              child: _buildSearchResults(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArabicSearchField(bool isTeacher) {
    return ArabicSearchField(
      isTeacher: isTeacher,
      controller: _searchController,
      pcontext: context,
    );
  }

  Widget _buildSearchResults() {
    return BlocBuilder<StudentCubit, StudentState>(
      builder: (context, state) {
        if (state is StudentLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SearchedStudentLoaded) {
          if (state.students.isEmpty) {
            return const Center(
              child: Text(
                'لا توجد نتائج',
                style: TextStyle(
                  fontFamily: AppStrings.fontfam,
                  fontSize: 18,
                ),
              ),
            );
          }
          return MyList(
            userName: userName,
            previousContext: context,
            students: state.students,
            isteacher: widget.isTeacher,
          );
        } else if (state is StudentError) {
          return Center(
            child: Text(
              'خطأ: ${state.message}',
              style: const TextStyle(
                fontFamily: AppStrings.fontfam,
                fontSize: 16,
                color: Colors.red,
              ),
            ),
          );
        } else {
          return const Center(
            child: Text(
              'ابدأ البحث...',
              style: TextStyle(
                fontFamily: AppStrings.fontfam,
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
