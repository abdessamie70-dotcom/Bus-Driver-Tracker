import 'package:flutter/material.dart';
import '../services/app_state.dart';
import 'dashboard_tab.dart';
import 'trips_tab.dart';
import 'reports_tab.dart';
import 'attendance_tab.dart';
import 'fleet_tab.dart';

class MainScreen extends StatelessWidget {
  final AppState state;
  const MainScreen({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isAr = state.isArabic;

    final titles = [
      isAr ? 'لوحة التحكم والإحصائيات' : 'Dashboard & Overview',
      isAr ? 'سجل الرحلات اليومية' : 'Daily Trip Logs',
      isAr ? 'التقارير الشهرية وإكسل' : 'Monthly Reports',
      isAr ? 'حضور وأجور السائقين' : 'Driver Attendance',
      isAr ? 'السائقون والأسطول' : 'Drivers & Fleet',
    ];

    final tabs = [
      DashboardTab(state: state),
      TripsTab(state: state),
      ReportsTab(state: state),
      AttendanceTab(state: state),
      FleetTab(state: state),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text('🚌', style: TextStyle(fontSize: 20)),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'نظام متابعة سائقي الحافلات',
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                        decoration: BoxDecoration(
                          color: Colors.amber[400],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'مؤسسة سويقات أبو طالب',
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black87),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '• ${titles[state.selectedTab]}',
                        style: TextStyle(fontSize: 11, color: Colors.blue[100]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'بوابة حجز الزبائن',
            icon: const Icon(Icons.confirmation_number_outlined, color: Colors.amberAccent),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('بوابة الحجز مفعلة في booking.html مع خوارزمية التحويل التلقائي عند الامتلاء.'),
                  duration: Duration(seconds: 3),
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: tabs[state.selectedTab],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: state.selectedTab,
        onDestinationSelected: state.switchTab,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.dashboard_outlined),
            selectedIcon: const Icon(Icons.dashboard),
            label: isAr ? 'الرئيسية' : 'Dashboard',
          ),
          NavigationDestination(
            icon: const Icon(Icons.route_outlined),
            selectedIcon: const Icon(Icons.route),
            label: isAr ? 'الرحلات' : 'Trips',
          ),
          NavigationDestination(
            icon: const Icon(Icons.table_chart_outlined),
            selectedIcon: const Icon(Icons.table_chart),
            label: isAr ? 'التقارير' : 'Reports',
          ),
          NavigationDestination(
            icon: const Icon(Icons.calendar_month_outlined),
            selectedIcon: const Icon(Icons.calendar_month),
            label: isAr ? 'الحضور' : 'Attendance',
          ),
          NavigationDestination(
            icon: const Icon(Icons.groups_outlined),
            selectedIcon: const Icon(Icons.groups),
            label: isAr ? 'الأسطول' : 'Fleet',
          ),
        ],
      ),
    );
  }
}
