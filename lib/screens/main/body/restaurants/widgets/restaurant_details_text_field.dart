import 'package:flutter/material.dart';
import 'package:food_couriers_admin/constants/colors/app_colors.dart';
import 'package:food_couriers_admin/utils.dart';

class RestaurantDetailsTextField extends StatelessWidget {
  const RestaurantDetailsTextField({
    super.key,
    required this.title,
    this.onSaved,
  });

  final String title;
  final void Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColors.textDarkColor.withAlpha(245),
            fontFamily: 'DM Sans',
            fontSize: screenWidth! * 0.0115,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: screenWidth! * 0.0075),
        TextFormField(
          onSaved: onSaved,
          style: TextStyle(
            color: AppColors.textDarkColor,
            fontFamily: 'DM Sans',
            fontSize: screenWidth! * 0.0115,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
              hintText: title,
              hintStyle: TextStyle(
                color: AppColors.silver.withAlpha(140),
              ),
              isCollapsed: true,
              border: border(),
              focusedBorder: border(),
              enabledBorder: border(),
              contentPadding: EdgeInsets.symmetric(
                  horizontal: screenWidth! * 0.01,
                  vertical: screenWidth! * 0.01)),
        ),
      ],
    );
  }

  OutlineInputBorder border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(screenWidth! * 0.005),
      borderSide: BorderSide(color: AppColors.primary.withOpacity(0.8)),
      gapPadding: 0,
    );
  }
}
