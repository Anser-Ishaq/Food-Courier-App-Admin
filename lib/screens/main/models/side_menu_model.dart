import 'package:flutter/material.dart';
import 'package:food_couriers_admin/screens/main/body/dashboard_body.dart';
import 'package:food_couriers_admin/screens/main/body/finances_body.dart';
import 'package:food_couriers_admin/screens/main/body/restaurant_body.dart';
import 'package:food_couriers_admin/screens/main/body/support_body.dart';
import 'package:food_couriers_admin/screens/main/body/users_body.dart';

class SideMenuModel {
  final IconData? icon;
  final String? label;

  SideMenuModel({
    required this.icon,
    required this.label,
  });
}

List<SideMenuModel> sideMenuItem = [
  SideMenuModel(icon: Icons.home_rounded, label: 'Dashboard'),
  SideMenuModel(icon: Icons.restaurant_rounded, label: 'Restaurant'),
  SideMenuModel(icon: Icons.attach_money_rounded, label: 'Finances'),
  SideMenuModel(icon: Icons.people_outline_rounded, label: 'Users'),
  SideMenuModel(icon: Icons.support_rounded, label: 'Support'),
];

Widget bodyUI(String sideMenuItem) {
  switch (sideMenuItem) {
    case 'Dashboard':
      return const DashboardBody();
    case 'Restaurant':
      return const RestaurantBody();
    case 'Finances':
      return const FinancesBody();
    case 'Users':
      return const UsersBody();
    case 'Support':
      return const SupportBody();
    default:
      return const DashboardBody();
  }
}
