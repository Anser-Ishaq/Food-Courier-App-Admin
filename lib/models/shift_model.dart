import 'package:flutter/material.dart';

enum Day {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}

class WorkingHoursModel {
  bool? isEnabled;
  Day? day;
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  WorkingHoursModel({
    required this.isEnabled,
    required this.day,
    required this.startTime,
    required this.endTime,
  });

  static String timeOfDayToString(TimeOfDay? time) {
    if (time == null) return '';
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  static TimeOfDay stringToTimeOfDay(String timeString) {
    final parts = timeString.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }

  factory WorkingHoursModel.fromJson(Map<String, dynamic> json) {
    return WorkingHoursModel(
      isEnabled: json['isEnabled'],
      day: Day.values.byName(json['day']),
      startTime: json['startTime'] != null
          ? stringToTimeOfDay(json['startTime'])
          : null,
      endTime:
          json['endTime'] != null ? stringToTimeOfDay(json['endTime']) : null,

    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isEnabled'] = isEnabled;
    data['day'] = day!.name;
    data['startTime'] = startTime != null ? timeOfDayToString(startTime) : null;
    data['endTime'] = endTime != null ? timeOfDayToString(endTime) : null;
    return data;
  }
}

class ShiftModel {
  String? sid;
  String? rid;
  String? oid;
  List<WorkingHoursModel>? workingHours;

  ShiftModel({
    required this.sid,
    required this.rid,
    required this.oid,
    required this.workingHours,
  });

  factory ShiftModel.fromJson(Map<String, dynamic> json) {
    return ShiftModel(
      sid: json['sid'],
      rid: json['rid'],
      oid: json['oid'],
      workingHours: (json['workingHours'] as List)
          .map((shift) => WorkingHoursModel.fromJson(shift))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sid'] = sid;
    data['rid'] = rid;
    data['oid'] = oid;
    data['workingHours'] =
        workingHours?.map((shift) => shift.toJson()).toList();
    return data;
  }

  String getDescription() {
    final descriptions = workingHours
        ?.where((wh) => wh.isEnabled!)
        .map((wh) => '${wh.day}: ${wh.startTime != null ? WorkingHoursModel.timeOfDayToString(wh.startTime) : 'N/A'} - ${wh.endTime != null ? WorkingHoursModel.timeOfDayToString(wh.endTime) : 'N/A'}')
        .join(', ');
    return descriptions!.isEmpty ? 'No shifts scheduled' : descriptions;
  }

    ShiftModel copyWith({
    String? sid,
    String? rid,
    String? oid,
    List<WorkingHoursModel>? workingHours,
  }) {
    return ShiftModel(
      sid: sid ?? this.sid,
      rid: rid ?? this.rid,
      oid: oid ?? this.oid,
      workingHours: workingHours ?? this.workingHours,
    );
  }
}
