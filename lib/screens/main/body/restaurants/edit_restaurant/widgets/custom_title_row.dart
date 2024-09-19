import 'package:flutter/material.dart';
import 'package:food_couriers_admin/constants/colors/app_colors.dart';
import 'package:food_couriers_admin/utils.dart';

class CustomTitleRow extends StatelessWidget {
  const CustomTitleRow({
    super.key,
    required this.title,
    required this.showButton1,
    required this.showButton2,
    this.button1,
    this.button2,
  })  : assert(
          !(showButton1 && button1 == null),
          'button1 is required when showButton1 is true',
        ),
        assert(
          !(showButton2 && button2 == null),
          'button2 is required when showButton2 is true',
        );

  final String title;
  final bool showButton1;
  final bool showButton2;
  final Widget? button1;
  final Widget? button2;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColors.textDarkColor,
            fontFamily: 'DM Sans',
            fontSize: screenWidth! * 0.0135,
            fontWeight: FontWeight.w600,
            height: 1.1,
            letterSpacing: screenWidth! * 0.0125 * -0.01,
            wordSpacing: screenWidth! * 0.0125 * 0.05,
          ),
        ),
        Row(
          children: [
            if (showButton1) button1!,
            if (showButton2) button2!,
          ],
        ),
      ],
    );
  }
}
