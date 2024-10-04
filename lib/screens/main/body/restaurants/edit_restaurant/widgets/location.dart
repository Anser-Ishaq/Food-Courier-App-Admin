import 'package:flutter/material.dart';
import 'package:food_couriers_admin/models/models.dart';
import 'package:food_couriers_admin/screens/main/body/restaurants/edit_restaurant/widgets/widgets.dart';

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
    return const CustomTitleRow(
      title: 'Location',
      showButton1: false,
      showButton2: false,
    );
  }
}
