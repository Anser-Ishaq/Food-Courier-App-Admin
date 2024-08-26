import 'package:flutter/material.dart';
import 'package:food_couriers_admin/constants/colors/app_colors.dart';
import 'package:food_couriers_admin/utils.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.screen,
    required this.imageURL,
    required this.userName,
  });

  final String screen;
  final String imageURL;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth! * 0.01, vertical: screenWidth! * 0.0165),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pages / $screen',
            style: TextStyle(
              color: const Color(0xFF707EAE),
              fontFamily: 'DM Sans',
              fontSize: screenWidth! * 0.007,
              fontWeight: FontWeight.w500,
              height: 1,
              letterSpacing: -0.02 * screenWidth! * 0.007,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                screen.toUpperCase(),
                style: TextStyle(
                  color: AppColors.textDarkColor,
                  fontFamily: 'DM Sans',
                  fontSize: screenWidth! * 0.015,
                  fontWeight: FontWeight.w700,
                  height: 1.1,
                  letterSpacing: -0.03 * screenWidth! * 0.015,
                ),
              ),
              Container(
                padding: EdgeInsets.all(screenWidth! * 0.0025),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(screenWidth! * 0.1),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(14, 17),
                      blurRadius: 40,
                      spreadRadius: 4,
                      color: const Color(0xFF7090B0).withOpacity(0.08),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: screenWidth! * 0.025,
                      height: screenWidth! * 0.025,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(imageURL),
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth! * 0.005),
                    Text(
                      userName,
                      style: TextStyle(
                        color: AppColors.textDarkColor,
                        fontFamily: 'DM Sans',
                        fontSize: screenWidth! * 0.0125,
                        fontWeight: FontWeight.w400,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(width: 5),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: screenWidth! * 0.008),
        ],
      ),
    );
  }
}
