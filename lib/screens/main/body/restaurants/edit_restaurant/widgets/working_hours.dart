import 'package:flutter/material.dart';
import 'package:food_couriers_admin/models/models.dart';
import 'package:food_couriers_admin/provider/provider.dart';
import 'package:food_couriers_admin/res/utils/utils.dart';
import 'package:food_couriers_admin/screens/main/body/restaurants/edit_restaurant/widgets/widgets.dart';
import 'package:food_couriers_admin/screens/main/body/restaurants/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:food_couriers_admin/res/colors/app_colors.dart';

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
  final ValueNotifier<bool> _isDeletingShift = ValueNotifier(false);
  final int maxVisibleItems = 5;

  late ShiftProvider _shiftProvider;

  String? updateShiftId;
  int? updateShiftIndex;

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
              return shiftProvider.shifts == null ||
                      shiftProvider.shifts!.isEmpty
                  ? _buildShiftRowDummy(context)
                  : shiftProvider.shifts!.length == 1
                      ? _buildShiftRow(shiftProvider.shifts![0], 0)
                      : ValueListenableBuilder(
                          valueListenable: _isDeletingShift,
                          builder: (context, value, child) {
                            return value
                                ? const CustomProgressIndicator()
                                : Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        height: screenWidth! * 0.04,
                                        child: LayoutBuilder(
                                          builder: (context, constraints) {
                                            final itemWidth =
                                                (constraints.maxWidth /
                                                        (shiftProvider.shifts!
                                                                    .length >
                                                                maxVisibleItems
                                                            ? maxVisibleItems
                                                            : shiftProvider
                                                                .shifts!
                                                                .length)) -
                                                    screenWidth! * 0.01;
                                            return ListView.separated(
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  shiftProvider.shifts!.length,
                                              separatorBuilder:
                                                  (context, index) {
                                                return SizedBox(
                                                    width:
                                                        screenWidth! * 0.015);
                                              },
                                              itemBuilder: (context, index) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    _selectedShift.value =
                                                        index;
                                                  },
                                                  child: ValueListenableBuilder(
                                                    valueListenable:
                                                        _selectedShift,
                                                    builder: (context, value,
                                                        child) {
                                                      return SizedBox(
                                                        width: itemWidth,
                                                        child: CustomTabBar(
                                                          icon: Icons
                                                              .calendar_today,
                                                          text:
                                                              'Shift ${index + 1}',
                                                          isSelected:
                                                              value == index,
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
                                              _shiftProvider.shifts![value],
                                              value);
                                        },
                                      ),
                                    ],
                                  );
                          },
                        );
            },
          ),
          _spacer(),
          Consumer<ShiftProvider>(
            builder: (context, shiftProvider, child) {
              return shiftProvider.shifts != null &&
                      shiftProvider.shifts!.length > 1
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildSaveButton(isDelete: true),
                        SizedBox(width: screenWidth! * 0.015),
                        _buildSaveButton(isDelete: false),
                      ],
                    )
                  : _buildSaveButton(isDelete: false);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return CustomTitleRow(
      title: 'Working Hours',
      showButton1: true,
      showButton2: false,
      button1: Consumer2<RestaurantProvider, ShiftProvider>(
        builder: (context, restaurantProvider, shiftProvider, child) {
          return ButtonBox(
            title: 'Add new shift',
            isLoading: shiftProvider.isLoading || restaurantProvider.isLoading,
            onTap: () async {
              final shiftID = await _shiftProvider.addNewShift();
              if (shiftID != null) {
                if (!widget.restaurant.shifts!.contains(shiftID)) {
                  widget.restaurant.shifts!.add(shiftID);
                }
                restaurantProvider.updateRestaurant(
                  rid: widget.restaurant.rid!,
                  newShiftID: shiftID,
                );
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildShiftRowDummy(BuildContext context) {
    updateShiftId = null;
    updateShiftIndex = null;
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

  Widget _buildShiftRow(ShiftModel shift, int indexShift) {
    updateShiftId = shift.sid;
    updateShiftIndex = indexShift;
    return ListView.separated(
      shrinkWrap: true,
      itemCount: shift.workingHours!.length,
      separatorBuilder: (context, index) =>
          SizedBox(height: screenWidth! * 0.01),
      itemBuilder: (context, index) {
        return _singleShiftRow(
          workingHours: shift.workingHours![index],
          onChanged: (newValue) =>
              _shiftProvider.onChanged(indexShift, index, newValue),
          onStartTimeSelected: (time) =>
              _shiftProvider.setStartTime(indexShift, index, time),
          onEndTimeSelected: (time) =>
              _shiftProvider.setEndTime(indexShift, index, time),
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

  Widget _buildSaveButton({required bool isDelete}) {
    return Consumer2<RestaurantProvider, ShiftProvider>(
      builder: (context, restaurantProvider, shiftProvider, child) {
        return SaveButton(
          buttonText: isDelete ? 'Delete' : 'Save',
          gradient:
              isDelete ? AppColors.gradientPrimary : AppColors.gradientGreen,
          isLoading: isDelete
              ? restaurantProvider.isLoading || shiftProvider.isDeleting
              : restaurantProvider.isLoading || shiftProvider.isLoading,
          onTap: isDelete
              ? () async {
                  _isDeletingShift.value = true;
                  final deleteableShiftID = updateShiftId!;
                  final deleteableShiftIndex = updateShiftIndex!;
                  await shiftProvider.deleteShift(
                      deleteableShiftID, deleteableShiftIndex);

                  final shifts = widget.restaurant.shifts!;
                  shifts.remove(deleteableShiftID);
                  widget.restaurant.shifts = shifts;
                  await restaurantProvider.updateRestaurant(
                      rid: widget.restaurant.rid!,
                      oldShiftID: deleteableShiftID);
                  if (_selectedShift.value >= shiftProvider.shifts!.length) {
                    _selectedShift.value = 0;
                  }
                  await shiftProvider.fetchShifts(widget.restaurant.shifts);
                  _isDeletingShift.value = false;
                }
              : () async {
                  if (updateShiftId != null && updateShiftIndex != null) {
                    await shiftProvider.updateShift(
                        updateShiftId!, updateShiftIndex!);
                    shiftProvider.fetchShifts(widget.restaurant.shifts);
                    return;
                  }
                  shiftProvider.shift.rid = widget.restaurant.rid;
                  shiftProvider.shift.oid = widget.restaurant.oid;
                  final shiftID =
                      await shiftProvider.createShift(shiftProvider.shift);
                  if (!widget.restaurant.shifts!.contains(shiftID)) {
                    widget.restaurant.shifts!.add(shiftID);
                  }
                  restaurantProvider.updateRestaurant(
                    rid: widget.restaurant.rid!,
                    newShiftID: shiftID,
                  );
                  shiftProvider.fetchShifts(widget.restaurant.shifts);
                },
        );
      },
    );
  }

  SizedBox _spacer() => SizedBox(height: screenWidth! * 0.04);
}
