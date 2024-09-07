import 'package:flutter/material.dart';
import 'package:food_couriers_admin/constants/colors/app_colors.dart';
import 'package:food_couriers_admin/utils.dart';

class RestaurantDivider extends StatelessWidget {
  const RestaurantDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: screenWidth! * 0.025,
        right: screenWidth! * 0.02,
        top: screenWidth! * 0.01,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screenWidth! * 0.01),
        border: Border.all(
          color: AppColors.silver.withAlpha(90),
          width: screenWidth! * 0.0005,
        ),
      ),
    );
  }
}
