import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/database_service.dart';
import 'providers/habit_provider.dart';
import 'screens/dashboard_screen.dart';
import 'utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize database
  await DatabaseService.init();

  runApp(const HabitKitApp());
}

class HabitKitApp extends StatelessWidget {
  const HabitKitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HabitProvider()..init(),
        ),
      ],
      child: MaterialApp(
        title: 'HabitKit',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const DashboardScreen(),
      ),
    );
  }
}
