import 'package:flutter/material.dart';
import 'package:food_couriers_admin/constants/colors/app_colors.dart';
import 'package:food_couriers_admin/utils.dart';

class SupportBody extends StatefulWidget {
  const SupportBody({super.key});

  @override
  State<SupportBody> createState() => _SupportBodyState();
}

class _SupportBodyState extends State<SupportBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(screenWidth! * 0.007),
      padding: EdgeInsets.all(screenWidth! * 0.01),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(screenWidth! * 0.01),
      ),
      child: Column(),
    );
  }
}
