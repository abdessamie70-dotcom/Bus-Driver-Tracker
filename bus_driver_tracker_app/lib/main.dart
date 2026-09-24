import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'services/app_state.dart';
import 'theme/app_theme.dart';
import 'screens/main_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const BusDriverTrackerApp());
}

class BusDriverTrackerApp extends StatefulWidget {
  const BusDriverTrackerApp({Key? key}) : super(key: key);

  @override
  State<BusDriverTrackerApp> createState() => _BusDriverTrackerAppState();
}

class _BusDriverTrackerAppState extends State<BusDriverTrackerApp> {
  final AppState _appState = AppState();

  @override
  void initState() {
    super.initState();
    _appState.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _appState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bus Driver Tracker',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      locale: _appState.locale,
      supportedLocales: const [
        Locale('ar'),
        Locale('en'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: MainScreen(state: _appState),
    );
  }
}
