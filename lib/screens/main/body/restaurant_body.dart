import 'package:flutter/material.dart';
import 'package:food_couriers_admin/constants/colors/app_colors.dart';
import 'package:food_couriers_admin/utils.dart';

class RestaurantBody extends StatefulWidget {
  const RestaurantBody({super.key});

  @override
  State<RestaurantBody> createState() => _RestaurantBodyState();
}

class _RestaurantBodyState extends State<RestaurantBody> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(screenWidth! * 0.007),
          padding: EdgeInsets.all(screenWidth! * 0.01),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(screenWidth! * 0.01),
          ),
          child: Column(
            children: [
              _head(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _head() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Restaurant',
          style: TextStyle(
            color: AppColors.textDarkColor,
            fontFamily: 'DM Sans',
            fontSize: screenWidth! * 0.013,
            fontWeight: FontWeight.w600,
            height: 1.1,
            letterSpacing: -0.03 * screenWidth! * 0.013,
          ),
        ),
        Row(
          children: [
            _bottonBox(
              title: 'Add Restaurant',
              isOutline: false,
              onTap: () {},
            ),
            _bottonBox(
              title: 'Export CSV',
              isOutline: true,
              onTap: () {},
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: screenWidth! * 0.004),
              padding: EdgeInsets.all(screenWidth! * 0.002),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(screenWidth! * 0.005),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.silver,
                    blurRadius: screenWidth! * 0.001,
                    spreadRadius: 0,
                    offset: Offset(7, 7),
                  )
                ],
                ),
                child: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppColors.textDarkColor,
                  size: screenWidth! * 0.025,
                ),
            )
          ],
        ),
      ],
    );
  }

  Widget _bottonBox({
    required String title,
    required bool isOutline,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: screenWidth! * 0.004),
        padding: EdgeInsets.all(screenWidth! * 0.007),
        decoration: BoxDecoration(
          color: isOutline ? AppColors.white : AppColors.primary,
          borderRadius: BorderRadius.circular(screenWidth! * 0.005),
          border: Border.all(
            color: isOutline ?  AppColors.primary : AppColors.primary,
            strokeAlign: isOutline ? BorderSide.strokeAlignCenter : BorderSide.strokeAlignCenter,
            width: isOutline ? screenWidth! * 0.001 : screenWidth! * 0.001,
          ),
        ),
        child: Text(
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
