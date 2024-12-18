import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/error/error_message.dart';
import 'package:madrassat_iqraa/core/navigation/navigation.dart';
import 'package:madrassat_iqraa/core/string.dart';
import 'package:madrassat_iqraa/core/theme/colors.dart';
import 'package:madrassat_iqraa/features/home/ui/bloc/cubit/user_cubit.dart';
import 'package:madrassat_iqraa/features/home/data/model/user_model.dart';
import 'package:madrassat_iqraa/features/home/ui/widgets/login/form.dart';
import 'package:madrassat_iqraa/features/home/ui/widgets/login/logo.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  dynamic _userListener() {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserLoading) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('جاري المعالجة...')),
          );
        } else if (state is UserCreated) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('تم إنشاء المستخدم بنجاح')),
          );
          _navigateToHomePage();
        } else if (state is UserError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('خطأ: ${state.message}')),
          );
        }
      },
      child: Container(),
    );
  }

  Future<void> _saveUser() async {
    if (_formKey.currentState!.validate()) {
      final userName = _userNameController.text;
      final password = _passwordController.text;
      final newUser =
          User(userName: userName, password: password, accepted: false);
      context.read<UserCubit>().createUser(newUser);
      _userListener();
      // BlocListener<UserCubit, UserState>(
      //   listener: (context, state) {
      //     if (state is UserLoaded) {
      //       if (state.user.password == password) {
      //         context.read<UserCubit>().saveUserId(state.user.id);
      //         _navigateToHomePage();
      //       } else {
      //         ScaffoldMessenger.of(context).showSnackBar(
      //           SnackBar(
      //             content: Text(invalidPassword),
      //             backgroundColor: AppColors.vibrantOrange,
      //           ),
      //         );
      //       }
      //     } else if (state is UserError) {
      //       if (state.message == itemNotFound) {
      //         showDialog(
      //           context: context,
      //           builder: (BuildContext context) {
      //             return AlertDialog(
      //               title: Text('المستخدم غير موجود'),
      //               content: Text('هل تريد التسجيل في التطبيق؟'),
      //               actions: [
      //                 TextButton(
      //                   onPressed: () {
      //                     Navigator.of(context).pop();
      //                   },
      //                   child: Text('إلغاء'),
      //                 ),
      //                 TextButton(
      //                   onPressed: () {
      //                     Navigator.of(context).pop();
      //                     context.read<UserCubit>().createUser(newUser);
      //                   },
      //                   child: Text('تسجيل'),
      //                 ),
      //               ],
      //             );
      //           },
      //         );
      //       }
      //     }
      //   },
      //   child: Container(),
      // );
    }
  }

  void _navigateToHomePage() {
    navigateToPage(context, 'home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(color: AppColors.shadowBlue),
        Logo(),
        form(),
      ]),
    );
  }

  Widget form() {
    return Positioned(
      top: 217.h,
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(45.sp),
            topRight: Radius.circular(45.sp),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.vibrantOrange,
              offset: Offset(0, -5),
              blurRadius: 10,
            ),
          ],
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min, // Adjusts to the content height
            children: [
              SizedBox(
                height: 50.h,
              ),
              Text('تسجيل الدخول',
                  style: TextStyle(
                    fontFamily: AppStrings.fontfam,
                    fontWeight: FontWeight.w600,
                    color: AppColors.navyBlue,
                    fontSize: 32.sp,
                  )),
              SizedBox(
                height: 50.h,
              ),
              usernameTFF(controller: _userNameController),
              SizedBox(
                height: 35.h,
              ),
              passwordTFF(controller: _passwordController),
              SizedBox(
                height: 50.h,
              ),
              registerButton(saveUser: _saveUser),
            ],
          ),
        ),
      ),
    );
  }
}
