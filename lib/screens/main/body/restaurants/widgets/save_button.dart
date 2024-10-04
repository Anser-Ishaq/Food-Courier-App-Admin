import 'package:flutter/material.dart';
import 'package:food_couriers_admin/res/colors/app_colors.dart';
import 'package:food_couriers_admin/res/utils/utils.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({
    super.key,
    required this.isLoading,
    required this.onTap,
    required this.buttonText,
    this.gradient,
  });

  final String buttonText;
  final Gradient? gradient;
  final bool isLoading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth! * 0.015, vertical: screenWidth! * 0.005),
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(screenWidth! * 0.005),
          ),
          child: isLoading
              ? CircularProgressIndicator(
                  strokeWidth: screenWidth! * 0.0025,
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(AppColors.white),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      buttonText,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: screenWidth! * 0.015,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: screenWidth! * 0.005),
                    Icon(
                      Icons.save_rounded,
                      color: AppColors.white,
                      size: screenWidth! * 0.017,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
