import 'package:flutter/material.dart';
import 'package:food_couriers_admin/screens/login/reponsive/desktop_login.dart';
import 'package:food_couriers_admin/screens/login/reponsive/mobile_login.dart';
import 'package:food_couriers_admin/screens/login/reponsive/tablet_login.dart';
import 'package:food_couriers_admin/res/utils/utils.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    deviceType = getDeviceType(MediaQuery.of(context).size);
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return ScreenTypeLayout.builder(
      mobile: (context) => const MobileLogin(),
      tablet: (context) => const TabletLogin(),
      desktop: (context) => const DesktopLogin(),
    );
  }
}
