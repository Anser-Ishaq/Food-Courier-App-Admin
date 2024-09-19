import 'package:flutter/material.dart';
import 'package:food_couriers_admin/constants/colors/app_colors.dart';
import 'package:food_couriers_admin/screens/main/body/restaurants/widgets/button_box.dart';
import 'package:food_couriers_admin/utils.dart';

class RestaurantHead extends StatelessWidget {
  const RestaurantHead({
    super.key,
    required this.showSearch,
    required this.onAddRestaurant,
    required this.onSearchToggle,
  });

  final bool showSearch;
  final VoidCallback onAddRestaurant;
  final VoidCallback onSearchToggle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Restaurant',
          style: commonTextStyle(screenWidth! * 0.013, FontWeight.w600),
        ),
        Row(
          children: [
            ButtonBox(
              title: 'Add Restaurant',
              isOutline: false,
              onTap: onAddRestaurant,
            ),
            ButtonBox(
              title: 'Export CSV',
              isOutline: true,
              onTap: () {},
            ),
            _buttonSearchToggle(
              onTap: onSearchToggle,
            )
          ],
        ),
      ],
    );
  }

  Widget _buttonSearchToggle({
    required VoidCallback onTap,
  }) {
    return _customIconButton(
      onTap: onTap,
      icon: showSearch
          ? Icons.keyboard_arrow_up_rounded
          : Icons.keyboard_arrow_down_rounded,
    );
  }

  Widget _customIconButton({
    required VoidCallback onTap,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: screenWidth! * 0.004),
        padding: EdgeInsets.all(screenWidth! * 0.003),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(screenWidth! * 0.005),
          boxShadow: [
            BoxShadow(
              color: AppColors.silver.withOpacity(0.3),
              offset: const Offset(5, 8),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Icon(
          icon,
          color: AppColors.textDarkColor,
          size: screenWidth! * 0.02,
        ),
      ),
    );
  }
}
