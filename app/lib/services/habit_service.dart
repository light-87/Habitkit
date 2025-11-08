import 'package:uuid/uuid.dart';
import '../models/habit.dart';
import '../models/completion.dart';
import '../models/or_option.dart';
import 'database_service.dart';

class HabitService {
  static final _uuid = const Uuid();

  // Create a new habit
  static Future<Habit> createHabit({
    required String name,
    String description = '',
    required String icon,
    required String color,
    bool hasOrOptions = false,
    OrOptions? orOptions,
    List<String> tags = const [],
    int? streakGoal,
    int? targetCompletionsPerDay,
  }) async {
    final habit = Habit(
      id: _uuid.v4(),
      name: name,
      description: description,
      icon: icon,
      color: color,
      createdAt: DateTime.now(),
      hasOrOptions: hasOrOptions,
      orOptions: orOptions,
      tags: tags,
      streakGoal: streakGoal,
      targetCompletionsPerDay: targetCompletionsPerDay,
    );

    final box = DatabaseService.getHabitsBox();
    await box.put(habit.id, habit);

    return habit;
  }

  // Get all habits
  static List<Habit> getAllHabits({bool includeArchived = false}) {
    final box = DatabaseService.getHabitsBox();
    final habits = box.values.toList();

    if (!includeArchived) {
      return habits.where((h) => !h.isArchived).toList();
    }

    return habits;
  }

  // Get habit by ID
  static Habit? getHabitById(String id) {
    final box = DatabaseService.getHabitsBox();
    return box.get(id);
  }

  // Update habit
  static Future<void> updateHabit(Habit habit) async {
    final box = DatabaseService.getHabitsBox();
    await box.put(habit.id, habit);
  }

  // Delete habit
  static Future<void> deleteHabit(String id) async {
    final box = DatabaseService.getHabitsBox();
    await box.delete(id);
  }

  // Archive habit
  static Future<void> archiveHabit(String id) async {
    final habit = getHabitById(id);
    if (habit != null) {
      habit.isArchived = true;
      await updateHabit(habit);
    }
  }

  // Unarchive habit
  static Future<void> unarchiveHabit(String id) async {
    final habit = getHabitById(id);
    if (habit != null) {
      habit.isArchived = false;
      await updateHabit(habit);
    }
  }

  // Mark habit as complete for a specific date
  static Future<void> completeHabit({
    required String habitId,
    DateTime? date,
    String? selectedOption, // For OR options
  }) async {
    final habit = getHabitById(habitId);
    if (habit == null) return;

    final completionDate = date ?? DateTime.now();
    final existingCompletion = habit.getCompletionForDate(completionDate);

    if (existingCompletion != null) {
      // If OR options are enabled and a different option is selected
      if (habit.hasOrOptions && selectedOption != null) {
        if (existingCompletion.selectedOption == null) {
          existingCompletion.selectedOption = selectedOption;
        } else if (existingCompletion.selectedOption != selectedOption) {
          // Both options selected
          existingCompletion.selectedOption = 'both';
        }
      } else {
        // Increment count for multiple completions
        existingCompletion.increment();
      }
    } else {
      // Create new completion
      final completion = Completion(
        id: _uuid.v4(),
        date: completionDate,
        count: 1,
        selectedOption: selectedOption,
      );
      habit.completions.add(completion);
    }

    await updateHabit(habit);
  }

  // Uncomplete habit for a specific date
  static Future<void> uncompleteHabit({
    required String habitId,
    DateTime? date,
  }) async {
    final habit = getHabitById(habitId);
    if (habit == null) return;

    final completionDate = date ?? DateTime.now();
    habit.completions.removeWhere((c) =>
      c.dateOnly == DateTime(completionDate.year, completionDate.month, completionDate.day)
    );

    await updateHabit(habit);
  }

  // Toggle completion for today
  static Future<void> toggleCompletion({
    required String habitId,
    String? selectedOption,
  }) async {
    final habit = getHabitById(habitId);
    if (habit == null) return;

    final today = DateTime.now();
    final isCompleted = habit.isCompletedOn(today);

    if (isCompleted) {
      await uncompleteHabit(habitId: habitId, date: today);
    } else {
      await completeHabit(
        habitId: habitId,
        date: today,
        selectedOption: selectedOption,
      );
    }
  }

  // Get habits by tag
  static List<Habit> getHabitsByTag(String tag) {
    final habits = getAllHabits();
    return habits.where((h) => h.tags.contains(tag)).toList();
  }

  // Get all tags
  static List<String> getAllTags() {
    final habits = getAllHabits();
    final tags = <String>{};

    for (final habit in habits) {
      tags.addAll(habit.tags);
    }

    return tags.toList()..sort();
  }

  // Get habits completion stats
  static Map<String, dynamic> getStats() {
    final habits = getAllHabits();
    int totalHabits = habits.length;
    int completedToday = 0;
    int totalCompletions = 0;
    int totalStreak = 0;

    for (final habit in habits) {
      if (habit.isCompletedOn(DateTime.now())) {
        completedToday++;
      }
      totalCompletions += habit.totalCompletions;
      totalStreak += habit.currentStreak;
    }

    return {
      'totalHabits': totalHabits,
      'completedToday': completedToday,
      'totalCompletions': totalCompletions,
      'averageStreak': totalHabits > 0 ? totalStreak / totalHabits : 0,
    };
  }

  // Check if free tier limit reached
  static bool isFreeTierLimitReached() {
    final habits = getAllHabits();
    // This would check against pro status in a real app
    const freeLimit = 5;
    return habits.length >= freeLimit;
  }
}
