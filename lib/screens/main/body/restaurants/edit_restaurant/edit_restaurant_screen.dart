import 'package:flutter/material.dart';
import 'package:food_couriers_admin/constants/colors/app_colors.dart';
import 'package:food_couriers_admin/provider/restaurant_provider.dart';
import 'package:food_couriers_admin/screens/main/body/restaurants/edit_restaurant/widgets/restaurant_management.dart';
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

  int _selectedIndex = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
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
          TabBar(
            controller: _tabController,
            padding: const EdgeInsets.all(0),
            labelPadding:
                EdgeInsets.symmetric(horizontal: screenWidth! * 0.007),
            indicator: const BoxDecoration(),
            dividerColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            tabs: [
              _buildTab(
                icon: Icons.badge_rounded,
                text: 'Restaurant Management',
                index: 0,
              ),
              _buildTab(
                icon: Icons.punch_clock_rounded,
                text: 'Working Hours',
                index: 1,
              ),
              _buildTab(
                icon: Icons.location_city_rounded,
                text: 'Location',
                index: 2,
              ),
              _buildTab(
                icon: Icons.monetization_on_rounded,
                text: 'Plans',
                index: 3,
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.all(screenWidth! * 0.007),
            padding: EdgeInsets.all(screenWidth! * 0.02),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(screenWidth! * 0.01),
            ),
            height: _findHeightOfTextView(_selectedIndex),
            child: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: _isLoading
                  ? [
                      _buildLoadingTab(),
                      _buildLoadingTab(),
                      _buildLoadingTab(),
                      _buildLoadingTab(),
                    ]
                  : [
                      _buildTabBarView(
                        index: 0,
                        child: RestaurantManagement(
                          restaurant: _restaurantProvider.selectedRestaurant!,
                        ),
                      ),
                      _buildTabBarView(
                        index: 1,
                        child: const Text(
                          'Working Hours',
                        ),
                      ),
                      _buildTabBarView(
                        index: 2,
                        child: const Text(
                          'Location',
                        ),
                      ),
                      _buildTabBarView(
                        index: 3,
                        child: const Text(
                          'Plans',
                        ),
                      ),
                    ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBarView({
    required int index,
    required Widget child,
  }) {
    return child;
  }

  Widget _buildTab({
    required IconData icon,
    required String text,
    required int index,
  }) {
    return Container(
      alignment: Alignment.center,
      padding:
          EdgeInsets.symmetric(horizontal: screenWidth! * 0.01, vertical: 10),
      decoration: BoxDecoration(
        color: _selectedIndex == index ? AppColors.primary : AppColors.white,
        borderRadius: BorderRadius.circular(screenWidth! * 0.005),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Icon(
            icon,
            size: screenWidth! * 0.0125,
            color:
                _selectedIndex == index ? AppColors.white : AppColors.primary,
          ),
          SizedBox(width: screenWidth! * 0.005),
          Text(
            text,
            style: TextStyle(
              fontSize: screenWidth! * 0.0115,
              fontFamily: 'DM Sans',
              color:
                  _selectedIndex == index ? AppColors.white : AppColors.primary,
              fontWeight: FontWeight.w400,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingTab() {
    return Stack(
      children: [
        Positioned(
          top: screenHeight! / 3,
          left: 0,
          right: 0,
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: screenWidth! * 0.0025,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ),
        ),
      ],
    );
  }

  double _findHeightOfTextView(int index) {
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
