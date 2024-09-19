import 'package:flutter/material.dart';
import 'package:food_couriers_admin/constants/colors/app_colors.dart';
import 'package:food_couriers_admin/models/restaurant.dart';
import 'package:food_couriers_admin/screens/main/body/restaurants/edit_restaurant/widgets/custom_title_row.dart';
import 'package:food_couriers_admin/utils.dart';

class Plans extends StatelessWidget {
  const Plans({
    super.key,
    required this.restaurant,
  });

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(),
        _spacer(),
        _spacer(),
        _spacer(),
        _buildPlanTitle(),
        _spacer(),
        _buildPlanSelector(),
      ],
    );
  }

  Widget _buildTitle() {
    return const CustomTitleRow(
      title: 'Subscription plan',
      showButton1: false,
      showButton2: false,
    );
  }

  Widget _buildPlanTitle() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: screenWidth! * 0.05),
      child: Text(
        'Current plan',
        style: TextStyle(
          color: AppColors.textDarkColor.withAlpha(180),
          fontFamily: 'DM Sans',
          fontSize: screenWidth! * 0.0135,
          fontWeight: FontWeight.w500,
          height: 1.1,
          letterSpacing: screenWidth! * 0.0125 * -0.01,
          wordSpacing: screenWidth! * 0.0125 * 0.05,
        ),
      ),
    );
  }

  Widget _buildPlanSelector() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: screenWidth! * 0.2,
      margin: EdgeInsets.symmetric(horizontal: screenWidth! * 0.05),
    );
  }

  SizedBox _spacer() => SizedBox(height: screenWidth! * 0.01);
}
