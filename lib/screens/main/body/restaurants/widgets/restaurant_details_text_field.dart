import 'package:flutter/material.dart';
import 'package:food_couriers_admin/components/hover.dart';
import 'package:food_couriers_admin/constants/colors/app_colors.dart';
import 'package:food_couriers_admin/utils.dart';

class RestaurantDetailsTextField extends StatefulWidget {
  const RestaurantDetailsTextField({
    super.key,
    required this.title,
    this.controller,
    this.onSaved,
    this.showIncrementDecrement = false,
  });

  final String title;
  final TextEditingController? controller;
  final void Function(String?)? onSaved;
  final bool showIncrementDecrement;

  @override
  State<RestaurantDetailsTextField> createState() =>
      _RestaurantDetailsTextFieldState();
}

class _RestaurantDetailsTextFieldState
    extends State<RestaurantDetailsTextField> {
  int value = 0;

  @override
  void initState() {
    super.initState();
    widget.showIncrementDecrement
        ? value = int.tryParse(widget.controller!.text)!
        : value = 1;
  }

  void _increment() {
    setState(() {
      value++;
      widget.controller!.text = value.toString();
    });
  }

  void _decrement() {
    if (value > 0) {
      setState(() {
        value--;
        widget.controller!.text = value.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            color: AppColors.textDarkColor.withAlpha(245),
            fontFamily: 'DM Sans',
            fontSize: screenWidth! * 0.0115,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: screenWidth! * 0.0075),
        Hover(builder: (hover) {
          return TextFormField(
            controller: widget.controller,
            onSaved: widget.onSaved,
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: AppColors.textDarkColor,
              fontFamily: 'DM Sans',
              fontSize: screenWidth! * 0.0115,
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              hintText: widget.title,
              hintStyle: TextStyle(
                color: AppColors.silver.withAlpha(140),
              ),
              // isCollapsed: true,
              border: border(),
              focusedBorder: border(),
              enabledBorder: border(),
              constraints: BoxConstraints(
                maxHeight: screenWidth! * 0.03,
                minHeight: screenWidth! * 0.03,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: screenWidth! * 0.01,
                vertical: screenWidth! * 0.01,
              ),
              suffixIcon: widget.showIncrementDecrement && hover
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildIncrementDecrementButton(isIncrement: true),
                        _buildIncrementDecrementButton(isIncrement: false),
                      ],
                    )
                  : null,
            ),
          );
        }),
      ],
    );
  }

  Widget _buildIncrementDecrementButton({
    required bool isIncrement,
  }) {
    return Hover(builder: (hover) {
      return GestureDetector(
        onTap: isIncrement ? _increment : _decrement,
        child: Container(
          alignment: Alignment.center,
          width: screenWidth! * 0.015,
          decoration: BoxDecoration(
            color: hover
                ? AppColors.silver.withAlpha(150)
                : AppColors.silver.withAlpha(80),
            borderRadius: BorderRadius.circular(screenWidth! * 0.001),
          ),
          child: Icon(
            isIncrement ? Icons.arrow_drop_up : Icons.arrow_drop_down,
            color: AppColors.textDarkColor,
            size: screenWidth! * 0.0085,
            fill: 1,
          ),
        ),
      );
    });
  }

}
