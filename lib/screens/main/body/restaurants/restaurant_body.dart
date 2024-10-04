import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_couriers_admin/res/colors/app_colors.dart';
import 'package:food_couriers_admin/res/routes/routes.dart';
import 'package:food_couriers_admin/models/restaurant.dart';
import 'package:food_couriers_admin/provider/ownerdata_provider.dart';
import 'package:food_couriers_admin/provider/restaurant_provider.dart';
import 'package:food_couriers_admin/screens/main/body/restaurants/widgets/widgets.dart';
import 'package:food_couriers_admin/res/utils/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:universal_html/html.dart' as html;

class RestaurantBody extends StatefulWidget {
  const RestaurantBody({super.key});

  @override
  State<RestaurantBody> createState() => _RestaurantBodyState();
}

class _RestaurantBodyState extends State<RestaurantBody> {
  bool _showSearch = false;
  Restaurant? _searchedRestaurant;

  void _generateCSV({
    required List<Restaurant> restaurants,
  }) {
    final List<List<String>> data = [
      ['ID', 'Name', 'Address', 'Phone', 'Owner Email', 'Status'],
    ];

    for (var restaurant in restaurants) {
      data.add([
        restaurant.rid ?? 'N/A',
        restaurant.name ?? 'N/A',
        restaurant.address ?? 'N/A',
        restaurant.phone ?? 'N/A',
        restaurant.ownerEmail ?? 'N/A',
        restaurant.active.toString(),
      ]);
    }

    final csvContent = const ListToCsvConverter().convert(data);
    String formattedDate =
        DateFormat('MM-dd-yyyy-HH-mm-ss').format(DateTime.now());

    if (kIsWeb) {
      final bytes = utf8.encode(csvContent);

      final blob = html.Blob([bytes], 'text/csv');

      final url = html.Url.createObjectUrlFromBlob(blob);

      final anchor = html.document.createElement('a') as html.AnchorElement
        ..href = url
        ..style.display = 'none'
        ..download = 'restaurants-$formattedDate.csv';

      html.document.body!.children.add(anchor);

      anchor.click();

      html.Url.revokeObjectUrl(url);
    }
  }

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
                onExportCSV: () {
                  _generateCSV(restaurants: restaurants);
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
                  restaurantProvider.updateRestaurant(
                      rid: restaurant.rid!, newActive: restaurant.active);
                },
                onTapDelete: (Restaurant restaurant) {
                  Provider.of<OwnerdataProvider>(context, listen: false)
                      .updateOwner(
                          uid: restaurant.oid!,
                          existingRestaurantID: restaurant.rid!);
                  restaurantProvider.deleteRestaurant(restaurant.rid!);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
