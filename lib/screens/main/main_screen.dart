import 'package:flutter/material.dart';
import 'package:food_couriers_admin/screens/main/responsive/desktop_main.dart';
import 'package:food_couriers_admin/screens/main/responsive/mobile_main.dart';
import 'package:food_couriers_admin/screens/main/responsive/tablet_main.dart';
import 'package:food_couriers_admin/res/utils/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    deviceType = getDeviceType(MediaQuery.of(context).size);
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return ScreenTypeLayout.builder(
      mobile: (context) => MobileMain(navigationShell: navigationShell),
      tablet: (context) => TabletMain(navigationShell: navigationShell),
      desktop: (context) => DesktopMain(navigationShell: navigationShell),
    );
  }
}
