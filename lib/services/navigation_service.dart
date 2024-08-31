import 'package:flutter/material.dart';
import 'package:food_couriers_admin/constants/routes/routes.dart';
import 'package:food_couriers_admin/screens/main/body/restaurants/add_restaurant/add_restaurant_screen.dart';
import 'package:food_couriers_admin/screens/login/login_screen.dart';
import 'package:food_couriers_admin/screens/main/body/dashboard/dashboard_body.dart';
import 'package:food_couriers_admin/screens/main/body/finances/finances_body.dart';
import 'package:food_couriers_admin/screens/main/body/restaurants/restaurant_body.dart';
import 'package:food_couriers_admin/screens/main/body/support/support_body.dart';
import 'package:food_couriers_admin/screens/main/body/users/users_body.dart';
import 'package:food_couriers_admin/screens/main/main_screen.dart';
import 'package:go_router/go_router.dart';

class NavigationService {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  GoRouter get router => GoRouter(
        navigatorKey: _navigatorKey,
        initialLocation: '/${Routes.login}',
        routes: [
          GoRoute(
            name: Routes.login,
            path: '/${Routes.login}',
            builder: (context, state) => const LoginScreen(),
          ),
          StatefulShellRoute.indexedStack(
            builder: (context, state, navigationShell) =>
                MainScreen(navigationShell: navigationShell),
            branches: [
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    name: Routes.home,
                    path: '/${Routes.home}',
                    builder: (context, state) => const DashboardBody(),
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    name: Routes.restaurant,
                    path: '/${Routes.restaurant}',
                    builder: (context, state) => const RestaurantBody(),
                    routes: [
                      GoRoute(
                        name: Routes.addRestaurant,
                        path: Routes.addRestaurant,
                        builder: (context, state) {
                          return const AddRestaurantScreen();
                        },
                      ),
                    ],
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    name: Routes.finances,
                    path: '/${Routes.finances}',
                    builder: (context, state) => const FinancesBody(),
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    name: Routes.users,
                    path: '/${Routes.users}',
                    builder: (context, state) => const UsersBody(),
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    name: Routes.support,
                    path: '/${Routes.support}',
                    builder: (context, state) => const SupportBody(),
                  ),
                ],
              ),
            ],
          ),
        ],
      );
}
