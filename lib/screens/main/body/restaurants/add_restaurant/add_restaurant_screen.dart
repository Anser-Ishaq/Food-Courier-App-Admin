import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_couriers_admin/constants/colors/app_colors.dart';
import 'package:food_couriers_admin/models/user_model.dart';
import 'package:food_couriers_admin/screens/main/body/restaurants/widgets/divider.dart';
import 'package:food_couriers_admin/screens/main/body/restaurants/widgets/phone_number_input.dart';
import 'package:food_couriers_admin/screens/main/body/restaurants/widgets/restaurant_details_text_field.dart';
import 'package:food_couriers_admin/screens/main/body/restaurants/widgets/save_button.dart';
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
  final _restaurantNameController = TextEditingController();
  final _restaurantAddressController = TextEditingController();
  final _ownerNameController = TextEditingController();
  final _ownerEmailController = TextEditingController();
  final _ownerPhoneController = TextEditingController();

  String _initialCountryCode = 'PK';

  String _restaurantName = '';
  String _restaurantAddress = '';
  String _ownerName = '';
  String _ownerEmail = '';
  String _ownerPhone = '';

  @override
  void dispose() {
    _restaurantNameController.dispose();
    _restaurantAddressController.dispose();
    _ownerNameController.dispose();
    _ownerEmailController.dispose();
    _ownerPhoneController.dispose();
    super.dispose();
  }

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
                        controller: _restaurantNameController,
                        onSaved: (value) {
                          _restaurantName = value ?? '';
                        },
                      ),
                      _spacer(),
                      RestaurantDetailsTextField(
                        title: 'Restaurant Address',
                        controller: _restaurantAddressController,
                        onSaved: (value) {
                          _restaurantAddress = value ?? '';
                        },
                      ),
                    ],
                  ),
                ),
                _spacer(),
                const RestaurantDivider(),
                _spacer(),
                SubSection(
                  title: 'Owner Information'.toUpperCase(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RestaurantDetailsTextField(
                        title: 'Owner Name',
                        controller: _ownerNameController,
                        onSaved: (value) {
                          _ownerName = value ?? '';
                        },
                      ),
                      _spacer(),
                      RestaurantDetailsTextField(
                        title: 'Owner Email',
                        controller: _ownerEmailController,
                        onSaved: (value) {
                          _ownerEmail = value ?? '';
                        },
                      ),
                      _spacer(),
                      PhoneNumberInput(
                        title: 'Owner Phone Number',
                        controller: _ownerPhoneController,
                        initialCountryCode: _initialCountryCode,
                        onSaved: (value) {
                          _ownerPhone = value!.number;
                          _initialCountryCode = value.countryISOCode;
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
    return SaveButton(
      isLoading: restaurantProvider.isLoading || ownerProvider.isLoading,
      onTap: () async {
        if (_formKey.currentState?.validate() ?? false) {
          // Prevent multiple submissions by checking loading state
          if (restaurantProvider.isLoading || ownerProvider.isLoading) return;

          // Save the form fields
          _formKey.currentState?.save();

          try {
            // Check if the owner already exists by email
            final existingOwner =
                await ownerProvider.getOwnerByEmail(_ownerEmail);

            String ownerId;
            if (existingOwner != null) {
              ownerId = existingOwner.uid!;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Existing owner found, linking restaurant...'),
                ),
              );
            } else {
              final owner = UserModel(
                name: _ownerName,
                email: _ownerEmail,
                phoneISOCode: _initialCountryCode,
                phone: _ownerPhone,
                role: 'Owner',
                createAt: Timestamp.now(),
              );
              ownerId = await ownerProvider.createOwner(owner);

              if (ownerId.isEmpty) throw Exception('Failed to create owner.');
            }

            // Create and save the restaurant
            final restaurant = Restaurant(
              name: _restaurantName,
              address: _restaurantAddress,
              oid: ownerId,
              ownerName: existingOwner?.name ?? _ownerName,
              ownerEmail: existingOwner?.email ?? _ownerEmail,
              ownerPhoneISOCode: existingOwner?.phoneISOCode ?? _initialCountryCode,
              ownerPhone: existingOwner?.phone ?? _ownerPhone,
              creationDate: Timestamp.now(),
            );

            final restaurantId =
                await restaurantProvider.createRestaurant(restaurant);

            // Update the owner with the new restaurant ID
            await ownerProvider.updateOwner(
              uid: ownerId,
              newRestaurantID: restaurantId,
            );

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Restaurant added successfully!'),
              ),
            );

            _clearFields();
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error occurred: $e'),
              ),
            );
          }
        }
      },
    );
  }

  void _clearFields() {
    _restaurantNameController.clear();
    _restaurantAddressController.clear();
    _ownerNameController.clear();
    _ownerEmailController.clear();
    _ownerPhoneController.clear();
    _initialCountryCode = 'PK';
  }

  SizedBox _spacer() {
    return SizedBox(height: screenWidth! * 0.02);
  }
}
