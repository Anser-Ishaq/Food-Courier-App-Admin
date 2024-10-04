import 'package:flutter/material.dart';
import 'package:food_couriers_admin/res/colors/app_colors.dart';
import 'package:food_couriers_admin/res/utils/utils.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: screenWidth! * 0.0025,
        valueColor: const AlwaysStoppedAnimation<Color>(
          AppColors.primary,
        ),
      ),
    );
  }
}
