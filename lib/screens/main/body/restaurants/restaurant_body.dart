import 'package:flutter/material.dart';
import 'package:food_couriers_admin/constants/colors/app_colors.dart';
import 'package:food_couriers_admin/constants/routes/routes.dart';
import 'package:food_couriers_admin/models/restaurant.dart';
import 'package:food_couriers_admin/provider/ownerdata_provider.dart';
import 'package:food_couriers_admin/provider/restaurant_provider.dart';
import 'package:food_couriers_admin/screens/main/body/restaurants/widgets/restaurant_head.dart';
import 'package:food_couriers_admin/screens/main/body/restaurants/widgets/restaurant_list.dart';
import 'package:food_couriers_admin/screens/main/body/restaurants/widgets/restaurant_search.dart';
import 'package:food_couriers_admin/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RestaurantBody extends StatefulWidget {
  const RestaurantBody({super.key});

  @override
  State<RestaurantBody> createState() => _RestaurantBodyState();
}

class _RestaurantBodyState extends State<RestaurantBody> {
  bool _showSearch = false;
  Restaurant? _searchedRestaurant;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(screenWidth! * 0.007),
      padding: EdgeInsets.all(screenWidth! * 0.01),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(screenWidth! * 0.01),
      ),
      child: Consumer<RestaurantProvider>(
          builder: (context, restaurantProvider, child) {
        restaurantProvider.fetchRestaurants();
        final restaurants = restaurantProvider.restaurants ?? [];
        return Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RestaurantHead(
              showSearch: _showSearch,
              onAddRestaurant: () {
                context.goNamed(
                  Routes.addRestaurant,
                );
              },
              onSearchToggle: () {
                setState(() {
                  _showSearch = !_showSearch;
                });
              },
            ),
            RestaurantSearch(
              showSearch: _showSearch,
              restaurants: restaurants,
              onChanged: (value) => setState(() {
                _searchedRestaurant = value;
              }),
            ),
            RestaurantList(
              restaurants: restaurants,
              onTapEdit: (Restaurant restaurant) {
                context.goNamed(
                  Routes.editRestaurant,
                  pathParameters: {
                    'rid': restaurant.rid!,
                  },
                );
              },
              onTapActive: (Restaurant restaurant) {
                restaurant.active = !restaurant.active;
                restaurantProvider.updateRestaurant(rid: restaurant.rid!, newActive: restaurant.active);
              },
              onTapDelete: (Restaurant restaurant) {
                Provider.of<OwnerdataProvider>(context, listen: false).updateOwner(uid: restaurant.oid!, existingRestaurantID: restaurant.rid!);
                restaurantProvider.deleteRestaurant(restaurant.rid!);
              },
            ),
          ],
        );
      }),
    );
  }
}
