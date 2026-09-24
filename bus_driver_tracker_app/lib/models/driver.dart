import 'dart:convert';

class Driver {
  final String id;
  String name;
  String busNumber;
  String busType; // '50_seater' or 'standard'
  int capacity;
  String phone;
  double dailyWage;
  double overtimeRate;
  String status; // 'active', 'leave', 'suspended'
  String route;
  String license;
  String notes;
  bool active;

  Driver({
    required this.id,
    required this.name,
    required this.busNumber,
    this.busType = '50_seater',
    this.capacity = 50,
    required this.phone,
    required this.dailyWage,
    required this.overtimeRate,
    this.status = 'active',
    this.route = '',
    this.license = '',
    this.notes = '',
    this.active = true,
  });

  bool get is50Seater => busType == '50_seater' || capacity == 50;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'busNumber': busNumber,
      'busType': busType,
      'capacity': capacity,
      'phone': phone,
      'dailyWage': dailyWage,
      'overtimeRate': overtimeRate,
      'status': status,
      'route': route,
      'license': license,
      'notes': notes,
      'active': active,
    };
  }

  factory Driver.fromMap(Map<String, dynamic> map) {
    return Driver(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      busNumber: map['busNumber'] ?? '',
      busType: map['busType'] ?? '50_seater',
      capacity: (map['capacity'] is num) ? (map['capacity'] as num).toInt() : 50,
      phone: map['phone'] ?? '',
      dailyWage: (map['dailyWage'] is num) ? (map['dailyWage'] as num).toDouble() : 2800.0,
      overtimeRate: (map['overtimeRate'] is num) ? (map['overtimeRate'] as num).toDouble() : 450.0,
      status: map['status'] ?? 'active',
      route: map['route'] ?? '',
      license: map['license'] ?? '',
      notes: map['notes'] ?? '',
      active: map['active'] ?? true,
    );
  }

  String toJson() => json.encode(toMap());

  factory Driver.fromJson(String source) => Driver.fromMap(json.decode(source));
}
