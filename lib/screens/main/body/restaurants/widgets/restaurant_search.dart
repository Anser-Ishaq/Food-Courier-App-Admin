import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:food_couriers_admin/res/images/images.dart';
import 'package:food_couriers_admin/models/restaurant.dart';
import 'package:food_couriers_admin/res/colors/app_colors.dart';
import 'package:food_couriers_admin/res/utils/utils.dart';

class RestaurantSearch extends StatefulWidget {
  final bool showSearch;
  final List<Restaurant> restaurants;
  final ValueChanged<Restaurant?> onChanged;

  const RestaurantSearch({
    super.key,
    required this.showSearch,
    required this.restaurants,
    required this.onChanged,
  });

  @override
  State<RestaurantSearch> createState() => _RestaurantSearchState();
}

class _RestaurantSearchState extends State<RestaurantSearch> {
  final FocusNode _searchFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 200),
      height: widget.showSearch ? screenWidth! * 0.03 : 0,
      width: screenWidth! * 0.2,
      margin: EdgeInsets.symmetric(vertical: screenWidth! * 0.01),
      padding: EdgeInsets.all(screenWidth! * 0.001),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screenWidth! * 0.005),
      ),
      child: widget.showSearch
          ? DropdownSearch<Restaurant>(
              items: widget.restaurants,
              itemAsString: (Restaurant restaurant) => restaurant.name ?? '',
              compareFn: (Restaurant a, Restaurant b) => a.rid == b.rid,
              onChanged: widget.onChanged,
              dropdownDecoratorProps: DropDownDecoratorProps(
                textAlignVertical: TextAlignVertical.center,
                dropdownSearchDecoration: InputDecoration(
                  isCollapsed: true,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: screenWidth! * 0.007,
                    vertical: screenWidth! * 0.008,
                  ),
                  border: border(),
                  enabledBorder: border(),
                  focusedBorder: border(),
                ),
              ),
              dropdownButtonProps: DropdownButtonProps(
                icon: Icon(
                  Icons.arrow_drop_down_rounded,
                  size: screenWidth! * 0.018,
                ),
                padding: EdgeInsets.zero,
                alignment: Alignment.centerRight,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                style: ButtonStyle(
                  padding: const WidgetStatePropertyAll(
                    EdgeInsets.zero,
                  ),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth! * 0.005),
                    ),
                  ),
                ),
              ),
              dropdownBuilder: (context, selectedItem) {
                return Text(
                  selectedItem?.name ?? 'Search',
                  style: commonTextStyle(screenWidth! * 0.01, FontWeight.w600),
                );
              },
              popupProps: PopupProps.menu(
                fit: FlexFit.loose,
                isFilterOnline: true,
                showSelectedItems: true,
                showSearchBox: true,
                
                searchDelay: const Duration(milliseconds: 50),
                itemBuilder: _customPopupItemBuilder,
                searchFieldProps: TextFieldProps(
                  focusNode: _searchFocusNode,
                  style:
                      commonTextStyle(screenWidth! * 0.0125, FontWeight.w400),
                  decoration: InputDecoration(
                    isCollapsed: true,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: screenWidth! * 0.005,
                      vertical: screenWidth! * 0.008,
                    ),
                    border: border(),
                    enabledBorder: border(),
                    focusedBorder: border(),
                  ),
                ),
                containerBuilder: (context, popupWidget) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _searchFocusNode.requestFocus();
                  });
                  return Container(
                    color: AppColors.white,
                    child: popupWidget,
                  );
                },
              ),
            )
          : null,
    );
  }

  Widget _customPopupItemBuilder(
      BuildContext context, Restaurant restaurant, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: screenWidth! * 0.005),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(screenWidth! * 0.005),
              color: Colors.grey[100],
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(
          restaurant.name ?? '',
          style:
                      commonTextStyle(screenWidth! * 0.0125, FontWeight.w600),
        ),
        subtitle: Text(
          restaurant.address ?? '',
          style:
                      commonTextStyle(screenWidth! * 0.0085, FontWeight.w300),
        ),
        leading: CircleAvatar(
          backgroundImage: AssetImage(restaurant.logo ?? Images.icon),
          radius: screenWidth! * 0.0125,
        ),
      ),
    );
  }
}
