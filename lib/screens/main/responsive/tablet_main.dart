import 'package:flutter/material.dart';
import 'package:food_couriers_admin/constants/colors/app_colors.dart';
import 'package:food_couriers_admin/constants/images/images.dart';
import 'package:food_couriers_admin/constants/routes/routes.dart';
import 'package:food_couriers_admin/provider/userdata_provider.dart';
import 'package:food_couriers_admin/screens/main/models/side_menu_model.dart';
import 'package:food_couriers_admin/screens/main/widgets/header.dart';
import 'package:food_couriers_admin/screens/main/menu/side_menu.dart';
import 'package:food_couriers_admin/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TabletMain extends StatelessWidget {
  const TabletMain({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    bool showScreen = true;
    String screenName = sideMenuItem[navigationShell.currentIndex].label!;

    final currentLocation =
        GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;

    if (navigationShell.currentIndex == 1 &&
        currentLocation == '/${Routes.restaurant}/${Routes.addRestaurant}') {
      showScreen = false;
      screenName = "Add Restaurant";
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: screenWidth! * 0.18,
            color: AppColors.white,
            constraints: const BoxConstraints(
              maxWidth: 250,
            ),
            child: SideMenu(
              selectedIndex: navigationShell.currentIndex,
              onTapSideMenuItem: navigationShell.goBranch,
              sideMenuItem: sideMenuItem,
              version: 'VERSION 4.0.4',
              versionDateTime: '2024-09-22 03:31:30',
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Consumer<UserdataProvider>(
                    builder: (context, userdataProvider, child) {
                      final user = userdataProvider.currentUser;
                      return Header(
                        screen: screenName,
                        imageURL: user?.imageURL ?? Images.person,
                        userName: user?.name ?? '',
                        showScreen: showScreen,
                      );
                    }
                  ),
                  navigationShell,
                  SizedBox(height: screenWidth! * 0.075),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
