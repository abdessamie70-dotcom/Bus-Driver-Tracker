import 'dart:convert';

class Trip {
  final String id;
  String driverId;
  String busNumber;
  bool is50Seater;
  int busCapacity;
  String date; // YYYY-MM-DD
  String route;
  int passengerCount;
  double fuelExpense;
  double revenue;
  String status; // 'completed', 'in_progress', 'scheduled', 'canceled'
  String notes;

  Trip({
    required this.id,
    required this.driverId,
    required this.busNumber,
    this.is50Seater = true,
    this.busCapacity = 50,
    required this.date,
    required this.route,
    required this.passengerCount,
    required this.fuelExpense,
    required this.revenue,
    this.status = 'completed',
    this.notes = '',
  });

  double get occupancyRate {
    if (busCapacity <= 0) return 0.0;
    return (passengerCount / busCapacity).clamp(0.0, 1.5);
  }

  int get occupancyPercentage => (occupancyRate * 100).round();

  double get netProfit => revenue - fuelExpense;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'driverId': driverId,
      'busNumber': busNumber,
      'is50Seater': is50Seater,
      'busCapacity': busCapacity,
      'date': date,
      'route': route,
      'passengerCount': passengerCount,
      'fuelExpense': fuelExpense,
      'revenue': revenue,
      'status': status,
      'notes': notes,
    };
  }

  factory Trip.fromMap(Map<String, dynamic> map) {
    return Trip(
      id: map['id'] ?? '',
      driverId: map['driverId'] ?? '',
      busNumber: map['busNumber'] ?? '',
      is50Seater: map['is50Seater'] ?? true,
      busCapacity: (map['busCapacity'] is num) ? (map['busCapacity'] as num).toInt() : 50,
      date: map['date'] ?? '',
      route: map['route'] ?? '',
      passengerCount: (map['passengerCount'] is num) ? (map['passengerCount'] as num).toInt() : 0,
      fuelExpense: (map['fuelExpense'] is num) ? (map['fuelExpense'] as num).toDouble() : 0.0,
      revenue: (map['revenue'] is num) ? (map['revenue'] as num).toDouble() : 0.0,
      status: map['status'] ?? 'completed',
      notes: map['notes'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Trip.fromJson(String source) => Trip.fromMap(json.decode(source));
}
