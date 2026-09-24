import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/driver.dart';
import '../models/trip.dart';
import '../models/attendance.dart';

class AppState extends ChangeNotifier {
  Locale _locale = const Locale('ar');
  Locale get locale => _locale;
  bool get isArabic => _locale.languageCode == 'ar';

  int _selectedTab = 0;
  int get selectedTab => _selectedTab;

  int _currentYear = 2026;
  int get currentYear => _currentYear;

  int _currentMonth = 8; // 0-indexed (8 = September)
  int get currentMonth => _currentMonth;

  String? _currentDriverId;
  String? get currentDriverId => _currentDriverId;

  List<Driver> _drivers = [];
  List<Driver> get drivers => _drivers;

  List<Trip> _trips = [];
  List<Trip> get trips => _trips;

  Map<String, MonthAttendanceRecord> _attendance = {};
  Map<String, MonthAttendanceRecord> get attendance => _attendance;

  // Search and filters for trips
  String _tripSearchQuery = '';
  String get tripSearchQuery => _tripSearchQuery;

  String? _filterDriverId;
  String? get filterDriverId => _filterDriverId;

  bool _filter50Only = false;
  bool get filter50Only => _filter50Only;

  String _filterStatus = 'all';
  String get filterStatus => _filterStatus;

  AppState() {
    _initData();
  }

  void switchTab(int index) {
    _selectedTab = index;
    notifyListeners();
  }

  void toggleLanguage() {
    _locale = isArabic ? const Locale('en') : const Locale('ar');
    _savePreferences();
    notifyListeners();
  }

  void setMonth(int year, int month) {
    _currentYear = year;
    _currentMonth = month;
    notifyListeners();
  }

  void prevMonth() {
    if (_currentMonth == 0) {
      _currentMonth = 11;
      _currentYear--;
    } else {
      _currentMonth--;
    }
    notifyListeners();
  }

  void nextMonth() {
    if (_currentMonth == 11) {
      _currentMonth = 0;
      _currentYear++;
    } else {
      _currentMonth++;
    }
    notifyListeners();
  }

  void setCurrentDriver(String id) {
    _currentDriverId = id;
    notifyListeners();
  }

  Driver? get currentDriver {
    if (_drivers.isEmpty) return null;
    return _drivers.firstWhere(
      (d) => d.id == _currentDriverId,
      orElse: () => _drivers.first,
    );
  }

  // --- Filter Setters ---
  void setTripSearchQuery(String q) {
    _tripSearchQuery = q;
    notifyListeners();
  }

  void setFilterDriverId(String? id) {
    _filterDriverId = id;
    notifyListeners();
  }

  void setFilter50Only(bool val) {
    _filter50Only = val;
    notifyListeners();
  }

  void setFilterStatus(String s) {
    _filterStatus = s;
    notifyListeners();
  }

  // --- Filtered Trips Getter ---
  List<Trip> get filteredTrips {
    return _trips.where((t) {
      final matchesSearch = _tripSearchQuery.isEmpty ||
          t.route.toLowerCase().contains(_tripSearchQuery.toLowerCase()) ||
          t.busNumber.toLowerCase().contains(_tripSearchQuery.toLowerCase());
      final matchesDriver = _filterDriverId == null || _filterDriverId!.isEmpty || t.driverId == _filterDriverId;
      final matches50 = !_filter50Only || t.is50Seater || t.busCapacity == 50;
      final matchesStatus = _filterStatus == 'all' || t.status == _filterStatus;
      return matchesSearch && matchesDriver && matches50 && matchesStatus;
    }).toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  // --- CRUD Trips ---
  void addTrip(Trip trip) {
    _trips.insert(0, trip);
    _savePreferences();
    notifyListeners();
  }

  void updateTrip(Trip trip) {
    final index = _trips.indexWhere((t) => t.id == trip.id);
    if (index != -1) {
      _trips[index] = trip;
      _savePreferences();
      notifyListeners();
    }
  }

  void deleteTrip(String id) {
    _trips.removeWhere((t) => t.id == id);
    _savePreferences();
    notifyListeners();
  }

  // --- CRUD Drivers ---
  void addDriver(Driver driver) {
    _drivers.add(driver);
    _currentDriverId = driver.id;
    _savePreferences();
    notifyListeners();
  }

  void updateDriver(Driver driver) {
    final index = _drivers.indexWhere((d) => d.id == driver.id);
    if (index != -1) {
      _drivers[index] = driver;
      _savePreferences();
      notifyListeners();
    }
  }

  void deleteDriver(String id) {
    if (_drivers.length <= 1) return;
    _drivers.removeWhere((d) => d.id == id);
    if (_currentDriverId == id) {
      _currentDriverId = _drivers.first.id;
    }
    _savePreferences();
    notifyListeners();
  }

  // --- Attendance Management ---
  String getMonthKey(String driverId, int year, int month) => '${driverId}_${year}_$month';

  MonthAttendanceRecord getAttendanceRecord(String driverId, int year, int month) {
    final key = getMonthKey(driverId, year, month);
    if (!_attendance.containsKey(key)) {
      _attendance[key] = MonthAttendanceRecord();
    }
    return _attendance[key]!;
  }

  void setDayStatus(String driverId, int year, int month, int day, String status, {double overtime = 0.0, String notes = ''}) {
    final record = getAttendanceRecord(driverId, year, month);
    record.days[day] = DayAttendance(status: status, overtime: overtime, notes: notes);
    _savePreferences();
    notifyListeners();
  }

  void cycleDayStatus(String driverId, int year, int month, int day) {
    final record = getAttendanceRecord(driverId, year, month);
    final current = record.days[day]?.status ?? 'work';
    const cycle = {
      'work': 'rest',
      'rest': 'absence',
      'absence': 'leave',
      'leave': 'work',
    };
    final next = cycle[current] ?? 'work';
    final existing = record.days[day];
    record.days[day] = DayAttendance(
      status: next,
      overtime: existing?.overtime ?? 0.0,
      trips: existing?.trips ?? '',
      notes: existing?.notes ?? '',
    );
    _savePreferences();
    notifyListeners();
  }

  // Quick fill pattern, including the requested 1-on-1 shift pattern
  void applyShiftPattern(String driverId, int year, int month, String pattern) {
    final record = getAttendanceRecord(driverId, year, month);
    final daysInMonth = DateTime(year, month + 2, 0).day;

    for (int day = 1; day <= daysInMonth; day++) {
      final dt = DateTime(year, month + 1, day);
      final weekday = dt.weekday; // 1=Mon, 5=Fri, 6=Sat, 7=Sun

      String status = 'work';
      if (pattern == 'one_on_one_off') {
        // 1. يوم بيوم: يوم عمل يليه يوم راحة (1x1)
        status = (day % 2 == 1) ? 'work' : 'rest';
      } else if (pattern == 'friday_off') {
        // 2. العمل طيلة الأسبوع مع راحة يوم الجمعة
        status = (weekday == DateTime.friday) ? 'rest' : 'work';
      } else if (pattern == 'two_on_one_off') {
        // 3. يومان عمل ثم يوم راحة (2x1)
        status = (day % 3 == 0) ? 'rest' : 'work';
      } else if (pattern == 'one_on_two_off') {
        // 4. يوم عمل ويومان راحة (1x2)
        status = (day % 3 == 1) ? 'work' : 'rest';
      } else if (pattern == 'all_work') {
        // 5. عمل كل الشهر
        status = 'work';
      }

      final existing = record.days[day];
      record.days[day] = DayAttendance(
        status: status,
        overtime: existing?.overtime ?? 0.0,
        trips: existing?.trips ?? '',
        notes: existing?.notes ?? '',
      );
    }

    _savePreferences();
    notifyListeners();
  }

  void updateBonusDeductions(String driverId, int year, int month, double bonus, double deduction) {
    final record = getAttendanceRecord(driverId, year, month);
    record.bonus = bonus;
    record.deduction = deduction;
    _savePreferences();
    notifyListeners();
  }

  // --- Initial Seed Data & Persistence ---
  Future<void> _initData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final lang = prefs.getString('lang');
      if (lang != null) {
        _locale = Locale(lang);
      }

      final driversJson = prefs.getString('drivers');
      final tripsJson = prefs.getString('trips');
      final attJson = prefs.getString('attendance');

      if (driversJson != null && tripsJson != null) {
        final List dList = json.decode(driversJson);
        _drivers = dList.map((m) => Driver.fromMap(m)).toList();

        final List tList = json.decode(tripsJson);
        _trips = tList.map((m) => Trip.fromMap(m)).toList();
      } else {
        _loadSeedData();
      }

      if (attJson != null) {
        final Map<String, dynamic> aMap = json.decode(attJson);
        _attendance = aMap.map((k, v) => MapEntry(k, MonthAttendanceRecord.fromMap(Map<String, dynamic>.from(v))));
      }

      final activeDrv = prefs.getString('activeDriverId');
      if (activeDrv != null && _drivers.any((d) => d.id == activeDrv)) {
        _currentDriverId = activeDrv;
      } else if (_drivers.isNotEmpty) {
        _currentDriverId = _drivers.first.id;
      }

      final now = DateTime.now();
      _currentYear = now.year;
      _currentMonth = now.month - 1;

      notifyListeners();
    } catch (e) {
      _loadSeedData();
    }
  }

  void _loadSeedData() {
    _drivers = [
      Driver(
        id: 'drv_1',
        name: 'أحمد بن علي / Ahmed Benali',
        busNumber: '12 (01452-116-16)',
        busType: '50_seater',
        capacity: 50,
        phone: '0550123456',
        dailyWage: 2800,
        overtimeRate: 450,
      ),
      Driver(
        id: 'drv_2',
        name: 'مراد قدور / Mourad Kaddour',
        busNumber: '08 (02891-118-16)',
        busType: '50_seater',
        capacity: 50,
        phone: '0661234567',
        dailyWage: 2800,
        overtimeRate: 450,
      ),
      Driver(
        id: 'drv_3',
        name: 'سفيان بلقاسم / Sofiane Belkacem',
        busNumber: '19 (03412-119-16)',
        busType: '50_seater',
        capacity: 50,
        phone: '0770345678',
        dailyWage: 3000,
        overtimeRate: 500,
      ),
      Driver(
        id: 'drv_4',
        name: 'كمال شريف / Kamel Cherif',
        busNumber: '04 (00921-115-16)',
        busType: 'minibus',
        capacity: 30,
        phone: '0559876543',
        dailyWage: 2400,
        overtimeRate: 400,
      ),
    ];
    _currentDriverId = _drivers.first.id;

    _trips = [
      Trip(
        id: 'trip_1',
        driverId: 'drv_1',
        busNumber: '12',
        is50Seater: true,
        busCapacity: 50,
        date: '2026-09-24',
        route: 'المحطة المركزية ➔ الجامعة المركزية',
        passengerCount: 48,
        fuelExpense: 2200,
        revenue: 4800,
        status: 'completed',
        notes: 'رحلة صباحية عالية الإشغال',
      ),
      Trip(
        id: 'trip_2',
        driverId: 'drv_2',
        busNumber: '08',
        is50Seater: true,
        busCapacity: 50,
        date: '2026-09-24',
        route: 'حي النور ➔ وسط المدينة',
        passengerCount: 45,
        fuelExpense: 2100,
        revenue: 4500,
        status: 'completed',
      ),
      Trip(
        id: 'trip_3',
        driverId: 'drv_3',
        busNumber: '19',
        is50Seater: true,
        busCapacity: 50,
        date: '2026-09-24',
        route: 'المطار الدولي ➔ المحطة الكبرى',
        passengerCount: 50,
        fuelExpense: 2600,
        revenue: 6000,
        status: 'completed',
      ),
    ];
  }

  Future<void> _savePreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('lang', _locale.languageCode);
      await prefs.setString('drivers', json.encode(_drivers.map((d) => d.toMap()).toList()));
      await prefs.setString('trips', json.encode(_trips.map((t) => t.toMap()).toList()));
      await prefs.setString('attendance', json.encode(_attendance.map((k, v) => MapEntry(k, v.toMap()))));
      if (_currentDriverId != null) {
        await prefs.setString('activeDriverId', _currentDriverId!);
      }
    } catch (_) {}
  }
}
