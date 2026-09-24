import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class BookingRouteInfo {
  final String id;
  final String name;
  final String primaryBus;
  final String overflowBus;
  final int capacity;

  const BookingRouteInfo({
    required this.id,
    required this.name,
    required this.primaryBus,
    required this.overflowBus,
    this.capacity = 50,
  });
}

class BookingRecord {
  final String code;
  final String name;
  final String phone;
  final String routeName;
  final String date;
  final int seats;
  final String assignedBus;
  final String originalBus;
  final bool isOverflow;
  final String notes;

  BookingRecord({
    required this.code,
    required this.name,
    required this.phone,
    required this.routeName,
    required this.date,
    required this.seats,
    required this.assignedBus,
    required this.originalBus,
    required this.isOverflow,
    required this.notes,
  });
}

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final List<BookingRouteInfo> _routes = const [
    BookingRouteInfo(
      id: "route_1",
      name: "الخط 01: المحطة المركزية ➔ الجامعة المركزية",
      primaryBus: "12",
      overflowBus: "08",
      capacity: 50,
    ),
    BookingRouteInfo(
      id: "route_2",
      name: "الخط 02: وسط المدينة ➔ حي النور",
      primaryBus: "08",
      overflowBus: "19",
      capacity: 50,
    ),
    BookingRouteInfo(
      id: "route_3",
      name: "الخط 03: المطار الدولي ➔ محطة الحافلات الكبرى",
      primaryBus: "19",
      overflowBus: "12",
      capacity: 50,
    ),
    BookingRouteInfo(
      id: "route_4",
      name: "الخط 04: خط النقل التكميلي - الضواحي",
      primaryBus: "04",
      overflowBus: "12",
      capacity: 30,
    ),
  ];

  late BookingRouteInfo _selectedRoute;
  DateTime _selectedDate = DateTime.now();
  int _seatsCount = 1;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  BookingRecord? _confirmedBooking;

  // Track booked seats in memory (simulating initial load where Bus 12 has 48/50 seats)
  final Map<String, int> _bookedMap = {
    "12": 48,
    "08": 15,
    "19": 20,
    "04": 10,
  };

  @override
  void initState() {
    super.initState();
    _selectedRoute = _routes[0];
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  bool get _isBusFull {
    final booked = _bookedMap[_selectedRoute.primaryBus] ?? 0;
    return (booked + _seatsCount) > _selectedRoute.capacity;
  }

  void _submitBooking() {
    if (_nameController.text.trim().isEmpty || _phoneController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى ملء الاسم ورقم الهاتف بالكامل.')),
      );
      return;
    }

    final isOverflow = _isBusFull;
    final assignedBus = isOverflow ? _selectedRoute.overflowBus : _selectedRoute.primaryBus;
    final code = "BK-${Random().nextInt(90000) + 10000}";

    // Update in-memory booked count
    _bookedMap[assignedBus] = (_bookedMap[assignedBus] ?? 0) + _seatsCount;

    setState(() {
      _confirmedBooking = BookingRecord(
        code: code,
        name: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
        routeName: _selectedRoute.name,
        date: "${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}",
        seats: _seatsCount,
        assignedBus: assignedBus,
        originalBus: _selectedRoute.primaryBus,
        isOverflow: isOverflow,
        notes: _notesController.text.trim().isEmpty ? "لا توجد ملاحظات" : _notesController.text.trim(),
      );
    });
  }

  void _resetForNewBooking() {
    setState(() {
      _confirmedBooking = null;
      _nameController.clear();
      _phoneController.clear();
      _notesController.clear();
      _seatsCount = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
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
              child: const Text('🎫', style: TextStyle(fontSize: 20)),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'بوابة حجز المقاعد والرحلات',
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
                        '• حجز تذاكر مباشر',
                        style: TextStyle(fontSize: 11, color: Colors.blue[100]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: _confirmedBooking == null ? _buildBookingForm() : _buildConfirmationTicket(),
    );
  }

  Widget _buildBookingForm() {
    final booked = _bookedMap[_selectedRoute.primaryBus] ?? 0;
    final remaining = max(0, _selectedRoute.capacity - booked);
    final isFull = _isBusFull;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner
          Card(
            color: Colors.blue[900],
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'احجز مقعدك وتذكرتك بسهولة 🚌',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'اختر خط السير وتاريخ الرحلة. في حال اكتمال مقاعد الحافلة الأولى، يتم تحويل حجزك تلقائياً للحافلة التالية!',
                    style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.4),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Route Select
          const Text('مسار الرحلة / الخط:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: DropdownButton<String>(
              isExpanded: true,
              underline: const SizedBox(),
              value: _selectedRoute.id,
              items: _routes.map((r) => DropdownMenuItem(value: r.id, child: Text(r.name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)))).toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() {
                    _selectedRoute = _routes.firstWhere((r) => r.id === val);
                  });
                }
              },
            ),
          ),
          const SizedBox(height: 12),

          // Real-time Overflow Banner
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isFull ? Colors.amber[50] : Colors.green[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: isFull ? Colors.amber[400]! : Colors.green[400]!),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(isFull ? '⚠️' : '🟢', style: const TextStyle(fontSize: 20)),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isFull
                            ? 'الحافلة رقم (${_selectedRoute.primaryBus}) ممتلئة تماماً ($booked/${_selectedRoute.capacity})'
                            : 'مقاعد متوفرة في الحافلة (${_selectedRoute.primaryBus}) - المتبقي: $remaining مقعد',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isFull ? Colors.amber[950] : Colors.green[950],
                          fontSize: 13,
                        ),
                      ),
                      if (isFull)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            '👉 سيتم تأكيد حجزك تلقائياً في الحافلة البديلة رقم (${_selectedRoute.overflowBus}) سعة 50 مقعد.',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.amber[900]),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Date & Seats Row
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('تاريخ الرحلة:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    const SizedBox(height: 6),
                    InkWell(
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: _selectedDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(const Duration(days: 60)),
                        );
                        if (picked != null) {
                          setState(() => _selectedDate = picked);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}",
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const Icon(Icons.calendar_today, size: 18),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('عدد المقاعد:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: DropdownButton<int>(
                        isExpanded: true,
                        underline: const SizedBox(),
                        value: _seatsCount,
                        items: [1, 2, 3, 4, 5].map((n) => DropdownMenuItem(value: n, child: Text('$n مقعد', style: const TextStyle(fontWeight: FontWeight.bold)))).toList(),
                        onChanged: (val) {
                          if (val != null) setState(() => _seatsCount = val);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Passenger Name
          const Text('اسم المسافر الكامل: *', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 6),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: 'مثال: محمد العمري',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[300]!)),
            ),
          ),
          const SizedBox(height: 14),

          // Phone
          const Text('رقم الهاتف: *', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 6),
          TextField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: '05 / 06 / 07 XX XX XX XX',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[300]!)),
            ),
          ),
          const SizedBox(height: 14),

          // Notes
          const Text('ملاحظات إضافية (اختياري):', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 6),
          TextField(
            controller: _notesController,
            decoration: InputDecoration(
              hintText: 'مكان الركوب أو ملاحظة السفر...',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[300]!)),
            ),
          ),
          const SizedBox(height: 24),

          // Submit Button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              icon: const Text('🎟️', style: TextStyle(fontSize: 20)),
              label: Text(
                isFull ? 'تأكيد الحجز في الحافلة البديلة (${_selectedRoute.overflowBus})' : 'تأكيد الحجز في الحافلة (${_selectedRoute.primaryBus})',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
              ),
              onPressed: _submitBooking,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmationTicket() {
    final b = _confirmedBooking!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Success banner
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.green[600],
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: const [
                Text('✅', style: TextStyle(fontSize: 24)),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'تم تأكيد حجزك بنجاح لدى مؤسسة سويقات أبو طالب!',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Digital Ticket Card
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: Colors.grey[300]!, width: 1.5),
            ),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('مؤسسة سويقات أبو طالب للنقل', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15)),
                          Text('تذكرة صعود إلكترونية معتمدة', style: TextStyle(fontSize: 11, color: Colors.black54)),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(8)),
                        child: Text(b.code, style: const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue)),
                      ),
                    ],
                  ),
                  const Divider(height: 24),

                  if (b.isOverflow)
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.amber[50],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.amber[300]!),
                      ),
                      child: Text(
                        '⚠️ نظراً لاكتمال مقاعد الحافلة الأساسية (${b.originalBus})، تم تخصيص وتأكيد مقعدك في الحافلة البديلة رقم (${b.assignedBus})!',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.amber[900]),
                      ),
                    ),

                  _ticketRow('اسم المسافر:', b.name),
                  _ticketRow('رقم الهاتف:', b.phone),
                  _ticketRow('مسار الرحلة:', b.routeName),
                  _ticketRow('تاريخ السفر:', b.date),
                  _ticketRow('الحافلة المخصصة:', '🚌 حافلة رقم ${b.assignedBus} (50 مقعد)'),
                  _ticketRow('عدد المقاعد:', '${b.seats} مقعد'),
                  _ticketRow('ملاحظات:', b.notes),

                  const Divider(height: 24),
                  const Text(
                    '📍 يرجى الحضور للمحطة قبل الانطلاق بـ 15 دقيقة وإبراز هذه التذكرة.',
                    style: TextStyle(fontSize: 11, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Actions
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[800],
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: const Icon(Icons.share, color: Colors.white, size: 18),
                  label: const Text('مشاركة التذكرة', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('تم نسخ تفاصيل التذكرة ${b.code} بنجاح!')),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('حجز آخر', style: TextStyle(fontWeight: FontWeight.bold)),
                  onPressed: _resetForNewBooking,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _ticketRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(label, style: const TextStyle(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87)),
          ),
        ],
      ),
    );
  }
}
