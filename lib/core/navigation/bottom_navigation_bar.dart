import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/theme/colors.dart';
import 'package:icons_plus/icons_plus.dart';

NavigationBarTheme myNavBar(
    {required int selectedIndex, required dynamic onItemTapped}) {
  return NavigationBarTheme(
    data: NavigationBarThemeData(
      labelTextStyle: WidgetStateProperty.all(
        TextStyle(
          fontSize: 12,
          fontFamily: "Cairo",
          fontWeight: FontWeight.w600,
        ),
      ),
      indicatorColor: const Color.fromARGB(255, 220, 214, 231),
      height: 80,
      iconTheme: WidgetStateProperty.all(
        IconThemeData(
          size: 24.sp,
        ),
      ),
    ),
    child: NavigationBar(
      backgroundColor: Colors.white,
      elevation: 3,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      height: 80.h,
      selectedIndex: selectedIndex,
      onDestinationSelected: onItemTapped,
      destinations: [
        myNavDestination(
          activeIcon: Icons.home,
          inActiveIcon: Icons.home_outlined,
          label: "الرئيسية",
        ),
        myNavDestination(
          activeIcon: Icons.app_registration,
          inActiveIcon: Icons.app_registration_outlined,
          label: "إضافة",
        ),
        myNavDestination(
          activeIcon: Icons.receipt_long,
          inActiveIcon: Icons.receipt_long_outlined,
          label: "السجل",
        ),
        myNavDestination(
          activeIcon: Icons.account_balance_wallet,
          inActiveIcon: Icons.account_balance_wallet_outlined,
          label: "المحفظة",
        ),
      ],
    ),
  );
}

NavigationDestination myNavDestination(
        {required IconData? inActiveIcon,
        required IconData? activeIcon,
        required String label}) =>
    NavigationDestination(
      icon: Icon(
        inActiveIcon,
        size: 25.sp,
        color: NavBar().inactive,
      ),
      selectedIcon: Icon(
        activeIcon,
        size: 27.sp,
        color: AppColors().accent,
      ),
      label: label,
    );
