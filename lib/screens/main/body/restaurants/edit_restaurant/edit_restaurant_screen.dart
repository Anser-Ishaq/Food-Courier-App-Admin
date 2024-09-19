import 'package:flutter/material.dart';
import 'package:food_couriers_admin/constants/colors/app_colors.dart';
import 'package:food_couriers_admin/provider/restaurant_provider.dart';
import 'package:food_couriers_admin/screens/main/body/restaurants/edit_restaurant/widgets/custom_tab_bar.dart';
import 'package:food_couriers_admin/screens/main/body/restaurants/edit_restaurant/widgets/location.dart';
import 'package:food_couriers_admin/screens/main/body/restaurants/edit_restaurant/widgets/plans.dart';
import 'package:food_couriers_admin/screens/main/body/restaurants/edit_restaurant/widgets/restaurant_management.dart';
import 'package:food_couriers_admin/screens/main/body/restaurants/edit_restaurant/widgets/working_hours.dart';
import 'package:food_couriers_admin/screens/main/body/restaurants/widgets/custom_progress_indicator.dart';
import 'package:food_couriers_admin/utils.dart';
import 'package:provider/provider.dart';

class EditRestaurantScreen extends StatefulWidget {
  const EditRestaurantScreen({
    super.key,
    required this.rid,
  });

  final String rid;

  @override
  State<EditRestaurantScreen> createState() => _EditRestaurantScreenState();
}

class _EditRestaurantScreenState extends State<EditRestaurantScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late RestaurantProvider _restaurantProvider;

  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      // setState(() {
      _selectedIndex.value = _tabController.index;
      // });
    });
    _restaurantProvider =
        Provider.of<RestaurantProvider>(context, listen: false);
    initialize();
  }

  void initialize() async {
    await _restaurantProvider.getRestaurantById(widget.rid);
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ValueListenableBuilder(
              valueListenable: _selectedIndex,
              builder: (context, value, child) {
                return TabBar(
                  controller: _tabController,
                  padding: const EdgeInsets.all(0),
                  labelPadding:
                      EdgeInsets.symmetric(horizontal: screenWidth! * 0.007),
                  indicator: const BoxDecoration(),
                  dividerColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory,
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  tabs: [
                    CustomTabBar(
                      icon: Icons.badge_rounded,
                      text: 'Restaurant Management',
                      isSelected: value == 0,
                    ),
                    CustomTabBar(
                      icon: Icons.punch_clock_rounded,
                      text: 'Working Hours',
                      isSelected: value == 1,
                    ),
                    CustomTabBar(
                      icon: Icons.location_city_rounded,
                      text: 'Location',
                      isSelected: value == 2,
                    ),
                    CustomTabBar(
                      icon: Icons.monetization_on_rounded,
                      text: 'Plans',
                      isSelected: value == 3,
                    ),
                  ],
                );
              }),
          Container(
            margin: EdgeInsets.all(screenWidth! * 0.007),
            padding: EdgeInsets.all(screenWidth! * 0.02),
            constraints: BoxConstraints(
              minHeight: screenHeight! * 0.7,
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(screenWidth! * 0.01),
            ),
            child: _isLoading
                ? _buildLoadingTab()
                : ValueListenableBuilder(
                    valueListenable: _selectedIndex,
                    builder: (context, value, child) {
                      return value == 0
                          ? RestaurantManagement(
                              restaurant:
                                  _restaurantProvider.selectedRestaurant!)
                          : value == 1
                              ? WorkingHours(
                                  restaurant:
                                      _restaurantProvider.selectedRestaurant!)
                              : value == 2
                                  ? Location(
                                      restaurant: _restaurantProvider
                                          .selectedRestaurant!)
                                  : Plans(
                                      restaurant: _restaurantProvider
                                          .selectedRestaurant!);
                    },
                  ),
            // child: TabBarView(
            //   controller: _tabController,
            //   physics: const NeverScrollableScrollPhysics(),
            //   children: _isLoading
            //       ? [
            //           _buildLoadingTab(),
            //           _buildLoadingTab(),
            //           _buildLoadingTab(),
            //           _buildLoadingTab(),
            //         ]
            //       : [
            //           RestaurantManagement(
            //             restaurant: _restaurantProvider.selectedRestaurant!,
            //           ),
            //           WorkingHours(
            //             restaurant: _restaurantProvider.selectedRestaurant!,
            //           ),
            //           const Text(
            //             'Location',
            //           ),
            //           const Text(
            //             'Plans',
            //           ),
            //         ],
            // ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingTab() {
    return
        // Stack(
        //   children: [
        //     Positioned(
        //       top: screenHeight! / 3,
        //       left: 0,
        //       right: 0,
        //       child:
        const CustomProgressIndicator()
        // ,
        //     ),
        //   ],
        // )
        ;
  }

  double _findHeightOfTabBarView(int index) {
    switch (index) {
      case 0:
        return screenWidth! * 1;
      case 1:
        return screenWidth! * 0.75;
      case 2:
        return screenWidth! * 0.5;
      case 3:
        return screenWidth! * 0.6;
      default:
        return screenWidth! * 2.0;
    }
  }
}
