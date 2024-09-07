import 'package:flutter/material.dart';
import 'package:food_couriers_admin/constants/colors/app_colors.dart';
import 'package:food_couriers_admin/utils.dart';

class FinancesBody extends StatefulWidget {
  const FinancesBody({super.key});

  @override
  State<FinancesBody> createState() => _FinancesBodyState();
}

class _FinancesBodyState extends State<FinancesBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(screenWidth! * 0.007),
      padding: EdgeInsets.all(screenWidth! * 0.01),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(screenWidth! * 0.01),
      ),
      child: const Column(),
    );
  }
}
