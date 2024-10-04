import 'package:flutter/material.dart';
import 'package:food_couriers_admin/res/colors/app_colors.dart';


class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key, required this.textEditingController, required this.focusNode});

  final TextEditingController textEditingController;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 32),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        gradient: AppColors.gradientSecondary,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.search_rounded,
            size: 20,
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: TextField(
              controller: textEditingController,
              focusNode: focusNode,
              style: const TextStyle(fontSize: 16),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search',
                hintStyle: TextStyle(
                  fontFamily: 'Poppins',
                  color: AppColors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.01,
                ),
              ),
              expands: true,
              maxLines: null,
            ),
          ),
        ],
      ),
    );
  }
}
