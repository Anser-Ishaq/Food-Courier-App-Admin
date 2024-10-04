import 'package:food_couriers_admin/provider/provider.dart';
import 'package:food_couriers_admin/res/routes/routes.dart';
import 'package:food_couriers_admin/screens/main/body/body.dart';
import 'package:food_couriers_admin/screens/main/body/restaurants/restaurants.dart';
import 'package:food_couriers_admin/screens/screens.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class NavigationService {
  final GoRouter _router = GoRouter(
    initialLocation: '/${Routes.login}',
    routes: [
      GoRoute(
        name: Routes.login,
        path: '/${Routes.login}',
        builder: (context, state) => const LoginScreen(),
        redirect: (context, state) {
          final authProvider = Provider.of<AuthProvider>(context, listen: false);
          final user = authProvider.user;
          
          if (user != null) {
            return '/${Routes.home}';
          }
          
          return null;
        },
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
                  GoRoute(
                    name: Routes.editRestaurant,
                    path: '${Routes.editRestaurant}/:rid',
                    builder: (context, state) {
                      final rid = state.pathParameters['rid']!;
                      return EditRestaurantScreen(rid: rid);
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

  GoRouter get router => _router;
}
