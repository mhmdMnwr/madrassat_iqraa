import 'package:flutter/material.dart';

class NavBar {
  Color active = Colors.blue;
  Color inactive = Colors.black;
  double activeSize = 10;
  double inActiveSize = 5;
}

class AppColors {
  // Primary color for main elements (e.g., active icons, headers, buttons)
  Color primary = Color(0xFF5D5FEF); // Indigo blue

  // Secondary color for highlights and selected states
  Color secondary = Color(0xFFFFB020); // Amber

  // Accent color for subtle details and secondary actions
  Color accent = Color(0xFF009688); // Teal

  // Background color for a clean app appearance
  Color background = Color(0xFFF8F9FA); // Light grey

  // Error color for error messages and warnings
  Color error = Color(0xFFFF5252); // Red

  // Text color for primary content
  Color primaryText = Colors.black87;

  // Text color for secondary content
  Color secondaryText = Colors.black54;
}
