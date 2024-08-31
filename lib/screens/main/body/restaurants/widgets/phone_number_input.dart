import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:food_couriers_admin/constants/colors/app_colors.dart';
import 'package:food_couriers_admin/utils.dart';

class PhoneNumberInput extends StatelessWidget {
  final String title;
  final TextEditingController phoneController;
  final String initialCountryCode;

  const PhoneNumberInput({
    super.key,
    required this.title,
    required this.phoneController,
    this.initialCountryCode = 'PK',
  });

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
        IntlPhoneField(
          controller: phoneController,
          initialCountryCode: initialCountryCode,
          onChanged: (phone) {
            print('Phone number changed: ${phone.completeNumber}');
          },
          decoration: InputDecoration(
            hintText: title,
            hintStyle: TextStyle(
              color: AppColors.silver.withAlpha(140),
            ),
            isCollapsed: true,
            border: _border(),
            focusedBorder: _border(),
            enabledBorder: _border(),
            contentPadding: EdgeInsets.symmetric(
              horizontal: screenWidth! * 0.01,
              vertical: screenWidth! * 0.01,
            ),
          ),
          style: TextStyle(
            color: AppColors.textDarkColor,
            fontFamily: 'DM Sans',
            fontSize: screenWidth! * 0.0115,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(screenWidth! * 0.005),
      borderSide: BorderSide(color: AppColors.primary.withOpacity(0.8)),
      gapPadding: 0,
    );
  }
}
