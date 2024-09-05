import 'package:flutter/material.dart';
import 'package:food_couriers_admin/constants/colors/app_colors.dart';
import 'package:food_couriers_admin/utils.dart';

class EditRestaurantScreen extends StatefulWidget {
  const EditRestaurantScreen({
    super.key,
    required this.rid,
  });

  final String rid;

  @override
  State<EditRestaurantScreen> createState() => _EditRestaurantScreenState();
}

class _EditRestaurantScreenState extends State<EditRestaurantScreen> {
  @override
  Widget build(BuildContext context) {
    print(widget.rid);
    return Container(
      margin: EdgeInsets.all(screenWidth! * 0.007),
      padding: EdgeInsets.all(screenWidth! * 0.02),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(screenWidth! * 0.01),
      ),
    );
  }
}
