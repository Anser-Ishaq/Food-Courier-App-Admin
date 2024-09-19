import 'package:flutter/material.dart';
import 'package:food_couriers_admin/provider/restaurant_provider.dart';
import 'package:food_couriers_admin/provider/shift_provider.dart';
import 'package:provider/provider.dart';

class ConsumerRestaurantShift extends StatelessWidget {
  const ConsumerRestaurantShift({super.key, required this.builder});

  final Widget Function(RestaurantProvider, ShiftProvider) builder; 

  @override
  Widget build(BuildContext context) {
    return Consumer2<RestaurantProvider, ShiftProvider>(
      builder: (context, restaurantProvider, shiftProvider, child) {
        return builder(restaurantProvider, shiftProvider);
      },
    );
  }
}
