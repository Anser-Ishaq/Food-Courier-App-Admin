import 'package:flutter/material.dart';
import 'package:food_couriers_admin/res/colors/app_colors.dart';
import 'package:food_couriers_admin/res/components/components.dart';
import 'package:food_couriers_admin/res/images/images.dart';
import 'package:food_couriers_admin/models/restaurant.dart';
import 'package:food_couriers_admin/res/utils/utils.dart';

class RestaurantList extends StatelessWidget {
  const RestaurantList({
    super.key,
    required this.restaurants,
    required this.onTapEdit,
    required this.onTapActive,
    required this.onTapDelete,
  });

  final List<Restaurant> restaurants;
  final void Function(Restaurant) onTapEdit;
  final void Function(Restaurant) onTapActive;
  final void Function(Restaurant) onTapDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHeader(),
        _buildList(),
      ],
    );
  }

  Widget _buildList() {
    return Flexible(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: screenWidth! * 0.01),
        padding: EdgeInsets.all(screenWidth! * 0.001),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(screenWidth! * 0.005),
        ),
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: restaurants.length,
          itemBuilder: (context, index) {
            final restaurant = restaurants[index];
            return _buildListItem(restaurant);
          },
          separatorBuilder: (context, index) => SizedBox(
            height: screenWidth! * 0.005,
          ),
        ),
      ),
    );
  }

  Widget _buildListItem(Restaurant restaurant) {
    return Container(
      padding: EdgeInsets.all(screenWidth! * 0.005),
      decoration: BoxDecoration(
        color: AppColors.silver.withOpacity(0.05),
        borderRadius: BorderRadius.circular(screenWidth! * 0.005),
      ),
      child: Row(
        children: [
          _buildExpandedText(flex: 5, text: restaurant.name ?? ''),
          _buildSpacing(),
          _buildLogo(restaurant.logo ?? Images.icon),
          _buildSpacing(),
          _buildExpandedText(flex: 3, text: restaurant.ownerName ?? ''),
          _buildSpacing(),
          _buildExpandedText(flex: 4, text: restaurant.ownerEmail ?? ''),
          _buildSpacing(),
          _buildExpandedText(
            flex: 7,
            text: formatDate(restaurant.creationDate!.toDate()),
          ),
          _buildSpacing(),
          _buildStatusIndicator(restaurant.active),
          _buildSpacing(),
          _buildActionMenu(restaurant),
        ],
      ),
    );
  }

  Widget _buildLogo(String logoPath) {
    return Expanded(
      flex: 2,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: screenWidth! * 0.03,
          height: screenWidth! * 0.03,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(logoPath),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(screenWidth! * 0.005),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(bool isActive) {
    return Expanded(
      flex: 2,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.all(screenWidth! * 0.005),
          decoration: BoxDecoration(
            color: isActive ? Colors.green.shade100 : Colors.red.shade100,
            borderRadius: BorderRadius.circular(screenWidth! * 0.005),
          ),
          child: Text(
            isActive ? 'Active' : 'Inactive',
            style: commonTextStyle(
              screenWidth! * 0.01,
              FontWeight.w300,
            ).copyWith(color: isActive ? Colors.green : Colors.red),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(screenWidth! * 0.005),
      decoration: BoxDecoration(
        color: AppColors.silver.withOpacity(0.15),
        borderRadius: BorderRadius.circular(screenWidth! * 0.005),
      ),
      child: Row(
        children: [
          _buildExpandedText(flex: 5, text: 'name'.toUpperCase()),
          _buildSpacing(),
          _buildExpandedText(flex: 2, text: 'logo'.toUpperCase()),
          _buildSpacing(),
          _buildExpandedText(flex: 3, text: 'owner'.toUpperCase()),
          _buildSpacing(),
          _buildExpandedText(flex: 4, text: 'owner email'.toUpperCase()),
          _buildSpacing(),
          _buildExpandedText(flex: 7, text: 'creation date'.toUpperCase()),
          _buildSpacing(),
          _buildExpandedText(flex: 2, text: 'active'.toUpperCase()),
          _buildSpacing(),
          _buildExpandedText(text: ''),
        ],
      ),
    );
  }

  Widget _buildExpandedText({int? flex = 1, required String text}) {
    return Expanded(
      flex: flex!,
      child: Text(
        text,
        style: commonTextStyle(screenWidth! * 0.01, FontWeight.w500),
      ),
    );
  }

  Widget _buildSpacing() {
    return SizedBox(width: screenWidth! * 0.015);
  }

  Widget _buildActionMenu(Restaurant restaurant) {
    return Expanded(
      child: Hover(
        builder: (hover) {
          return Center(
            child: Container(
              padding: EdgeInsets.all(screenWidth! * 0.003),
              decoration: BoxDecoration(
                color: hover ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(screenWidth! * 0.005),
                boxShadow: hover
                    ? [
                        BoxShadow(
                          color: AppColors.silver.withOpacity(0.3),
                          offset: const Offset(5, 8),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ]
                    : [],
              ),
              child: PopupMenuButton<String>(
                tooltip: '',
                color: AppColors.white,
                position: PopupMenuPosition.under,
                padding: const EdgeInsets.all(0),
                menuPadding: const EdgeInsets.all(0),
                elevation: 3,
                onSelected: (value) {
                  switch (value) {
                    case 'edit':
                      onTapEdit(restaurant);
                      break;
                    case 'login_as':
                      // Handle login as action
                      break;
                    case 'Deactivate':
                    case 'Activate':
                      onTapActive(restaurant);
                      break;
                    case 'delete':
                      onTapDelete(restaurant);
                      break;
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem<String>(
                    height: screenWidth! * 0.025,
                    value: 'edit',
                    child: Text(
                      'Edit',
                      style:
                          commonTextStyle(screenWidth! * 0.01, FontWeight.w500),
                    ),
                  ),
                  PopupMenuItem<String>(
                    height: screenWidth! * 0.025,
                    value: 'login_as',
                    child: Text(
                      'Login As',
                      style:
                          commonTextStyle(screenWidth! * 0.01, FontWeight.w500),
                    ),
                  ),
                  PopupMenuItem<String>(
                    height: screenWidth! * 0.025,
                    value: restaurant.active ? 'Deactivate' : 'Activate',
                    child: Text(
                      restaurant.active ? 'Deactivate' : 'Activate',
                      style:
                          commonTextStyle(screenWidth! * 0.01, FontWeight.w500),
                    ),
                  ),
                  PopupMenuItem<String>(
                    height: screenWidth! * 0.025,
                    value: 'delete',
                    child: Text(
                      'Delete',
                      style:
                          commonTextStyle(screenWidth! * 0.01, FontWeight.w500),
                    ),
                  ),
                ],
                child: Icon(
                  Icons.more_vert_rounded,
                  size: screenWidth! * 0.015,
                  opticalSize: 1,
                  fill: 0.5,
                  color: AppColors.silver,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
