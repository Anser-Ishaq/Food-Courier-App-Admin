import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_couriers_admin/models/models.dart';
import 'package:food_couriers_admin/provider/provider.dart';
import 'package:food_couriers_admin/res/colors/app_colors.dart';
import 'package:food_couriers_admin/res/utils/utils.dart';
import 'package:food_couriers_admin/screens/main/body/restaurants/edit_restaurant/widgets/widgets.dart';
import 'package:food_couriers_admin/screens/main/body/restaurants/widgets/widgets.dart';
import 'package:provider/provider.dart';

class Plans extends StatefulWidget {
  const Plans({
    super.key,
    required this.restaurant,
  });

  final Restaurant restaurant;

  @override
  State<Plans> createState() => _PlansState();
}

class _PlansState extends State<Plans> {
  final FocusNode _searchFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(),
        _spacer(),
        _spacer(),
        _spacer(),
        _buildPlanTitle(),
        _spacer(),
        _buildPlanSelector(),
        _spacer(),
        _spacer(),
        _spacer(),
        _spacer(),
        _spacer(),
        _spacer(),
        _buildSaveButton(),
      ],
    );
  }

  Widget _buildTitle() {
    return const CustomTitleRow(
      title: 'Subscription plan',
      showButton1: false,
      showButton2: false,
    );
  }

  Widget _buildPlanTitle() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: screenWidth! * 0.05),
      child: Text(
        'Current plan',
        style: TextStyle(
          color: AppColors.textDarkColor.withAlpha(180),
          fontFamily: 'DM Sans',
          fontSize: screenWidth! * 0.0135,
          fontWeight: FontWeight.w500,
          height: 1.1,
          letterSpacing: screenWidth! * 0.0125 * -0.01,
          wordSpacing: screenWidth! * 0.0125 * 0.05,
        ),
      ),
    );
  }

  Widget _buildPlanSelector() {
    return Container(
      width: screenWidth! * 0.15,
      margin: EdgeInsets.symmetric(horizontal: screenWidth! * 0.05),
      child: DropdownSearch<PlanType>(
        items: PlanType.values,
        itemAsString: (PlanType plan) => plan.name,
        compareFn: (PlanType? item, PlanType? selectedItem) {
          return item?.name == selectedItem?.name;
        },
        onChanged: (PlanType? value) {
          if (value != null) {
            widget.restaurant.plan = value;
          }
        },
        selectedItem: widget.restaurant.plan,
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
            capitalize(selectedItem!.name),
            style: commonTextStyle(screenWidth! * 0.011, FontWeight.w600),
          );
        },
        popupProps: PopupProps.menu(
          fit: FlexFit.loose,
          // isFilterOnline: true,
          showSelectedItems: true,
          // showSearchBox: true,
          searchDelay: const Duration(milliseconds: 50),
          itemBuilder: _customPopupItemBuilder,
          containerBuilder: (context, popupWidget) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _searchFocusNode.requestFocus();
            });
            return Container(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth! * 0.005,
                  vertical: screenWidth! * 0.003),
              color: AppColors.white,
              child: popupWidget,
            );
          },
        ),
      ),
    );
  }

  Widget _customPopupItemBuilder(
      BuildContext context, PlanType plan, bool isSelected) {
    return Container(
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(screenWidth! * 0.005),
              color: Colors.grey[100],
            ),
      child: ListTile(
        selected: isSelected,
        minTileHeight: 35,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        title: Text(
          capitalize(plan.name),
          style: commonTextStyle(screenWidth! * 0.0115, FontWeight.w500),
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return Consumer<RestaurantProvider>(
      builder: (context, restaurantProvider, child) {
        return SaveButton(
          isLoading: restaurantProvider.isLoading,
          onTap: () {
            if (kDebugMode) {
              print(widget.restaurant.plan!.name);
            }
            restaurantProvider.updateRestaurant(rid: widget.restaurant.rid!, newPlan: widget.restaurant.plan);
          },
          buttonText: 'Save',
          gradient: AppColors.gradientGreen,
        );
      }
    );
  }

  SizedBox _spacer() => SizedBox(height: screenWidth! * 0.01);
}
