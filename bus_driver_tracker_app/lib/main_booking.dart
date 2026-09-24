import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'theme/app_theme.dart';
import 'screens/booking_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PassengerBookingApp());
}

class PassengerBookingApp extends StatelessWidget {
  const PassengerBookingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'بوابة حجز التذاكر - مؤسسة سويقات أبو طالب',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      locale: const Locale('ar'),
      supportedLocales: const [
        Locale('ar'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const BookingScreen(),
    );
  }
}
