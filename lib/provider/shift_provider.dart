import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_couriers_admin/models/shift_model.dart';
import 'package:food_couriers_admin/services/database_service.dart';
import 'package:get_it/get_it.dart';

class ShiftProvider with ChangeNotifier {
  final GetIt _getIt = GetIt.instance;
  late DatabaseService _databaseService;

  ShiftModel? _selectedShift;
  bool _isLoading = false;
  List<ShiftModel>? _shifts;

  ShiftModel? get selectedShift => _selectedShift;
  bool get isLoading => _isLoading;
  List<ShiftModel>? get shifts => _shifts;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  ShiftProvider() {
    _databaseService = _getIt.get<DatabaseService>();
  }

  // List of shift
  final ShiftModel _shift = ShiftModel(
    sid: null,
    rid: null,
    oid: null,
    shiftNo: 1,
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

  // Existing methods for handling shifts
  void onChanged(
    int? indexShift,
    int indexWorkingHours,
    bool? newValue,
  ) {
    indexShift != null
        ? _shifts![indexShift].workingHours![indexWorkingHours].isEnabled =
            newValue
        : _shift.workingHours![indexWorkingHours].isEnabled = newValue;
    notifyListeners();
  }

  void setStartTime(
    int? indexShift,
    int indexWorkingHours,
    TimeOfDay? time,
  ) {
    indexShift != null
        ? _shifts![indexShift].workingHours![indexWorkingHours].startTime = time
        : _shift.workingHours![indexWorkingHours].startTime = time;
    notifyListeners();
  }

  void setEndTime(
    int? indexShift,
    int indexWorkingHours,
    TimeOfDay? time,
  ) {
    indexShift != null
        ? _shifts![indexShift].workingHours![indexWorkingHours].endTime = time
        : _shift.workingHours![indexWorkingHours].endTime = time;
    notifyListeners();
  }

  // Fetch shifts using Future (integrates with getAllShifts)
  Future<void> fetchShifts(List<String>? shifts) async {
    // _setLoading(true);
    try {
      _shifts = await _databaseService.getAllShifts(shiftIDs: shifts);
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching shifts: $e');
      }
      _shifts = null;
    } finally {
      // _setLoading(false);
    }
  }

    Future<String?> addNewShift() async {
    _setLoading(true);
    try {
      final newShift = ShiftModel(
        sid: null,
        rid: _shifts![0].rid,
        oid: _shifts![0].oid,
        shiftNo: (_shifts?.length ?? 0) + 1,
        workingHours: _shift.workingHours,
      );

      final newShiftId = await _databaseService.createShift(shift: newShift);

      if (_shifts != null) {
        _shifts!.add(newShift.copyWith(sid: newShiftId));
        notifyListeners();
      }

      if (kDebugMode) print('New shift added with ID: $newShiftId');
      return newShiftId;
    } catch (e) {
      if (kDebugMode) print('Error adding new shift: $e');
      return null;
    } finally {
      _setLoading(false);
    }
  }

  // Create shift
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

  // Update shift
  Future<void> updateShift(String sid,int shiftNo) async {
    _setLoading(true);
    try {
      final shift = _shifts![shiftNo - 1];
      await _databaseService.updateShift(sid: shift.sid!, shift: shift);
    } catch (e) {
      if (kDebugMode) print('Error updating shift: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Delete shift
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
