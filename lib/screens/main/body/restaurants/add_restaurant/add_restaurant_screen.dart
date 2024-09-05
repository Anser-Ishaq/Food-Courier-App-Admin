import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_couriers_admin/constants/colors/app_colors.dart';
import 'package:food_couriers_admin/models/user_model.dart';
import 'package:food_couriers_admin/screens/main/body/restaurants/widgets/phone_number_input.dart';
import 'package:food_couriers_admin/screens/main/body/restaurants/widgets/restaurant_details_text_field.dart';
import 'package:food_couriers_admin/screens/main/body/restaurants/widgets/sub_section.dart';
import 'package:food_couriers_admin/utils.dart';
import 'package:provider/provider.dart';
import 'package:food_couriers_admin/provider/restaurant_provider.dart';
import 'package:food_couriers_admin/provider/ownerdata_provider.dart';
import 'package:food_couriers_admin/models/restaurant.dart';

class AddRestaurantScreen extends StatefulWidget {
  const AddRestaurantScreen({super.key});

  @override
  State<AddRestaurantScreen> createState() => _AddRestaurantScreenState();
}

class _AddRestaurantScreenState extends State<AddRestaurantScreen> {
  final _formKey = GlobalKey<FormState>();

  String _restaurantName = '';
  String _restaurantAddress = '';
  String _ownerName = '';
  String _ownerEmail = '';
  String _ownerPhone = '';

  @override
  Widget build(BuildContext context) {
    return Consumer2<RestaurantProvider, OwnerdataProvider>(
      builder: (context, restaurantProvider, ownerProvider, child) {
        return Container(
          margin: EdgeInsets.all(screenWidth! * 0.007),
          padding: EdgeInsets.all(screenWidth! * 0.02),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(screenWidth! * 0.01),
          ),
          child: Form(
            key: _formKey,
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
                        onSaved: (value) {
                          _restaurantName = value ?? '';
                        },
                      ),
                      _spacer(),
                      RestaurantDetailsTextField(
                        title: 'Restaurant Address',
                        onSaved: (value) {
                          _restaurantAddress = value ?? '';
                        },
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
                        onSaved: (value) {
                          _ownerName = value ?? '';
                        },
                      ),
                      _spacer(),
                      RestaurantDetailsTextField(
                        title: 'Owner Email',
                        onSaved: (value) {
                          _ownerEmail = value ?? '';
                        },
                      ),
                      _spacer(),
                      PhoneNumberInput(
                        title: 'Owner Phone Number',
                        onSaved: (value) {
                          _ownerPhone = value!.completeNumber;
                        },
                      ),
                    ],
                  ),
                ),
                _spacer(),
                _saveButton(context, restaurantProvider, ownerProvider),
                _spacer(),
                _spacer(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _saveButton(BuildContext context,
      RestaurantProvider restaurantProvider, OwnerdataProvider ownerProvider) {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () async {
          if (restaurantProvider.isLoading || ownerProvider.isLoading) return;

          // Save the form's fields.
          _formKey.currentState?.save();

          try {
            // Create and save owner
            final owner = UserModel(
              name: _ownerName,
              email: _ownerEmail,
              phone: _ownerPhone,
              role: 'Owner',
              createAt: Timestamp.now(),
            );
            final ownerId = await ownerProvider.createOwner(owner);

            if (ownerId.isNotEmpty) {
              // Create and save restaurant
              final restaurant = Restaurant(
                name: _restaurantName,
                address: _restaurantAddress,
                oid: ownerId,
                ownerName: owner.name,
                ownerEmail: owner.email,
                ownerPhone: owner.phone,
                creationDate: Timestamp.now(),
              );
              final restaurantId =
                  await restaurantProvider.createRestaurant(restaurant);

              // Update owner with new restaurant ID
              await ownerProvider.updateOwner(
                  uid: ownerId, newRestaurantID: restaurantId);

              // Provide success feedback to the user
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Restaurant added successfully!')),
              );
            }
          } catch (e) {
            // Handle errors and provide feedback
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error occurred: $e')),
            );
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth! * 0.015, vertical: screenWidth! * 0.005),
          decoration: BoxDecoration(
            gradient: AppColors.gradientPrimary,
            borderRadius: BorderRadius.circular(screenWidth! * 0.005),
          ),
          child: restaurantProvider.isLoading || ownerProvider.isLoading
              ? CircularProgressIndicator(
                  strokeWidth: screenWidth! * 0.0025,
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(AppColors.white),
                )
              : Row(
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
