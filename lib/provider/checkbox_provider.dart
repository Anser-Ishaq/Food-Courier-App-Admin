import 'package:flutter/material.dart';

class CheckboxProvider with ChangeNotifier {
  final Map<String, List<bool>> _isCheckedMap = {
    'Monday': [false],
    'Tuesday': [false],
    'Wednesday': [false],
    'Thursday': [false],
    'Friday': [false],
    'Saturday': [false],
    'Sunday': [false],
  };

  Map<String, List<bool>> get isCheckedMap => _isCheckedMap;

  void onChanged(String day, int index, bool? value) {
    _isCheckedMap[day]?[index] = value ?? false;
    notifyListeners();
  }

  void addShift(String day) {
    _isCheckedMap[day]?.add(false);
    notifyListeners();
  }
}
