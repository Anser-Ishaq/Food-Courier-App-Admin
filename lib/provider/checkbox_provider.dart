import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_couriers_admin/models/shift_model.dart';
import 'package:food_couriers_admin/services/database_service.dart';
import 'package:get_it/get_it.dart'; // Import the DatabaseService

class CheckboxProvider with ChangeNotifier {
  final GetIt _getIt = GetIt.instance;
  late DatabaseService _databaseService;

  ShiftModel? _selectedShift;
  bool _isLoading = false;

  ShiftModel? get selectedShift => _selectedShift;
  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  CheckboxProvider() {
    _databaseService = _getIt.get<DatabaseService>();
  }

  // List of shift
  final ShiftModel _shift = ShiftModel(
    sid: null,
    rid: null,
    oid: null,
    shiftNo: 1,
    shiftType: ShiftType.morning,
    workingHours: [
      WorkingHoursModel(
        isEnabled: false,
        day: Day.monday,
        startTime: null,
        endTime: null,
      ),
      WorkingHoursModel(
        isEnabled: false,
        day: Day.tuesday,
        startTime: null,
        endTime: null,
      ),
      WorkingHoursModel(
        isEnabled: false,
        day: Day.wednesday,
        startTime: null,
        endTime: null,
      ),
      WorkingHoursModel(
        isEnabled: false,
        day: Day.thursday,
        startTime: null,
        endTime: null,
      ),
      WorkingHoursModel(
        isEnabled: false,
        day: Day.friday,
        startTime: null,
        endTime: null,
      ),
      WorkingHoursModel(
        isEnabled: false,
        day: Day.saturday,
        startTime: null,
        endTime: null,
      ),
      WorkingHoursModel(
        isEnabled: false,
        day: Day.sunday,
        startTime: null,
        endTime: null,
      ),
    ],
  );

  ShiftModel get shift => _shift;

  // Existing methods
  void onChanged(
    String? sid,
    int indexWorkingHours,
    bool? newValue,
  ) {
    _shift.workingHours![indexWorkingHours].isEnabled = newValue;
    notifyListeners();
  }

  void setStartTime(
    String? sid,
    int indexWorkingHours,
    TimeOfDay? time,
  ) {
    _shift.workingHours![indexWorkingHours].startTime = time;
    notifyListeners();
  }

  void setEndTime(
    String? sid,
    int indexWorkingHours,
    TimeOfDay? time,
  ) {
    _shift.workingHours![indexWorkingHours].endTime = time;
    notifyListeners();
  }

  Stream<List<ShiftModel>?> fetchShifts(List<String>? shifts) {
    return _databaseService.getAllShifts(shiftIDs: shifts).handleError((e) {
      if (kDebugMode) print('Error fetching shifts: $e');
      return null;
    });
  }

  Future<String> createShift(ShiftModel shift) async {
    _setLoading(true);
    try {
      final result = await _databaseService.createShift(shift: shift);
      if (kDebugMode) print('Shift created successfully!');
      return result;
    } catch (e) {
      if (kDebugMode) print('Error creating shift: $e');
      return '';
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateShift(int index) async {
    final shift = _shift;
    if (shift.sid == null) return;

    try {
      await _databaseService.updateShift(sid: shift.sid!);
    } catch (e) {
      if (kDebugMode) print('Error updating shift: $e');
    }
  }

  Future<void> deleteShift(int index) async {
    final shift = _shift;
    if (shift.sid == null) return;

    try {
      await _databaseService.deleteShift(sid: shift.sid!);
      notifyListeners();
    } catch (e) {
      if (kDebugMode) print('Error deleting shift: $e');
    }
  }
}
