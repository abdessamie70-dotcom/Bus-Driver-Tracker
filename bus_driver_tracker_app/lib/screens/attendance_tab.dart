import 'package:flutter/material.dart';
import '../services/app_state.dart';
import '../theme/app_theme.dart';

class AttendanceTab extends StatelessWidget {
  final AppState state;
  const AttendanceTab({Key? key, required this.state}) : super(key: key);

  static const arabicMonths = [
    'يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو',
    'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر'
  ];

  @override
  Widget build(BuildContext context) {
    final isAr = state.isArabic;
    final driver = state.currentDriver;
    if (driver == null) {
      return Center(child: Text(isAr ? 'لا يوجد سائق محدد' : 'No driver selected'));
    }

    final monthName = isAr ? arabicMonths[state.currentMonth] : 'Month ${state.currentMonth + 1}';
    final record = state.getAttendanceRecord(driver.id, state.currentYear, state.currentMonth);
    final daysInMonth = DateTime(state.currentYear, state.currentMonth + 2, 0).day;

    int workDays = 0, restDays = 0, absentDays = 0;
    double otHours = 0.0;

    for (int day = 1; day <= daysInMonth; day++) {
      final st = record.days[day]?.status ?? 'work';
      if (st == 'work') workDays++;
      if (st == 'rest') restDays++;
      if (st == 'absence') absentDays++;
      otHours += record.days[day]?.overtime ?? 0.0;
    }

    final baseSalary = workDays * driver.dailyWage;
    final overtimeSalary = otHours * driver.overtimeRate;
    final netSalary = (baseSalary + overtimeSalary + record.bonus - record.deduction).clamp(0.0, 9999999.0);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Driver & Month Controls
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(isAr ? 'السائق:' : 'Driver:', style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: driver.id,
                            underline: const SizedBox(),
                            items: state.drivers.map((d) => DropdownMenuItem(value: d.id, child: Text(d.name))).toList(),
                            onChanged: (val) {
                              if (val != null) state.setCurrentDriver(val);
                            },
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(icon: const Icon(Icons.chevron_left), onPressed: state.prevMonth),
                            Text('$monthName ${state.currentYear}', style: const TextStyle(fontWeight: FontWeight.bold)),
                            IconButton(icon: const Icon(Icons.chevron_right), onPressed: state.nextMonth),
                          ],
                        ),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[50],
                            foregroundColor: AppTheme.primaryColor,
                            elevation: 0,
                          ),
                          icon: const Icon(Icons.flash_on, size: 16),
                          label: Text(isAr ? '⚡ ملء تلقائي' : 'Auto Fill'),
                          onPressed: () => _showQuickFillDialog(context, driver.id),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Mini Stats Row
            Row(
              children: [
                _buildStatBadge(isAr ? 'عمل' : 'Work', '$workDays', Colors.green),
                _buildStatBadge(isAr ? 'راحة' : 'Rest', '$restDays', Colors.blue),
                _buildStatBadge(isAr ? 'غياب' : 'Absent', '$absentDays', Colors.red),
                _buildStatBadge(isAr ? 'صافي الأجر' : 'Net Wage', '${netSalary.toInt()} ${isAr ? 'دج' : 'DZD'}', Colors.indigo, isFlex: true),
              ],
            ),

            const SizedBox(height: 16),

            // Calendar Grid Days
            Text(
              isAr ? 'جدول أيام الحضور والغياب (اضغط للتبديل السريع):' : 'Attendance Days Grid (Tap to toggle):',
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 8),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                crossAxisSpacing: 6,
                mainAxisSpacing: 6,
                childAspectRatio: 0.85,
              ),
              itemCount: daysInMonth,
              itemBuilder: (context, index) {
                final day = index + 1;
                final dayRecord = record.days[day];
                final status = dayRecord?.status ?? 'work';

                Color bg = Colors.green[50]!;
                Color border = Colors.green[400]!;
                String icon = '🟢';

                if (status == 'rest') {
                  bg = Colors.blue[50]!;
                  border = Colors.blue[400]!;
                  icon = '🔵';
                } else if (status == 'absence') {
                  bg = Colors.red[50]!;
                  border = Colors.red[400]!;
                  icon = '🔴';
                } else if (status == 'leave') {
                  bg = Colors.amber[50]!;
                  border = Colors.amber[400]!;
                  icon = '🟠';
                }

                return InkWell(
                  onTap: () => state.cycleDayStatus(driver.id, state.currentYear, state.currentMonth, day),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: bg,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: border),
                    ),
                    padding: const EdgeInsets.all(4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('$day', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                        Text(icon, style: const TextStyle(fontSize: 10)),
                        if ((dayRecord?.overtime ?? 0.0) > 0)
                          Text('+${dayRecord!.overtime}h', style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.purple))
                        else
                          const SizedBox(height: 10),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatBadge(String title, String val, MaterialColor color, {bool isFlex = false}) {
    final widget = Container(
      margin: const EdgeInsets.only(right: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: color[50],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color[200]!),
      ),
      child: Column(
        children: [
          Text(title, style: TextStyle(fontSize: 11, color: color[800], fontWeight: FontWeight.w600)),
          Text(val, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: color[900])),
        ],
      ),
    );

    return isFlex ? Expanded(child: widget) : widget;
  }

  void _showQuickFillDialog(BuildContext context, String driverId) {
    final isAr = state.isArabic;
    String selectedPattern = 'one_on_one_off'; // Default to 1-on-1 shift requested by user!

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: Text(isAr ? '⚡ ملء تلقائي لجدول الشهر' : '⚡ Auto Fill Schedule'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                value: 'one_on_one_off',
                groupValue: selectedPattern,
                title: const Text('1. نظام المناوبة (يوم بيوم)'),
                subtitle: const Text('يوم عمل يليه يوم راحة أسبوعية بالتناوب (1x1)'),
                onChanged: (v) => setState(() => selectedPattern = v!),
              ),
              RadioListTile<String>(
                value: 'friday_off',
                groupValue: selectedPattern,
                title: const Text('2. العمل طيلة الأسبوع مع راحة يوم الجمعة'),
                subtitle: const Text('السبت إلى الخميس: عمل | الجمعة: راحة أسبوعية'),
                onChanged: (v) => setState(() => selectedPattern = v!),
              ),
              RadioListTile<String>(
                value: 'two_on_one_off',
                groupValue: selectedPattern,
                title: const Text('3. نظام المناوبة (يومان عمل ثم يوم راحة - 2x1)'),
                subtitle: const Text('يومان عمل متتاليان ثم يوم راحة بالتناوب'),
                onChanged: (v) => setState(() => selectedPattern = v!),
              ),
              RadioListTile<String>(
                value: 'one_on_two_off',
                groupValue: selectedPattern,
                title: const Text('4. نظام المناوبة (يوم عمل ويومان راحة - 1x2)'),
                subtitle: const Text('يوم عمل واحد يليه يومان راحة بالتناوب'),
                onChanged: (v) => setState(() => selectedPattern = v!),
              ),
              RadioListTile<String>(
                value: 'all_work',
                groupValue: selectedPattern,
                title: const Text('5. عمل كل الشهر'),
                subtitle: const Text('جميع أيام الشهر عمل بدون عطلة افتراضية'),
                onChanged: (v) => setState(() => selectedPattern = v!),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: Text(isAr ? 'إلغاء' : 'Cancel')),
            ElevatedButton(
              onPressed: () {
                state.applyShiftPattern(driverId, state.currentYear, state.currentMonth, selectedPattern);
                Navigator.pop(ctx);
              },
              child: Text(isAr ? 'تطبيق' : 'Apply'),
            ),
          ],
        ),
      ),
    );
  }
}
