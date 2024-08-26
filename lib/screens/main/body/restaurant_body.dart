import 'package:flutter/material.dart';

class RestaurantBody extends StatefulWidget {
  const RestaurantBody({super.key});

  @override
  State<RestaurantBody> createState() => _RestaurantBodyState();
}

class _RestaurantBodyState extends State<RestaurantBody> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Text(
          'Restaurant Body',
        ),
      ),
    );
  }
}
