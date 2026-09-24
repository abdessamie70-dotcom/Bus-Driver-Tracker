import 'package:flutter/material.dart';
import '../services/app_state.dart';
import '../theme/app_theme.dart';

class ReportsTab extends StatelessWidget {
  final AppState state;
  const ReportsTab({Key? key, required this.state}) : super(key: key);

  static const arabicMonths = [
    'يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو',
    'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر'
  ];

  static const englishMonths = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  @override
  Widget build(BuildContext context) {
    final isAr = state.isArabic;
    final monthName = isAr ? arabicMonths[state.currentMonth] : englishMonths[state.currentMonth];

    // Filter month trips
    final monthTrips = state.trips.where((t) {
      final parts = t.date.split('-');
      if (parts.length >= 2) {
        final y = int.tryParse(parts[0]);
        final m = int.tryParse(parts[1]);
        return y == state.currentYear && m == (state.currentMonth + 1);
      }
      return false;
    }).toList();

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Month Selector & Export Action
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.chevron_left),
                          onPressed: state.prevMonth,
                        ),
                        Text(
                          '$monthName ${state.currentYear}',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        IconButton(
                          icon: const Icon(Icons.chevron_right),
                          onPressed: state.nextMonth,
                        ),
                      ],
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(backgroundColor: AppTheme.successEmerald),
                      icon: const Icon(Icons.download, size: 18),
                      label: Text(isAr ? 'تصدير Excel' : 'Export Excel'),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(isAr ? 'تم تصدير ملف التقرير الشهري بنجاح' : 'Monthly report exported successfully'),
                            backgroundColor: AppTheme.successEmerald,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            Text(
              isAr ? 'التقرير المالي والتشغيلي المجمّع لكل سائق' : 'Monthly Aggregated Report per Driver',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),

            // Driver Aggregations Cards
            ...state.drivers.map((driver) {
              final dTrips = monthTrips.where((t) => t.driverId == driver.id).toList();
              final tripsCount = dTrips.length;
              final paxCount = dTrips.fold<int>(0, (sum, t) => sum + t.passengerCount);
              final fuel = dTrips.fold<double>(0.0, (sum, t) => sum + t.fuelExpense);
              final rev = dTrips.fold<double>(0.0, (sum, t) => sum + t.revenue);

              final att = state.getAttendanceRecord(driver.id, state.currentYear, state.currentMonth);
              int workDays = 0;
              double otHours = 0.0;
              att.days.forEach((day, dAtt) {
                if (dAtt.status == 'work') workDays++;
                otHours += dAtt.overtime;
              });

              final wages = (workDays * driver.dailyWage) + (otHours * driver.overtimeRate) + att.bonus - att.deduction;
              final netCompany = rev - fuel - wages;

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(driver.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: driver.is50Seater ? Colors.blue[50] : Colors.grey[100],
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: driver.is50Seater ? Colors.blue[200]! : Colors.grey[300]!),
                            ),
                            child: Text(
                              '🚌 ${driver.busNumber} ${driver.is50Seater ? '(50 مقعد)' : ''}',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: driver.is50Seater ? Colors.blue[800] : Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 16),
                      Wrap(
                        spacing: 16,
                        runSpacing: 8,
                        children: [
                          _buildReportItem(isAr ? 'أيام العمل' : 'Work Days', '$workDays'),
                          _buildReportItem(isAr ? 'الرحلات' : 'Trips', '$tripsCount'),
                          _buildReportItem(isAr ? 'إجمالي الركاب' : 'Passengers', '$paxCount'),
                          _buildReportItem(isAr ? 'الوقود' : 'Fuel', '${fuel.toInt()} ${isAr ? 'دج' : 'DZD'}'),
                          _buildReportItem(isAr ? 'أجور السائق' : 'Wages', '${wages.toInt()} ${isAr ? 'دج' : 'DZD'}'),
                          _buildReportItem(isAr ? 'الإيراد الإجمالي' : 'Gross Rev', '${rev.toInt()} ${isAr ? 'دج' : 'DZD'}', color: AppTheme.successEmerald),
                          _buildReportItem(isAr ? 'صافي المؤسسة' : 'Company Net', '${netCompany.toInt()} ${isAr ? 'دج' : 'DZD'}', color: AppTheme.primaryColor),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildReportItem(String label, String value, {Color? color}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.black54, fontSize: 11)),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: color ?? Colors.black87,
          ),
        ),
      ],
    );
  }
}
