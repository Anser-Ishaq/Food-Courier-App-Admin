import 'package:flutter/material.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:food_couriers_admin/res/colors/app_colors.dart';
import 'package:food_couriers_admin/res/utils/utils.dart';
import 'package:intl_phone_field/phone_number.dart';

class PhoneNumberInput extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final String initialCountryCode;
  final void Function(PhoneNumber?)? onSaved;

  const PhoneNumberInput({
    super.key,
    required this.title,
    this.controller,
    required this.initialCountryCode,
    this.onSaved,
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
          controller: controller,
          flagWidth: screenWidth! * 0.02,
          style: _textStyle(),
          dropdownTextStyle: _textStyle(),
          textAlignVertical: TextAlignVertical.center,
          initialCountryCode: initialCountryCode,
          flagsButtonMargin: EdgeInsets.all(screenWidth! * 0.005),
          dropdownIconPosition: IconPosition.trailing,
          dropdownIcon: Icon(
            Icons.arrow_drop_down,
            color: AppColors.textDarkColor,
            size: screenWidth! * 0.015,
          ),
          disableLengthCheck: true,
          onSaved: onSaved,
          decoration: InputDecoration(
            hintText: title,
            hintStyle: TextStyle(
              color: AppColors.silver.withAlpha(140),
            ),
            // isCollapsed: true,
            border: border(),
            focusedBorder: border(),
            enabledBorder: border(),
            constraints: BoxConstraints(
              maxHeight: screenWidth! * 0.03,
              minHeight: screenWidth! * 0.03,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: screenWidth! * 0.01,
              vertical: screenWidth! * 0.01,
            ),
          ),
          pickerDialogStyle: PickerDialogStyle(
              backgroundColor: AppColors.white,
              countryCodeStyle: _textStyle(),
              countryNameStyle: _textStyle(),
              width: screenWidth! * 0.55,
              searchFieldInputDecoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(
                  color: AppColors.silver.withAlpha(140),
                ),
                border: border(),
                focusedBorder: border(),
                enabledBorder: border(),
              ),
              searchFieldPadding: EdgeInsets.all(screenWidth! * 0.01)),
        ),
      ],
    );
  }

  TextStyle _textStyle() {
    return TextStyle(
      color: AppColors.textDarkColor.withAlpha(245),
      fontFamily: 'DM Sans',
      fontSize: screenWidth! * 0.0115,
      fontWeight: FontWeight.w400,
    );
  }
}
