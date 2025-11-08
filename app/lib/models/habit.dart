import 'package:hive/hive.dart';
import 'completion.dart';
import 'or_option.dart';

part 'habit.g.dart';

@HiveType(typeId: 0)
class Habit extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String description;

  @HiveField(3)
  String icon; // Emoji or icon name

  @HiveField(4)
  String color; // Hex color string

  @HiveField(5)
  DateTime createdAt;

  @HiveField(6)
  List<Completion> completions;

  @HiveField(7)
  bool hasOrOptions; // NEW: Enable OR options feature

  @HiveField(8)
  OrOptions? orOptions; // NEW: The two options

  @HiveField(9)
  List<String> tags; // For organization

  @HiveField(10)
  bool isArchived;

  @HiveField(11)
  int? streakGoal; // Optional streak target

  @HiveField(12)
  int? targetCompletionsPerDay; // For multiple completions

  Habit({
    required this.id,
    required this.name,
    this.description = '',
    required this.icon,
    required this.color,
    required this.createdAt,
    List<Completion>? completions,
    this.hasOrOptions = false,
    this.orOptions,
    List<String>? tags,
    this.isArchived = false,
    this.streakGoal,
    this.targetCompletionsPerDay,
  })  : completions = completions ?? [],
        tags = tags ?? [];

  // Get completion for a specific date
  Completion? getCompletionForDate(DateTime date) {
    final targetDate = DateTime(date.year, date.month, date.day);
    try {
      return completions.firstWhere(
        (c) => c.dateOnly == targetDate,
      );
    } catch (e) {
      return null;
    }
  }

  // Check if completed on a specific date
  bool isCompletedOn(DateTime date) {
    return getCompletionForDate(date) != null;
  }

  // Get current streak
  int get currentStreak {
    if (completions.isEmpty) return 0;

    int streak = 0;
    final now = DateTime.now();
    DateTime checkDate = DateTime(now.year, now.month, now.day);

    // If not completed today, check if completed yesterday
    if (!isCompletedOn(checkDate)) {
      checkDate = checkDate.subtract(const Duration(days: 1));
      if (!isCompletedOn(checkDate)) {
        return 0;
      }
    }

    // Count consecutive days backwards
    while (isCompletedOn(checkDate)) {
      streak++;
      checkDate = checkDate.subtract(const Duration(days: 1));
    }

    return streak;
  }

  // Get longest streak
  int get longestStreak {
    if (completions.isEmpty) return 0;

    // Sort completions by date
    final sorted = List<Completion>.from(completions)
      ..sort((a, b) => a.date.compareTo(b.date));

    int maxStreak = 1;
    int currentStreakCount = 1;

    for (int i = 1; i < sorted.length; i++) {
      final prevDate = sorted[i - 1].dateOnly;
      final currDate = sorted[i].dateOnly;
      final diff = currDate.difference(prevDate).inDays;

      if (diff == 1) {
        currentStreakCount++;
        if (currentStreakCount > maxStreak) {
          maxStreak = currentStreakCount;
        }
      } else {
        currentStreakCount = 1;
      }
    }

    return maxStreak;
  }

  // Get total completions
  int get totalCompletions {
    return completions.fold(0, (sum, c) => sum + c.count);
  }

  // Get completion rate (last 30 days)
  double get completionRate {
    final now = DateTime.now();
    final thirtyDaysAgo = now.subtract(const Duration(days: 30));

    int completedDays = 0;
    for (int i = 0; i < 30; i++) {
      final checkDate = thirtyDaysAgo.add(Duration(days: i));
      if (isCompletedOn(checkDate)) {
        completedDays++;
      }
    }

    return completedDays / 30.0;
  }

  // OR Options Statistics
  Map<String, int> get orOptionStats {
    if (!hasOrOptions || orOptions == null) {
      return {};
    }

    int option1Count = 0;
    int option2Count = 0;

    for (final completion in completions) {
      if (completion.selectedOption == 'option1') {
        option1Count += completion.count;
      } else if (completion.selectedOption == 'option2') {
        option2Count += completion.count;
      } else if (completion.selectedOption == 'both') {
        option1Count += completion.count;
        option2Count += completion.count;
      }
    }

    return {
      'option1': option1Count,
      'option2': option2Count,
      'total': option1Count + option2Count,
    };
  }

  // Copy with
  Habit copyWith({
    String? id,
    String? name,
    String? description,
    String? icon,
    String? color,
    DateTime? createdAt,
    List<Completion>? completions,
    bool? hasOrOptions,
    OrOptions? orOptions,
    List<String>? tags,
    bool? isArchived,
    int? streakGoal,
    int? targetCompletionsPerDay,
  }) {
    return Habit(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
      completions: completions ?? this.completions,
      hasOrOptions: hasOrOptions ?? this.hasOrOptions,
      orOptions: orOptions ?? this.orOptions,
      tags: tags ?? this.tags,
      isArchived: isArchived ?? this.isArchived,
      streakGoal: streakGoal ?? this.streakGoal,
      targetCompletionsPerDay:
          targetCompletionsPerDay ?? this.targetCompletionsPerDay,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'icon': icon,
      'color': color,
      'createdAt': createdAt.toIso8601String(),
      'completions': completions.map((c) => c.toJson()).toList(),
      'hasOrOptions': hasOrOptions,
      'orOptions': orOptions?.toJson(),
      'tags': tags,
      'isArchived': isArchived,
      'streakGoal': streakGoal,
      'targetCompletionsPerDay': targetCompletionsPerDay,
    };
  }

  // From JSON
  factory Habit.fromJson(Map<String, dynamic> json) {
    return Habit(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      icon: json['icon'] as String,
      color: json['color'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      completions: (json['completions'] as List<dynamic>?)
              ?.map((c) => Completion.fromJson(c as Map<String, dynamic>))
              .toList() ??
          [],
      hasOrOptions: json['hasOrOptions'] as bool? ?? false,
      orOptions: json['orOptions'] != null
          ? OrOptions.fromJson(json['orOptions'] as Map<String, dynamic>)
          : null,
      tags: (json['tags'] as List<dynamic>?)?.map((t) => t as String).toList() ?? [],
      isArchived: json['isArchived'] as bool? ?? false,
      streakGoal: json['streakGoal'] as int?,
      targetCompletionsPerDay: json['targetCompletionsPerDay'] as int?,
    );
  }
}
