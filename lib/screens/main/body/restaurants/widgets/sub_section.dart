import 'package:flutter/material.dart';
import 'package:food_couriers_admin/constants/colors/app_colors.dart';
import 'package:food_couriers_admin/utils.dart';

class SubSection extends StatelessWidget {
  const SubSection({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: screenWidth! * 0.01),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: AppColors.silver.withAlpha(200),
              fontFamily: 'DM Sans',
              fontSize: screenWidth! * 0.013,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: screenHeight! * 0.03),
          Flexible(
            child: Container(
              margin: EdgeInsets.only(left: screenWidth! * 0.01),
              child: child,
            ),
          )
        ],
      ),
    );
  }
}
