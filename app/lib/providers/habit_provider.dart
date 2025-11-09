import 'package:flutter/foundation.dart';
import '../models/habit.dart';
import '../models/or_option.dart';
import '../services/habit_service.dart';

class HabitProvider extends ChangeNotifier {
  List<Habit> _habits = [];
  String? _selectedTag;
  bool _showArchived = false;

  List<Habit> get habits {
    List<Habit> filtered = _habits;

    // Filter by archive status
    if (!_showArchived) {
      filtered = filtered.where((h) => !h.isArchived).toList();
    }

    // Filter by tag
    if (_selectedTag != null) {
      filtered = filtered.where((h) => h.tags.contains(_selectedTag)).toList();
    }

    return filtered;
  }

  String? get selectedTag => _selectedTag;
  bool get showArchived => _showArchived;

  List<String> get allTags {
    return HabitService.getAllTags();
  }

  Map<String, dynamic> get stats {
    return HabitService.getStats();
  }

  // Initialize - load habits from database
  Future<void> init() async {
    await loadHabits();
  }

  // Load all habits
  Future<void> loadHabits() async {
    _habits = HabitService.getAllHabits(includeArchived: true);
    notifyListeners();
  }

  // Create habit
  Future<Habit> createHabit({
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
    final habit = await HabitService.createHabit(
      name: name,
      description: description,
      icon: icon,
      color: color,
      hasOrOptions: hasOrOptions,
      orOptions: orOptions,
      tags: tags,
      streakGoal: streakGoal,
      targetCompletionsPerDay: targetCompletionsPerDay,
    );

    await loadHabits();
    return habit;
  }

  // Update habit
  Future<void> updateHabit(Habit habit) async {
    await HabitService.updateHabit(habit);
    await loadHabits();
  }

  // Delete habit
  Future<void> deleteHabit(String id) async {
    await HabitService.deleteHabit(id);
    await loadHabits();
  }

  // Archive habit
  Future<void> archiveHabit(String id) async {
    await HabitService.archiveHabit(id);
    await loadHabits();
  }

  // Unarchive habit
  Future<void> unarchiveHabit(String id) async {
    await HabitService.unarchiveHabit(id);
    await loadHabits();
  }

  // Complete habit
  Future<void> completeHabit({
    required String habitId,
    DateTime? date,
    String? selectedOption,
  }) async {
    await HabitService.completeHabit(
      habitId: habitId,
      date: date,
      selectedOption: selectedOption,
    );
    await loadHabits();
  }

  // Uncomplete habit
  Future<void> uncompleteHabit({
    required String habitId,
    DateTime? date,
  }) async {
    await HabitService.uncompleteHabit(
      habitId: habitId,
      date: date,
    );
    await loadHabits();
  }

  // Toggle completion
  Future<void> toggleCompletion({
    required String habitId,
    String? selectedOption,
  }) async {
    await HabitService.toggleCompletion(
      habitId: habitId,
      selectedOption: selectedOption,
    );
    await loadHabits();
  }

  // Set selected tag filter
  void setSelectedTag(String? tag) {
    _selectedTag = tag;
    notifyListeners();
  }

  // Toggle show archived
  void toggleShowArchived() {
    _showArchived = !_showArchived;
    notifyListeners();
  }

  // Get habit by ID
  Habit? getHabitById(String id) {
    try {
      return _habits.firstWhere((h) => h.id == id);
    } catch (e) {
      return null;
    }
  }

  // Check if free tier limit reached
  bool get isFreeTierLimitReached {
    return HabitService.isFreeTierLimitReached();
  }
}
