import 'package:flutter/material.dart';
import 'package:food_couriers_admin/models/models.dart';
import 'package:food_couriers_admin/provider/provider.dart';
import 'package:food_couriers_admin/res/colors/app_colors.dart';
import 'package:food_couriers_admin/res/utils/utils.dart';
import 'package:food_couriers_admin/screens/main/body/restaurants/edit_restaurant/widgets/widgets.dart';
import 'package:food_couriers_admin/screens/main/body/restaurants/widgets/widgets.dart';
import 'package:provider/provider.dart';

class RestaurantManagement extends StatefulWidget {
  const RestaurantManagement({
    super.key,
    required this.restaurant,
  });

  final Restaurant restaurant;

  @override
  State<RestaurantManagement> createState() => _RestaurantManagementState();
}

class _RestaurantManagementState extends State<RestaurantManagement> {
  final _formKey = GlobalKey<FormState>();

  String? restaurantName,
      restaurantDescription,
      restaurantAddress,
      restaurantPhoneISOCode,
      restaurantPhone,
      feePercent,
      staticFee,
      minOrder,
      whatsappNumberISOCode,
      whatsappNumber,
      ownerName,
      ownerEmail,
      ownerPhoneISOCode,
      ownerPhone;

  late TextEditingController restaurantNameController,
      restaurantDescriptionController,
      restaurantAddressController,
      restaurantPhoneController,
      feePercentController,
      staticFeeController,
      minOrderController,
      whatsappNumberController,
      ownerNameController,
      ownerEmailController,
      ownerPhoneController;

  @override
  void initState() {
    super.initState();
    initializeTextController();
  }

  void initializeTextController() async {
    restaurantNameController =
        TextEditingController(text: widget.restaurant.name);
    restaurantDescriptionController =
        TextEditingController(text: widget.restaurant.description);
    restaurantAddressController =
        TextEditingController(text: widget.restaurant.address);
    restaurantPhoneISOCode = widget.restaurant.phoneISOCode ?? 'PK';
    restaurantPhoneController =
        TextEditingController(text: widget.restaurant.phone);
    feePercentController =
        TextEditingController(text: widget.restaurant.percentFee ?? '0');
    staticFeeController =
        TextEditingController(text: widget.restaurant.staticFee ?? '0');
    minOrderController =
        TextEditingController(text: widget.restaurant.minOrder ?? '10');
    whatsappNumberISOCode = widget.restaurant.whatsappNumberISOCode ?? 'PK';
    whatsappNumberController =
        TextEditingController(text: widget.restaurant.whatsappNumber);
    ownerNameController =
        TextEditingController(text: widget.restaurant.ownerName);
    ownerEmailController =
        TextEditingController(text: widget.restaurant.ownerEmail);
    ownerPhoneISOCode = widget.restaurant.ownerPhoneISOCode ?? 'PK';
    ownerPhoneController =
        TextEditingController(text: widget.restaurant.ownerPhone);
  }

  @override
  void dispose() {
    restaurantNameController.dispose();
    restaurantDescriptionController.dispose();
    restaurantAddressController.dispose();
    restaurantPhoneController.dispose();
    feePercentController.dispose();
    staticFeeController.dispose();
    minOrderController.dispose();
    whatsappNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(),
          _spacer(),
          _buildBody(),
          _spacer(),
          _spacer(),
          const RestaurantDivider(),
          _spacer(),
          _buildOwnerInfo(),
          _spacer(),
          _spacer(),
          _buildSaveButton(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return CustomTitleRow(
      title: 'Restaurant Management',
      showButton1: true,
      showButton2: true,
      button1: ButtonBox(
        title: 'View it',
        onTap: () {},
      ),
      button2: ButtonBox(
        title: 'Login as',
        onTap: () {},
      ),
    );
  }

  Widget _buildBody() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLeft(),
        _buildRight(),
      ],
    );
  }

  Widget _buildLeft() {
    return Expanded(
      child: SubSection(
        title: 'Restaurant Information',
        child: Column(
          children: [
            RestaurantDetailsTextField(
              title: 'Restaurant Name',
              controller: restaurantNameController,
              onSaved: (value) {
                restaurantName = value;
              },
            ),
            _spacer(),
            RestaurantDetailsTextField(
              title: 'Restaurant description',
              controller: restaurantDescriptionController,
              onSaved: (value) {
                restaurantDescription = value;
              },
            ),
            _spacer(),
            RestaurantDetailsTextField(
              title: 'Restaurant address',
              controller: restaurantAddressController,
              onSaved: (value) {
                restaurantAddress = value;
              },
            ),
            _spacer(),
            PhoneNumberInput(
              title: 'Restaurant phone',
              initialCountryCode: restaurantPhoneISOCode!,
              controller: restaurantPhoneController,
              onSaved: (value) {
                restaurantPhone = value!.number;
                restaurantPhoneISOCode = value.countryISOCode;
              },
            ),
            _spacer(),
            _spacer(),
            Row(
              children: [
                Expanded(
                  child: RestaurantDetailsTextField(
                    title: 'Fee percent',
                    controller: feePercentController,
                    onSaved: (value) {
                      feePercent = value;
                    },
                    showIncrementDecrement: true,
                  ),
                ),
                SizedBox(width: screenWidth! * 0.02),
                Expanded(
                  child: RestaurantDetailsTextField(
                    title: 'Static fee',
                    controller: staticFeeController,
                    onSaved: (value) {
                      staticFee = value;
                    },
                    showIncrementDecrement: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRight() {
    return Expanded(
      child: Column(
        children: [
          _spacer(),
          _buildOrderSection(),
          _spacer(),
          _spacer(),
          _buildWhatsappSection(),
        ],
      ),
    );
  }

  Widget _buildOrderSection() {
    return SubSection(
      title: 'Orders',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RestaurantDetailsTextField(
            title: 'Minimum Order',
            controller: minOrderController,
            onSaved: (value) {
              minOrder = value;
            },
            showIncrementDecrement: true,
          ),
          Text(
            'Enter Minimum order value',
            style: TextStyle(
              color: AppColors.textDarkColor.withAlpha(150),
              fontFamily: 'DM Sans',
              fontSize: screenWidth! * 0.01,
              fontWeight: FontWeight.bold,
              letterSpacing: screenWidth! * 0.0085 * -0.015,
            ),
          ),
          _spacer(),
        ],
      ),
    );
  }

  Widget _buildWhatsappSection() {
    return SubSection(
      title: 'Whatsapp Number',
      child: PhoneNumberInput(
        title: 'Whatsapp phone',
        initialCountryCode: whatsappNumberISOCode!,
        controller: whatsappNumberController,
        onSaved: (value) {
          whatsappNumber = value!.number;
          whatsappNumberISOCode = value.countryISOCode;
        },
      ),
    );
  }

  Widget _buildOwnerInfo() {
    return SubSection(
      title: 'Owner Information',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RestaurantDetailsTextField(
            title: 'Owner Name',
            controller: ownerNameController,
            onSaved: (value) {
              ownerName = value ?? '';
            },
          ),
          _spacer(),
          RestaurantDetailsTextField(
            title: 'Owner Email',
            controller: ownerEmailController,
            onSaved: (value) {
              ownerEmail = value ?? '';
            },
          ),
          _spacer(),
          PhoneNumberInput(
            title: 'Owner Phone Number',
            initialCountryCode: ownerPhoneISOCode!,
            controller: ownerPhoneController,
            onSaved: (value) {
              ownerPhone = value!.number;
              ownerPhoneISOCode = value.countryISOCode;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return Consumer2<RestaurantProvider, OwnerdataProvider>(
      builder: (context, restaurantProvider, ownerProvider, child) {
        return SaveButton(
          buttonText: 'Save',
          gradient: AppColors.gradientGreen,
          isLoading: restaurantProvider.isLoading || ownerProvider.isLoading,
          onTap: () async {
            if (restaurantProvider.isLoading || ownerProvider.isLoading) return;

            if (_formKey.currentState?.validate() ?? false) {
              _formKey.currentState?.save();

              try {
                // Validate and ensure non-null values before update
                restaurantName ??= widget.restaurant.name;
                restaurantDescription ??= widget.restaurant.description;
                restaurantAddress ??= widget.restaurant.address;
                restaurantPhoneISOCode ??= widget.restaurant.phoneISOCode;
                restaurantPhone ??= widget.restaurant.phone;
                feePercent ??= widget.restaurant.percentFee ?? '0';
                staticFee ??= widget.restaurant.staticFee ?? '0';
                minOrder ??= widget.restaurant.minOrder ?? '10';
                whatsappNumberISOCode ??=
                    widget.restaurant.whatsappNumberISOCode;
                whatsappNumber ??= widget.restaurant.whatsappNumber;

                ownerName ??= widget.restaurant.ownerName;
                ownerEmail ??= widget.restaurant.ownerEmail;
                ownerPhoneISOCode ??= widget.restaurant.ownerPhoneISOCode;
                ownerPhone ??= widget.restaurant.ownerPhone;

                // Update restaurant details
                await restaurantProvider.updateRestaurant(
                  rid: widget.restaurant.rid!,
                  newName: restaurantName,
                  newDescription: restaurantDescription,
                  newAddress: restaurantAddress,
                  newPhoneISOCode: restaurantPhoneISOCode,
                  newPhone: restaurantPhone,
                  newPercentFee: feePercent,
                  newStaticFee: staticFee,
                  newMinOrder: minOrder,
                  newWhatsappNumberISOCode: whatsappNumberISOCode,
                  newWhatsappNumber: whatsappNumber,
                  newOwnerName: ownerName,
                  newOwnerEmail: ownerEmail,
                  newOwnerPhoneISOCode: ownerPhoneISOCode,
                  newOwnerPhone: ownerPhone,
                );

                // Update owner details
                await ownerProvider.updateOwner(
                  uid: widget.restaurant.oid!,
                  newName: ownerName,
                  newEmail: ownerEmail,
                  newPhone: ownerPhone,
                  newRestaurantID: widget.restaurant.rid,
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text(
                          'Restaurant and owner details updated successfully!')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error occurred: ${e.toString()}')),
                );
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Please fill out all fields correctly.')),
              );
            }
          },
        );
      },
    );
  }

  SizedBox _spacer() {
    return SizedBox(height: screenWidth! * 0.02);
  }
}
