import 'package:hive_flutter/hive_flutter.dart';
import '../models/habit.dart';
import '../models/completion.dart';
import '../models/or_option.dart';

class DatabaseService {
  static const String habitsBoxName = 'habits';
  static const String settingsBoxName = 'settings';

  // Initialize Hive
  static Future<void> init() async {
    // Initialize Hive Flutter
    await Hive.initFlutter();

    // Register adapters
    Hive.registerAdapter(HabitAdapter());
    Hive.registerAdapter(CompletionAdapter());
    Hive.registerAdapter(OrOptionAdapter());
    Hive.registerAdapter(OrOptionsAdapter());

    // Open boxes
    await Hive.openBox<Habit>(habitsBoxName);
    await Hive.openBox(settingsBoxName);
  }

  // Get habits box
  static Box<Habit> getHabitsBox() {
    return Hive.box<Habit>(habitsBoxName);
  }

  // Get settings box
  static Box getSettingsBox() {
    return Hive.box(settingsBoxName);
  }

  // Close all boxes
  static Future<void> close() async {
    await Hive.close();
  }

  // Export all data
  static Future<Map<String, dynamic>> exportData() async {
    final habitsBox = getHabitsBox();
    final settingsBox = getSettingsBox();

    final habits = habitsBox.values.map((h) => h.toJson()).toList();
    final settings = settingsBox.toMap();

    return {
      'version': '1.0.0',
      'exportDate': DateTime.now().toIso8601String(),
      'habits': habits,
      'settings': settings,
    };
  }

  // Import data
  static Future<void> importData(Map<String, dynamic> data) async {
    final habitsBox = getHabitsBox();
    final settingsBox = getSettingsBox();

    // Clear existing data
    await habitsBox.clear();
    await settingsBox.clear();

    // Import habits
    if (data.containsKey('habits')) {
      final habitsList = data['habits'] as List<dynamic>;
      for (final habitJson in habitsList) {
        final habit = Habit.fromJson(habitJson as Map<String, dynamic>);
        await habitsBox.put(habit.id, habit);
      }
    }

    // Import settings
    if (data.containsKey('settings')) {
      final settingsMap = data['settings'] as Map<String, dynamic>;
      for (final entry in settingsMap.entries) {
        await settingsBox.put(entry.key, entry.value);
      }
    }
  }

  // Clear all data
  static Future<void> clearAll() async {
    final habitsBox = getHabitsBox();
    final settingsBox = getSettingsBox();

    await habitsBox.clear();
    await settingsBox.clear();
  }
}
