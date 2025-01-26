import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/navigation/navigation.dart';
import 'package:madrassat_iqraa/core/string.dart';
import 'package:madrassat_iqraa/core/theme/colors.dart';
import 'package:madrassat_iqraa/core/theme/font.dart';
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
  bool _isCreatingUser = false;

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _saveUser({required bool signup}) async {
    if (_formKey.currentState!.validate()) {
      final userName = _userNameController.text;
      final password = _passwordController.text;
      final newUser =
          User(userName: userName, password: password, accepted: false);

      if (signup) {
        context.read<UserCubit>().createUser(newUser);
      } else {
        await context.read<UserCubit>().getUserByName(userName);
      }
    }
  }

  void _navigateToHomePage() {
    navigateToPage(context, 'home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<UserCubit, UserState>(
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
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('تم تسجيل طلبك')),
            );
            // _navigateToHomePage();
          } else if (state is UserLoaded) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            if (state.user.password == _passwordController.text) {
              if (state.user.accepted) {
                context.read<UserCubit>().saveUserId(state.user.id);
                _navigateToHomePage();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('لم يتم قبول طلبك بعد')),
                );
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('اسم المستخدم أو كلمة المرور غير صحيحة')),
              );
            }
            // _navigateToHomePage();
          } else if (state is UserError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('خطأ: ${state.message}')),
            );
          }
        },
        child: Stack(children: [
          Container(color: AppColors.shadowBlue),
          Logo(),
          form(),
        ]),
      ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('إنشاء مستخدم جديد؟', style: AppTextStyle.subTitles),
                  Checkbox(
                    value: _isCreatingUser,
                    onChanged: (bool? value) {
                      setState(() {
                        _isCreatingUser = value!;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 50.h,
              ),
              registerButton(
                  saveUser: () => _saveUser(signup: _isCreatingUser)),
            ],
          ),
        ),
      ),
    );
  }
}
