import 'package:flutter/material.dart';
import 'package:food_couriers_admin/constants/colors/app_colors.dart';
import 'package:food_couriers_admin/utils.dart';

class RestaurantBody extends StatefulWidget {
  const RestaurantBody({super.key});

  @override
  State<RestaurantBody> createState() => _RestaurantBodyState();
}

class _RestaurantBodyState extends State<RestaurantBody> {
  bool _showSearch = true;

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _head(),
              _searchContainer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchContainer() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: _showSearch ? screenWidth! * 0.03 : screenWidth! * 0,
      width: screenWidth! * 0.2,
      margin: EdgeInsets.symmetric(vertical: screenWidth! * 0.01),
      padding: EdgeInsets.all(screenWidth! * 0.007),
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(screenWidth! * 0.005),
      ),
      child: TextField(
            decoration: InputDecoration(
              hintText: 'Search Restaurants...',
              hintStyle: TextStyle(
                color: AppColors.white.withOpacity(0.6),
                fontSize: screenWidth! * 0.01,
              ),
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.search,
                color: AppColors.white.withOpacity(0.6),
                size: screenWidth! * 0.015,
              ),
            ),
            style: TextStyle(
              color: AppColors.white,
              fontSize: screenWidth! * 0.01,
            ),
            cursorColor: AppColors.white,
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
            _buttonBox(
              title: 'Add Restaurant',
              isOutline: false,
              onTap: () {},
            ),
            _buttonBox(
              title: 'Export CSV',
              isOutline: true,
              onTap: () {},
            ),
            _buttonSearchToggle(
              onTap: () {
                setState(() {
                  _showSearch = !_showSearch;
                });
              },
            )
          ],
        ),
      ],
    );
  }

  Widget _buttonSearchToggle({
    required VoidCallback onTap,
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
              offset: const Offset(10, 10),
              blurRadius: 20,
              spreadRadius: 4,
            )
          ],
        ),
        child: Icon(
          _showSearch
              ? Icons.keyboard_arrow_up_rounded
              : Icons.keyboard_arrow_down_rounded,
          color: AppColors.textDarkColor,
          size: screenWidth! * 0.02,
        ),
      ),
    );
  }

  Widget _buttonBox({
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
            color: isOutline ? AppColors.primary : AppColors.primary,
            strokeAlign: isOutline
                ? BorderSide.strokeAlignCenter
                : BorderSide.strokeAlignCenter,
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
