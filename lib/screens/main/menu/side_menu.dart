import 'package:flutter/material.dart';
import 'package:food_couriers_admin/models/models.dart';
import 'package:food_couriers_admin/res/colors/app_colors.dart';
import 'package:food_couriers_admin/res/images/images.dart';
import 'package:food_couriers_admin/res/utils/utils.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    super.key,
    required this.selectedIndex,
    required this.sideMenuItem,
    required this.onTapSideMenuItem,
    required this.version,
    required this.versionDateTime,
  });

  final int selectedIndex;
  final List<SideMenuModel> sideMenuItem;
  final void Function(int) onTapSideMenuItem;
  final String version;
  final String versionDateTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: screenWidth! * 0.025,
        ),
        Container(
          margin: EdgeInsets.only(left: screenWidth! * 0.012),
          child: Row(
            children: [
              Container(
                width: screenWidth! * 0.027,
                height: screenWidth! * 0.027,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Images.icon),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(width: screenWidth! * 0.006),
              Text(
                'Food Couriers',
                style: TextStyle(
                  color: AppColors.primary,
                  fontFamily: 'DM Sans',
                  fontSize: screenWidth! * 0.015,
                  fontWeight: FontWeight.w700,
                  height: 1.1,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: screenWidth! * 0.015,
        ),
        Divider(
          color: AppColors.silver.withOpacity(0.5),
          height: screenHeight! * 0.01,
          thickness: 1,
        ),
        SizedBox(
          height: screenHeight! * 0.01,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: sideMenuItem.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  onTapSideMenuItem(index);
                },
                child: Container(
                  margin: EdgeInsets.only(left: screenWidth! * 0.015),
                  padding: EdgeInsets.symmetric(vertical: screenWidth! * 0.005),
                  child: Row(
                    children: [
                      Icon(
                        sideMenuItem[index].icon,
                        size: screenWidth! * 0.015,
                        color: selectedIndex == index
                            ? AppColors.primary
                            : AppColors.silver.withOpacity(0.5),
                      ),
                      SizedBox(
                        width: screenWidth! * 0.01,
                      ),
                      Text(
                        sideMenuItem[index].label!,
                        style: TextStyle(
                          color: selectedIndex == index
                              ? AppColors.black
                              : AppColors.silver.withOpacity(0.5),
                          fontFamily: 'DM Sans',
                          fontSize: screenWidth! * 0.01,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Divider(
          color: AppColors.silver.withOpacity(0.5),
          height: screenHeight! * 0.01,
          thickness: 1,
        ),
        SizedBox(
          height: screenHeight! * 0.012,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(left: screenWidth! * 0.015),
          child: Text(
            version,
            style: TextStyle(
              color: AppColors.silver.withOpacity(0.5),
              fontSize: screenWidth! * 0.009,
              fontWeight: FontWeight.w500,
              height: 1.1,
              letterSpacing: -0.02 * screenWidth! * 0.009,
            ),
          ),
        ),
        SizedBox(
          height: screenHeight! * 0.005,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(left: screenWidth! * 0.015),
          child: Text(
            versionDateTime,
            style: TextStyle(
              fontSize: screenWidth! * 0.006,
              fontWeight: FontWeight.w300,
              height: 1,
              letterSpacing: -0.02 * screenWidth! * 0.006,
            ),
          ),
        ),
        SizedBox(
          height: screenHeight! * 0.012,
        ),
      ],
    );
  }
}
