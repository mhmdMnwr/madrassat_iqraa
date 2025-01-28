import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madrassat_iqraa/core/navigation/navigation.dart';
import 'package:madrassat_iqraa/features/home/ui/widgets/body/grid_component.dart';

Widget categories({required bool admin}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 30.w),
    child: LayoutBuilder(
      builder: (context, constraints) {
        return GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns
            crossAxisSpacing: 22.w, // Spacing between columns
            mainAxisSpacing: 22.w, // Spacing between rows
            childAspectRatio: 1.11.sp, // Adjust the aspect ratio as needed
          ),
          itemCount: admin ? 6 : 5,
          itemBuilder: (context, index) {
            return gridRouter(context: context, index: index);
          },
        );
      },
    ),
  );
}

Widget gridRouter({required BuildContext context, required int index}) {
  return InkWell(
    onTap: () {
      navigateToPage(context, pageNames[index]);
    },
    child: gridsBorder(index: index),
  );
}
