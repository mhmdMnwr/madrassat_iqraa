import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/theme/colors.dart';

Widget curvedAppBar(int height) {
  return ClipPath(
    clipper: CurvedAppBarClipper(),
    child: Container(
      height: height.h,
      color: AppColors.shadowBlue,
    ),
  );
}

class CurvedAppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 20); // Bottom left corner curve start
    path.quadraticBezierTo(
      0, size.height, // Control point for bottom-left curve
      20, size.height, // End point for bottom-left curve
    );
    path.lineTo(
        size.width - 20, size.height); // Move to bottom right corner start
    path.quadraticBezierTo(
      size.width, size.height, // Control point for bottom-right curve
      size.width, size.height - 20, // End point for bottom-right curve
    );
    path.lineTo(size.width, 0); // Line to top-right corner
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
