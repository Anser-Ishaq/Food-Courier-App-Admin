import 'package:flutter/material.dart';
import 'package:food_couriers_admin/models/restaurant.dart';
import 'package:food_couriers_admin/models/shift_model.dart';
import 'package:food_couriers_admin/screens/main/body/restaurants/widgets/save_button.dart';
import 'package:food_couriers_admin/utils.dart';
import 'package:provider/provider.dart';
import 'package:food_couriers_admin/constants/colors/app_colors.dart';
import 'package:food_couriers_admin/provider/checkbox_provider.dart';

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

  late CheckboxProvider _checkboxProvider;

  @override
  void initState() {
    super.initState();
    _checkboxProvider = Provider.of<CheckboxProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    print('Build');
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildTitle(),
          _spacer(),
          _spacer(),
          StreamBuilder(
            stream: _checkboxProvider.fetchShifts(widget.restaurant.shifts),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    strokeWidth: screenWidth! * 0.0025,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(AppColors.primary),
                  ),
                );
              }

              // if (snapshot.data!.isEmpty) {
              //   print('No shifts found');
              //   return _buildShiftRowDummy(context);
              // }

              if (snapshot.data!.length == 1) {
                final shift = snapshot.data![0];
                return _buildShiftRow(shift);
              }

              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final shift = snapshot.data![index];
                  return Container();
                },
              );
            },
          ),
          _spacer(),
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
        _buttonBox(
          title: 'Add new shift',
          onTap: () {
            // _checkboxProvider.addShift();
          },
        ),
      ],
    );
  }

  Widget _buildShiftRowDummy(BuildContext context) {
    return Consumer<CheckboxProvider>(
      builder: (context, checkboxProvider, child) {
        final shift = checkboxProvider.shift;
        return ListView.separated(
          shrinkWrap: true,
          itemCount: checkboxProvider.shift.workingHours!.length,
          separatorBuilder: (context, index) =>
              SizedBox(height: screenWidth! * 0.01),
          itemBuilder: (context, index) {
            return _singleShiftRow(
              workingHours: shift.workingHours![index],
              onChanged: (newValue) =>
                  checkboxProvider.onChanged(null, index, newValue),
              onStartTimeSelected: (time) =>
                  checkboxProvider.setStartTime(null, index, time),
              onEndTimeSelected: (time) =>
                  checkboxProvider.setEndTime(null, index, time),
            );
          },
        );
      },
    );
  }

  Widget _buildShiftRow(ShiftModel shift) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: shift.workingHours!.length,
      separatorBuilder: (context, index) =>
          SizedBox(height: screenWidth! * 0.01),
      itemBuilder: (context, index) {
        return _singleShiftRow(
          workingHours: shift.workingHours![index],
          onChanged: (newValue) =>
              _checkboxProvider.onChanged(shift.sid!, index, newValue),
          onStartTimeSelected: (time) =>
              _checkboxProvider.setStartTime(shift.sid!, index, time),
          onEndTimeSelected: (time) =>
              _checkboxProvider.setEndTime(shift.sid!, index, time),
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
        border: _border(),
        focusedBorder: _border(),
        enabledBorder: _border(),
      ),
    );
  }

  Widget _buildSaveButton() {
    return SaveButton(
      isLoading: false,
      onTap: () {},
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

  OutlineInputBorder _border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(screenWidth! * 0.005),
      borderSide: BorderSide(
        color: AppColors.primary.withAlpha(200),
      ),
    );
  }

  SizedBox _spacer() => SizedBox(height: screenWidth! * 0.02);
}
