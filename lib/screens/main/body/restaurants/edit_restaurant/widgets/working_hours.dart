import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_couriers_admin/constants/colors/app_colors.dart';
import 'package:food_couriers_admin/provider/checkbox_provider.dart';
import 'package:food_couriers_admin/utils.dart';
import 'package:food_couriers_admin/models/restaurant.dart';

class WorkingHours extends StatefulWidget {
  const WorkingHours({
    super.key,
    required this.restaurant,
  });

  final Restaurant restaurant;

  @override
  State<WorkingHours> createState() => _WorkingHoursState();
}

class _WorkingHoursState extends State<WorkingHours> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildTitle(),
          _spacer(),
          Expanded(
            child: ListView.separated(
              itemCount: 7,
              separatorBuilder: (context, index) {
                return _spacer();
              },
              itemBuilder: (context, index) {
                final dayNames = [
                  'Monday',
                  'Tuesday',
                  'Wednesday',
                  'Thursday',
                  'Friday',
                  'Saturday',
                  'Sunday'
                ];
                final day = dayNames[index];
                return _buildCheckboxRow(
                  context,
                  index,
                  day,
                  '08:00',
                  '18:00',
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Working Hours',
          style: TextStyle(
            color: AppColors.textDarkColor,
            fontFamily: 'DM Sans',
            fontSize: screenWidth! * 0.0135,
            fontWeight: FontWeight.w600,
            height: 1.1,
            letterSpacing: screenWidth! * 0.0125 * -0.01,
            wordSpacing: screenWidth! * 0.0125 * 0.05,
          ),
        ),
        _buttonBox(
          title: 'Add new shift',
          onTap: () {
            // Add shift logic here
          },
        ),
      ],
    );
  }

  Widget _buildCheckboxRow(BuildContext context, int index, String day,
      String startTime, String endTime) {
    return Consumer<CheckboxProvider>(
      builder: (context, checkboxProvider, child) {
        return _singleDayShiftRow(
          value: checkboxProvider.isCheckedMap[day]![0],
          onChanged: (newValue) => checkboxProvider.onChanged(day, 0, newValue),
          day: day,
          startTime: startTime,
          endTime: endTime,
        );
      },
    );
  }

  Widget _singleDayShiftRow({
    required bool? value,
    required void Function(bool?)? onChanged,
    required String day,
    required String startTime,
    required String endTime,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox.adaptive(
              value: value,
              onChanged: onChanged,
              activeColor: AppColors.primary,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              splashRadius: 0.1,
            ),
            Text(
              day,
              style: TextStyle(
                color: AppColors.textDarkColor,
                fontFamily: 'DM Sans',
                fontSize: screenWidth! * 0.0115,
                fontWeight: FontWeight.w400,
                height: 1.1,
                letterSpacing: screenWidth! * 0.0125 * -0.01,
                wordSpacing: screenWidth! * 0.0125 * 0.05,
              ),
            ),
          ],
        ),
        SizedBox(
          width: screenWidth! * 0.5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _timeField(),
              Text(
                ' - ',
                style: TextStyle(
                  color: AppColors.textDarkColor,
                  fontFamily: 'DM Sans',
                  fontSize: screenWidth! * 0.02,
                  fontWeight: FontWeight.w600,
                  height: 1.1,
                  letterSpacing: screenWidth! * 0.0125 * -0.01,
                  wordSpacing: screenWidth! * 0.0125 * 0.05,
                ),
              ),
              _timeField(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buttonBox({
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: screenWidth! * 0.004),
        padding: EdgeInsets.all(screenWidth! * 0.007),
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(screenWidth! * 0.005),
          border: Border.all(
            color: AppColors.secondary,
            width: screenWidth! * 0.001,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: AppColors.white,
            fontFamily: 'DM Sans',
            fontSize: screenWidth! * 0.01,
            fontWeight: FontWeight.w600,
            height: 1.1,
            letterSpacing: -0.03 * screenWidth! * 0.01,
          ),
        ),
      ),
    );
  }

  Widget _timeField() {
    return TextFormField(
      // controller: widget.controller,
      // onSaved: widget.onSaved,
      keyboardType: TextInputType.number,
      textAlignVertical: TextAlignVertical.center,
      style: TextStyle(
        color: AppColors.textDarkColor,
        fontFamily: 'DM Sans',
        fontSize: screenWidth! * 0.0115,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        hintText: '08:00',
        hintStyle: TextStyle(
          color: AppColors.silver.withAlpha(140),
        ),
        isCollapsed: true,
        border: _border(),
        focusedBorder: _border(),
        enabledBorder: _border(),
        constraints: BoxConstraints(
          maxWidth: screenWidth! * 0.18,
          minWidth: screenWidth! * 0.18,
          maxHeight: screenWidth! * 0.03,
          minHeight: screenWidth! * 0.03,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: screenWidth! * 0.01,
          vertical: screenWidth! * 0.01,
        ),
        prefixIcon: SizedBox(
          width: screenWidth! * 0.015,
          height: screenHeight! * 0.015,
          child: Icon(
            Icons.access_time_filled_rounded,
            color: AppColors.silver.withAlpha(150),
            size: screenWidth! * 0.0145,
          ),
        ),
        // isDense: true,
      ),
    );
  }

  OutlineInputBorder _border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(screenWidth! * 0.005),
      borderSide: BorderSide(color: AppColors.primary.withOpacity(0.8)),
      gapPadding: 0,
    );
  }

  SizedBox _spacer() {
    return SizedBox(height: screenWidth! * 0.03);
  }
}
