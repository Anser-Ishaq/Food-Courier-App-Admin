import 'package:flutter/material.dart';
import 'package:food_couriers_admin/res/colors/app_colors.dart';
import 'package:food_couriers_admin/res/utils/utils.dart';

class ButtonBox extends StatelessWidget {
  const ButtonBox({
    super.key,
    required this.title,
    this.isLoading = false,
    required this.onTap,
    this.isOutline = false,
  });

  final String title;
  final bool isLoading;
  final VoidCallback? onTap;
  final bool isOutline;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: screenWidth! * 0.004),
        padding: EdgeInsets.all(screenWidth! * 0.007),
        decoration: BoxDecoration(
          color: isOutline ? AppColors.white : AppColors.secondary,
          borderRadius: BorderRadius.circular(screenWidth! * 0.005),
          border: Border.all(
            color: AppColors.secondary,
            width: screenWidth! * 0.001,
          ),
        ),
        child: isLoading
            ? SizedBox(
                height: screenWidth! * 0.0075,
                width: screenWidth! * 0.0075,
                child: CircularProgressIndicator(
                  strokeWidth: screenWidth! * 0.001,
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(AppColors.white),
                ),
              )
            : Text(
                title,
                style: TextStyle(
                  color: isOutline ? AppColors.primary : AppColors.white,
                  fontFamily: 'DM Sans',
                  fontSize: screenWidth! * 0.01,
                  fontWeight: FontWeight.w600,
                  height: 1.1,
                  letterSpacing: -0.03 * screenWidth! * 0.01,
                ),
              ),
      ),
    );
  }
}
