import 'package:flutter/material.dart';
import 'package:food_couriers_admin/constants/colors/app_colors.dart';
import 'package:food_couriers_admin/constants/images/images.dart';
import 'package:food_couriers_admin/screens/main/models/side_menu_model.dart';
import 'package:food_couriers_admin/screens/main/body/dashboard_body.dart';
import 'package:food_couriers_admin/screens/main/widgets/header.dart';
import 'package:food_couriers_admin/screens/main/menu/side_menu.dart';
import 'package:food_couriers_admin/utils.dart';

class TabletMain extends StatefulWidget {
  const TabletMain({super.key});

  @override
  State<TabletMain> createState() => _TabletMainState();
}

class _TabletMainState extends State<TabletMain> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Row(
        children: [
          Container(
            width: screenWidth! * 0.18,
            color: AppColors.white,
            constraints: const BoxConstraints(
              maxWidth: 250,
            ),
            child: SideMenu(
              selectedIndex: _selectedIndex,
              onTapSideMenuItem: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              sideMenuItem: sideMenuItem,
              version: 'VERSION 4.0.4',
              versionDateTime: '2024-09-22 03:31:30',
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Header(
                  screen: sideMenuItem[_selectedIndex].label!,
                  imageURL: Images.person,
                  userName: 'Admin',
                ),
                bodyUI(sideMenuItem[1].label!),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
