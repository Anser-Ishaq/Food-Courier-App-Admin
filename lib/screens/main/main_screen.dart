import 'package:flutter/material.dart';
import 'package:food_couriers_admin/screens/main/responsive/desktop_main.dart';
import 'package:food_couriers_admin/screens/main/responsive/mobile_main.dart';
import 'package:food_couriers_admin/screens/main/responsive/tablet_main.dart';
import 'package:food_couriers_admin/utils.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    deviceType = getDeviceType(MediaQuery.of(context).size);
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return ScreenTypeLayout.builder(
      mobile: (context) => const MobileMain(),
      tablet: (context) => const TabletMain(),
      desktop: (context) => const DesktopMain(),
    );
  }
}
