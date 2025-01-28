import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/theme/colors.dart';
import 'package:madrassat_iqraa/core/theme/font.dart';
import 'package:madrassat_iqraa/core/theme/icons.dart';
import 'package:madrassat_iqraa/features/home/data/model/user_model.dart';
import 'package:madrassat_iqraa/features/home/ui/bloc/cubit/user_cubit.dart';

class UserListTile extends StatefulWidget {
  final User user;
  const UserListTile({super.key, required this.user});

  @override
  State<UserListTile> createState() => _UserListTileState();
}

class _UserListTileState extends State<UserListTile> {
  bool disable = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 17.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.vibrantOrange, width: 3.5.sp),
        borderRadius: BorderRadius.circular(8.sp),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 1.5,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: BlocListener<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UpdateLoading) {
            setState(() {
              disable = true;
            });
          } else if (state is AcceptedUsersLoaded) {
            setState(() {
              disable = false;
            });
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: disable
                  ? null
                  : () {
                      User newUser = widget.user.copyWith(refused: true);
                      context
                          .read<UserCubit>()
                          .updateUser(id: widget.user.id, user: newUser);
                    },
              child: Padding(
                padding: EdgeInsets.only(left: 15.w),
                child: Opacity(
                  opacity: disable ? 0.5 : 1,
                  child: Image.asset(
                    AppIcons.adminreject,
                    height: 40.h,
                    width: 40.w,
                  ),
                ),
              ),
            ),
            Text(
              widget.user.userName,
              style: AppTextStyle.subTitles,
            ),
            InkWell(
              onTap: disable
                  ? null
                  : () {
                      User newUser = widget.user.copyWith(accepted: true);
                      context
                          .read<UserCubit>()
                          .updateUser(id: widget.user.id, user: newUser);
                    },
              child: Padding(
                padding: EdgeInsets.only(right: 15.w),
                child: Opacity(
                  opacity: disable ? 0.5 : 1,
                  child: Image.asset(
                    AppIcons.adminaccept,
                    height: 40.h,
                    width: 40.w,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
