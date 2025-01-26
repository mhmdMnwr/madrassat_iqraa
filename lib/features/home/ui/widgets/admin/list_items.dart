import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madrassat_iqraa/core/theme/colors.dart';
import 'package:madrassat_iqraa/features/home/data/model/user_model.dart';
import 'package:madrassat_iqraa/features/home/ui/bloc/cubit/user_cubit.dart';
import 'package:madrassat_iqraa/features/home/ui/widgets/admin/accepted_user_list.dart';
import 'package:madrassat_iqraa/features/home/ui/widgets/admin/user_list_tile.dart';

class AdminList extends StatelessWidget {
  final List<User> users;
  final List<User> accepted;
  const AdminList({super.key, required this.users, required this.accepted});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          BlocListener<UserCubit, UserState>(
            listener: (context, state) {
              if (state is UpdateLoading) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Loading...'),
                    backgroundColor: AppColors.vibrantOrange,
                  ),
                );
              } else if (state is AcceptedUsersLoaded) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('successfully updated...'),
                      backgroundColor: Colors.green),
                );
              }
            },
            child: ListView.builder(
                shrinkWrap:
                    true, // This makes it take up only as much space as its content
                physics: NeverScrollableScrollPhysics(),
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return UserListTile(
                    user: users[index],
                  );
                }),
          ),
          ListView.builder(
              shrinkWrap:
                  true, // This makes it take up only as much space as its content
              physics: NeverScrollableScrollPhysics(),
              itemCount: accepted.length,
              itemBuilder: (context, index) {
                return AcceptedUserList(
                  user: accepted[index],
                );
              }),
        ],
      ),
    );
  }
}
