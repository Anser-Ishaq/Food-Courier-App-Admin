import 'package:flutter/material.dart';
import 'package:food_couriers_admin/models/restaurant.dart';
import 'package:food_couriers_admin/models/shift_model.dart';
import 'package:food_couriers_admin/provider/restaurant_provider.dart';
import 'package:food_couriers_admin/screens/main/body/restaurants/edit_restaurant/widgets/custom_tab_bar.dart';
import 'package:food_couriers_admin/screens/main/body/restaurants/widgets/save_button.dart';
import 'package:food_couriers_admin/utils.dart';
import 'package:provider/provider.dart';
import 'package:food_couriers_admin/constants/colors/app_colors.dart';
import 'package:food_couriers_admin/provider/shift_provider.dart';

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
  final ValueNotifier<int> _selectedShift = ValueNotifier(0);
  final int maxVisibleItems = 5;

  late ShiftProvider _shiftProvider;

  String? updateShiftId;
  int? updateShiftNo;

  @override
  void initState() {
    super.initState();
    _shiftProvider = Provider.of<ShiftProvider>(context, listen: false);
    initialize();
  }

  void initialize() async {
    await _shiftProvider.fetchShifts(widget.restaurant.shifts);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildTitle(),
          _spacer(),
          Consumer<ShiftProvider>(
            builder: (context, shiftProvider, child) {
              return _shiftProvider.shifts == null ||
                      _shiftProvider.shifts!.isEmpty
                  ? _buildShiftRowDummy(context)
                  : _shiftProvider.shifts!.length == 1
                      ? _buildShiftRow(_shiftProvider.shifts![0])
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: screenWidth! * 0.04,
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  final itemWidth = (constraints.maxWidth /
                                          (shiftProvider.shifts!.length >
                                                  maxVisibleItems
                                              ? maxVisibleItems
                                              : shiftProvider.shifts!.length)) -
                                      screenWidth! * 0.01;
                                  return ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _shiftProvider.shifts!.length,
                                    separatorBuilder: (context, index) {
                                      return SizedBox(
                                          width: screenWidth! * 0.015);
                                    },
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          _selectedShift.value = index;
                                        },
                                        child: ValueListenableBuilder(
                                          valueListenable: _selectedShift,
                                          builder: (context, value, child) {
                                            return SizedBox(
                                              width: itemWidth,
                                              child: CustomTabBar(
                                                icon: Icons.calendar_today,
                                                text: 'Shift ${index + 1}',
                                                isSelected: value == index,
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                            _spacer(),
                            ValueListenableBuilder(
                              valueListenable: _selectedShift,
                              builder: (context, value, child) {
                                return _buildShiftRow(
                                    _shiftProvider.shifts![value]);
                              },
                            ),
                          ],
                        );
            },
          ),
          _spacer(),
          _buildSaveButton(),
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
        Consumer2<RestaurantProvider, ShiftProvider>(
          builder: (context, restaurantProvider, shiftProvider, child) {
            return _buttonBox(
              title: 'Add new shift',
              isLoading:
                  shiftProvider.isLoading || restaurantProvider.isLoading,
              onTap: () async {
                final shiftID = await _shiftProvider.addNewShift();
                if (shiftID != null) {
                  restaurantProvider.updateRestaurant(
                      rid: widget.restaurant.rid!, newShiftID: shiftID);
                }
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildShiftRowDummy(BuildContext context) {
    updateShiftId = null;
    updateShiftNo = null;
    return Consumer<ShiftProvider>(
      builder: (context, shiftProvider, child) {
        final shift = shiftProvider.shift;
        return ListView.separated(
          shrinkWrap: true,
          itemCount: shiftProvider.shift.workingHours!.length,
          separatorBuilder: (context, index) =>
              SizedBox(height: screenWidth! * 0.01),
          itemBuilder: (context, index) {
            return _singleShiftRow(
              workingHours: shift.workingHours![index],
              onChanged: (newValue) =>
                  shiftProvider.onChanged(null, index, newValue),
              onStartTimeSelected: (time) =>
                  shiftProvider.setStartTime(null, index, time),
              onEndTimeSelected: (time) =>
                  shiftProvider.setEndTime(null, index, time),
            );
          },
        );
      },
    );
  }

  Widget _buildShiftRow(ShiftModel shift) {
    updateShiftId = shift.sid;
    updateShiftNo = shift.shiftNo;
    return ListView.separated(
      shrinkWrap: true,
      itemCount: shift.workingHours!.length,
      separatorBuilder: (context, index) =>
          SizedBox(height: screenWidth! * 0.01),
      itemBuilder: (context, index) {
        return _singleShiftRow(
          workingHours: shift.workingHours![index],
          onChanged: (newValue) =>
              _shiftProvider.onChanged(shift.shiftNo! - 1, index, newValue),
          onStartTimeSelected: (time) =>
              _shiftProvider.setStartTime(shift.shiftNo! - 1, index, time),
          onEndTimeSelected: (time) =>
              _shiftProvider.setEndTime(shift.shiftNo! - 1, index, time),
        );
      },
    );
  }

  Widget _singleShiftRow({
    required WorkingHoursModel workingHours,
    required void Function(bool?)? onChanged,
    required ValueChanged<TimeOfDay?> onStartTimeSelected,
    required ValueChanged<TimeOfDay?> onEndTimeSelected,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox.adaptive(
              value: workingHours.isEnabled,
              onChanged: onChanged,
              activeColor: AppColors.primary,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              splashRadius: 0.1,
            ),
            Text(
              capitalize(workingHours.day!.name),
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
              _timeField(
                controller: workingHours.isEnabled!
                    ? TextEditingController(
                        text: WorkingHoursModel.timeOfDayToString(
                            workingHours.startTime),
                      )
                    : null,
                enabled: workingHours.isEnabled,
                hintText: '08:00',
                onTimeSelected: (time) => onStartTimeSelected(time),
              ),
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
              _timeField(
                controller: workingHours.isEnabled!
                    ? TextEditingController(
                        text: WorkingHoursModel.timeOfDayToString(
                            workingHours.endTime),
                      )
                    : null,
                enabled: workingHours.isEnabled,
                hintText: '17:00',
                onTimeSelected: (time) => onEndTimeSelected(time),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _timeField({
    required TextEditingController? controller,
    required bool? enabled,
    required String hintText,
    required ValueChanged<TimeOfDay?> onTimeSelected,
  }) {
    return TextFormField(
      controller: controller,
      onTap: () async {
        final TimeOfDay? timeOfDay = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          initialEntryMode: TimePickerEntryMode.inputOnly,
        );
        if (timeOfDay != null) {
          onTimeSelected(timeOfDay);
        }
      },
      enabled: enabled,
      keyboardType: TextInputType.number,
      textAlignVertical: TextAlignVertical.center,
      style: TextStyle(
        color: enabled == true
            ? AppColors.textDarkColor
            : AppColors.silver.withAlpha(140),
        fontFamily: 'DM Sans',
        fontSize: screenWidth! * 0.0115,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColors.silver.withAlpha(140),
        ),
        isCollapsed: true,
        constraints: BoxConstraints(
          maxWidth: screenWidth! * 0.18,
          minWidth: screenWidth! * 0.18,
          maxHeight: screenWidth! * 0.03,
          minHeight: screenWidth! * 0.03,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: screenWidth! * 0.01,
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
        border: border(),
        focusedBorder: border(),
        enabledBorder: border(),
      ),
    );
  }

  Widget _buildSaveButton() {
    return Consumer2<RestaurantProvider, ShiftProvider>(
        builder: (context, restaurantProvider, shiftProvider, child) {
      return SaveButton(
        isLoading: restaurantProvider.isLoading || shiftProvider.isLoading,
        onTap: () async {
          if (updateShiftId != null && updateShiftNo != null) {
            await shiftProvider.updateShift(updateShiftId!, updateShiftNo!);
            return;
          }
          shiftProvider.shift.rid = widget.restaurant.rid;
          shiftProvider.shift.oid = widget.restaurant.oid;
          final shiftID = await shiftProvider.createShift(shiftProvider.shift);
          restaurantProvider.updateRestaurant(
            rid: widget.restaurant.rid!,
            newShiftID: shiftID,
          );
        },
      );
    });
  }

  Widget _buttonBox({
    required String title,
    required bool isLoading,
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
        child: isLoading
            ? SizedBox(
                height: screenWidth! * 0.0075,
                width: screenWidth! * 0.0075,
                child: CircularProgressIndicator(
                  strokeWidth: screenWidth! * 0.001,
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(AppColors.white),
                ),
              )
            : Text(
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

  SizedBox _spacer() => SizedBox(height: screenWidth! * 0.04);
}
