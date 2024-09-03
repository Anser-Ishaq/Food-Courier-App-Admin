import 'package:flutter/material.dart';
import 'package:food_couriers_admin/constants/colors/app_colors.dart';
import 'package:food_couriers_admin/screens/main/body/restaurants/widgets/phone_number_input.dart';
import 'package:food_couriers_admin/screens/main/body/restaurants/widgets/restaurant_details_text_field.dart';
import 'package:food_couriers_admin/screens/main/body/restaurants/widgets/sub_section.dart';
import 'package:food_couriers_admin/utils.dart';

class AddRestaurantScreen extends StatefulWidget {
  const AddRestaurantScreen({super.key});

  @override
  State<AddRestaurantScreen> createState() => _AddRestaurantScreenState();
}

class _AddRestaurantScreenState extends State<AddRestaurantScreen> {
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _ownerNameController = TextEditingController();
  final _ownerEmailController = TextEditingController();
  final _ownerPhoneController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _addressController.dispose();
    _ownerNameController.dispose();
    _ownerEmailController.dispose();
    _ownerPhoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(screenWidth! * 0.007),
      padding: EdgeInsets.all(screenWidth! * 0.02),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(screenWidth! * 0.01),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add Restaurant',
            style: commonTextStyle(screenWidth! * 0.015, FontWeight.w600),
          ),
          _spacer(),
          SubSection(
            title: 'Restaurant Information'.toUpperCase(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RestaurantDetailsTextField(
                  title: 'Restaurant Name',
                  textEditingController: _nameController,
                ),
                _spacer(),
                RestaurantDetailsTextField(
                  title: 'Restaurant Address',
                  textEditingController: _addressController,
                ),
              ],
            ),
          ),
          _spacer(),
          Container(
            margin: EdgeInsets.only(
              left: screenWidth! * 0.025,
              right: screenWidth! * 0.02,
              top: screenWidth! * 0.01,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(screenWidth! * 0.01),
              border: Border.all(
                color: AppColors.silver.withAlpha(90),
                width: screenWidth! * 0.0005,
              ),
            ),
          ),
          _spacer(),
          SubSection(
            title: 'Owner Information'.toUpperCase(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RestaurantDetailsTextField(
                  title: 'Owner Name',
                  textEditingController: _ownerNameController,
                ),
                _spacer(),
                RestaurantDetailsTextField(
                  title: 'Owner Email',
                  textEditingController: _ownerEmailController,
                ),
                _spacer(),
                PhoneNumberInput(
                  title: 'Owner Phone Number',
                  phoneController: _ownerPhoneController,
                ),
              ],
            ),
          ),
          _spacer(),
          _saveButton(),
          _spacer(),
          _spacer(),
        ],
      ),
    );
  }

  Widget _saveButton() {
    return Align(
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: screenWidth! * 0.015, vertical: screenWidth! * 0.005),
              decoration: BoxDecoration(
                gradient: AppColors.gradientPrimary,
                borderRadius: BorderRadius.circular(screenWidth! * 0.005),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Save',
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

  SizedBox _spacer() {
    return SizedBox(height: screenWidth! * 0.02);
  }
}
