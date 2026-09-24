import 'dart:convert';

class DayAttendance {
  String status; // 'work', 'rest', 'absence', 'leave'
  double overtime;
  String trips;
  String notes;

  DayAttendance({
    this.status = 'work',
    this.overtime = 0.0,
    this.trips = '',
    this.notes = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'overtime': overtime,
      'trips': trips,
      'notes': notes,
    };
  }

  factory DayAttendance.fromMap(Map<String, dynamic> map) {
    return DayAttendance(
      status: map['status'] ?? 'work',
      overtime: (map['overtime'] is num) ? (map['overtime'] as num).toDouble() : 0.0,
      trips: map['trips'] ?? '',
      notes: map['notes'] ?? '',
    );
  }
}

class MonthAttendanceRecord {
  Map<int, DayAttendance> days;
  double bonus;
  double deduction;

  MonthAttendanceRecord({
    Map<int, DayAttendance>? days,
    this.bonus = 0.0,
    this.deduction = 0.0,
  }) : days = days ?? {};

  Map<String, dynamic> toMap() {
    return {
      'days': days.map((key, value) => MapEntry(key.toString(), value.toMap())),
      'bonus': bonus,
      'deduction': deduction,
    };
  }

  factory MonthAttendanceRecord.fromMap(Map<String, dynamic> map) {
    final daysMap = <int, DayAttendance>{};
    if (map['days'] is Map) {
      (map['days'] as Map).forEach((k, v) {
        final dayNum = int.tryParse(k.toString());
        if (dayNum != null && v is Map) {
          daysMap[dayNum] = DayAttendance.fromMap(Map<String, dynamic>.from(v));
        }
      });
    }
    return MonthAttendanceRecord(
      days: daysMap,
      bonus: (map['bonus'] is num) ? (map['bonus'] as num).toDouble() : 0.0,
      deduction: (map['deduction'] is num) ? (map['deduction'] as num).toDouble() : 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory MonthAttendanceRecord.fromJson(String source) =>
      MonthAttendanceRecord.fromMap(json.decode(source));
}
