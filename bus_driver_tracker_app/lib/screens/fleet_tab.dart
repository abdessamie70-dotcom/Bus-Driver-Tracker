import 'package:flutter/material.dart';
import '../services/app_state.dart';
import '../models/driver.dart';
import '../theme/app_theme.dart';

class FleetTab extends StatelessWidget {
  final AppState state;
  const FleetTab({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(14),
        itemCount: state.drivers.length,
        itemBuilder: (context, index) {
          final driver = state.drivers[index];

          Color statusColor = Colors.green;
          String statusText = '🟢 نشط في الخدمة';
          if (driver.status == 'leave') {
            statusColor = Colors.blue;
            statusText = '🔵 في عطلة رسمية';
          } else if (driver.status == 'suspended') {
            statusColor = Colors.red;
            statusText = '🔴 موقف مؤقتاً';
          }

          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: CircleAvatar(
                backgroundColor: driver.is50Seater ? Colors.blue[100] : Colors.grey[200],
                child: Text(driver.is50Seater ? '50' : '🚌', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              ),
              title: Row(
                children: [
                  Expanded(
                    child: Text(driver.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: statusColor.withOpacity(0.4)),
                    ),
                    child: Text(
                      statusText,
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: statusColor),
                    ),
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text('🚌 ${driver.busNumber} • 📞 ${driver.phone}'),
                  if (driver.route.isNotEmpty)
                    Text('📍 المسار: ${driver.route}', style: const TextStyle(fontSize: 11, color: Colors.black87)),
                  if (driver.license.isNotEmpty)
                    Text('🪪 الرخصة: ${driver.license}', style: const TextStyle(fontSize: 11, color: Colors.black54)),
                  const SizedBox(height: 4),
                  Text(
                    'اليومية: ${driver.dailyWage.toInt()} دج • الإضافي: ${driver.overtimeRate.toInt()} دج',
                    style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black87),
                  ),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.edit, size: 20, color: AppTheme.primaryColor),
                onPressed: () => _showDriverDialog(context, driverToEdit: driver),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppTheme.primaryColor,
        icon: const Icon(Icons.person_add, color: Colors.white),
        label: const Text('إضافة سائق جديد', style: TextStyle(color: Colors.white)),
        onPressed: () => _showDriverDialog(context),
      ),
    );
  }

  void _showDriverDialog(BuildContext context, {Driver? driverToEdit}) {
    final isEditing = driverToEdit != null;

    final nameCtrl = TextEditingController(text: driverToEdit?.name ?? '');
    final busCtrl = TextEditingController(text: driverToEdit?.busNumber ?? '');
    final phoneCtrl = TextEditingController(text: driverToEdit?.phone ?? '');
    final routeCtrl = TextEditingController(text: driverToEdit?.route ?? '');
    final licenseCtrl = TextEditingController(text: driverToEdit?.license ?? '');
    final notesCtrl = TextEditingController(text: driverToEdit?.notes ?? '');
    final wageCtrl = TextEditingController(text: (driverToEdit?.dailyWage ?? 2800).toInt().toString());
    final otCtrl = TextEditingController(text: (driverToEdit?.overtimeRate ?? 450).toInt().toString());
    String status = driverToEdit?.status ?? 'active';
    bool is50 = driverToEdit?.is50Seater ?? true;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: Text(isEditing ? 'تعديل بيانات السائق' : 'إضافة سائق جديد'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(labelText: 'اسم السائق *'),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: status,
                  decoration: const InputDecoration(labelText: 'حالة السائق'),
                  items: const [
                    DropdownMenuItem(value: 'active', child: Text('🟢 نشط في الخدمة')),
                    DropdownMenuItem(value: 'leave', child: Text('🔵 في عطلة رسمية / إجازة')),
                    DropdownMenuItem(value: 'suspended', child: Text('🔴 موقف مؤقتاً')),
                  ],
                  onChanged: (val) => setState(() => status = val ?? 'active'),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: busCtrl,
                  decoration: const InputDecoration(labelText: 'رقم الحافلة'),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Checkbox(
                      value: is50,
                      onChanged: (v) => setState(() => is50 = v ?? true),
                    ),
                    const Text('حافلة كبيرة (50 راكب)'),
                  ],
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: routeCtrl,
                  decoration: const InputDecoration(labelText: 'المسار أو الخط المعتاد'),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: phoneCtrl,
                  decoration: const InputDecoration(labelText: 'رقم الهاتف'),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: licenseCtrl,
                  decoration: const InputDecoration(labelText: 'صنف ورقم رخصة السياقة'),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: wageCtrl,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: 'اليومية (دج)'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        controller: otCtrl,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: 'الإضافي (دج)'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('إلغاء')),
            ElevatedButton(
              onPressed: () {
                final name = nameCtrl.text.trim();
                if (name.isEmpty) return;

                if (isEditing) {
                  driverToEdit.name = name;
                  driverToEdit.busNumber = busCtrl.text.trim();
                  driverToEdit.busType = is50 ? '50_seater' : 'standard';
                  driverToEdit.capacity = is50 ? 50 : 30;
                  driverToEdit.phone = phoneCtrl.text.trim();
                  driverToEdit.status = status;
                  driverToEdit.route = routeCtrl.text.trim();
                  driverToEdit.license = licenseCtrl.text.trim();
                  driverToEdit.notes = notesCtrl.text.trim();
                  driverToEdit.dailyWage = double.tryParse(wageCtrl.text) ?? 2800.0;
                  driverToEdit.overtimeRate = double.tryParse(otCtrl.text) ?? 450.0;
                  state.updateDriver(driverToEdit);
                } else {
                  final newDriver = Driver(
                    id: 'drv_${DateTime.now().millisecondsSinceEpoch}',
                    name: name,
                    busNumber: busCtrl.text.trim(),
                    busType: is50 ? '50_seater' : 'standard',
                    capacity: is50 ? 50 : 30,
                    phone: phoneCtrl.text.trim(),
                    status: status,
                    route: routeCtrl.text.trim(),
                    license: licenseCtrl.text.trim(),
                    notes: notesCtrl.text.trim(),
                    dailyWage: double.tryParse(wageCtrl.text) ?? 2800.0,
                    overtimeRate: double.tryParse(otCtrl.text) ?? 450.0,
                  );
                  state.addDriver(newDriver);
                }

                Navigator.pop(ctx);
              },
              child: const Text('حفظ'),
            ),
          ],
        ),
      ),
    );
  }
}
