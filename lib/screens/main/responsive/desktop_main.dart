import 'package:flutter/material.dart';
import 'package:food_couriers_admin/constants/colors/app_colors.dart';
import 'package:food_couriers_admin/constants/images/images.dart';
import 'package:food_couriers_admin/constants/routes/routes.dart';
import 'package:food_couriers_admin/provider/userdata_provider.dart';
import 'package:food_couriers_admin/screens/main/menu/side_menu.dart';
import 'package:food_couriers_admin/screens/main/models/side_menu_model.dart';
import 'package:food_couriers_admin/screens/main/widgets/header.dart';
import 'package:food_couriers_admin/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DesktopMain extends StatefulWidget {
  const DesktopMain({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<DesktopMain> createState() => _DesktopMainState();
}

class _DesktopMainState extends State<DesktopMain> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserdataProvider>(context, listen: false).getUser(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool showScreen = true;
    String screenName =
        sideMenuItem[widget.navigationShell.currentIndex].label!;

    final currentLocation =
        GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;

    if (widget.navigationShell.currentIndex == 1 &&
        (currentLocation == '/${Routes.restaurant}/${Routes.addRestaurant}' ||
            currentLocation
                .contains('/${Routes.restaurant}/${Routes.editRestaurant}'))) {
      showScreen = false;
      screenName = currentLocation
              .contains('/${Routes.restaurant}/${Routes.editRestaurant}')
          ? "Edit Restaurant"
          : "Add Restaurant";
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Consumer<UserdataProvider>(
        builder: (context, userdataProvider, child) {
          if (userdataProvider.isLoading) {
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: screenWidth! * 0.0025,
                valueColor:
                    const AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            );
          }
          final user = userdataProvider.currentUser;
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: screenWidth! * 0.18,
                color: AppColors.white,
                child: SideMenu(
                  selectedIndex: widget.navigationShell.currentIndex,
                  onTapSideMenuItem: widget.navigationShell.goBranch,
                  sideMenuItem: sideMenuItem,
                  version: 'VERSION 4.0.4',
                  versionDateTime: '2024-09-22 03:31:30',
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Header(
                        screen: screenName,
                        imageURL: user?.imageURL ?? Images.person,
                        userName: user?.name ?? '',
                        showScreen: showScreen,
                      ),
                      widget.navigationShell,
                      SizedBox(height: screenWidth! * 0.075),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
