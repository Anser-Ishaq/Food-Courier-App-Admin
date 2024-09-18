import 'package:flutter/material.dart';
import 'package:food_couriers_admin/constants/colors/app_colors.dart';
import 'package:food_couriers_admin/utils.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
    required this.icon,
    required this.text,
    required this.isSelected,
  });

  final IconData? icon;
  final String text;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenWidth! * 0.03,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(vertical: screenWidth! * 0.005),
      padding: EdgeInsets.symmetric(horizontal: screenWidth! * 0.01),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : AppColors.white,
        borderRadius: BorderRadius.circular(screenWidth! * 0.005),
        boxShadow: [
          BoxShadow(
            color: AppColors.silver.withAlpha(40),
            blurRadius: screenWidth! * 0.003,
            spreadRadius: screenWidth! * 0.00075,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Icon(
            icon,
            size: screenWidth! * 0.0125,
            color: isSelected ? AppColors.white : AppColors.primary,
          ),
          SizedBox(width: screenWidth! * 0.005),
          Text(
            text,
            style: TextStyle(
              fontSize: screenWidth! * 0.0115,
              fontFamily: 'DM Sans',
              color: isSelected ? AppColors.white : AppColors.primary,
              fontWeight: FontWeight.w400,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}
