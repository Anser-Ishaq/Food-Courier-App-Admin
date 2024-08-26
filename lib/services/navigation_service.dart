import 'package:flutter/material.dart';
import 'package:food_couriers_admin/constants/routes/routes.dart';
import 'package:food_couriers_admin/screens/main/main_screen.dart';
import 'package:food_couriers_admin/screens/login/login_screen.dart';

class NavigationService {

  late GlobalKey<NavigatorState> _navigatorKey;

  final Map<String, Widget Function(BuildContext)> _routes = {
    Routes.login : (context) => const LoginScreen(),
    Routes.main : (context) => const MainScreen(),
  };

  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;
  Map<String, Widget Function(BuildContext)> get routes => _routes;

  NavigationService() {
    _navigatorKey = GlobalKey<NavigatorState>();
  }

  void push(MaterialPageRoute route) {
    _navigatorKey.currentState?.push(route);
  }

  void pushNamed(String routeName) {
    _navigatorKey.currentState?.pushNamed(routeName);
  }

  void pushReplacementNamed(String routeName) {
    _navigatorKey.currentState?.pushReplacementNamed(routeName);
  }

  void goBack() {
    _navigatorKey.currentState?.pop();
  }

}