import 'package:flutter/material.dart';

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
  SideMenuModel(icon: Icons.restaurant_rounded, label: 'Restaurants'),
  SideMenuModel(icon: Icons.attach_money_rounded, label: 'Finances'),
  SideMenuModel(icon: Icons.people_outline_rounded, label: 'Users'),
  SideMenuModel(icon: Icons.support_rounded, label: 'Support'),
];
