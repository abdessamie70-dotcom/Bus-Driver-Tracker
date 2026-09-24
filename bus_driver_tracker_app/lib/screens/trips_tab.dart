import 'package:flutter/material.dart';
import '../services/app_state.dart';
import '../models/trip.dart';
import '../models/driver.dart';
import '../theme/app_theme.dart';

class TripsTab extends StatelessWidget {
  final AppState state;
  const TripsTab({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isAr = state.isArabic;
    final trips = state.filteredTrips;

    // Dynamic calculations
    final totalFilteredTrips = trips.length;
    final totalFilteredPassengers = trips.fold<int>(0, (sum, t) => sum + t.passengerCount);
    final totalFilteredFuel = trips.fold<double>(0.0, (sum, t) => sum + t.fuelExpense);
    final totalFilteredRevenue = trips.fold<double>(0.0, (sum, t) => sum + t.revenue);
    final totalFilteredCapacity = trips.fold<int>(0, (sum, t) => sum + t.busCapacity);
    final avgOccupancy = totalFilteredCapacity > 0
        ? ((totalFilteredPassengers / totalFilteredCapacity) * 100).round()
        : 0;

    return Scaffold(
      body: Column(
        children: [
          // Filter & Search Header
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.white,
            child: Column(
              children: [
                TextField(
                  onChanged: state.setTripSearchQuery,
                  decoration: InputDecoration(
                    hintText: isAr ? 'بحث بالمسار أو الحافلة...' : 'Search route or bus...',
                    prefixIcon: const Icon(Icons.search),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    FilterChip(
                      selected: state.filter50Only,
                      label: Text(isAr ? 'حافلات 50 مقعد فقط' : '50-Seaters Only'),
                      onSelected: state.setFilter50Only,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DropdownButton<String?>(
                        isExpanded: true,
                        value: state.filterDriverId,
                        hint: Text(isAr ? 'جميع السائقين' : 'All Drivers', style: const TextStyle(fontSize: 12)),
                        underline: const SizedBox(),
                        items: [
                          DropdownMenuItem<String?>(
                            value: null,
                            child: Text(isAr ? 'جميع السائقين' : 'All Drivers'),
                          ),
                          ...state.drivers.map((d) => DropdownMenuItem<String?>(
                                value: d.id,
                                child: Text('${d.name} (${d.busNumber})'),
                              )),
                        ],
                        onChanged: state.setFilterDriverId,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Dynamic Calculations Summary Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: const Color(0xFF0F172A),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${isAr ? 'الرحلات:' : 'Trips:'} $totalFilteredTrips',
                  style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${isAr ? 'الركاب:' : 'Pax:'} $totalFilteredPassengers',
                  style: const TextStyle(color: Colors.white70, fontSize: 11),
                ),
                Text(
                  '${isAr ? 'الإشغال:' : 'Load:'} $avgOccupancy%',
                  style: const TextStyle(color: AppTheme.accentAmber, fontSize: 11, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${totalFilteredRevenue.toInt()} ${isAr ? 'دج' : 'DZD'}',
                  style: const TextStyle(color: AppTheme.successEmerald, fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          // Trips List
          Expanded(
            child: trips.isEmpty
                ? Center(
                    child: Text(isAr ? 'لا توجد رحلات مطابقة' : 'No matching trips found'),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: trips.length,
                    itemBuilder: (context, index) {
                      final trip = trips[index];
                      final driver = state.drivers.firstWhere(
                        (d) => d.id == trip.driverId,
                        orElse: () => Driver(
                          id: '',
                          name: isAr ? 'سائق غير محدد' : 'Unknown',
                          busNumber: trip.busNumber,
                          phone: '',
                          dailyWage: 0,
                          overtimeRate: 0,
                        ),
                      );

                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    trip.route,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: trip.is50Seater ? Colors.blue[50] : Colors.grey[100],
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(color: trip.is50Seater ? Colors.blue[200]! : Colors.grey[300]!),
                                    ),
                                    child: Text(
                                      '🚌 ${trip.busNumber} ${trip.is50Seater ? "(50)" : ""}',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: trip.is50Seater ? Colors.blue[800] : Colors.black87,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                '${trip.date} • ${driver.name}',
                                style: const TextStyle(color: Colors.black54, fontSize: 12),
                              ),
                              const SizedBox(height: 8),

                              // Occupancy Meter
                              Row(
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: LinearProgressIndicator(
                                        value: trip.occupancyRate.clamp(0.0, 1.0),
                                        minHeight: 6,
                                        backgroundColor: Colors.grey[200],
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                          trip.occupancyPercentage >= 80
                                              ? AppTheme.successEmerald
                                              : (trip.occupancyPercentage >= 50 ? AppTheme.accentAmber : AppTheme.dangerRose),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '${trip.passengerCount}/${trip.busCapacity} (${trip.occupancyPercentage}%)',
                                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${isAr ? 'الوقود:' : 'Fuel:'} ${trip.fuelExpense.toInt()} ${isAr ? 'دج' : 'DZD'}',
                                    style: const TextStyle(fontSize: 11, color: Colors.black54),
                                  ),
                                  Text(
                                    '${isAr ? 'الإيراد:' : 'Revenue:'} ${trip.revenue.toInt()} ${isAr ? 'دج' : 'DZD'}',
                                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppTheme.successEmerald),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.delete_outline, size: 18, color: Colors.red),
                                        onPressed: () => _confirmDeleteTrip(context, trip),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppTheme.primaryColor,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(isAr ? 'تسجيل رحلة' : 'Log Trip', style: const TextStyle(color: Colors.white)),
        onPressed: () => _showAddTripDialog(context),
      ),
    );
  }

  void _confirmDeleteTrip(BuildContext context, Trip trip) {
    final isAr = state.isArabic;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(isAr ? 'تأكيد الحذف' : 'Confirm Delete'),
        content: Text(isAr ? 'هل أنت متأكد من حذف هذه الرحلة؟' : 'Are you sure you want to delete this trip record?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text(isAr ? 'إلغاء' : 'Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              state.deleteTrip(trip.id);
              Navigator.pop(ctx);
            },
            child: Text(isAr ? 'حذف' : 'Delete'),
          ),
        ],
      ),
    );
  }

  void _showAddTripDialog(BuildContext context) {
    final isAr = state.isArabic;
    String selectedDriverId = state.drivers.isNotEmpty ? state.drivers.first.id : '';
    final driver = state.drivers.firstWhere((d) => d.id == selectedDriverId, orElse: () => state.drivers.first);

    final routeCtrl = TextEditingController();
    final busNumCtrl = TextEditingController(text: driver.busNumber);
    final paxCtrl = TextEditingController(text: '45');
    final fuelCtrl = TextEditingController(text: '2000');
    final revCtrl = TextEditingController(text: '4500');
    bool is50 = driver.is50Seater;
    int capacity = driver.capacity;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: Text(isAr ? 'تسجيل رحلة جديدة' : 'Log New Trip'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  value: selectedDriverId,
                  decoration: InputDecoration(labelText: isAr ? 'السائق' : 'Driver'),
                  items: state.drivers.map((d) => DropdownMenuItem(value: d.id, child: Text(d.name))).toList(),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() {
                        selectedDriverId = val;
                        final d = state.drivers.firstWhere((x) => x.id == val);
                        busNumCtrl.text = d.busNumber;
                        is50 = d.is50Seater;
                        capacity = d.capacity;
                      });
                    }
                  },
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: routeCtrl,
                  decoration: InputDecoration(labelText: isAr ? 'المسار / الخط' : 'Route'),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: busNumCtrl,
                        decoration: InputDecoration(labelText: isAr ? 'رقم الحافلة' : 'Bus Number'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Checkbox(
                      value: is50,
                      onChanged: (v) => setState(() {
                        is50 = v ?? true;
                        capacity = is50 ? 50 : 30;
                      }),
                    ),
                    Text(isAr ? 'حافلة 50 راكب' : '50-Seater'),
                  ],
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: paxCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: isAr ? 'عدد الركاب' : 'Passenger Count'),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: fuelCtrl,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: isAr ? 'الوقود (دج)' : 'Fuel Cost'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        controller: revCtrl,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: isAr ? 'الإيراد (دج)' : 'Revenue'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: Text(isAr ? 'إلغاء' : 'Cancel')),
            ElevatedButton(
              onPressed: () {
                final route = routeCtrl.text.trim();
                if (route.isEmpty) return;

                final newTrip = Trip(
                  id: 'trip_${DateTime.now().millisecondsSinceEpoch}',
                  driverId: selectedDriverId,
                  busNumber: busNumCtrl.text.trim(),
                  is50Seater: is50,
                  busCapacity: capacity,
                  date: DateTime.now().toIso8601String().substring(0, 10),
                  route: route,
                  passengerCount: int.tryParse(paxCtrl.text) ?? 0,
                  fuelExpense: double.tryParse(fuelCtrl.text) ?? 0.0,
                  revenue: double.tryParse(revCtrl.text) ?? 0.0,
                );

                state.addTrip(newTrip);
                Navigator.pop(ctx);
              },
              child: Text(isAr ? 'حفظ' : 'Save'),
            ),
          ],
        ),
      ),
    );
  }
}
