import 'package:flutter/material.dart';
import 'package:food_couriers_admin/models/restaurant.dart';
import 'package:food_couriers_admin/screens/main/body/restaurants/edit_restaurant/widgets/custom_title_row.dart';

class Location extends StatelessWidget {
  const Location({
    super.key,
    required this.restaurant,
  });

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTitle(),
      ],
    );
  }

  Widget _buildTitle() {
    return CustomTitleRow(
      title: 'Location',
      showButton1: false,
      showButton2: false,
    );
  }
}
