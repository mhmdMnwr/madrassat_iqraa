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

  // Handles saving or authenticating the user
  Future<void> _saveUser({required bool signup}) async {
    if (_formKey.currentState!.validate()) {
      final userName = _userNameController.text;
      final password = _passwordController.text;
      final newUser = User(
        userName: userName,
        password: password,
        accepted: false,
        refused: false,
      );

      signup
          ? context.read<UserCubit>().createUser(newUser)
          : await context.read<UserCubit>().getUserByName(userName);
    }
  }

  // Navigates to the home page
  void _navigateToHomePage() {
    navigateToPage(context, 'home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UserLoading) {
            _showSnackBar('جاري المعالجة...');
          } else if (state is UserCreated) {
            _handleUserCreated();
          } else if (state is UserLoaded) {
            _handleUserLoaded(state);
          } else if (state is UserError) {
            _showSnackBar('خطأ: ${state.message}');
          }
        },
        child: _buildLoginScreen(),
      ),
    );
  }

  // Handles UI feedback when user is created
  void _handleUserCreated() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    _showSnackBar('تم إنشاء المستخدم بنجاح');
    _showSnackBar('تم تسجيل طلبك');
    // _navigateToHomePage();
  }

  // Handles UI feedback when user is loaded from database
  void _handleUserLoaded(UserLoaded state) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    if (state.user.password == _passwordController.text) {
      if (state.user.accepted) {
        context.read<UserCubit>().saveUserId(state.user.id);
        _navigateToHomePage();
      } else if (state.user.refused) {
        _showSnackBar("تم رفض طلبك ");
      } else {
        _showSnackBar('لم يتم قبول طلبك بعد');
      }
    } else {
      _showSnackBar('اسم المستخدم أو كلمة المرور غير صحيحة');
    }
  }

  // Shows a snackbar with the given message
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  // Builds the main login screen UI
  Widget _buildLoginScreen() {
    return Stack(
      children: [
        _buildBackground(),
        const Logo(),
        _buildFormContainer(),
      ],
    );
  }

  // Background container with app theme color
  Widget _buildBackground() {
    return Container(color: AppColors.shadowBlue);
  }

  // Form container positioned on the screen
  Widget _buildFormContainer() {
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
              offset: const Offset(0, -5),
              blurRadius: 10,
            ),
          ],
        ),
        child: SingleChildScrollView(
          // Added scrollable behavior
          child: _buildForm(),
        ),
      ),
    );
  }

  // Builds the form widget
  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min, // Adjusts to the content height
        children: [
          SizedBox(height: 50.h),
          _buildTitle(),
          SizedBox(height: 50.h),
          usernameTFF(controller: _userNameController),
          SizedBox(height: 35.h),
          PasswordField(controller: _passwordController),
          _buildSignupCheckbox(),
          SizedBox(height: 50.h),
          registerButton(saveUser: () => _saveUser(signup: _isCreatingUser)),
        ],
      ),
    );
  }

  // Builds the login title text
  Widget _buildTitle() {
    return Text(
      'تسجيل الدخول',
      style: TextStyle(
        fontFamily: AppStrings.fontfam,
        fontWeight: FontWeight.w600,
        color: AppColors.navyBlue,
        fontSize: 32.sp,
      ),
    );
  }

  // Builds the signup checkbox with label
  Widget _buildSignupCheckbox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text('إنشاء مستخدم جديد؟', style: AppTextStyle.subTitles),
        Checkbox(
          value: _isCreatingUser,
          onChanged: (bool? value) {
            setState(() {
              _isCreatingUser = value ?? false;
            });
          },
        ),
      ],
    );
  }
}
