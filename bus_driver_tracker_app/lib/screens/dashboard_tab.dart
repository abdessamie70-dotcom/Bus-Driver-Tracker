import 'package:flutter/material.dart';
import '../services/app_state.dart';
import '../models/trip.dart';
import '../models/driver.dart';
import '../theme/app_theme.dart';

class DashboardTab extends StatelessWidget {
  final AppState state;
  const DashboardTab({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isAr = state.isArabic;

    // Filter current month trips
    final currentMonthTrips = state.trips.where((t) {
      final parts = t.date.split('-');
      if (parts.length >= 2) {
        final y = int.tryParse(parts[0]);
        final m = int.tryParse(parts[1]);
        return y == state.currentYear && m == (state.currentMonth + 1);
      }
      return false;
    }).toList();

    final totalTrips = currentMonthTrips.length;
    final activeDrivers = state.drivers.length;
    final totalRevenue = currentMonthTrips.fold<double>(0.0, (sum, t) => sum + t.revenue);
    final totalFuel = currentMonthTrips.fold<double>(0.0, (sum, t) => sum + t.fuelExpense);
    final netBalance = totalRevenue - totalFuel;

    // 50-Seater Metrics
    final large50Buses = state.drivers.where((d) => d.is50Seater).toList();
    final large50Trips = currentMonthTrips.where((t) => t.is50Seater || t.busCapacity == 50).toList();
    final large50Passengers = large50Trips.fold<int>(0, (sum, t) => sum + t.passengerCount);
    final potential50Capacity = large50Trips.length * 50;
    final occupancy50Rate = potential50Capacity > 0
        ? ((large50Passengers / potential50Capacity) * 100).round()
        : 0;
    final avgLoad50 = large50Trips.isNotEmpty
        ? (large50Passengers / large50Trips.length).toStringAsFixed(1)
        : '0';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 5 Top KPI Cards
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildKpiCard(
                title: isAr ? 'إجمالي الرحلات' : 'Total Trips',
                value: '$totalTrips',
                icon: Icons.directions_bus,
                color: Colors.blue,
              ),
              _buildKpiCard(
                title: isAr ? 'السائقون النشطون' : 'Active Drivers',
                value: '$activeDrivers',
                icon: Icons.people,
                color: Colors.teal,
              ),
              _buildKpiCard(
                title: isAr ? 'إجمالي الإيرادات' : 'Total Revenue',
                value: '${totalRevenue.toInt()} ${isAr ? 'دج' : 'DZD'}',
                icon: Icons.monetization_on,
                color: Colors.green,
              ),
              _buildKpiCard(
                title: isAr ? 'تكاليف الوقود' : 'Fuel Costs',
                value: '${totalFuel.toInt()} ${isAr ? 'دج' : 'DZD'}',
                icon: Icons.local_gas_station,
                color: Colors.amber[800]!,
              ),
              _buildKpiCard(
                title: isAr ? 'الصافي التشغيلي' : 'Net Balance',
                value: '${netBalance.toInt()} ${isAr ? 'دج' : 'DZD'}',
                icon: Icons.trending_up,
                color: AppTheme.primaryColor,
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Dedicated 50-Seater Large Bus Section
          Card(
            color: const Color(0xFF1E3A8A),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('🌟', style: TextStyle(fontSize: 24)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          isAr
                              ? 'إحصائيات حافلات النقل الكبيرة (سعة 50 راكب)'
                              : '50-Seater Large Buses Analytics',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isAr
                        ? 'معدل استغلال المقاعد ونسب امتلاء الأسطول الكبير'
                        : 'Capacity utilization and occupancy rate for 50-passenger fleet',
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  const SizedBox(height: 16),

                  // 50-Seater Sub-metrics
                  Row(
                    children: [
                      _build50SeaterMetric(
                        title: isAr ? 'حافلات 50 مقعد' : '50-Seater Buses',
                        val: '${large50Buses.length}',
                      ),
                      _build50SeaterMetric(
                        title: isAr ? 'رحلات 50 مقعد' : '50-Seater Trips',
                        val: '${large50Trips.length}',
                      ),
                      _build50SeaterMetric(
                        title: isAr ? 'إجمالي الركاب' : 'Passengers',
                        val: '$large50Passengers',
                      ),
                      _build50SeaterMetric(
                        title: isAr ? 'نسبة الامتلاء' : 'Occupancy',
                        val: '$occupancy50Rate%',
                        isHighlight: true,
                      ),
                      _build50SeaterMetric(
                        title: isAr ? 'معدل/رحلة' : 'Avg/Trip',
                        val: avgLoad50,
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Progress Bar for 50-Seater Occupancy
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: (occupancy50Rate / 100.0).clamp(0.0, 1.0),
                      minHeight: 10,
                      backgroundColor: Colors.white24,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        occupancy50Rate >= 80
                            ? AppTheme.successEmerald
                            : (occupancy50Rate >= 50 ? AppTheme.accentAmber : AppTheme.dangerRose),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Recent Trips List
          Text(
            isAr ? 'آخر الرحلات المسجلة' : 'Recent Trip Logs',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          if (state.trips.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(isAr ? 'لا توجد رحلات مسجلة بعد' : 'No trip records found'),
              ),
            )
          else
            ...state.trips.take(5).map((trip) {
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
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: trip.is50Seater ? Colors.blue[100] : Colors.grey[200],
                    child: Text(trip.is50Seater ? '50' : '🚌', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                  title: Text(trip.route, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  subtitle: Text('${trip.date} • ${driver.name} • 🚌 ${trip.busNumber}'),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${trip.passengerCount} / ${trip.busCapacity}',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                      Text(
                        '${trip.revenue.toInt()} ${isAr ? 'دج' : 'DZD'}',
                        style: const TextStyle(color: AppTheme.successEmerald, fontWeight: FontWeight.bold, fontSize: 11),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
        ],
      ),
    );
  }

  Widget _buildKpiCard({required String title, required String value, required IconData icon, required Color color}) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(color: Colors.black54, fontSize: 11, fontWeight: FontWeight.w600)),
              Icon(icon, color: color, size: 20),
            ],
          ),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _build50SeaterMetric({required String title, required String val, bool isHighlight = false}) {
    return Expanded(
      child: Column(
        children: [
          Text(title, style: const TextStyle(color: Colors.white70, fontSize: 10)),
          const SizedBox(height: 2),
          Text(
            val,
            style: TextStyle(
              color: isHighlight ? AppTheme.accentAmber : Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
